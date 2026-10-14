// C++ code-generation test that needs no C++ runtime library: no exceptions,
// RTTI or thread-safe statics.  Only printf is used from the C library.
extern "C" int printf (const char *, ...);

// placement new, so that nothing needs operator new from libstdc++
inline void *operator new (__SIZE_TYPE__, void *p) { return p; }

// the deleting destructors refer to operator delete (libstdc++ has the real one)
void operator delete (void *) {}

static int failures;
#define CHECK(n, cond) do { if (!(cond)) { printf ("FAIL %d\n", (n)); failures++; } } while (0)

static int order[8], norder;
static int ctor_order, dtor_order;

struct Shape {
  int id;
  Shape (int i) : id (i) { order[norder++] = i; }
  virtual ~Shape () { dtor_order = dtor_order * 10 + id; }
  virtual int area () const { return 0; }
  virtual double scale (double f) const { return f * id; }
  int twice () const { return area () * 2; }
};
struct Rect : Shape {
  int w, h;
  Rect (int a, int b) : Shape (1), w (a), h (b) {}
  int area () const { return w * h; }
};
struct Square : Rect {
  Square (int s) : Rect (s, s) { id = 2; }
  int area () const { return Rect::area () + 1; }
  double scale (double f) const { return f / 2; }
};
struct Mixin { int m; Mixin () : m (40) {} virtual int mix () const { return m; } };
struct Both : Shape, Mixin {
  Both () : Shape (3) {}
  int area () const { return 100; }
  int mix () const { return m + 2; }
};

template <class T> T maxof (T a, T b) { return a > b ? a : b; }
template <class T, int N> struct Arr {
  T v[N];
  T sum () const { T s = T (); for (int i = 0; i < N; i++) s += v[i]; return s; }
};
template <class T> struct Counter { static int count; Counter () { count++; } };
template <class T> int Counter<T>::count;

struct Vec {
  double x, y;
  Vec (double a = 0, double b = 0) : x (a), y (b) {}
  Vec operator+ (const Vec &o) const { return Vec (x + o.x, y + o.y); }
  Vec &operator*= (double f) { x *= f; y *= f; return *this; }
  bool operator== (const Vec &o) const { return x == o.x && y == o.y; }
};

struct Global {
  int v;
  Global () : v (77) { ctor_order = ctor_order * 10 + 1; }
  ~Global () {}
};
static Global global_obj;

static int ref_set (int &r, int v) { int old = r; r = v; return old; }
static int overloaded (int x) { return x; }
static int overloaded (double x) { return (int) (x * 2); }
static int overloaded (const char *s) { return s[0]; }

int main ()
{
  CHECK (1, global_obj.v == 77);
  CHECK (2, ctor_order == 1);

  Rect r (3, 4);
  Square sq (5);
  Shape *shapes[3] = { &r, &sq, 0 };
  CHECK (3, shapes[0]->area () == 12);
  CHECK (4, shapes[1]->area () == 26);
  CHECK (5, shapes[0]->twice () == 24 && shapes[1]->twice () == 52);
  CHECK (6, shapes[1]->scale (10) == 5.0 && shapes[0]->scale (10) == 10.0);
  CHECK (7, norder == 2 && order[0] == 1 && order[1] == 1);

  Both b;
  Shape *sp = &b; Mixin *mp = &b;
  CHECK (8, sp->area () == 100 && mp->mix () == 42);
  CHECK (9, (char *) mp != (char *) sp);
  CHECK (10, ((Both *) mp)->id == 3);

  CHECK (11, maxof (3, 9) == 9 && maxof (2.5, -1.0) == 2.5);
  Arr<int, 5> ai = { { 1, 2, 3, 4, 5 } };
  Arr<double, 3> ad = { { 0.5, 1.5, 2.0 } };
  CHECK (12, ai.sum () == 15 && ad.sum () == 4.0);
  Counter<int> c1, c2; Counter<char> c3;
  CHECK (13, Counter<int>::count == 2 && Counter<char>::count == 1);

  Vec v (1, 2), w (0.5, 0.25);
  Vec s = v + w; s *= 2;
  CHECK (14, s.x == 3.0 && s.y == 4.5);
  CHECK (15, s == Vec (3.0, 4.5) && !(s == v));

  int n = 5;
  CHECK (16, ref_set (n, 9) == 5 && n == 9);
  CHECK (17, overloaded (4) == 4 && overloaded (1.5) == 3 && overloaded ("A") == 65);

  Shape *heap = new (__builtin_alloca (sizeof (Rect))) Rect (2, 3);
  CHECK (18, heap->area () == 6);
  heap->~Shape ();
  CHECK (19, dtor_order == 1);

  printf ("cxxtest: %d failures\n", failures);
  return failures;
}
