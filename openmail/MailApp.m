/*
**  MailApp.m
*/

#import "MailApp.h"
#import "Account.h"
#import "AccountPanel.h"
#import "MailSession.h"
#import "Windows.h"

#import <Pantomime/Pantomime.h>

#define OPENMAIL_VERSION @"0.1"

@interface MailApp (Private)
- (ViewerWindow *) _viewerForMailbox: (NSString *) theName;
- (void) _startSession;
- (void) _forgetSession;
@end

@implementation MailApp

- (id) init
{
  self = [super init];
  if (self)
    {
      _viewers = [[NSMutableArray alloc] init];
    }
  return self;
}

- (void) dealloc
{
  [_account release];
  [_password release];
  [_session release];
  [_mailboxes release];
  [_viewers release];
  [_pendingOpen release];
  [super dealloc];
}

/* --- Menus: the NeXT style, a vertical main menu with submenus --- */

static NSMenu *add_submenu(NSMenu *theMenu, NSString *theTitle)
{
  NSMenu *sub;
  id item;

  sub = [[[NSMenu alloc] initWithTitle: theTitle] autorelease];
  item = [theMenu addItemWithTitle: theTitle  action: NULL  keyEquivalent: @""];
  [theMenu setSubmenu: sub  forItem: item];
  return sub;
}

- (void) installMenus
{
  NSMenu *main, *info, *mailbox, *edit, *windows, *services;

  main = [[[NSMenu alloc] initWithTitle: @"OpenMail"] autorelease];

  info = add_submenu(main, @"Info");
  [info addItemWithTitle: @"Info Panel..."  action: @selector(showInfo:)  keyEquivalent: @""];
  [info addItemWithTitle: @"Account Setup..."  action: @selector(setUpAccount:)  keyEquivalent: @""];

  mailbox = add_submenu(main, @"Mailbox");
  [mailbox addItemWithTitle: @"Connect"  action: @selector(connect:)  keyEquivalent: @"o"];
  [mailbox addItemWithTitle: @"Check Mail"  action: @selector(checkMail:)  keyEquivalent: @"n"];
  [mailbox addItemWithTitle: @"Disconnect"  action: @selector(disconnect:)  keyEquivalent: @""];

  edit = add_submenu(main, @"Edit");
  [edit addItemWithTitle: @"Copy"  action: @selector(copy:)  keyEquivalent: @"c"];
  [edit addItemWithTitle: @"Select All"  action: @selector(selectAll:)  keyEquivalent: @"a"];

  windows = add_submenu(main, @"Windows");
  [windows addItemWithTitle: @"Arrange in Front"  action: @selector(arrangeInFront:)  keyEquivalent: @""];
  [windows addItemWithTitle: @"Miniaturize Window"  action: @selector(performMiniaturize:)  keyEquivalent: @"m"];
  [windows addItemWithTitle: @"Close Window"  action: @selector(performClose:)  keyEquivalent: @"w"];

  services = add_submenu(main, @"Services");

  [main addItemWithTitle: @"Hide"  action: @selector(hide:)  keyEquivalent: @"h"];
  [main addItemWithTitle: @"Quit"  action: @selector(terminate:)  keyEquivalent: @"q"];

  [NSApp setMainMenu: main];
  [NSApp setWindowsMenu: windows];
  [NSApp setServicesMenu: services];
}

/* --- Application delegate --- */

- (void) applicationDidFinishLaunching: (NSNotification *) theNotification
{
  _account = [[Account savedAccount] retain];

  if (![_account isComplete])
    {
      if (![AccountPanel runForAccount: _account])
	{
	  return;
	}
    }

  [self _startSession];
}

- (void) applicationWillTerminate: (NSNotification *) theNotification
{
  [_session setDelegate: nil];
  [_session close];
}

/* --- Menu actions --- */

- (void) showInfo: (id) sender
{
  NSRunAlertPanel(@"OpenMail",
		  @"Version %@\n\nA mail reader for OPENSTEP, in the style of NeXTMail, built on Pantomime.",
		  @"OK", nil, nil, OPENMAIL_VERSION);
}

- (void) setUpAccount: (id) sender
{
  if (!_account)
    {
      _account = [[Account savedAccount] retain];
    }

  if ([AccountPanel runForAccount: _account])
    {
      [self _forgetSession];
      [self _startSession];
    }
}

- (void) connect: (id) sender
{
  if (_session)
    {
      return;
    }

  if (!_account)
    {
      _account = [[Account savedAccount] retain];
    }

  if (![_account isComplete])
    {
      [self setUpAccount: sender];
      return;
    }

  [self _startSession];
}

