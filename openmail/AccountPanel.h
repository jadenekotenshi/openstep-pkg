/*
**  AccountPanel.h
**
**  The account setup panel, and the password prompt that goes with it.
*/

#ifndef _OpenMail_AccountPanel_H
#define _OpenMail_AccountPanel_H

#import <AppKit/AppKit.h>

@class Account;

@interface AccountPanel : NSObject
{
  NSWindow *_window;
  Account *_account;
  BOOL _saved;

  NSTextField *_fullName;
  NSTextField *_email;
  NSTextField *_imapHost;
  NSTextField *_imapPort;
  NSPopUpButton *_imapSecurity;
  NSTextField *_imapUser;
  NSTextField *_smtpHost;
  NSTextField *_smtpPort;
  NSPopUpButton *_smtpSecurity;
  NSTextField *_smtpUser;
  NSButton *_verify;
  NSTextField *_caFile;
}

/* Shows the panel for theAccount, modally.  Returns YES if the user saved
   it (theAccount has then been changed and written to the defaults). */
+ (BOOL) runForAccount: (Account *) theAccount;

@end


/* Asks for the password of an account, modally. */
@interface PasswordPrompt : NSObject
{
  NSWindow *_window;
  NSSecureTextField *_field;
  NSString *_result;
}

/* The password typed, or nil if the user cancelled. */
+ (NSString *) askForAccount: (Account *) theAccount;
- (id) initWithAccount: (Account *) theAccount;

@end

#endif
