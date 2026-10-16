/*
**  pmail.m
**
**  A command line mail client built on Pantomime: fetch over IMAP or POP3 and
**  send over SMTP, with TLS (certificates are checked unless told otherwise).
**
**  Distributed under the same terms as Pantomime (LGPL 2.1 or later).
*/

#import <Foundation/Foundation.h>
#import <Pantomime/Pantomime.h>
#import <Pantomime/CWRunLoopWatcher.h>
#import <Pantomime/CWTCPConnection.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define PMAIL_VERSION "0.1"

typedef enum
{
  CMD_NONE,
  CMD_IMAP_FOLDERS,
  CMD_IMAP_LIST,
  CMD_IMAP_GET,
  CMD_POP3_LIST,
  CMD_POP3_GET,
  CMD_SEND
} Command;

typedef enum
{
  TLS_IMPLICIT,
  TLS_STARTTLS,
  TLS_NONE
} TLSMode;

static void usage(void)
{
  fputs(
"usage: pmail [options] command [argument ...]\n"
"\n"
"commands:\n"
"  imap-folders                list the mailboxes\n"
"  imap-list [FOLDER]          list the messages in FOLDER (default INBOX)\n"
"  imap-get [FOLDER] N         print message number N (or uid:N for a UID);\n"
"                              the whole message, headers included, goes to stdout\n"
"  pop3-list                   list the messages in the maildrop\n"
"  pop3-get N                  print message number N\n"
"  send [FILE]                 send a message over SMTP.  FILE (default stdin)\n"
"                              is a complete message with headers, unless -s is\n"
"                              given, in which case it is just the text\n"
"\n"
"options:\n"
"  -h HOST      server name (required)\n"
"  -p PORT      port (default: 993/995/465 with TLS, 143/110/587 otherwise)\n"
"  -u USER      user name\n"
"  -m MECH      authentication: LOGIN, PLAIN or CRAM-MD5 (IMAP default: LOGIN),\n"
"               PLAIN, LOGIN or CRAM-MD5 (SMTP, default PLAIN), none (POP3 USER/PASS)\n"
"  -T MODE      tls (default: TLS from the first byte), starttls, or none\n"
"  -C FILE      trusted certificate authorities, PEM (default: /usr/local/ssl/cert.pem)\n"
"  -k           do not verify the server's certificate (insecure)\n"
"  -f ADDRESS   (send) sender address\n"
"  -t ADDRESS   (send) recipient; may be repeated\n"
"  -s SUBJECT   (send) compose a message from the text on FILE/stdin\n"
"  -w SECONDS   give up after this long (default 120)\n"
"  -d           show the dialogue with the server on stderr (this includes\n"
"               the password, sometimes in base64)\n"
"\n"
"The password is read from the environment variable PMAIL_PASSWORD, or\n"
"asked for on the terminal.\n", stderr);
  exit(2);
}

//
// Options
//
static NSString *opt_host = nil;
static NSString *opt_user = nil;
static NSString *opt_mech = nil;
static NSString *opt_from = nil;
static NSString *opt_subject = nil;
static NSMutableArray *opt_to = nil;
static int opt_port = 0;
static int opt_timeout = 120;
static TLSMode opt_tls = TLS_IMPLICIT;
static BOOL opt_debug = NO;
static Command command = CMD_NONE;
static NSString *arg_folder = @"INBOX";
static NSString *arg_which = nil;
static NSString *arg_file = nil;

@interface PMail : NSObject
{
  CWService *_service;
  NSString *_password;
  NSString *_failure;
  NSMutableArray *_chunks;
  BOOL _done;
  BOOL _closing;
  BOOL _handled;
  int _status;
}
- (int) run;
@end

//
// Reading and writing
//
//
// Pantomime hands back messages with LF line ends and without the newline
// that ends the last line; put that back.
//
static void put(NSData *theData)
{
  unsigned int length;

  length = [theData length];

  if (length)
    {
      fwrite([theData bytes], 1, length, stdout);

      if (((const char *)[theData bytes])[length - 1] != '\n')
	{
	  putc('\n', stdout);
	}
    }
}

static NSString *flat(NSString *theString)
{
  NSMutableString *s;
  int i;

  if (!theString)
    {
      return @"";
    }

  s = [NSMutableString stringWithString: theString];

  for (i = 0; i < [s length]; i++)
    {
      unichar c = [s characterAtIndex: i];

      if (c == '\t' || c == '\n' || c == '\r')
	{
	  [s replaceCharactersInRange: NSMakeRange(i, 1)  withString: @" "];
	}
    }

  return s;
}

