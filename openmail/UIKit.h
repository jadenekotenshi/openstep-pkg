/*
**  UIKit.h  (not Apple's: a few helpers for building windows in code)
**
**  There is no Interface Builder here, so the windows are made by hand.
**  These make the usual controls.
*/

#ifndef _OpenMail_UIKit_H
#define _OpenMail_UIKit_H

#import <AppKit/AppKit.h>

/* A text label (not editable, no border). */
NSTextField *MakeLabel(NSString *theTitle, NSRect theFrame);

/* An editable text field. */
NSTextField *MakeField(NSRect theFrame);

/* A push button. */
NSButton *MakeButton(NSString *theTitle, id theTarget, SEL theAction, NSRect theFrame);

/* A check box. */
NSButton *MakeCheckBox(NSString *theTitle, NSRect theFrame);

/* A scroll view with a read-only text view inside; the text view is returned
   through theTextView. */
NSScrollView *MakeTextScroller(NSRect theFrame, NSTextView **theTextView);

/* A scroll view holding a table with the given (identifier, title, width) columns. */
NSScrollView *MakeTableScroller(NSRect theFrame, NSTableView **theTable,
				NSArray *theIdentifiers, NSArray *theTitles, NSArray *theWidths);

#endif
