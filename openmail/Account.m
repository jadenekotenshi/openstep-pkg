/*
**  Account.m
*/

#import "Account.h"

static NSString *Domain = @"OpenMail";

@implementation Account

+ (int) defaultImapPortForSecurity: (AccountSecurity) theSecurity
{
  return (theSecurity == AccountSecurityTLS ? 993 : 143);
}

+ (int) defaultSmtpPortForSecurity: (AccountSecurity) theSecurity
{
  return (theSecurity == AccountSecurityTLS ? 465 : 587);
}

- (id) init
{
  self = [super init];
  if (self)
    {
      _imapSecurity = AccountSecurityTLS;
      _smtpSecurity = AccountSecuritySTARTTLS;
      _imapPort = [Account defaultImapPortForSecurity: _imapSecurity];
      _smtpPort = [Account defaultSmtpPortForSecurity: _smtpSecurity];
      _verifyCertificates = YES;
    }
  return self;
}

- (void) dealloc
{
  [_fullName release];
  [_emailAddress release];
  [_imapHost release];
  [_imapUser release];
  [_smtpHost release];
  [_smtpUser release];
  [_caFile release];
  [super dealloc];
}

+ (Account *) savedAccount
{
  NSUserDefaults *defaults;
  NSDictionary *d;
  Account *account;
  id v;

  account = [[[Account alloc] init] autorelease];
  defaults = [NSUserDefaults standardUserDefaults];
  d = [defaults objectForKey: Domain];

  if (![d isKindOfClass: [NSDictionary class]])
    {
      return account;
    }

  [account setFullName: [d objectForKey: @"FullName"]];
  [account setEmailAddress: [d objectForKey: @"EmailAddress"]];
  [account setImapHost: [d objectForKey: @"ImapHost"]];
  [account setImapUser: [d objectForKey: @"ImapUser"]];
  [account setSmtpHost: [d objectForKey: @"SmtpHost"]];
  [account setSmtpUser: [d objectForKey: @"SmtpUser"]];
  [account setCaFile: [d objectForKey: @"CAFile"]];

  if ((v = [d objectForKey: @"ImapPort"]))
    [account setImapPort: [v intValue]];
  if ((v = [d objectForKey: @"SmtpPort"]))
    [account setSmtpPort: [v intValue]];
  if ((v = [d objectForKey: @"ImapSecurity"]))
    [account setImapSecurity: (AccountSecurity)[v intValue]];
  if ((v = [d objectForKey: @"SmtpSecurity"]))
    [account setSmtpSecurity: (AccountSecurity)[v intValue]];
  if ((v = [d objectForKey: @"VerifyCertificates"]))
    [account setVerifyCertificates: [v intValue] != 0];

  return account;
}

- (void) save
{
  NSMutableDictionary *d;

  d = [NSMutableDictionary dictionary];

  if (_fullName) [d setObject: _fullName forKey: @"FullName"];
  if (_emailAddress) [d setObject: _emailAddress forKey: @"EmailAddress"];
  if (_imapHost) [d setObject: _imapHost forKey: @"ImapHost"];
  if (_imapUser) [d setObject: _imapUser forKey: @"ImapUser"];
  if (_smtpHost) [d setObject: _smtpHost forKey: @"SmtpHost"];
  if (_smtpUser) [d setObject: _smtpUser forKey: @"SmtpUser"];
  if (_caFile) [d setObject: _caFile forKey: @"CAFile"];
  [d setObject: [NSString stringWithFormat: @"%d", _imapPort] forKey: @"ImapPort"];
  [d setObject: [NSString stringWithFormat: @"%d", _smtpPort] forKey: @"SmtpPort"];
  [d setObject: [NSString stringWithFormat: @"%d", (int)_imapSecurity] forKey: @"ImapSecurity"];
  [d setObject: [NSString stringWithFormat: @"%d", (int)_smtpSecurity] forKey: @"SmtpSecurity"];
  [d setObject: (_verifyCertificates ? @"1" : @"0") forKey: @"VerifyCertificates"];

  [[NSUserDefaults standardUserDefaults] setObject: d forKey: Domain];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) isComplete
{
  return [_imapHost length] > 0 && [_imapUser length] > 0 && _imapPort > 0;
}

#define STRING_ACCESSOR(getter, setter, ivar) \
- (NSString *) getter { return ivar; } \
- (void) setter: (NSString *) theString \
{ \
  NSString *s = [theString length] ? [theString copy] : nil; \
  [ivar release]; \
  ivar = s; \
}

STRING_ACCESSOR(fullName, setFullName, _fullName)
STRING_ACCESSOR(emailAddress, setEmailAddress, _emailAddress)
STRING_ACCESSOR(imapHost, setImapHost, _imapHost)
STRING_ACCESSOR(imapUser, setImapUser, _imapUser)
STRING_ACCESSOR(smtpHost, setSmtpHost, _smtpHost)
STRING_ACCESSOR(smtpUser, setSmtpUser, _smtpUser)
STRING_ACCESSOR(caFile, setCaFile, _caFile)

- (int) imapPort { return _imapPort; }
- (void) setImapPort: (int) thePort { _imapPort = thePort; }
- (AccountSecurity) imapSecurity { return _imapSecurity; }
- (void) setImapSecurity: (AccountSecurity) theSecurity { _imapSecurity = theSecurity; }
- (int) smtpPort { return _smtpPort; }
- (void) setSmtpPort: (int) thePort { _smtpPort = thePort; }
- (AccountSecurity) smtpSecurity { return _smtpSecurity; }
- (void) setSmtpSecurity: (AccountSecurity) theSecurity { _smtpSecurity = theSecurity; }
- (BOOL) verifyCertificates { return _verifyCertificates; }
- (void) setVerifyCertificates: (BOOL) theBOOL { _verifyCertificates = theBOOL; }

@end