static NSData *read_input(NSString *thePath)
{
  NSMutableData *data;
  FILE *f;
  char buf[4096];
  size_t n;

  if (thePath && ![thePath isEqualToString: @"-"])
    {
      return [NSData dataWithContentsOfFile: thePath];
    }

  f = stdin;
  data = [NSMutableData data];

  while ((n = fread(buf, 1, sizeof(buf), f)) > 0)
    {
      [data appendBytes: buf  length: n];
    }

  return data;
}

//
// Line ends in the message have to be CRLF on the wire; Pantomime's SMTP
// code takes care of that when sending, so we only make sure of a final
// newline here.
//
static NSData *message_data(void)
{
  NSData *input;

  input = read_input(arg_file);

  if (!input)
    {
      fprintf(stderr, "pmail: cannot read %s\n", [arg_file UTF8String]);
      exit(1);
    }

  return input;
}

@implementation PMail

- (id) init
{
  self = [super init];
  if (self)
    {
      _chunks = [[NSMutableArray alloc] init];
    }
  return self;
}

- (void) dealloc
{
  [_service release];
  [_password release];
  [_failure release];
  [_chunks release];
  [super dealloc];
}

- (void) _fail: (NSString *) theReason
{
  if (_done)
    {
      return;
    }

  fprintf(stderr, "pmail: %s\n", [theReason UTF8String]);
  _status = 1;
  _done = YES;
}

//
// Finish nicely: log out, and stop when the server has hung up.
//
- (void) _finish
{
  if (_closing || _done)
    {
      return;
    }

  _closing = YES;
  [_service close];
}

- (NSString *) _askForPassword
{
  char *p;

  p = getenv("PMAIL_PASSWORD");

  if (!p)
    {
      if (!isatty(0))
	{
	  fprintf(stderr, "pmail: set PMAIL_PASSWORD, there is no terminal to ask on\n");
	  exit(1);
	}

      p = getpass("Password: ");
    }

  return p ? [NSString stringWithUTF8String: p] : @"";
}

//
// Pick the service and start connecting.
//
- (BOOL) _start
{
  NSString *kind;
  int defaultPort;

  switch (command)
    {
    case CMD_IMAP_FOLDERS:
    case CMD_IMAP_LIST:
    case CMD_IMAP_GET:
      kind = @"imap";
      defaultPort = (opt_tls == TLS_IMPLICIT ? 993 : 143);
      break;
    case CMD_POP3_LIST:
    case CMD_POP3_GET:
      kind = @"pop3";
      defaultPort = (opt_tls == TLS_IMPLICIT ? 995 : 110);
      break;
    default:
      kind = @"smtp";
      defaultPort = (opt_tls == TLS_IMPLICIT ? 465 : 587);
      break;
    }

  if (!opt_port)
    {
      opt_port = defaultPort;
    }

  if (opt_user)
    {
      _password = [[self _askForPassword] retain];
    }

  if ([kind isEqualToString: @"imap"])
    {
      _service = [[CWIMAPStore alloc] initWithName: opt_host  port: opt_port];
    }
  else if ([kind isEqualToString: @"pop3"])
    {
      _service = [[CWPOP3Store alloc] initWithName: opt_host  port: opt_port];
    }
  else
    {
      CWSMTP *smtp;
      NSData *data;
      CWMessage *message;

      smtp = [[CWSMTP alloc] initWithName: opt_host  port: opt_port];
      _service = smtp;

      data = message_data();

      if (opt_subject)
	{
	  CWInternetAddress *address;
	  NSString *text;
	  int i;

	  if (!opt_from || ![opt_to count])
	    {
	      fprintf(stderr, "pmail: -s needs -f and at least one -t\n");
	      return NO;
	    }

	  message = [[[CWMessage alloc] init] autorelease];
	  [message setSubject: opt_subject];

	  address = [[[CWInternetAddress alloc] initWithString: opt_from] autorelease];
	  [message setFrom: address];

	  for (i = 0; i < [opt_to count]; i++)
	    {
	      address = [[[CWInternetAddress alloc] initWithString: [opt_to objectAtIndex: i]] autorelease];
	      [address setType: PantomimeToRecipient];
	      [message addRecipient: address];
	    }

	  text = [[[NSString alloc] initWithData: data  encoding: NSUTF8StringEncoding] autorelease];

	  if (!text)
	    {
	      fprintf(stderr, "pmail: the text is not valid UTF-8\n");
	      return NO;
	    }

	  [message setContentType: @"text/plain"];
	  [message setCharset: @"utf-8"];
	  [message setContentTransferEncoding: PantomimeEncodingQuotedPrintable];
	  [message setContent: [text dataUsingEncoding: NSUTF8StringEncoding]];
	  [message setReceivedDate: [NSCalendarDate calendarDate]];

	  [smtp setMessage: message];
	}
      else
	{
	  message = [[[CWMessage alloc] initWithData: data] autorelease];

	  if (opt_from)
	    {
	      CWInternetAddress *address;

	      address = [[[CWInternetAddress alloc] initWithString: opt_from] autorelease];
	      [message setFrom: address];
	    }

	  if (![message from] || ![[message from] address])
	    {
	      fprintf(stderr, "pmail: the message has no From: header; use -f\n");
	      return NO;
	    }

	  [smtp setMessage: message];
	  [smtp setMessageData: data];

	  if ([opt_to count])
	    {
	      NSMutableArray *to;
	      int i;

	      to = [NSMutableArray array];

	      for (i = 0; i < [opt_to count]; i++)
		{
		  CWInternetAddress *address;

		  address = [[[CWInternetAddress alloc] initWithString: [opt_to objectAtIndex: i]] autorelease];
		  [address setType: PantomimeToRecipient];
		  [to addObject: address];
		}

	      [smtp setRecipients: to];
	    }
	  else if (![[message recipients] count])
	    {
	      fprintf(stderr, "pmail: the message has no recipients; use -t\n");
	      return NO;
	    }
	}
    }

  [_service setDelegate: self];
  [_service connectInBackgroundAndNotify];
  return YES;
}

