/*
**  Account.h
**
**  The settings of one mail account: where the IMAP and SMTP servers are,
**  how to reach them securely, and who the user is.  Kept in the user's
**  defaults (OpenMail domain); the password is not.
*/

#ifndef _OpenMail_Account_H
#define _OpenMail_Account_H

#import <Foundation/Foundation.h>

typedef enum
{
  AccountSecurityTLS = 0,	/* TLS from the first byte (IMAPS 993, SMTPS 465) */
  AccountSecuritySTARTTLS = 1,	/* upgrade with STARTTLS (IMAP 143, submission 587) */
  AccountSecurityNone = 2	/* plain text; only for a trusted network */
} AccountSecurity;

@interface Account : NSObject
{
  NSString *_fullName;
  NSString *_emailAddress;
  NSString *_imapHost;
  NSString *_imapUser;
  NSString *_smtpHost;
  NSString *_smtpUser;
  int _imapPort;
  int _smtpPort;
  AccountSecurity _imapSecurity;
  AccountSecurity _smtpSecurity;
  BOOL _verifyCertificates;
  NSString *_caFile;
}

/* The account saved in the defaults, or an empty one with the usual ports. */
+ (Account *) savedAccount;
- (void) save;

/* YES when the settings are enough to try to connect. */
- (BOOL) isComplete;

- (NSString *) fullName;
- (void) setFullName: (NSString *) theString;
- (NSString *) emailAddress;
- (void) setEmailAddress: (NSString *) theString;
- (NSString *) imapHost;
- (void) setImapHost: (NSString *) theString;
- (NSString *) imapUser;
- (void) setImapUser: (NSString *) theString;
- (int) imapPort;
- (void) setImapPort: (int) thePort;
- (AccountSecurity) imapSecurity;
- (void) setImapSecurity: (AccountSecurity) theSecurity;
- (NSString *) smtpHost;
- (void) setSmtpHost: (NSString *) theString;
- (NSString *) smtpUser;
- (void) setSmtpUser: (NSString *) theString;
- (int) smtpPort;
- (void) setSmtpPort: (int) thePort;
- (AccountSecurity) smtpSecurity;
- (void) setSmtpSecurity: (AccountSecurity) theSecurity;
- (BOOL) verifyCertificates;
- (void) setVerifyCertificates: (BOOL) theBOOL;
- (NSString *) caFile;
- (void) setCaFile: (NSString *) theString;

/* The usual port for a kind of service with a kind of security. */
+ (int) defaultImapPortForSecurity: (AccountSecurity) theSecurity;
+ (int) defaultSmtpPortForSecurity: (AccountSecurity) theSecurity;

@end

#endif
