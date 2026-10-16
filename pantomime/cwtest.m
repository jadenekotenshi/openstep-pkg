/*
**  cwtest.m
**
**  Offline checks of the parts of Pantomime that the OPENSTEP port had to
**  touch: MIME parsing and generation, header encoding, character sets,
**  IMAP mailbox name encoding and the Foundation compatibility layer.
**  Prints "ok" lines and a summary; exits non-zero if anything failed.
*/

#import <Foundation/Foundation.h>
#import <Pantomime/Pantomime.h>

#include <stdio.h>
#include <string.h>

static int failures = 0;
static int checks = 0;

static void check(int theCondition, const char *theLabel)
{
  checks++;

  if (theCondition)
    {
      printf("ok   %s\n", theLabel);
    }
  else
    {
      printf("FAIL %s\n", theLabel);
      failures++;
    }
}

static int same(NSString *a, NSString *b)
{
  return a && b && [a isEqualToString: b];
}

static const char *MULTIPART =
"From: Bob <bob@example.org>\n"
"To: test@localhost\n"
"Cc: carol@example.org\n"
"Subject: Report with attachment\n"
"Date: Thu, 08 Oct 2026 09:15:00 -0600\n"
"Message-ID: <multi-3@example.org>\n"
"MIME-Version: 1.0\n"
"Content-Type: multipart/mixed; boundary=\"XXBOUNDARYXX\"\n"
"\n"
"--XXBOUNDARYXX\n"
"Content-Type: text/plain; charset=ISO-8859-1\n"
"Content-Transfer-Encoding: quoted-printable\n"
"\n"
"Gr=FC=DFe, caf=E9.\n"
"--XXBOUNDARYXX\n"
"Content-Type: application/octet-stream; name=\"data.bin\"\n"
"Content-Disposition: attachment; filename=\"data.bin\"\n"
"Content-Transfer-Encoding: base64\n"
"\n"
"AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1Njc4\n"
"OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5fYGFiY2RlZmdoaWprbG1ub3Bx\n"
"cnN0dXZ3eHl6e3x9fn8=\n"
"--XXBOUNDARYXX--\n";

static const char *ENCODED_SUBJECT =
"From: =?UTF-8?B?SsO8cmdlbiBNw7xsbGVy?= <juergen@example.org>\n"
"To: test@localhost\n"
"Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe_aus_K=C3=B6ln?=\n"
"Date: Wed, 07 Oct 2026 11:30:00 +0200\n"
"Message-ID: <utf8-2@example.org>\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: quoted-printable\n"
"\n"
"Sch=C3=B6ne Gr=C3=BC=C3=9Fe!\n";

static void test_utf7(void)
{
  unichar chars[] = {'T', 0x00e4, 's', 't', '/', 0x00fc, '&', 'x'};
  NSString *s, *e;
  unichar emoji[] = {0xd83d, 0xde00};

  s = [NSString stringWithCharacters: chars  length: 8];
  e = [s modifiedUTF7String];
  check(same(e, @"T&AOQ-st/&APw-&-x"), "modified UTF-7 encodes ä ü &");
  check(same([e stringFromModifiedUTF7], s), "modified UTF-7 round trip");

  check(same([@"INBOX.Sent" modifiedUTF7String], @"INBOX.Sent"), "modified UTF-7 leaves ASCII alone");

  s = [NSString stringWithCharacters: emoji  length: 2];
  e = [s modifiedUTF7String];
  check(same(e, @"&2D3eAA-"), "modified UTF-7 surrogate pair");
  check(same([e stringFromModifiedUTF7], s), "modified UTF-7 surrogate round trip");

  chars[0] = 0xe4;
  chars[1] = 0xe4;
  check(same([@"&AOQ-&AOQ-" stringFromModifiedUTF7], [NSString stringWithCharacters: chars  length: 2]),
	"modified UTF-7 adjacent runs");
}