- (int) run
{
  NSRunLoop *loop;
  NSDate *limit;

  if (![self _start])
    {
      return 1;
    }

  loop = [NSRunLoop currentRunLoop];
  limit = [NSDate dateWithTimeIntervalSinceNow: opt_timeout];

  while (!_done)
    {
      NSAutoreleasePool *pool;

      if ([limit timeIntervalSinceNow] <= 0.0)
	{
	  [self _fail: @"timed out"];
	  break;
	}

      pool = [[NSAutoreleasePool alloc] init];
      [loop runMode: NSDefaultRunLoopMode
	    beforeDate: [NSDate dateWithTimeIntervalSinceNow: 0.1]];
      [pool release];
    }

  fflush(stdout);
  return _status;
}

//
// Connection events
//
- (void) connectionEstablished: (NSNotification *) theNotification
{
  if (opt_tls == TLS_IMPLICIT)
    {
      CWTCPConnection *connection;

      connection = (CWTCPConnection *)[_service connection];

      if ([connection startSSL] != 0)
	{
	  [self _fail: [NSString stringWithFormat: @"TLS: %@", [connection sslError]]];
	}
    }
}

- (void) connectionTimedOut: (NSNotification *) theNotification
{
  [self _fail: [NSString stringWithFormat: @"cannot connect to %@:%d", opt_host, opt_port]];
}

- (void) connectionLost: (NSNotification *) theNotification
{
  if (_closing)
    {
      _done = YES;
    }
  else
    {
      NSString *why;

      why = [(CWTCPConnection *)[_service connection] sslError];
      [self _fail: why ? [@"TLS: " stringByAppendingString: why] : @"the connection was lost"];
    }
}

- (void) connectionTerminated: (NSNotification *) theNotification
{
  _done = YES;
}

- (void) service: (CWService *) theService  receivedData: (NSData *) theData
{
  if (opt_debug)
    {
      fputs("S: ", stderr);
      fwrite([theData bytes], 1, [theData length], stderr);
    }
}

- (void) service: (CWService *) theService  sentData: (NSData *) theData
{
  if (opt_debug)
    {
      fputs("C: ", stderr);
      fwrite([theData bytes], 1, [theData length], stderr);
    }
}

- (void) serviceInitialized: (NSNotification *) theNotification
{
  NSString *mech;

  if (opt_tls == TLS_STARTTLS && ![(CWTCPConnection *)[_service connection] isSSL])
    {
      // -startTLS makes the server switch; we get here again when it is done.
      [_service startTLS];
      return;
    }

  if (!opt_user)
    {
      if (command == CMD_SEND)
	{
	  [(CWSMTP *)_service sendMessage];
	}
      else
	{
	  [self _fail: @"a user name is needed (-u)"];
	}
      return;
    }

  mech = opt_mech;

  if (!mech)
    {
      mech = (command == CMD_SEND ? @"PLAIN" : (command == CMD_POP3_LIST || command == CMD_POP3_GET ? @"none" : @"LOGIN"));
    }

  [_service authenticate: opt_user  password: _password  mechanism: mech];
}

- (void) authenticationFailed: (NSNotification *) theNotification
{
  [self _fail: @"authentication failed"];
}

