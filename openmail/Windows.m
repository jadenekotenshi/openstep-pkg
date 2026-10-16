/*
**  Windows.m
*/

#import "Windows.h"
#import "UIKit.h"

#import <Pantomime/Pantomime.h>

/* --- Mailboxes --- */

@implementation MailboxesWindow

- (id) initWithDelegate: (id) theDelegate
{
  NSScrollView *scroll;

  self = [super init];
  if (!self)
    {
      return nil;
    }

  _delegate = theDelegate;
  _names = [[NSMutableArray alloc] init];

  _window = [[NSWindow alloc] initWithContentRect: NSMakeRect(60, 380, 220, 320)
			      styleMask: NSTitledWindowMask | NSClosableWindowMask |
					 NSMiniaturizableWindowMask | NSResizableWindowMask
			      backing: NSBackingStoreBuffered
			      defer: NO];
  [_window setTitle: @"Mailboxes"];
  [_window setReleasedWhenClosed: NO];
  [_window setMinSize: NSMakeSize(140, 120)];

  scroll = MakeTableScroller([[_window contentView] frame], &_table,
			     [NSArray arrayWithObject: @"name"],
			     [NSArray arrayWithObject: @"Mailbox"],
			     [NSArray arrayWithObject: [NSNumber numberWithFloat: 200.0]]);
  [_table setDataSource: self];
  [_table setDelegate: self];
  [_table setTarget: self];
  [_table setDoubleAction: @selector(openSelected:)];
  [[_window contentView] addSubview: scroll];

  return self;
}

- (void) dealloc
{
  [_table setDataSource: nil];
  [_table setDelegate: nil];
  [_window release];
  [_names release];
  [super dealloc];
}

- (NSWindow *) window
{
  return _window;
}

- (void) showWindow
{
  [_window makeKeyAndOrderFront: nil];
}

- (void) setMailboxes: (NSArray *) theNames
{
  [_names setArray: theNames];
  [_table reloadData];
}

- (void) openSelected: (id) sender
{
  int row;

  row = [_table selectedRow];

  if (row >= 0 && row < [_names count])
    {
      [_delegate mailboxesWindow: self  openMailbox: [_names objectAtIndex: row]];
    }
}

- (int) numberOfRowsInTableView: (NSTableView *) theTable
{
  return [_names count];
}

- (id) tableView: (NSTableView *) theTable  objectValueForTableColumn: (NSTableColumn *) theColumn  row: (int) theRow
{
  return [_names objectAtIndex: theRow];
}

@end


/* --- Viewer --- */

static NSString *size_string(unsigned long theSize)
{
  if (theSize >= 1024 * 1024)
    {
      return [NSString stringWithFormat: @"%.1f MB", theSize / (1024.0 * 1024.0)];
    }

  if (theSize >= 1024)
    {
      return [NSString stringWithFormat: @"%lu KB", (theSize + 512) / 1024];
    }

  return [NSString stringWithFormat: @"%lu", theSize];
}

@implementation ViewerWindow

