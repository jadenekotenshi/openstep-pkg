/*
**  MailSession.m
*/

#import "MailSession.h"
#import "Account.h"

#import <Pantomime/Pantomime.h>
#import <Pantomime/CWTCPConnection.h>

@interface MailSession (Private)
- (void) _fail: (NSString *) theReason;
- (void) _tellReady;
@end

@implementation MailSession

- (id) initWithAccount: (Account *) theAccount password: (NSString *) thePassword
{
  self = [super init];
  if (self)
    {
      _account = [theAccount retain];
      _password = [thePassword copy];
      _modes = [[NSMutableArray alloc] init];
    }
  return self;
}

- (void) dealloc
{
  if (_store)
    {
      [_store setDelegate: nil];
    }
  [_store release];
  [_account release];
  [_password release];
  [_modes release];
  [_mailbox release];
  [_wanted release];
  [super dealloc];
}

- (void) setDelegate: (id) theDelegate
{
  _delegate = theDelegate;
}

- (void) addRunLoopMode: (NSString *) theMode
{
  if (theMode && ![_modes containsObject: theMode])
    {
      [_modes addObject: theMode];
    }
}

- (BOOL) isReady
{
  return _ready;
}

- (NSString *) openMailboxName
{
  return _mailbox;
}

- (void) connect
{
  int i;

  if (_store)
    {
      return;
    }

  [CWTCPConnection setCertificateVerification: [_account verifyCertificates]];
  [CWTCPConnection setCAFile: [_account caFile]];

  _store = [[CWIMAPStore alloc] initWithName: [_account imapHost]  port: [_account imapPort]];
  [_store setDelegate: self];

  for (i = 0; i < [_modes count]; i++)
    {
      [_store addRunLoopMode: [_modes objectAtIndex: i]];
    }

  [_store connectInBackgroundAndNotify];
}

- (void) close
{
  if (!_store || _closing)
    {
      return;
    }

  _closing = YES;

  if ([_store isConnected])
    {
      [_store close];
    }
  else
    {
      [_delegate mailSessionClosed: self];
    }
}

- (void) listMailboxes
{
  NSEnumerator *e;

  if (!_ready)
    {
      return;
    }

  e = [_store folderEnumerator];

  // Nil means the LIST command has been sent; folderListCompleted: follows.
  if (e)
    {
      [self folderListCompleted: nil];
    }
}

- (void) openMailbox: (NSString *) theName
{
  if (!_ready)
    {
      return;
    }

  if (_mailbox)
    {
      [[_store folderForName: _mailbox  select: NO] close];
      DESTROY(_mailbox);
    }

  ASSIGN(_mailbox, theName);

  // A mailbox is opened for writing: Pantomime does not treat one opened
  // read-only as selected, and then will not fetch message text.
  [_store folderForName: theName  mode: PantomimeReadWriteMode  prefetch: YES];
}

- (void) fetchTextOfMessage: (CWMessage *) theMessage
{
  ASSIGN(_wanted, theMessage);

  if ([theMessage isInitialized])
    {
      NSString *text;

      text = [MailSession displayTextForMessage: theMessage];
      [_delegate mailSession: self  gotText: text  forMessage: theMessage];
      return;
    }

  [theMessage setInitialized: YES];
}

/* --- Pantomime's delegate methods --- */

- (void) connectionEstablished: (NSNotification *) theNotification
{
  if ([_account imapSecurity] == AccountSecurityTLS)
    {
      CWTCPConnection *connection;

      connection = (CWTCPConnection *)[_store connection];

      if ([connection startSSL] != 0)
	{
	  [self _fail: [NSString stringWithFormat: @"Cannot make a secure connection: %@", [connection sslError]]];
	}
    }
}

- (void) connectionTimedOut: (NSNotification *) theNotification
{
  [self _fail: [NSString stringWithFormat: @"Cannot connect to %@.", [_account imapHost]]];
}

- (void) connectionLost: (NSNotification *) theNotification
{
  NSString *why;

  if (_closing)
    {
      [_delegate mailSessionClosed: self];
      return;
    }

  why = [(CWTCPConnection *)[_store connection] sslError];
  [self _fail: why ? [@"Cannot make a secure connection: " stringByAppendingString: why]
		   : @"The connection to the server was lost."];
}

- (void) connectionTerminated: (NSNotification *) theNotification
{
  _ready = NO;
  [_delegate mailSessionClosed: self];
}

- (void) serviceInitialized: (NSNotification *) theNotification
{
  if ([_account imapSecurity] == AccountSecuritySTARTTLS &&
      ![(CWTCPConnection *)[_store connection] isSSL])
    {
      [_store startTLS];
      return;
    }

  [_store authenticate: [_account imapUser]  password: _password  mechanism: @"LOGIN"];
}

- (void) authenticationFailed: (NSNotification *) theNotification
{
  [self _fail: @"The server did not accept the user name and password."];
}