- (void) checkMail: (id) sender
{
  NSWindow *key;
  int i;

  if (![_session isReady])
    {
      return;
    }

  key = [NSApp keyWindow];

  for (i = 0; i < [_viewers count]; i++)
    {
      ViewerWindow *v;

      v = [_viewers objectAtIndex: i];

      if ([v window] == key)
	{
	  [v setStatus: @"Checking..."];
	  [_session openMailbox: [v mailboxName]];
	  return;
	}
    }

  [_session listMailboxes];
}

- (void) disconnect: (id) sender
{
  [self _forgetSession];
}

- (BOOL) validateMenuItem: (id <NSMenuItem>) theItem
{
  SEL action;

  action = [theItem action];

  if (action == @selector(connect:))
    {
      return _session == nil;
    }

  if (action == @selector(checkMail:) || action == @selector(disconnect:))
    {
      return _session != nil;
    }

  return YES;
}

/* --- Session --- */

- (void) _startSession
{
  NSString *password;

  password = [PasswordPrompt askForAccount: _account];

  if (!password)
    {
      return;
    }

  [_password release];
  _password = [password copy];

  _session = [[MailSession alloc] initWithAccount: _account  password: _password];
  [_session addRunLoopMode: NSModalPanelRunLoopMode];
  [_session addRunLoopMode: NSEventTrackingRunLoopMode];
  [_session setDelegate: self];

  ASSIGN(_pendingOpen, @"INBOX");
  [_session connect];
}

- (void) _forgetSession
{
  int i;

  [_session setDelegate: nil];
  [_session close];
  [_session release];
  _session = nil;

  for (i = 0; i < [_viewers count]; i++)
    {
      [[[_viewers objectAtIndex: i] window] close];
    }

  [_viewers removeAllObjects];
  [[_mailboxes window] close];
  [_mailboxes release];
  _mailboxes = nil;
}

- (void) mailSessionReady: (id) theSession
{
  if (!_mailboxes)
    {
      _mailboxes = [[MailboxesWindow alloc] initWithDelegate: self];
    }

  [_mailboxes showWindow];
  [_session listMailboxes];

  if (_pendingOpen)
    {
      [self mailboxesWindow: _mailboxes  openMailbox: _pendingOpen];
    }
}

- (void) mailSession: (id) theSession failedWithReason: (NSString *) theReason
{
  NSRunAlertPanel(@"OpenMail", @"%@", @"OK", nil, nil, theReason);
  [self _forgetSession];
}

- (void) mailSession: (id) theSession foundMailboxes: (NSArray *) theNames
{
  [_mailboxes setMailboxes: theNames];
}

- (void) mailSession: (id) theSession openedMailbox: (NSString *) theName messages: (NSArray *) theMessages
{
  ViewerWindow *viewer;

  viewer = [self _viewerForMailbox: theName];
  [viewer setMessages: theMessages];
  [viewer setStatus: [NSString stringWithFormat: @"%d messages", (int)[theMessages count]]];
}

- (void) mailSession: (id) theSession gotText: (NSString *) theText forMessage: (CWMessage *) theMessage
{
  ViewerWindow *viewer;

  viewer = [self _viewerForMailbox: [_session openMailboxName]];
  [viewer setText: theText  forMessage: theMessage];
}

- (void) mailSessionClosed: (id) theSession
{
}

/* --- Windows --- */

- (ViewerWindow *) _viewerForMailbox: (NSString *) theName
{
  ViewerWindow *viewer;
  int i;

  for (i = 0; i < [_viewers count]; i++)
    {
      viewer = [_viewers objectAtIndex: i];

      if ([[viewer mailboxName] isEqualToString: theName])
	{
	  return viewer;
	}
    }

  viewer = [[[ViewerWindow alloc] initWithMailbox: theName  delegate: self] autorelease];
  [_viewers addObject: viewer];
  [viewer showWindow];
  return viewer;
}

- (void) mailboxesWindow: (id) theWindow  openMailbox: (NSString *) theName
{
  ASSIGN(_pendingOpen, nil);

  // One mailbox is open on the server at a time; its viewer shows it.
  [self _viewerForMailbox: theName];
  [_session openMailbox: theName];
}

- (void) viewerWindow: (id) theWindow  selectedMessage: (CWMessage *) theMessage
{
  [_session fetchTextOfMessage: theMessage];
}

@end
