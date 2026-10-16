/*
**  AccountPanel.m
*/

#import "AccountPanel.h"
#import "Account.h"
#import "UIKit.h"

@interface AccountPanel (Private)
- (id) initWithAccount: (Account *) theAccount;
- (void) _run;
- (void) _fillFromAccount;
@end

/* Where the controls go: labels on the left, controls from x = 150. */
#define LABEL_X 12.0
#define LABEL_W 130.0
#define FIELD_X 150.0
#define FIELD_W 250.0
#define ROW_H 22.0

@implementation AccountPanel

+ (BOOL) runForAccount: (Account *) theAccount
{
  AccountPanel *panel;
  BOOL saved;

  panel = [[AccountPanel alloc] initWithAccount: theAccount];
  [panel _run];
  saved = panel->_saved;
  [panel release];

  return saved;
}

- (void) _addRow: (NSString *) theLabel  y: (float) theY  control: (NSView *) theControl
{
  [[_window contentView] addSubview: MakeLabel(theLabel, NSMakeRect(LABEL_X, theY, LABEL_W, 18.0))];
  [[_window contentView] addSubview: theControl];
}

- (NSPopUpButton *) _securityPopUpAtY: (float) theY
{
  NSPopUpButton *p;

  p = [[[NSPopUpButton alloc] initWithFrame: NSMakeRect(FIELD_X, theY, FIELD_W, ROW_H) pullsDown: NO] autorelease];
  [p addItemWithTitle: @"Encrypted (TLS)"];
  [p addItemWithTitle: @"Start TLS (STARTTLS)"];
  [p addItemWithTitle: @"None (not encrypted)"];
  [p setTarget: self];
  [p setAction: @selector(securityChanged:)];
  return p;
}

- (id) initWithAccount: (Account *) theAccount
{
  NSView *content;
  float y;

  self = [super init];
  if (!self)
    {
      return nil;
    }

  _account = [theAccount retain];

  _window = [[NSWindow alloc] initWithContentRect: NSMakeRect(200, 200, 420, 438)
			      styleMask: NSTitledWindowMask
			      backing: NSBackingStoreBuffered
			      defer: NO];
  [_window setTitle: @"Mail Account"];
  [_window setReleasedWhenClosed: NO];
  content = [_window contentView];

  y = 400.0;
  _fullName = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"Your name:" y: y + 2 control: _fullName];
  y -= 28;
  _email = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"E-mail address:" y: y + 2 control: _email];

  y -= 40;
  [content addSubview: MakeLabel(@"Incoming mail (IMAP)", NSMakeRect(LABEL_X, y + 4, 250.0, 18.0))];
  y -= 28;
  _imapHost = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"Server:" y: y + 2 control: _imapHost];
  y -= 28;
  _imapSecurity = [self _securityPopUpAtY: y];
  [self _addRow: @"Security:" y: y + 2 control: _imapSecurity];
  y -= 28;
  _imapPort = MakeField(NSMakeRect(FIELD_X, y, 60.0, ROW_H));
  [self _addRow: @"Port:" y: y + 2 control: _imapPort];
  y -= 28;
  _imapUser = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"User name:" y: y + 2 control: _imapUser];

  y -= 40;
  [content addSubview: MakeLabel(@"Outgoing mail (SMTP)", NSMakeRect(LABEL_X, y + 4, 250.0, 18.0))];
  y -= 28;
  _smtpHost = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"Server:" y: y + 2 control: _smtpHost];
  y -= 28;
  _smtpSecurity = [self _securityPopUpAtY: y];
  [self _addRow: @"Security:" y: y + 2 control: _smtpSecurity];
  y -= 28;
  _smtpPort = MakeField(NSMakeRect(FIELD_X, y, 60.0, ROW_H));
  [self _addRow: @"Port:" y: y + 2 control: _smtpPort];
  y -= 28;
  _smtpUser = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"User name:" y: y + 2 control: _smtpUser];

  y -= 36;
  _verify = MakeCheckBox(@"Check the server's certificate", NSMakeRect(FIELD_X, y, FIELD_W, 20.0));
  [content addSubview: _verify];
  y -= 28;
  _caFile = MakeField(NSMakeRect(FIELD_X, y, FIELD_W, ROW_H));
  [self _addRow: @"Certificates file:" y: y + 2 control: _caFile];

  [content addSubview: MakeButton(@"Cancel", self, @selector(cancel:), NSMakeRect(FIELD_X + 70, 10, 80.0, 24.0))];
  _saved = NO;

  {
    NSButton *ok;

    ok = MakeButton(@"Connect", self, @selector(save:), NSMakeRect(FIELD_X + 160, 10, 90.0, 24.0));
    [ok setKeyEquivalent: @"\r"];
    [content addSubview: ok];
  }

  [self _fillFromAccount];
  return self;
}

- (void) dealloc
{
  [_window release];
  [_account release];
  [super dealloc];
}

