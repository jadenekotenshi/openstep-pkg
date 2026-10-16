/*
**  sessiontest.m
**
**  Runs MailSession against a real IMAP server, without windows:
**
**    sessiontest host port tls|starttls|none user [cafile|-k] [mailbox]
**
**  The password is in PMAIL_PASSWORD.  It lists the mailboxes, opens the
**  mailbox (INBOX by default), prints each message's sender and subject, and
**  prints the text of the last one.
*/

#import <Foundation/Foundation.h>
#import <Pantomime/Pantomime.h>

#import "Account.h"
#import "MailSession.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

@interface Driver : NSObject
{
  MailSession *_session;
  NSString *_mailbox;
  BOOL _done;
  int _status;
  BOOL _fetched;
}
- (id) initWithSession: (MailSession *) theSession  mailbox: (NSString *) theMailbox;
- (BOOL) isDone;
- (int) status;
@end

@implementation Driver

- (id) initWithSession: (MailSession *) theSession  mailbox: (NSString *) theMailbox
{
  self = [super init];
  _session = [theSession retain];
  _mailbox = [theMailbox copy];
  return self;
}

- (BOOL) isDone { return _done; }
- (int) status { return _status; }

- (void) mailSessionReady: (id) theSession
{
  printf("ready\n");
  [_session listMailboxes];
}

- (void) mailSession: (id) theSession failedWithReason: (NSString *) theReason
{
  printf("FAILED: %s\n", [theReason UTF8String]);
  _status = 1;
  _done = YES;
}

- (void) mailSession: (id) theSession foundMailboxes: (NSArray *) theNames
{
  int i;

  for (i = 0; i < [theNames count]; i++)
    {
      printf("mailbox %s\n", [[theNames objectAtIndex: i] UTF8String]);
    }

  [_session openMailbox: _mailbox];
}

- (void) mailSession: (id) theSession openedMailbox: (NSString *) theName messages: (NSArray *) theMessages
{
  int i;

  if (_fetched)
    {
      return;
    }

  printf("opened %s: %d messages\n", [theName UTF8String], (int)[theMessages count]);

  for (i = 0; i < [theMessages count]; i++)
    {
      CWMessage *m = [theMessages objectAtIndex: i];

      printf("  %u  %s  |  %s\n", (unsigned)[m messageNumber],
	     [[[m from] stringValue] UTF8String], [[m subject] UTF8String]);
    }

  if ([theMessages count] > 0)
    {
      _fetched = YES;
      [_session fetchTextOfMessage: [theMessages lastObject]];
    }
  else
    {
      [_session close];
    }
}

- (void) mailSession: (id) theSession gotText: (NSString *) theText forMessage: (CWMessage *) theMessage
{
  printf("---- text of the last message ----\n%s----\n", [theText UTF8String]);
  [_session close];
}

- (void) mailSessionClosed: (id) theSession
{
  printf("closed\n");
  _done = YES;
}

@end

int main(int argc, char **argv)
{
  NSAutoreleasePool *pool;
  Account *account;
  MailSession *session;
  Driver *driver;
  NSDate *limit;
  NSString *mailbox;
  char *pw;

  pool = [[NSAutoreleasePool alloc] init];

  if (argc < 5)
    {
      fprintf(stderr, "usage: sessiontest host port tls|starttls|none user [cafile|-k] [mailbox]\n");
      return 2;
    }

  account = [[[Account alloc] init] autorelease];
  [account setImapHost: [NSString stringWithUTF8String: argv[1]]];
  [account setImapPort: atoi(argv[2])];
  [account setImapSecurity: (!strcmp(argv[3], "tls") ? AccountSecurityTLS :
			     !strcmp(argv[3], "starttls") ? AccountSecuritySTARTTLS : AccountSecurityNone)];
  [account setImapUser: [NSString stringWithUTF8String: argv[4]]];

  if (argc > 5)
    {
      if (!strcmp(argv[5], "-k"))
	[account setVerifyCertificates: NO];
      else
	[account setCaFile: [NSString stringWithUTF8String: argv[5]]];
    }

  mailbox = (argc > 6 ? [NSString stringWithUTF8String: argv[6]] : @"INBOX");
  pw = getenv("PMAIL_PASSWORD");

  session = [[MailSession alloc] initWithAccount: account  password: [NSString stringWithUTF8String: pw ? pw : ""]];
  driver = [[Driver alloc] initWithSession: session  mailbox: mailbox];
  [session setDelegate: driver];
  [session connect];

  limit = [NSDate dateWithTimeIntervalSinceNow: 30];

  while (![driver isDone] && [limit timeIntervalSinceNow] > 0)
    {
      NSAutoreleasePool *inner = [[NSAutoreleasePool alloc] init];
      [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode
				  beforeDate: [NSDate dateWithTimeIntervalSinceNow: 0.1]];
      [inner release];
    }

  if (![driver isDone])
    {
      printf("TIMED OUT\n");
      return 1;
    }

  [pool release];
  return [driver status];
}
