/* Self-checking code-generation test.  No headers: only printf and exit are
   used from the C library.  Prints "FAIL n" for each failed check and
   "selftest: N failures" at the end; the exit status is the failure count.  */
extern int printf (const char *, ...);
typedef __builtin_va_list va_list;

static int failures;
#define CHECK(n, cond) do { if (!(cond)) { printf ("FAIL %d\n", (n)); failures++; } } while (0)

/* The calls below go through volatile pointers or noinline functions so that
   the optimizer cannot fold them away at -O2.  */
volatile int vi = 7, vj = -3;
volatile unsigned vu = 0xfffffff0u;
volatile long long vl = 0x123456789abLL, vm = -97;
volatile double vd = 2.5, ve = -0.125;
volatile float vf = 1.5f;
volatile short vs = -300;
volatile signed char vc = -5;

int sw (int x)
{
  switch (x) {
  case 0: return 11; case 1: return 22; case 2: return 33; case 3: return 44;
  case 4: return 55; case 5: return 66; case 6: return 77; case 7: return 88;
  case 100: return 5; default: return -1;
  }
}

int vsum (int n, ...)
{
  va_list ap; int s = 0;
  __builtin_va_start (ap, n);
  while (n--) s += __builtin_va_arg (ap, int);
  __builtin_va_end (ap);
  return s;
}

double dsum (int n, ...)
{
  va_list ap; double s = 0;
  __builtin_va_start (ap, n);
  while (n--) s += __builtin_va_arg (ap, double);
  __builtin_va_end (ap);
  return s;
}

struct small { char c; short s; };
struct big { int a[20]; };
struct mixed { double d; int i; char c; };

struct small mksmall (int x) { struct small r; r.c = x; r.s = x * 2; return r; }
struct big mkbig (int x) { struct big b; int i; for (i = 0; i < 20; i++) b.a[i] = x + i; return b; }
struct mixed mkmixed (int x) { struct mixed m; m.d = x * 0.5; m.i = x; m.c = 'z'; return m; }
int sumbig (struct big b) { int i, s = 0; for (i = 0; i < 20; i++) s += b.a[i]; return s; }
double mixarg (int a, double b, char c, float d, long long e, short f)
{ return a + b + c + d + e + f; }

int fact (int n) { return n <= 1 ? 1 : n * fact (n - 1); }
int apply (int (*f) (int), int x) { return f (x); }
int twice (int x) { return 2 * x; }

int use_alloca (int n)
{
  char *p = __builtin_alloca (n); int i, s = 0;
  for (i = 0; i < n; i++) p[i] = i;
  for (i = 0; i < n; i++) s += p[i];
  return s;
}

struct bf { unsigned a : 3, b : 5, c : 7; int d : 6; };
char buf[16];
static int cnt;
static void bump (void) { cnt++; }

int main (void)
{
  int i, s; long long q, r; unsigned long long uq; double d; float f;
  struct small sm; struct big bg; struct mixed mx; struct bf bits;
  char str[8];

  /* integers */
  CHECK (1, vi + vj == 4); CHECK (2, vi - vj == 10); CHECK (3, vi * vj == -21);
  CHECK (4, vi / vj == -2); CHECK (5, vi % vj == 1); CHECK (6, -vi / 2 == -3);
  CHECK (7, (vu >> 4) == 0x0fffffffu); CHECK (8, (vi << 3) == 56);
  CHECK (9, (vj >> 1) == -2); CHECK (10, (vu / 16u) == 0x0fffffffu);
  CHECK (11, (vu % 7u) == 0xfffffff0u % 7u); CHECK (12, vs * vs == 90000);
  CHECK (13, vc * 2 == -10); CHECK (14, (unsigned char) vc == 251);
  CHECK (15, (vi & 5) == 5 && (vi | 8) == 15 && (vi ^ 2) == 5 && ~vi == -8);
  /* long long */
  q = vl * vm; CHECK (16, q == 0x123456789abLL * -97);
  CHECK (17, vl / vm == 0x123456789abLL / -97); CHECK (18, vl % vm == 0x123456789abLL % -97);
  CHECK (19, (vl << 9) == 0x123456789abLL * 512); CHECK (20, (vl >> 5) == 0x123456789abLL / 32);
  uq = (unsigned long long) vl * 3; CHECK (21, uq / 3 == (unsigned long long) vl);
  CHECK (22, vl > vm && vm < 0 && vl != vm);
  CHECK (23, (long long) vi + vl == 0x123456789abLL + 7);
  /* floating point */
  d = vd * ve; CHECK (24, d == -0.3125); CHECK (25, vd / ve == -20.0);
  CHECK (26, vd + vf == 4.0); f = vf * 2; CHECK (27, f == 3.0f);
  CHECK (28, (int) vd == 2 && (int) (ve * 16) == -2); CHECK (29, (double) vi == 7.0);
  CHECK (30, (long long) (vd * 1e10) == 25000000000LL); CHECK (31, vd > ve && ve < 0);
  CHECK (32, (float) vd == 2.5f); CHECK (33, -vd == -2.5);
  CHECK (34, (unsigned) (vd * 4) == 10);
  d = 1.0; for (i = 0; i < 10; i++) d = d * 1.5 + 0.25; CHECK (35, d > 85.9 && d < 86.0);
  /* control flow */
  CHECK (36, sw (0) == 11 && sw (3) == 44 && sw (7) == 88 && sw (8) == -1 && sw (100) == 5 && sw (-1) == -1);
  s = 0; for (i = 0; i < 100; i++) { if (i & 1) continue; s += i; } CHECK (37, s == 2450);
  CHECK (38, fact (10) == 3628800); CHECK (39, apply (twice, 21) == 42);
  /* varargs */
  CHECK (40, vsum (4, 1, 2, 3, 4) == 10); CHECK (41, dsum (3, 1.5, 2.5, 3.0) == 7.0);
  /* structures */
  sm = mksmall (9); CHECK (42, sm.c == 9 && sm.s == 18);
  bg = mkbig (5); CHECK (43, bg.a[0] == 5 && bg.a[19] == 24); CHECK (44, sumbig (bg) == 290);
  mx = mkmixed (7); CHECK (45, mx.d == 3.5 && mx.i == 7 && mx.c == 'z');
  CHECK (46, mixarg (1, 2.5, 3, 0.5f, 5000000000LL, -4) == 5000000003.0);
  CHECK (47, mkbig (1).a[3] == 4);
  /* memory */
  CHECK (48, use_alloca (10) == 45); bits.a = 5; bits.b = 20; bits.c = 100; bits.d = -7;
  CHECK (49, bits.a == 5 && bits.b == 20 && bits.c == 100 && bits.d == -7);
  buf[3] = 'x'; CHECK (50, buf[3] == 'x' && buf[4] == 0);
  str[0] = 'h'; str[1] = 'i'; str[2] = 0;
  /* Old BSD libcs return 0 or a count from printf; only print what it gave. */
  i = printf ("%s %d %ld %5.2f %c\n", str, 42, 1234567L, 3.14159, 'q');
  printf ("printf returned %d\n", i);
  bump (); bump (); CHECK (52, cnt == 2);

  printf ("selftest: %d failures\n", failures);
  return failures;
}
