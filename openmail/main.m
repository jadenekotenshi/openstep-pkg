/*
**  main.m
*/

#import <AppKit/AppKit.h>

#import "MailApp.h"

int main(int argc, char **argv)
{
  NSAutoreleasePool *pool;
  MailApp *delegate;

  pool = [[NSAutoreleasePool alloc] init];

  [NSApplication sharedApplication];

  delegate = [[MailApp alloc] init];
  [NSApp setDelegate: delegate];
  [delegate installMenus];

  [NSApp run];

  [delegate release];
  [pool release];
  return 0;
}