- (id) initWithMailbox: (NSString *) theName  delegate: (id) theDelegate
{
  NSSplitView *split;
  NSScrollView *listScroll, *textScroll;
  NSRect bounds;

  self = [super init];
  if (!self)
    {
      return nil;
    }

  _delegate = theDelegate;
  _mailboxName = [theName copy];
  _messages = [[NSMutableArray alloc] init];

  _window = [[NSWindow alloc] initWithContentRect: NSMakeRect(300, 120, 600, 560)
			      styleMask: NSTitledWindowMask | NSClosableWindowMask |
					 NSMiniaturizableWindowMask | NSResizableWindowMask
			      backing: NSBackingStoreBuffered
			      defer: NO];
  [_window setTitle: theName];
  [_window setReleasedWhenClosed: NO];
  [_window setMinSize: NSMakeSize(320, 240)];

  bounds = [[_window contentView] bounds];

  _status = MakeLabel(@"", NSMakeRect(4, 2, bounds.size.width - 8, 16));
  [_status setAutoresizingMask: NSViewWidthSizable | NSViewMaxYMargin];
  [[_window contentView] addSubview: _status];

  split = [[[NSSplitView alloc] initWithFrame: NSMakeRect(0, 20, bounds.size.width, bounds.size.height - 20)] autorelease];
  [split setVertical: NO];
  [split setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];

  listScroll = MakeTableScroller(NSMakeRect(0, 0, bounds.size.width, 200), &_table,
				 [NSArray arrayWithObjects: @"number", @"from", @"subject", @"date", @"size", nil],
				 [NSArray arrayWithObjects: @"#", @"From", @"Subject", @"Date", @"Size", nil],
				 [NSArray arrayWithObjects:
					    [NSNumber numberWithFloat: 36.0],
					  [NSNumber numberWithFloat: 150.0],
					  [NSNumber numberWithFloat: 220.0],
					  [NSNumber numberWithFloat: 110.0],
					  [NSNumber numberWithFloat: 60.0], nil]);
  [_table setDataSource: self];
  [_table setDelegate: self];

  textScroll = MakeTextScroller(NSMakeRect(0, 0, bounds.size.width, 300), &_text);

  [split addSubview: listScroll];
  [split addSubview: textScroll];
  [split adjustSubviews];
  [[_window contentView] addSubview: split];

  return self;
}

- (void) dealloc
{
  [_table setDataSource: nil];
  [_table setDelegate: nil];
  [_window release];
  [_messages release];
  [_mailboxName release];
  [super dealloc];
}

- (NSWindow *) window
{
  return _window;
}

- (void) showWindow
{
  [_window makeKeyAndOrderFront: nil];
}

- (NSString *) mailboxName
{
  return _mailboxName;
}

- (void) setMessages: (NSArray *) theMessages
{
  CWMessage *selected;
  int row;

  selected = [self selectedMessage];

  [_messages setArray: theMessages];
  [_table reloadData];

  if (selected)
    {
      row = [_messages indexOfObjectIdenticalTo: selected];

      if (row != NSNotFound)
	{
	  [_table selectRow: row byExtendingSelection: NO];
	}
    }

  [_window setTitle: [NSString stringWithFormat: @"%@ (%d)", _mailboxName, (int)[_messages count]]];
}

- (void) setStatus: (NSString *) theString
{
  [_status setStringValue: theString ? theString : @""];
}

- (CWMessage *) selectedMessage
{
  int row;

  row = [_table selectedRow];

  if (row >= 0 && row < [_messages count])
    {
      return [_messages objectAtIndex: row];
    }

  return nil;
}

- (void) setText: (NSString *) theText  forMessage: (CWMessage *) theMessage
{
  if (theMessage != [self selectedMessage])
    {
      return;
    }

  [_text setString: theText ? theText : @""];
  [_text scrollRangeToVisible: NSMakeRange(0, 0)];
}

- (void) tableViewSelectionDidChange: (NSNotification *) theNotification
{
  CWMessage *m;

  m = [self selectedMessage];

  if (m)
    {
      [_text setString: @"Loading..."];
      [_delegate viewerWindow: self  selectedMessage: m];
    }
  else
    {
      [_text setString: @""];
    }
}

- (int) numberOfRowsInTableView: (NSTableView *) theTable
{
  return [_messages count];
}

- (id) tableView: (NSTableView *) theTable  objectValueForTableColumn: (NSTableColumn *) theColumn  row: (int) theRow
{
  CWMessage *m;
  NSString *identifier;

  m = [_messages objectAtIndex: theRow];
  identifier = [theColumn identifier];

  if ([identifier isEqualToString: @"number"])
    {
      return [NSString stringWithFormat: @"%u", (unsigned int)[m messageNumber]];
    }

  if ([identifier isEqualToString: @"from"])
    {
      CWInternetAddress *from;

      from = [m from];
      return [from personal] ? [from personal] : [from address];
    }

  if ([identifier isEqualToString: @"subject"])
    {
      return [m subject] ? [m subject] : @"";
    }

  if ([identifier isEqualToString: @"date"])
    {
      return [m receivedDate] ? [[m receivedDate] descriptionWithCalendarFormat: @"%Y-%m-%d %H:%M"] : @"";
    }

  return size_string([m size]);
}

@end
