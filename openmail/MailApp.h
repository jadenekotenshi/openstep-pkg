/*
**  MailApp.h
**
**  The application object's delegate: owns the account, the IMAP session
**  and the windows, and connects the session's answers to the windows.
*/

#ifndef _OpenMail_MailApp_H
#define _OpenMail_MailApp_H

#import <AppKit/AppKit.h>

@class Account, MailSession, MailboxesWindow, ViewerWindow;

@interface MailApp : NSObject
{
  Account *_account;
  NSString *_password;
  MailSession *_session;
  MailboxesWindow *_mailboxes;
  NSMutableArray *_viewers;
  NSString *_pendingOpen;
}

- (void) installMenus;

/* Menu actions */
- (void) showInfo: (id) sender;
- (void) setUpAccount: (id) sender;
- (void) connect: (id) sender;
- (void) checkMail: (id) sender;
- (void) disconnect: (id) sender;

@end

#endif
