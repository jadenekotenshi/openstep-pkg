#define _PY_SHORT_FLOAT_REPR 1
double _Py_dg_strtod(const char *str, char **ptr);
char *_Py_dg_dtoa(double d, int mode, int ndigits, int *decpt, int *sign, char **rve);
void _Py_dg_freedtoa(char *s);
double _Py_dg_stdnan(int sign);
double _Py_dg_infinity(int sign);