- (void) authenticationCompleted: (NSNotification *) theNotification
{
  switch (command)
    {
    case CMD_IMAP_FOLDERS:
      if ([(CWIMAPStore *)_service folderEnumerator])
	{
	  [self folderListCompleted: nil];
	}
      break;

    case CMD_IMAP_LIST:
    case CMD_IMAP_GET:
      // Pantomime only treats a mailbox opened for writing as selected,
      // which fetching message bodies requires (it marks the message read).
      [(CWIMAPStore *)_service folderForName: arg_folder
			     mode: (command == CMD_IMAP_GET ? PantomimeReadWriteMode : PantomimeReadOnlyMode)
			     prefetch: YES];
      break;

    case CMD_POP3_LIST:
    case CMD_POP3_GET:
      [[(CWPOP3Store *)_service defaultFolder] prefetch];
      break;

    case CMD_SEND:
      [(CWSMTP *)_service sendMessage];
      break;

    default:
      break;
    }
}

//
// IMAP
//
- (void) folderListCompleted: (NSNotification *) theNotification
{
  NSEnumerator *e;
  NSMutableArray *names;
  NSString *name;
  int i;

  names = [NSMutableArray array];
  e = [(CWIMAPStore *)_service folderEnumerator];

  while ((name = [e nextObject]))
    {
      [names addObject: name];
    }

  [names sortUsingSelector: @selector(compare:)];

  for (i = 0; i < [names count]; i++)
    {
      printf("%s\n", [[names objectAtIndex: i] UTF8String]);
    }

  [self _finish];
}

- (void) folderListFailed: (NSNotification *) theNotification
{
  [self _fail: @"cannot list the mailboxes"];
}

- (void) folderOpenFailed: (NSNotification *) theNotification
{
  [self _fail: [NSString stringWithFormat: @"cannot open the mailbox %@", arg_folder]];
}

- (void) folderPrefetchFailed: (NSNotification *) theNotification
{
  [self _fail: @"cannot read the mailbox"];
}

- (void) folderPrefetchCompleted: (NSNotification *) theNotification
{
  NSArray *messages;
  id folder;
  int i;

  // IMAP reports the prefetch more than once.
  if (_handled)
    {
      return;
    }
  _handled = YES;

  if (command == CMD_POP3_LIST || command == CMD_POP3_GET)
    {
      folder = [(CWPOP3Store *)_service defaultFolder];
    }
  else
    {
      folder = [(CWIMAPStore *)_service folderForName: arg_folder  select: NO];
    }

  messages = [folder messages];

  if (command == CMD_IMAP_LIST || command == CMD_POP3_LIST)
    {
      for (i = 0; i < [messages count]; i++)
	{
	  CWMessage *m;
	  NSString *date, *uid;

	  m = [messages objectAtIndex: i];

	  date = [m receivedDate] ? [[m receivedDate] descriptionWithCalendarFormat: @"%Y-%m-%d %H:%M"] : @"";
	  uid = (command == CMD_IMAP_LIST ? [NSString stringWithFormat: @"%lu", (unsigned long)[(CWIMAPMessage *)m UID]]
		                          : [NSString stringWithFormat: @"%lu", (unsigned long)[m size]]);

	  printf("%u\t%s\t%s\t%s\t%s\n",
		 (unsigned int)[m messageNumber],
		 [uid UTF8String],
		 [date UTF8String],
		 [flat([[m from] stringValue]) UTF8String],
		 [flat([m subject]) UTF8String]);
	}

      [self _finish];
      return;
    }

  //
  // The -get commands: find the message and ask for it.
  //
  {
    BOOL byUID;
    unsigned long wanted;
    CWMessage *found;

    byUID = NO;
    found = nil;

    if ([arg_which hasPrefix: @"uid:"])
      {
	byUID = YES;
	wanted = strtoul([[arg_which substringFromIndex: 4] UTF8String], NULL, 10);
      }
    else
      {
	wanted = strtoul([arg_which UTF8String], NULL, 10);
      }

    for (i = 0; i < [messages count]; i++)
      {
	CWMessage *m;

	m = [messages objectAtIndex: i];

	if (byUID ? ([(CWIMAPMessage *)m UID] == wanted) : ([m messageNumber] == wanted))
	  {
	    found = m;
	    break;
	  }
      }

    if (!found)
      {
	[self _fail: [NSString stringWithFormat: @"no message %@", arg_which]];
	return;
      }

    if (command == CMD_IMAP_GET)
      {
	// The answer arrives as messageFetchCompleted:
	[found rawSource];
      }
    else
      {
	[found setInitialized: YES];
      }
  }
}

