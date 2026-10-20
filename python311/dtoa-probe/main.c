extern int printf(const char *, ...);
extern double _Py_dg_strtod(const char *, char **);
extern char *_Py_dg_dtoa(double, int, int, int *, int *, char **);
int errno_dummy;
int main(int argc, char **argv) {
    const char *t[] = {"5e-324","1e-323","2.2250738585072014e-308","2.225073858507201e-308","1e-310","4.9406564584124654e-324","1.7976931348623157e308","0.1","3.25", 0};
    int i;
    for (i = 0; t[i]; i++) {
        char *end; double d = _Py_dg_strtod(t[i], &end);
        unsigned int *w = (unsigned int *)&d;
        int decpt, sign; char *e; char *r;
        printf("strtod(%s) = %08x %08x\n", t[i], w[0], w[1]);
        r = _Py_dg_dtoa(d, 0, 0, &decpt, &sign, &e);
        printf("   dtoa: %s decpt=%d sign=%d\n", r, decpt, sign);
    }
    return 0;
}
