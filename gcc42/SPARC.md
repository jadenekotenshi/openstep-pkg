# gcc42 on sparc-next-openstep4

Status: **untested on hardware/emulator.** The port compiles as a Linux-hosted
cross compiler (`cc1`, `cc1plus`, `cc1obj`, `cc1objplus` all build) and emits
plausible SPARC V8 Mach-O assembly, but nothing has been assembled, linked or run
on OPENSTEP/SPARC yet.

## What it is

- `gcc/config/sparc/*` (FSF GCC 4.2.1 back end) comes from
  `gcc-sparc-config-4.2.1.tar.gz`; Apple's tree has no SPARC back end.
- `gcc/config.gcc`: `sparc-next-*` uses `sparc/sparc.h nextstep.h sparc/next.h`.
- `sparc/next.h` is the SPARC counterpart of `i386/next.h`; `sparc/t-next` copies
  `/NextDeveloper/Headers/*/sparc` to `include/*/__next_sparc__`.
- `nextstep.c` calls `NEXTSTEP_CPU_FILE_END` (only i386 defines it).
- Defaults: SPARC V8 (`with_cpu=v8` in `config.gcc`: OPENSTEP runs only on sun4m, so
  hardware `smul/sdiv/umul/udiv` are used; `-mcpu=v7` restores the `.mul/.div/...` calls),
  64-bit `long double`,
  standard SPARC struct return (hidden pointer in `[%sp+64]`, `unimp` word),
  `objc_msgSend_stret` for aggregate Objective-C results.

## Things to check on the emulator

Run on OPENSTEP/SPARC and send the output:

    arch; uname -a
    ls /NextDeveloper/Headers/bsd /NextDeveloper/Headers/architecture
    ls -d /NextDeveloper/Headers/*/sparc
    cat > t.c <<'EOF'
    struct S { int a, b, c; double d; };
    struct S mk(int x) { struct S s; s.a = x; s.b = x*3; s.c = x/7; s.d = x; return s; }
    long long q(long long a, long long b) { return a / b + a * b; }
    EOF
    /bin/cc -S -O2 t.c && cat t.s
    nm /usr/lib/libsys_s.a 2>/dev/null | egrep '\.(u?mul|u?div|u?rem)\b|muldi3|divdi3'
    nm -o /usr/lib/libobjc* 2>/dev/null | grep msgSend

and whether `/bin/as` accepts `umul`/`sdiv`/`smul` (now emitted by default) and `.align N` as a log2.
Open questions the output answers: the exact `.mul`/`.div` symbol names (with or
without a leading underscore), whether the native compiler calls `objc_msgSend_stret`,
whether `long double` should be 128-bit.
