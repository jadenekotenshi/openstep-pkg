#!/bin/sh

CONFIG_SHELL=${CONFIG_SHELL-/usr/local/bin/ksh}

run_configure() {
    if [ ! -x "$CONFIG_SHELL" ]; then
        echo "error: CONFIG_SHELL not executable: $CONFIG_SHELL" >&2
        exit 1
    fi

    export CONFIG_SHELL
    CONFIG_SHELL="$CONFIG_SHELL" "$CONFIG_SHELL" ./configure CONFIG_SHELL="$CONFIG_SHELL" "$@"
}

# pkg_arch_flags COMPILER...
# Print the default architecture flags pkg exports for the given compiler
# command: gcc-4.2 and friends get PKG_GCC42_ARCH_FLAGS, anything else (the
# system cc) gets PKG_SYSCC_ARCH_FLAGS.  Example:
#   CC=/usr/local/bin/gcc-4.2; CFLAGS="-O2 `pkg_arch_flags $CC`"
pkg_arch_flags() {
    for pkg_arch_cc in $1; do break; done

    case `basename "$pkg_arch_cc"` in
        gcc-4.2|g++-4.2|c++-4.2|cpp-4.2)
            echo "$PKG_GCC42_ARCH_FLAGS"
        ;;
        *)
            echo "$PKG_SYSCC_ARCH_FLAGS"
        ;;
    esac
}