static void test_compat(void)
{
  NSMutableString *m;
  NSMutableData *d;
  NSValue *v;
  NSRange r;
  NSString *s;
  unsigned int n;

  m = [NSMutableString stringWithString: @"a\\(b\\(c"];
  n = [m replaceOccurrencesOfString: @"\\("  withString: @"("  options: 0  range: NSMakeRange(0, [m length])];
  check(n == 2 && same(m, @"a(b(c"), "replaceOccurrencesOfString:withString:options:range:");

  m = [NSMutableString stringWithString: @"xx"];
  n = [m replaceOccurrencesOfString: @"x"  withString: @"yyy"  options: 0  range: NSMakeRange(0, 2)];
  check(n == 2 && same(m, @"yyyyyy"), "replaceOccurrences with a longer replacement");

  d = [NSMutableData dataWithBytes: "abcdef"  length: 6];
  [d replaceBytesInRange: NSMakeRange(2, 2)  withBytes: "XYZ"  length: 3];
  check([d length] == 7 && !memcmp([d bytes], "abXYZef", 7), "replaceBytesInRange:withBytes:length: grow");

  [d replaceBytesInRange: NSMakeRange(1, 4)  withBytes: NULL  length: 0];
  check([d length] == 3 && !memcmp([d bytes], "aef", 3), "replaceBytesInRange:withBytes:length: delete");

  v = [NSValue valueWithRange: NSMakeRange(3, 4)];
  r = [v rangeValue];
  check(r.location == 3 && r.length == 4, "valueWithRange: / rangeValue");

  s = [@"gr%C3%BC%C3%9Fe%20x" stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
  check(s && [s length] == 7 && [s characterAtIndex: 2] == 0xfc, "stringByReplacingPercentEscapesUsingEncoding:");

  s = [NSString stringWithUTF8String: "K\303\266ln"];
  check(s && [s length] == 4 && [s characterAtIndex: 1] == 0xf6, "stringWithUTF8String:");
  check(s && !strcmp([s UTF8String], "K\303\266ln"), "UTF8String");

  check([NSNull null] == [NSNull null], "NSNull");
}

static void test_regex(void)
{
  CWRegEx *re;
  NSArray *matches;
  CWMessage *m;
  NSRange r;

  re = [CWRegEx regexWithPattern: @"[0-9]+"];
  matches = [re matchString: @"abc 123 def 45"];
  check(matches && [matches count] == 2, "regular expression finds two matches");

  if ([matches count] == 2)
    {
      r = [[matches objectAtIndex: 1] rangeValue];
      check(r.location == 12 && r.length == 2, "regular expression match range");
    }

  m = [[[CWMessage alloc] init] autorelease];
  [m setSubject: @"Re: Fwd: Re: lunch tomorrow"];
  check(same([m baseSubject], @"lunch tomorrow"), "base subject strips Re: and Fwd:");
}

static void test_charsets(void)
{
  NSString *s;
  unichar euro = 0x20ac;

  s = [NSString stringWithData: [NSData dataWithBytes: "\244"  length: 1]
		charset: [@"iso-8859-15" dataUsingEncoding: NSASCIIStringEncoding]];
  check(s && [s length] == 1 && [s characterAtIndex: 0] == euro, "iso-8859-15 euro sign");

  s = [NSString stringWithData: [NSData dataWithBytes: "\317\304\301"  length: 3]
		charset: [@"koi8-r" dataUsingEncoding: NSASCIIStringEncoding]];
  check(s && [s length] == 3 && [s characterAtIndex: 0] == 0x043e, "koi8-r");

  s = [NSString stringWithData: [NSData dataWithBytes: "\374"  length: 1]
		charset: [@"iso-8859-1" dataUsingEncoding: NSASCIIStringEncoding]];
  check(s && [s length] == 1 && [s characterAtIndex: 0] == 0xfc, "iso-8859-1");

  s = [NSString stringWithData: [NSData dataWithBytes: "\303\266"  length: 2]
		charset: [@"utf-8" dataUsingEncoding: NSASCIIStringEncoding]];
  check(s && [s length] == 1 && [s characterAtIndex: 0] == 0xf6, "utf-8");
}

static void test_headers(void)
{
  NSData *d;
  NSString *s;
  unichar uuml[] = {'G', 'r', 0xfc, 0xdf, 'e'};

  s = [NSString stringWithCharacters: uuml  length: 5];
  d = [CWMIMEUtility encodeWordUsingQuotedPrintable: s  prefixLength: 9];
  check(d && [d length] > 0 && !strncmp([d bytes], "=?", 2), "encode a header word");

  s = [CWMIMEUtility decodeHeader: [@"=?UTF-8?Q?Gr=C3=BC=C3=9Fe_aus_K=C3=B6ln?=" dataUsingEncoding: NSASCIIStringEncoding]
		     charset: nil];
  check(s && [s length] == 14 && [s characterAtIndex: 2] == 0xfc, "decode a quoted-printable header word");

  s = [CWMIMEUtility decodeHeader: [@"=?UTF-8?B?SsO8cmdlbiBNw7xsbGVy?=" dataUsingEncoding: NSASCIIStringEncoding]
		     charset: nil];
  check(s && [s length] == 13 && [s characterAtIndex: 1] == 0xfc, "decode a base64 header word");
}

static void test_addresses(void)
{
  CWInternetAddress *a;

  a = [[[CWInternetAddress alloc] initWithString: @"Alice Example <alice@example.org>"] autorelease];
  check(a && same([a address], @"alice@example.org"), "address part");
  check(a && same([a personal], @"Alice Example"), "personal part");

  a = [[[CWInternetAddress alloc] initWithString: @"bob@example.org"] autorelease];
  check(a && same([a address], @"bob@example.org"), "bare address");
}

static void test_parse(void)
{
  CWMessage *m;
  CWMIMEMultipart *mp;
  CWPart *p;
  NSData *data;
  NSString *s;
  unsigned char all[128];
  int i;

  m = [[[CWMessage alloc] initWithData: [NSData dataWithBytes: MULTIPART  length: strlen(MULTIPART)]] autorelease];
  check(m != nil, "parse a multipart message");
  check(m && same([m subject], @"Report with attachment"), "subject");
  check(m && same([[m from] address], @"bob@example.org"), "from");
  check(m && [[m recipients] count] == 2, "two recipients (To and Cc)");
  check(m && same([m messageID], @"<multi-3@example.org>"), "message id");

  mp = (CWMIMEMultipart *)[m content];
  check(mp && [mp isKindOfClass: [CWMIMEMultipart class]] && [mp count] == 2, "two parts");

  p = [mp partAtIndex: 0];
  check(p && same([p contentType], @"text/plain"), "first part is text/plain");
  s = [[[NSString alloc] initWithData: (NSData *)[p content]  encoding: NSISOLatin1StringEncoding] autorelease];
  check(s && [s length] >= 10 && [s characterAtIndex: 2] == 0xfc && [s characterAtIndex: 3] == 0xdf,
	"quoted-printable body decoded");

  p = [mp partAtIndex: 1];
  check(p && same([p filename], @"data.bin"), "attachment file name");
  data = (NSData *)[p content];

  for (i = 0; i < 128; i++)
    {
      all[i] = (unsigned char)i;
    }

  check(data && [data length] == 128 && !memcmp([data bytes], all, 128), "base64 attachment decoded");

  m = [[[CWMessage alloc] initWithData: [NSData dataWithBytes: ENCODED_SUBJECT  length: strlen(ENCODED_SUBJECT)]] autorelease];
  s = [m subject];
  check(s && [s length] == 14 && [s characterAtIndex: 2] == 0xfc, "encoded subject");
  s = [[m from] personal];
  check(s && [s length] == 13 && [s characterAtIndex: 1] == 0xfc, "encoded from");
}

static void test_generate(void)
{
  CWMessage *m, *back;
  CWInternetAddress *a;
  NSData *data;
  NSString *s;
  const char *d;
  unichar subject[] = {'K', 0xf6, 'l', 'n'};
  unichar body[] = {'S', 'c', 'h', 0xf6, 'n', '\n'};

  m = [[[CWMessage alloc] init] autorelease];
  [m setSubject: [NSString stringWithCharacters: subject  length: 4]];

  a = [[[CWInternetAddress alloc] initWithString: @"Me <me@example.org>"] autorelease];
  [m setFrom: a];
  a = [[[CWInternetAddress alloc] initWithString: @"you@example.org"] autorelease];
  [a setType: PantomimeToRecipient];
  [m addRecipient: a];

  [m setContentType: @"text/plain"];
  [m setCharset: @"utf-8"];
  [m setContentTransferEncoding: PantomimeEncodingQuotedPrintable];
  s = [NSString stringWithCharacters: body  length: 6];
  [m setContent: [s dataUsingEncoding: NSUTF8StringEncoding]];

  data = [m dataValue];
  check(data && [data length] > 0, "generate a message");

  d = [data bytes];
  check(d && strstr(d, "Date: ") != NULL, "has a Date header");
  check(d && strstr(d, "From: ") != NULL && strstr(d, "To: you@example.org") != NULL, "has From and To");
  check(d && strstr(d, "Sch=C3=B6n") != NULL, "body is quoted-printable UTF-8");

  back = [[[CWMessage alloc] initWithData: data] autorelease];
  s = [back subject];
  check(s && [s length] == 4 && [s characterAtIndex: 1] == 0xf6, "generated subject reads back");
  s = [[[NSString alloc] initWithData: (NSData *)[back content]  encoding: NSUTF8StringEncoding] autorelease];
  check(s && [s length] == 6 && [s characterAtIndex: 3] == 0xf6, "generated body reads back");
}

int main(int argc, char **argv)
{
  NSAutoreleasePool *pool;

  pool = [[NSAutoreleasePool alloc] init];

  test_compat();
  test_utf7();
  test_regex();
  test_charsets();
  test_headers();
  test_addresses();
  test_parse();
  test_generate();

  printf("%d checks, %d failed\n", checks, failures);

  [pool release];
  return failures ? 1 : 0;
}
