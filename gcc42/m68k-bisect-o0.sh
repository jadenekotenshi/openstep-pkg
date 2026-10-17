#!/bin/sh
# m68k-bisect-o0.sh GCC_BUILD_DIR PREPROCESSED_FILE OBJECT...
#
# Finds which object file of cc1objplus (or cc1plus, cc1) the stage-2 compiler
# miscompiled: rebuilds the named objects at -O0, relinks the compiler and runs
# it on PREPROCESSED_FILE (a -fpreprocessed .ii that it should accept).
#
#   cd .../build-openstep/gcc          (where cc1objplus is built)
#   sh <repo>/gcc42/m68k-bisect-o0.sh `pwd` /tmp/return.ii \
#       objcp/objcp-act.o objcp/objcp-decl.o objcp/objcp-lang.o
#
# It prints what it did and ends with "PASS" or "FAIL".  The objects stay at
# -O0 afterwards; a later run with more objects adds to them.
#
# TARGET=cc1plus (or cc1) tests another compiler proper; default cc1objplus.
set -e
PATH=/usr/local/bin:/usr/ucb:/bin:/usr/bin:$PATH
dir=$1; ii=$2
shift 2
cd "$dir"
target=${TARGET-cc1objplus}
make=/usr/local/bin/gnumake
o0='-O0 -D_POSIX_SOURCE'

for o in "$@"; do
    echo "==> rebuilding $o at -O0"
    rm -f "$o"
    $make CFLAGS="$o0" "$o"
done

echo "==> relinking $target"
rm -f "$target"
$make CFLAGS="$o0" "$target"

echo "==> running $target on $ii"
if ./$target -quiet -O0 -fpreprocessed "$ii" -o /tmp/bisect-out.s 2>/tmp/bisect-err.log; then
    echo PASS
else
    cat /tmp/bisect-err.log | head -5
    echo FAIL
fi
