#!/bin/sh
# Link and run the self-checking programs whose assembly the cross-compiled
# cc1 produced (selftest-*.s), with the stock cc as assembler and linker.
# libgcc/*.s are GCC's libgcc2.c units (64-bit integer and conversion
# routines), compiled the same way, linked in because the stock library does
# not have them.
# Run on NeXTSTEP/m68k from this directory:   sh run-tests.sh
# Set CC to use a different driver (default /bin/cc).
CC=${CC:-/bin/cc}
TMPD=${TMPDIR:-/tmp}/run-tests.$$
mkdir $TMPD || exit 1
bad=0
for f in selftest-*.s; do
    name=`echo $f | sed 's/\.s$//'`
    if $CC -o $TMPD/$name $f libgcc/*.s > $TMPD/log 2>&1; then
        $TMPD/$name > $TMPD/out 2>&1
        status=$?
        if [ $status = 0 ]; then
            echo "$f: ok"
        else
            echo "$f: FAILED (exit $status)"; bad=1
            sed 's/^/    /' $TMPD/out | sed -n 1,20p
        fi
    else
        echo "$f: could not link"; bad=1
        sed 's/^/    /' $TMPD/log | sed -n 1,20p
    fi
done
rm -rf $TMPD
exit $bad
