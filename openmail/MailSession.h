/*
**  MailSession.h
**
**  One IMAP conversation, as the windows need it: connect and log in, list
**  the mailboxes, open one and get its messages, fetch a message's text.
**  It is a thin layer over Pantomime's CWIMAPStore and uses only Foundation,
**  so it can be tested without a window system.
**
**  Everything is asynchronous: ask, return to the run loop, and the delegate
**  is told.  Only one mailbox is open at a time.
*/

#ifndef _OpenMail_MailSession_H
#define _OpenMail_MailSession_H

#import <Foundation/Foundation.h>

@class Account, CWIMAPStore, CWIMAPFolder, CWMessage;

/* The delegate may implement any of these. */
@interface NSObject (MailSessionDelegate)
- (void) mailSessionReady: (id) theSession;
- (void) mailSession: (id) theSession failedWithReason: (NSString *) theReason;
- (void) mailSession: (id) theSession foundMailboxes: (NSArray *) theNames;
- (void) mailSession: (id) theSession openedMailbox: (NSString *) theName messages: (NSArray *) theMessages;
- (void) mailSession: (id) theSession gotText: (NSString *) theText forMessage: (CWMessage *) theMessage;
- (void) mailSessionClosed: (id) theSession;
@end

@interface MailSession : NSObject
{
  Account *_account;
  NSString *_password;
  CWIMAPStore *_store;
  id _delegate;
  NSMutableArray *_modes;
  NSString *_mailbox;
  CWMessage *_wanted;
  BOOL _ready;
  BOOL _closing;
  BOOL _failed;
  BOOL _listing;
}

- (id) initWithAccount: (Account *) theAccount password: (NSString *) thePassword;

- (void) setDelegate: (id) theDelegate;

/* Run loop modes besides the default in which to keep talking to the server,
   for example the modes of a modal panel or of mouse tracking. */
- (void) addRunLoopMode: (NSString *) theMode;

- (void) connect;
- (void) close;
- (BOOL) isReady;

- (void) listMailboxes;
- (void) openMailbox: (NSString *) theName;
- (NSString *) openMailboxName;
- (void) fetchTextOfMessage: (CWMessage *) theMessage;

/* The readable text of a message that has been fetched: its headers as the
   user wants to see them, a blank line, and the first text part. */
+ (NSString *) displayTextForMessage: (CWMessage *) theMessage;

@end

#endif
