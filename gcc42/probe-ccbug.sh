#!/bin/sh
# Find what in iasm_ptr_conv (gcc/c-common.c) crashes the stock OPENSTEP/SPARC
# cc 2.7.2.1.  Run from the build directory (gcc-gcc-5666.3/build-openstep/gcc),
# passing the source file, the compiler and the exact flags make used:
#
#   sh /path/to/probe-ccbug.sh ../../gcc/c-common.c /bin/cc <flags from make>
#
# Each variant is the file truncated after iasm_ptr_conv, with one change.
# "ok" means the compiler survived; "CRASH" means it died.
SRC=$1; shift
CC="$@"
TMPD=${TMPDIR:-/tmp}/probe-ccbug.$$
mkdir $TMPD || exit 1

start=`grep -n '^iasm_ptr_conv' "$SRC" | sed 's/:.*//'`
sed -n "${start},\$p" "$SRC" > $TMPD/tail.c
rel=`grep -n '^}' $TMPD/tail.c | sed -n 1p | sed 's/:.*//'`
end=`expr $start + $rel - 1`
echo "iasm_ptr_conv is lines $start-$end of $SRC"

sed -n "1,${end}p" "$SRC" > $TMPD/full.c

try() {
    name=$1; file=$2
    if $CC -c "$file" -o $TMPD/out.o > $TMPD/log 2>&1; then
        echo "$name: ok"
    else
        echo "$name: CRASH or error"; tail -2 $TMPD/log | sed 's/^/    /'
    fi
}

mk() { # name sed-script
    sed "${start},${end}$2" $TMPD/full.c > $TMPD/$1.c
    try "$1" $TMPD/$1.c
}

try "v0-original-truncated" $TMPD/full.c
mk v1-no-iasm_get_mode 's/to_mode = iasm_get_mode (type);/to_mode = VOIDmode;/'
mk v2-no-compare '{
/to_mode == TYPE_MODE (rhstype)/{
N
d
}
}'
mk v3-int-compare 's/if (to_mode == TYPE_MODE (rhstype))/if ((int) to_mode == (int) TYPE_MODE (rhstype))/'
mk v4-swapped 's/if (to_mode == TYPE_MODE (rhstype))/if (TYPE_MODE (rhstype) == to_mode)/'
mk v5-no-type_for_mode 's/ntype = c_common_type_for_mode (to_mode, 0);/ntype = NULL_TREE;/'
mk v6-no-rhstype 's/rhstype = TREE_TYPE (exp);/rhstype = type;/'
rm -rf $TMPD
