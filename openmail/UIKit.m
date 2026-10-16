/*
**  UIKit.m
*/

#import "UIKit.h"

NSTextField *MakeLabel(NSString *theTitle, NSRect theFrame)
{
  NSTextField *f;

  f = [[[NSTextField alloc] initWithFrame: theFrame] autorelease];
  [f setStringValue: theTitle];
  [f setEditable: NO];
  [f setSelectable: NO];
  [f setBezeled: NO];
  [f setBordered: NO];
  [f setDrawsBackground: NO];
  return f;
}

NSTextField *MakeField(NSRect theFrame)
{
  NSTextField *f;

  f = [[[NSTextField alloc] initWithFrame: theFrame] autorelease];
  [f setEditable: YES];
  [f setBezeled: YES];
  [f setDrawsBackground: YES];
  return f;
}

NSButton *MakeButton(NSString *theTitle, id theTarget, SEL theAction, NSRect theFrame)
{
  NSButton *b;

  b = [[[NSButton alloc] initWithFrame: theFrame] autorelease];
  [b setTitle: theTitle];
  [b setTarget: theTarget];
  [b setAction: theAction];
  [b setButtonType: NSMomentaryPushButton];
  [b setBordered: YES];
  return b;
}

NSButton *MakeCheckBox(NSString *theTitle, NSRect theFrame)
{
  NSButton *b;

  b = [[[NSButton alloc] initWithFrame: theFrame] autorelease];
  [b setTitle: theTitle];
  [b setButtonType: NSSwitchButton];
  return b;
}

NSScrollView *MakeTextScroller(NSRect theFrame, NSTextView **theTextView)
{
  NSScrollView *scroll;
  NSTextView *text;
  NSSize contentSize;

  scroll = [[[NSScrollView alloc] initWithFrame: theFrame] autorelease];
  [scroll setHasVerticalScroller: YES];
  [scroll setHasHorizontalScroller: NO];
  [scroll setBorderType: NSBezelBorder];
  [scroll setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];

  contentSize = [scroll contentSize];

  text = [[[NSTextView alloc] initWithFrame: NSMakeRect(0, 0, contentSize.width, contentSize.height)] autorelease];
  [text setMinSize: NSMakeSize(0.0, contentSize.height)];
  [text setMaxSize: NSMakeSize(1e7, 1e7)];
  [text setVerticallyResizable: YES];
  [text setHorizontallyResizable: NO];
  [text setAutoresizingMask: NSViewWidthSizable];
  [[text textContainer] setContainerSize: NSMakeSize(contentSize.width, 1e7)];
  [[text textContainer] setWidthTracksTextView: YES];
  [text setEditable: NO];
  [text setSelectable: YES];
  [text setRichText: NO];

  [scroll setDocumentView: text];

  if (theTextView)
    {
      *theTextView = text;
    }

  return scroll;
}

NSScrollView *MakeTableScroller(NSRect theFrame, NSTableView **theTable,
				NSArray *theIdentifiers, NSArray *theTitles, NSArray *theWidths)
{
  NSScrollView *scroll;
  NSTableView *table;
  int i;

  scroll = [[[NSScrollView alloc] initWithFrame: theFrame] autorelease];
  [scroll setHasVerticalScroller: YES];
  [scroll setHasHorizontalScroller: NO];
  [scroll setBorderType: NSBezelBorder];
  [scroll setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];

  table = [[[NSTableView alloc] initWithFrame: [[scroll contentView] frame]] autorelease];

  for (i = 0; i < [theIdentifiers count]; i++)
    {
      NSTableColumn *column;

      column = [[[NSTableColumn alloc] initWithIdentifier: [theIdentifiers objectAtIndex: i]] autorelease];
      [[column headerCell] setStringValue: [theTitles objectAtIndex: i]];
      [column setWidth: [[theWidths objectAtIndex: i] floatValue]];
      [column setEditable: NO];
      [table addTableColumn: column];
    }

  [table setAllowsMultipleSelection: NO];
  [table setAllowsEmptySelection: YES];
  [table setAutoresizesAllColumnsToFit: YES];

  [scroll setDocumentView: table];

  if (theTable)
    {
      *theTable = table;
    }

  return scroll;
}