- (void) authenticationCompleted: (NSNotification *) theNotification
{
  _ready = YES;
  [_delegate mailSessionReady: self];
}

- (void) folderListCompleted: (NSNotification *) theNotification
{
  NSEnumerator *e;
  NSMutableArray *names;
  NSString *name;

  names = [NSMutableArray array];
  e = [_store folderEnumerator];

  while ((name = [e nextObject]))
    {
      [names addObject: name];
    }

  [names sortUsingSelector: @selector(compare:)];
  [_delegate mailSession: self  foundMailboxes: names];
}

- (void) folderListFailed: (NSNotification *) theNotification
{
  [self _fail: @"The server would not list the mailboxes."];
}

- (void) folderOpenFailed: (NSNotification *) theNotification
{
  [self _fail: [NSString stringWithFormat: @"Cannot open the mailbox %@.", _mailbox]];
}

- (void) folderPrefetchFailed: (NSNotification *) theNotification
{
  [self _fail: @"Cannot read the mailbox."];
}

- (void) folderPrefetchCompleted: (NSNotification *) theNotification
{
  CWIMAPFolder *folder;

  folder = (CWIMAPFolder *)[_store folderForName: _mailbox  select: NO];

  // The server reports the prefetch more than once; the window just
  // replaces its list each time.
  [_delegate mailSession: self  openedMailbox: _mailbox  messages: [folder messages]];
}

- (void) messagePrefetchCompleted: (NSNotification *) theNotification
{
  CWMessage *message;

  message = [[theNotification userInfo] objectForKey: @"Message"];

  if (message && message == _wanted)
    {
      [_delegate mailSession: self
		 gotText: [MailSession displayTextForMessage: message]
		 forMessage: message];
    }
}

/* --- Private --- */

- (void) _fail: (NSString *) theReason
{
  if (_failed)
    {
      return;
    }

  _failed = YES;
  _ready = NO;
  [_delegate mailSession: self  failedWithReason: theReason];
}

/* --- Message text --- */

static CWPart *first_text_part(CWPart *thePart)
{
  id content;
  int i;

  if ([thePart isMIMEType: @"text"  subType: @"plain"])
    {
      return thePart;
    }

  content = [thePart content];

  if ([content isKindOfClass: [CWMIMEMultipart class]])
    {
      for (i = 0; i < (int)[(CWMIMEMultipart *)content count]; i++)
	{
	  CWPart *found;

	  found = first_text_part([(CWMIMEMultipart *)content partAtIndex: i]);

	  if (found)
	    {
	      return found;
	    }
	}
    }
  else if ([content isKindOfClass: [CWMessage class]])
    {
      return first_text_part(content);
    }

  return nil;
}

static NSString *header_line(NSString *theName, NSString *theValue)
{
  if ([theValue length] == 0)
    {
      return @"";
    }

  return [NSString stringWithFormat: @"%@: %@\n", theName, theValue];
}

static NSString *address_list(NSArray *theMessageRecipients, int theType)
{
  NSMutableArray *parts;
  int i;

  parts = [NSMutableArray array];

  for (i = 0; i < [theMessageRecipients count]; i++)
    {
      CWInternetAddress *a;

      a = [theMessageRecipients objectAtIndex: i];

      if ([a type] == theType)
	{
	  [parts addObject: [a stringValue]];
	}
    }

  return [parts componentsJoinedByString: @", "];
}

+ (NSString *) displayTextForMessage: (CWMessage *) theMessage
{
  NSMutableString *text;
  CWPart *part;
  NSString *body;
  NSData *data;

  text = [NSMutableString string];

  [text appendString: header_line(@"From", [[theMessage from] stringValue])];
  [text appendString: header_line(@"To", address_list([theMessage recipients], PantomimeToRecipient))];
  [text appendString: header_line(@"Cc", address_list([theMessage recipients], PantomimeCcRecipient))];
  [text appendString: header_line(@"Subject", [theMessage subject])];

  if ([theMessage receivedDate])
    {
      [text appendString: header_line(@"Date", [[theMessage receivedDate] descriptionWithCalendarFormat: @"%a, %d %b %Y %H:%M:%S %z"])];
    }

  [text appendString: @"\n"];

  part = first_text_part(theMessage);
  body = nil;

  if (part)
    {
      data = [CWMIMEUtility plainTextContentFromPart: part];

      if ([[part charset] length] > 0)
	{
	  body = [NSString stringWithData: data
			   charset: [[part charset] dataUsingEncoding: NSASCIIStringEncoding]];
	}

      if (!body)
	{
	  body = [[[NSString alloc] initWithData: data  encoding: NSISOLatin1StringEncoding] autorelease];
	}
    }

  [text appendString: body ? body : @"(This message has no text part.)\n"];

  return text;
}

@end
