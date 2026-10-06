#!/bin/sh

CONFIG_SHELL=${CONFIG_SHELL-/usr/local/bin/ksh}

# run_configure ARGS...
# Runs ./configure under $CONFIG_SHELL (default /usr/local/bin/ksh).  A build
# that needs a different shell can set CONFIG_SHELL itself (and depend on the
# package that provides it, e.g. bash), and setting PKG_CONFIG_SHELL in the
# environment overrides it for every package:
#   PKG_CONFIG_SHELL=/usr/local/bin/bash pkg build sudo
run_configure() {
    if [ -n "${PKG_CONFIG_SHELL-}" ]; then
        CONFIG_SHELL=$PKG_CONFIG_SHELL
    fi

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

# pkg_step NAME COMMAND [ARG...]
# Run COMMAND, then record NAME as done in the build directory.  With
# PKG_RESUME set (pkg resumes the build tree of a failed run), a step that
# already completed is skipped, unless it is listed in PKG_REDO:
#   PKG_RESUME=1 pkg install sudo                      # pick up where it stopped
#   PKG_RESUME=1 PKG_REDO=configure pkg install sudo   # ...but configure again
pkg_step() {
    pkg_step_name=$1
    shift

    if [ -n "${PKG_RESUME-}" ] && [ -f ".pkg-step-$pkg_step_name" ]; then
        case " ${PKG_REDO-} " in
            *" $pkg_step_name "*)
                :
            ;;
            *)
                echo "==> resuming: step $pkg_step_name already done, skipping"
                return 0
            ;;
        esac
    fi

    "$@"
    : > ".pkg-step-$pkg_step_name"
}

# pkg_apply_patch PATCHFILE [STRIP]
# Apply PATCHFILE (default -p1) and keep a copy of what was applied.  When the
# build is resumed and PATCHFILE has changed since, the old patch is reversed
# first, so a patch can be edited and the same tree rebuilt incrementally.
pkg_apply_patch() {
    pkg_patch_file=$1
    pkg_patch_strip=${2-1}
    pkg_patch_copy=.pkg-patch-`basename "$pkg_patch_file"`

    if [ -f "$pkg_patch_copy" ]; then
        if cmp -s "$pkg_patch_copy" "$pkg_patch_file"; then
            echo "==> resuming: $pkg_patch_file already applied, skipping"
            return 0
        fi
        echo "==> resuming: $pkg_patch_file changed, reversing the old version"
        patch -R -p$pkg_patch_strip < "$pkg_patch_copy"
        /bin/rm -f "$pkg_patch_copy"
    fi

    patch -p$pkg_patch_strip < "$pkg_patch_file"
    /bin/cp "$pkg_patch_file" "$pkg_patch_copy"
}
