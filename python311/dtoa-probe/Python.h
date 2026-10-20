typedef unsigned int uint32_t; typedef unsigned long long uint64_t; typedef int int32_t; typedef long long int64_t;
typedef long Py_ssize_t; typedef unsigned int Py_UCS4; typedef unsigned long size_t;
extern void *malloc(size_t); extern void free(void *); extern void *memcpy(void *, const void *, size_t);
extern void exit(int); extern int strlen(const char*); extern void *memset(void*,int,size_t);
#define NULL ((void*)0)
#define PyMem_Malloc malloc
#define PyMem_Free free
#define Py_LOCAL_INLINE(t) static t
#define DOUBLE_IS_BIG_ENDIAN_IEEE754 1
#define WORDS_BIGENDIAN 1
#define INT_MAX 2147483647
#define LONG_MAX 2147483647L
#define UINT_MAX 4294967295U
#define SIZE_MAX 4294967295UL
#define PY_SSIZE_T_MAX 2147483647L
#define assert(x) ((void)0)
#define errno (*(&errno_dummy))
extern int errno_dummy;
#define ENOMEM 12
#define ERANGE 34
