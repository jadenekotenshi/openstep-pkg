#!/bin/sh
# Binary-search the smallest prefix of a C file that makes the compiler die with
# a fatal signal.  Cut points are top-level closing braces outside #if blocks, so
# every prefix is complete C.  Usage (from the build directory):
#
#   sh probe-bisect.sh ../../gcc/c-common.c /bin/cc <flags from the failing make line>
#
# Prints the last good cut line, the first crashing cut line, and the source
# between them.  Assumes that once a prefix crashes, longer prefixes crash too.
SRC=$1; shift
CC="$@"
TMPD=${TMPDIR:-/tmp}/probe-bisect.$$
mkdir $TMPD || exit 1

awk '/^#[ \t]*if/ { d++ } /^#[ \t]*endif/ { d-- } /^}/ && d == 0 { print NR }' \
    "$SRC" > $TMPD/cuts
n=`wc -l < $TMPD/cuts | sed 's/ //g'`
echo "$n cut points in $SRC"

# crashes LINE -> returns 0 if compiling the first LINE lines dies by a signal
crashes() {
    sed -n "1,${1}p" "$SRC" > $TMPD/p.c
    $CC -c $TMPD/p.c -o $TMPD/p.o > $TMPD/log 2>&1
    grep 'fatal signal' $TMPD/log > /dev/null 2>&1
}

cut() { sed -n "${1}p" $TMPD/cuts; }

last=`cut $n`
if crashes $last; then :; else
    echo "the full file (to line $last) does not crash with these flags"
    echo "last lines of output:"; tail -5 $TMPD/log
    rm -rf $TMPD; exit 1
fi

lo=0     # cut index known good (0 = nothing)
hi=$n    # cut index known to crash
while [ `expr $hi - $lo` -gt 1 ]; do
    mid=`expr \( $lo + $hi \) / 2`
    line=`cut $mid`
    if crashes $line; then
        hi=$mid; echo "line $line: CRASH"
    else
        lo=$mid; echo "line $line: ok"
    fi
done

good=0; [ $lo -gt 0 ] && good=`cut $lo`
bad=`cut $hi`
echo
echo "last good prefix: line $good"
echo "first crashing prefix: line $bad"
echo "the culprit is in lines `expr $good + 1`-$bad:"
sed -n "`expr $good + 1`,${bad}p" "$SRC" | sed -n 1,15p
rm -rf $TMPD
