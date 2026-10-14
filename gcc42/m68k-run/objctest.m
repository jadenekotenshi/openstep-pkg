/* Objective-C code-generation test using only the system runtime (the Object
   root class in libsys) and printf; no headers.  */
extern int printf (const char *, ...);

static int failures;
#define CHECK(n, cond) do { if (!(cond)) { printf ("FAIL %d\n", (n)); failures++; } } while (0)

typedef struct { int a, b, c; double d; } V;
typedef struct { char c; } Tiny;
typedef struct objc_selector *SEL;

@interface Object { void *isa; }
+ new;
+ class;
+ (int) version;
- free;
- (int) isKindOf:(void *)aClass;
@end

@interface Base : Object { int bias; double scale; }
- (int) add:(int)a to:(int)b;
- (V) result:(int)v;
- (double) dbl;
- (double) scaled:(double)f;
- (void) setBias:(int)b;
- (int) bias;
- (Tiny) tiny;
- (long long) big:(long long)x;
+ (int) tag;
@end

@implementation Base
- (int) add:(int)a to:(int)b { return a + b + bias; }
- (V) result:(int)v { V r; r.a = bias; r.b = v; r.c = bias + v; r.d = 3.25; return r; }
- (double) dbl { return 3.25 * scale; }
- (double) scaled:(double)f { return f * scale; }
- (void) setBias:(int)b { bias = b; scale = 2.0; }
- (int) bias { return bias; }
- (Tiny) tiny { Tiny t; t.c = 'q'; return t; }
- (long long) big:(long long)x { return x * 1000; }
+ (int) tag { return 11; }
@end

@interface Kid : Base { int extra; }
- (V) result:(int)v;
- (int) add:(int)a to:(int)b;
- (int) viaSuper;
+ (int) tag;
@end

@implementation Kid
- (V) result:(int)v { V r = [super result:v]; r.c += 100; return r; }
- (int) add:(int)a to:(int)b { return [super add:a to:b] * 2; }
- (int) viaSuper { return [super bias] + 1000; }
+ (int) tag { return [super tag] + 1; }
@end

int main (void)
{
  Base *b = [Base new];
  Kid *k = [Kid new];
  V r; Tiny t;

  [b setBias:5]; [k setBias:7];
  CHECK (1, [b bias] == 5 && [k bias] == 7);
  CHECK (2, [b add:3 to:4] == 12);
  CHECK (3, [k add:3 to:4] == 28);
  r = [b result:11];
  CHECK (4, r.a == 5 && r.b == 11 && r.c == 16 && r.d == 3.25);
  r = [k result:11];
  CHECK (5, r.a == 7 && r.b == 11 && r.c == 118 && r.d == 3.25);
  CHECK (6, [b dbl] == 6.5 && [k dbl] == 6.5);
  CHECK (7, [b scaled:1.25] == 2.5);
  t = [b tiny];
  CHECK (8, t.c == 'q');
  CHECK (9, [b big:5000000LL] == 5000000000LL);
  CHECK (10, [Base tag] == 11 && [Kid tag] == 12);
  CHECK (11, [k viaSuper] == 1007);
  CHECK (12, [k isKindOf:[Base class]] && ![b isKindOf:[Kid class]]);
  { SEL s = @selector (add:to:); CHECK (13, s == @selector (add:to:)); }
  [b free]; [k free];

  printf ("objctest: %d failures\n", failures);
  return failures;
}