- (void) messageFetchCompleted: (NSNotification *) theNotification
{
  CWMessage *m;

  m = [[theNotification userInfo] objectForKey: @"Message"];
  put([m rawSource]);
  [self _finish];
}

- (void) messagePrefetchCompleted: (NSNotification *) theNotification
{
  CWMessage *m;

  m = [[theNotification userInfo] objectForKey: @"Message"];

  if (command == CMD_POP3_GET)
    {
      put([m rawSource]);
      [self _finish];
    }
}

//
// SMTP
//
- (void) transactionInitiationFailed: (NSNotification *) theNotification
{
  [self _fail: [NSString stringWithFormat: @"the server refused the sender: %s",
			 [[(CWSMTP *)_service lastResponse] length]
			 ? (const char *)[[(CWSMTP *)_service lastResponse] bytes] : ""]];
}

- (void) recipientIdentificationFailed: (NSNotification *) theNotification
{
  [self _fail: @"the server refused a recipient"];
}

- (void) messageNotSent: (NSNotification *) theNotification
{
  [self _fail: @"the server did not accept the message"];
}

- (void) messageSent: (NSNotification *) theNotification
{
  [self _finish];
}

@end


int main(int argc, char **argv)
{
  NSAutoreleasePool *pool;
  PMail *pmail;
  int i, status;
  char *a;

  pool = [[NSAutoreleasePool alloc] init];
  opt_to = [[NSMutableArray alloc] init];

  for (i = 1; i < argc; i++)
    {
      a = argv[i];

      if (a[0] != '-' || a[1] == '\0')
	{
	  break;
	}

      if (!strcmp(a, "-k"))
	{
	  [CWTCPConnection setCertificateVerification: NO];
	}
      else if (!strcmp(a, "-d"))
	{
	  opt_debug = YES;
	}
      else if (!strcmp(a, "--help"))
	{
	  usage();
	}
      else if (a[1] && strchr("hpumTCftsw", a[1]) && !a[2])
	{
	  NSString *v;

	  if (++i >= argc)
	    {
	      usage();
	    }

	  v = [NSString stringWithUTF8String: argv[i]];

	  switch (a[1])
	    {
	    case 'h': opt_host = [v retain]; break;
	    case 'p': opt_port = atoi(argv[i]); break;
	    case 'w': opt_timeout = atoi(argv[i]); break;
	    case 'u': opt_user = [v retain]; break;
	    case 'm': opt_mech = [v retain]; break;
	    case 'f': opt_from = [v retain]; break;
	    case 's': opt_subject = [v retain]; break;
	    case 't': [opt_to addObject: v]; break;
	    case 'C': [CWTCPConnection setCAFile: v]; break;
	    case 'T':
	      if ([v isEqualToString: @"tls"])
		opt_tls = TLS_IMPLICIT;
	      else if ([v isEqualToString: @"starttls"])
		opt_tls = TLS_STARTTLS;
	      else if ([v isEqualToString: @"none"])
		opt_tls = TLS_NONE;
	      else
		usage();
	      break;
	    }
	}
      else
	{
	  usage();
	}
    }

  if (i >= argc || !opt_host)
    {
      usage();
    }

  a = argv[i++];

  if (!strcmp(a, "imap-folders"))
    {
      command = CMD_IMAP_FOLDERS;
    }
  else if (!strcmp(a, "imap-list"))
    {
      command = CMD_IMAP_LIST;
      if (i < argc)
	arg_folder = [NSString stringWithUTF8String: argv[i++]];
    }
  else if (!strcmp(a, "imap-get"))
    {
      command = CMD_IMAP_GET;
      if (argc - i == 2)
	arg_folder = [NSString stringWithUTF8String: argv[i++]];
      if (i >= argc)
	usage();
      arg_which = [NSString stringWithUTF8String: argv[i++]];
    }
  else if (!strcmp(a, "pop3-list"))
    {
      command = CMD_POP3_LIST;
    }
  else if (!strcmp(a, "pop3-get"))
    {
      command = CMD_POP3_GET;
      if (i >= argc)
	usage();
      arg_which = [NSString stringWithUTF8String: argv[i++]];
    }
  else if (!strcmp(a, "send"))
    {
      command = CMD_SEND;
      if (i < argc)
	arg_file = [NSString stringWithUTF8String: argv[i++]];
    }
  else
    {
      usage();
    }

  if (i < argc)
    {
      usage();
    }

  pmail = [[PMail alloc] init];
  status = [pmail run];
  [pmail release];
  [pool release];

  return status;
}
