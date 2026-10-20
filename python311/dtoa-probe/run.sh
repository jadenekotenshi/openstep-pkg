#!/bin/sh
# Builds Python's dtoa.c (the float <-> string code) with a tiny test program,
# at several optimisation levels, and runs each for at most 20 seconds.
#   sh run.sh /path/to/Python-3.11.17/Python/dtoa.c
# Prints what each build converts "5e-324" and a few other numbers to.
dtoa=$1
[ -f "$dtoa" ] || { echo "usage: sh run.sh /path/to/Python/dtoa.c"; exit 2; }
here=`pwd`
CC=${CC-/usr/local/bin/gcc-4.2}
# The stub Python.h declares malloc and friends itself; drop dtoa.c's one libc include.
sed 's/#include <stdlib.h>.*//' "$dtoa" > "$here/dtoa-stub.c"
for flags in "-O0" "-O1" "-O2" "-O3" "-O3 -fno-strict-aliasing"; do
    echo "=== $flags"
    $CC $flags -w -DNeXT -I"$here" -c "$here/dtoa-stub.c" -o "$here/dtoa-stub.o" || continue
    $CC $flags -w -DNeXT -I"$here" -c "$here/main.c" -o "$here/main.o" || continue
    $CC -o "$here/probe" "$here/dtoa-stub.o" "$here/main.o" || continue
    "$here/probe" > "$here/probe.out" 2>&1 &
    pid=$!
    n=0
    while kill -0 $pid 2>/dev/null && [ $n -lt 20 ]; do
        sleep 1
        n=`expr $n + 1`
    done
    if kill -0 $pid 2>/dev/null; then
        kill -9 $pid
        echo "HUNG (killed after 20 s); output so far:"
    fi
    cat "$here/probe.out"
done