- (void) _fillFromAccount
{
  [_fullName setStringValue: [_account fullName] ? [_account fullName] : @""];
  [_email setStringValue: [_account emailAddress] ? [_account emailAddress] : @""];
  [_imapHost setStringValue: [_account imapHost] ? [_account imapHost] : @""];
  [_imapPort setStringValue: [NSString stringWithFormat: @"%d", [_account imapPort]]];
  [_imapSecurity selectItemAtIndex: (int)[_account imapSecurity]];
  [_imapUser setStringValue: [_account imapUser] ? [_account imapUser] : @""];
  [_smtpHost setStringValue: [_account smtpHost] ? [_account smtpHost] : @""];
  [_smtpPort setStringValue: [NSString stringWithFormat: @"%d", [_account smtpPort]]];
  [_smtpSecurity selectItemAtIndex: (int)[_account smtpSecurity]];
  [_smtpUser setStringValue: [_account smtpUser] ? [_account smtpUser] : @""];
  [_verify setState: [_account verifyCertificates] ? 1 : 0];
  [_caFile setStringValue: [_account caFile] ? [_account caFile] : @""];
}

- (void) _run
{
  [_window makeKeyAndOrderFront: nil];
  [_window makeFirstResponder: _imapHost];
  [NSApp runModalForWindow: _window];
  [_window orderOut: nil];
}

/* Picking another kind of security moves the port to the usual one, unless
   the user has typed a different port. */
- (void) securityChanged: (id) sender
{
  if (sender == _imapSecurity)
    {
      int old = [_imapPort intValue];

      if (old == 993 || old == 143 || old == 0)
	{
	  [_imapPort setIntValue: [Account defaultImapPortForSecurity: (AccountSecurity)[_imapSecurity indexOfSelectedItem]]];
	}
    }
  else
    {
      int old = [_smtpPort intValue];

      if (old == 465 || old == 587 || old == 25 || old == 0)
	{
	  [_smtpPort setIntValue: [Account defaultSmtpPortForSecurity: (AccountSecurity)[_smtpSecurity indexOfSelectedItem]]];
	}
    }
}

- (void) cancel: (id) sender
{
  [NSApp stopModal];
}

- (void) save: (id) sender
{
  if ([[_imapHost stringValue] length] == 0 || [[_imapUser stringValue] length] == 0)
    {
      NSRunAlertPanel(@"Mail Account", @"Enter at least the incoming mail server and your user name.",
		      @"OK", nil, nil);
      return;
    }

  [_account setFullName: [_fullName stringValue]];
  [_account setEmailAddress: [_email stringValue]];
  [_account setImapHost: [_imapHost stringValue]];
  [_account setImapPort: [_imapPort intValue]];
  [_account setImapSecurity: (AccountSecurity)[_imapSecurity indexOfSelectedItem]];
  [_account setImapUser: [_imapUser stringValue]];
  [_account setSmtpHost: [_smtpHost stringValue]];
  [_account setSmtpPort: [_smtpPort intValue]];
  [_account setSmtpSecurity: (AccountSecurity)[_smtpSecurity indexOfSelectedItem]];
  [_account setSmtpUser: [_smtpUser stringValue]];
  [_account setVerifyCertificates: [_verify state] != 0];
  [_account setCaFile: [_caFile stringValue]];
  [_account save];

  _saved = YES;
  [NSApp stopModal];
}

@end


/* --- The password prompt --- */

@implementation PasswordPrompt

+ (NSString *) askForAccount: (Account *) theAccount
{
  PasswordPrompt *prompt;
  NSString *result;

  prompt = [[PasswordPrompt alloc] initWithAccount: theAccount];
  [NSApp runModalForWindow: prompt->_window];
  [prompt->_window orderOut: nil];

  result = [[prompt->_result retain] autorelease];
  [prompt release];

  return result;
}

- (id) initWithAccount: (Account *) theAccount
{
  NSButton *ok;

  self = [super init];
  if (!self)
    {
      return nil;
    }

  _window = [[NSWindow alloc] initWithContentRect: NSMakeRect(300, 300, 360, 120)
			      styleMask: NSTitledWindowMask
			      backing: NSBackingStoreBuffered
			      defer: NO];
  [_window setTitle: @"Password"];
  [_window setReleasedWhenClosed: NO];

  [[_window contentView] addSubview:
    MakeLabel([NSString stringWithFormat: @"Password for %@ on %@:",
		       [theAccount imapUser], [theAccount imapHost]],
	      NSMakeRect(12, 86, 336, 18))];

  _field = [[NSSecureTextField alloc] initWithFrame: NSMakeRect(12, 56, 336, 22)];
  [[_window contentView] addSubview: _field];

  [[_window contentView] addSubview: MakeButton(@"Cancel", self, @selector(cancel:), NSMakeRect(180, 12, 80, 24))];
  ok = MakeButton(@"OK", self, @selector(ok:), NSMakeRect(268, 12, 80, 24));
  [ok setKeyEquivalent: @"\r"];
  [[_window contentView] addSubview: ok];

  [_window makeKeyAndOrderFront: nil];
  [_window makeFirstResponder: _field];
  return self;
}

- (void) dealloc
{
  [_window release];
  [_field release];
  [_result release];
  [super dealloc];
}

- (void) ok: (id) sender
{
  _result = [[_field stringValue] copy];
  [NSApp stopModal];
}

- (void) cancel: (id) sender
{
  [NSApp stopModal];
}

@end
