/*
**  Windows.h
**
**  The Mailboxes window (the list of mailboxes on the server) and the
**  Viewer window (the messages of one mailbox, and the text of the one
**  selected).
*/

#ifndef _OpenMail_Windows_H
#define _OpenMail_Windows_H

#import <AppKit/AppKit.h>

@class CWMessage;

@interface MailboxesWindow : NSObject
{
  NSWindow *_window;
  NSTableView *_table;
  NSMutableArray *_names;
  id _delegate;
}

- (id) initWithDelegate: (id) theDelegate;
- (void) showWindow;
- (void) setMailboxes: (NSArray *) theNames;
- (NSWindow *) window;

@end

/* The delegate of a MailboxesWindow. */
@interface NSObject (MailboxesWindowDelegate)
- (void) mailboxesWindow: (id) theWindow openMailbox: (NSString *) theName;
@end


@interface ViewerWindow : NSObject
{
  NSWindow *_window;
  NSTableView *_table;
  NSTextView *_text;
  NSTextField *_status;
  NSMutableArray *_messages;
  NSString *_mailboxName;
  id _delegate;
}

- (id) initWithMailbox: (NSString *) theName  delegate: (id) theDelegate;
- (void) showWindow;
- (NSWindow *) window;
- (NSString *) mailboxName;
- (void) setMessages: (NSArray *) theMessages;
- (void) setText: (NSString *) theText  forMessage: (CWMessage *) theMessage;
- (CWMessage *) selectedMessage;
- (void) setStatus: (NSString *) theString;

@end

/* The delegate of a ViewerWindow. */
@interface NSObject (ViewerWindowDelegate)
- (void) viewerWindow: (id) theWindow selectedMessage: (CWMessage *) theMessage;
@end

#endif
