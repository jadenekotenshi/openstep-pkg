# `pkg`

A minimal package manager for OPENSTEP.

## Usage

```sh
sh ./pkg download bash
sh ./pkg build bash
sh ./pkg install bash
sh ./pkg install bash grep
sh ./pkg test bash
sh ./pkg list
sh ./pkg remove bash
```

## Configuration

Site options live outside the package tree in `/usr/local/etc/pkg.conf` (under `PKG_ROOT`
when that is set; point `PKG_CONF` at another file to override).  The file is plain `sh`
`VAR=value` lines and is optional: every option has a default.  `pkg.conf.example` is a
template, and `./pkg config` prints the file in use and the resolved values.  Options are
exported to every `build`, `test`, `post-install` and `pre-remove` hook, so packages can
adapt to them.

| option     | default | meaning |
| ---------- | ------- | ------- |
| `HAVE_X11` | `0`     | `1` if an X11 server (CubXWindow or similar) and its development headers and libraries are installed |
| `X11_PREFIX` | `/usr/X11R6` | directory holding the X11 `include/` and `lib/` (CubXWindow installs under `/usr/X11R6`) |

An environment variable of the same name sets the default, and the file overrides it.

### Declaring what a package needs

A package may have an optional `requires` file listing the options it cares about, one per
line (`#` comments and blank lines are allowed):

```
HAVE_X11      # required: refuse to build or install without it
?HAVE_X11     # optional: build extra features when it is 1
```

* **Required** (`HAVE_X11`): `pkg build` and `pkg install` check the package and every
  not-yet-installed dependency up front and stop, before anything is built, with a message
  such as `cannot build xclock ...: libfoo needs HAVE_X11=1`.
* **Optional** (`?HAVE_X11`): nothing is refused.  `pkg` logs whether the feature is enabled,
  and the `build` script tests `$HAVE_X11` to add or omit the X11 configure options.  The value
  used is recorded in the package database; if `pkg.conf` changes later, `pkg list` shows
  `[rebuild to apply: HAVE_X11 (built with 0, now 1)]` and `pkg install` prints a note.  Remove
  and reinstall the package to pick up the change.
* An option name `pkg` does not know is an error, so typos are caught.

A `depends` entry can be made conditional on an option with `?OPTION:package`, for example
`?HAVE_X11:neXtaw`: the dependency is installed (and checked) only when that option is 1, and is
ignored otherwise.  `!package` conflicts work the same way (`?HAVE_X11:!package`).

A `build` script typically does:

```sh
if [ "$HAVE_X11" = 1 ]; then
    X11_OPTS="--with-x --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib"
else
    X11_OPTS=--without-x
fi
```

## Architecture

`pkg` detects the machine with `arch(1)` (`i386`, `sparc`, `m68k` or `hppa`; i386 if
`arch` is missing, or set `PKG_ARCH` to override) and exports to every `build`, `test`,
`post-install` and `pre-remove` hook:

| variable               | i386            | sparc            | m68k, hppa |
| ---------------------- | --------------- | ---------------- | ---------- |
| `PKG_ARCH`             | `i386`          | `sparc`          | `m68k`, `hppa` |
| `PKG_TARGET`           | `i386-next-openstep4` | `sparc-next-openstep4` | `<arch>-next-openstep4` |
| `PKG_SYSCC_ARCH_FLAGS` | `-m486`         | `-mv8`           | none       |
| `PKG_GCC42_ARCH_FLAGS` | `-march=i486`   | none (V8 is the default) | none |

Use them instead of hard-coding an architecture: `--build=$PKG_TARGET --host=$PKG_TARGET`
for configure, `CFLAGS="-O2 $PKG_GCC42_ARCH_FLAGS"` with `gcc-4.2` or
`CFLAGS="-O2 $PKG_SYSCC_ARCH_FLAGS"` with `/bin/cc`.  `build-helpers.sh` also provides
`pkg_arch_flags COMPILER`, which picks the right set from the compiler's name.  Either
`*_FLAGS` variable can be overridden, even to empty.  `sh ./pkg arch` prints the values.

Every package's `build` script applies the flags for the compiler it uses: in `CFLAGS` where
the package sets one, otherwise on `CC` (so autoconf's own `-g -O2` default survives), or on
`CPPFLAGS` where the script calls a quoted `"$CC"`.  The `test` hooks compile small probe
programs and are left at the compiler's defaults.

## Compiler selection

Packages that need the newer compiler depend on `gcc42` and explicitly use
`/usr/local/bin/gcc-4.2` or `/usr/local/bin/g++-4.2`, including their test hooks.
The GCC 4.2 package bootstraps directly from stock `/bin/cc`: stage 1 uses
`-O0`, stages 2/3 and runtimes use `-O2`, and stage 2 is compared with stage 3.

`gcc42` builds for the architecture it runs on (`/usr/bin/arch`): `i386-next-openstep4`
by default, or `sparc-next-openstep4` on OPENSTEP/SPARC (override with `GCC42_ARCH=sparc`).
The SPARC back end is not in Apple's GCC tree, so it comes from FSF GCC 4.2.1
(`gcc-sparc-config-4.2.1.tar.gz`, unpacked over the source) with the NeXT layer in the patch
(`gcc/config/sparc/next.h`). See `gcc42/SPARC.md` for its status and bring-up checklist.

Python 3.11 builds at `-O3`, except its generated `deepfreeze.c` unit, which uses
`-O0 -g0` to avoid GCC42 allocation failures and optimizer crashes on OPENSTEP.

## Package layout

Each package is a directory named after the package:

```text
bash/
  build
  version
  depends
  sources
  post-install
  pre-remove
  test
```

Required:

- `build`
- `version`

Optional:

- `depends`
- `sources`
- `post-install`
- `pre-remove`
- `test`

## Resuming a failed build

A failed build leaves its tree in `<cache>/build/<package>`.  Set `PKG_RESUME=1`
to carry on in that tree instead of extracting, patching and configuring again:

```sh
PKG_RESUME=1 pkg install sudo
```

The package's `build` script decides what can be skipped, using two helpers from
`build-helpers.sh`:

- `pkg_step NAME COMMAND [ARG...]` runs COMMAND and records NAME as done in the
  build directory; on a resumed build a step already done is skipped.  List
  steps to run again in `PKG_REDO`, e.g. `PKG_RESUME=1 PKG_REDO=configure pkg
  install sudo`.  Steps are only recorded when they succeed.
- `pkg_apply_patch PATCHFILE [STRIP]` applies a patch and keeps a copy; on a
  resumed build an unchanged patch is skipped, and an edited one has the old
  version reversed and the new one applied, so patches can be tweaked and the
  same tree rebuilt (make then only recompiles what changed).

Plain `make` steps are already incremental, so they need no wrapping.  Without
`PKG_RESUME`, or with no build tree to resume, the build starts from scratch.
Packages that do not use the helpers simply run all their steps again in the
kept tree.  `sudo` is the first to use them.

## `version`

Contains the package version as a single field.

Example:

```text
3.2.57
```

## `sources`

One source per line. Blank lines and `#` comments are ignored.

Examples:

```text
https://ftp.gnu.org/gnu/bash/bash-3.2.57.tar.gz
bash-3.2.57-openstep.patch
files/site.h patches
```

Rules:

- remote URLs are downloaded into the source cache
- local paths are copied from the package directory
- `.tar.gz`, `.tgz`, and `.tar` archives are extracted into the build root
- non-archive files are copied as plain files
- `.tar.bz2`, `.tbz2`, `.tar.xz`, and `.txz` are rejected

The optional second field is the destination directory inside the build root.

## `depends`

Optional file with one package name per line.
Prefix a package name with `!` to declare a conflicting package that must not be installed.

Example:

```text
make
grep
!alternative-make
```

Behavior:

- `pkg build` checks them before building
- `pkg build` requires positive dependencies to already be installed
- `pkg build` requires negative dependencies to be absent
- `pkg install` installs missing dependencies automatically when their package directories can be found alongside the requested package
- `pkg install` fails if a negative dependency is already installed
- `pkg install` accepts multiple package directories and installs them in the order provided
- no build-vs-runtime distinction

## `build`

`build` is run with:

- current directory set to the extracted source root when possible
- `$1` set to `DESTDIR`
- `$2` set to the package version
- `DESTDIR` exported in the environment
- `PKG_BUILD_HELPERS` exported as the path to `build-helpers.sh`
- `/usr/local/bin/ksh` used as the build shell for normal packages when
  available; the bootstrap `pdksh` package is built with `/bin/sh`
- `PKG_BUILD_SHELL` in the environment replaces that build/test shell for every
  package, and `PKG_CONFIG_SHELL` replaces the shell `run_configure` runs
  `./configure` under (default ksh).  For a package that misbehaves under
  pdksh, either run e.g. `PKG_CONFIG_SHELL=/usr/local/bin/bash pkg build sudo`
  or set `CONFIG_SHELL` in its `build` and add the shell's package to `depends`.
  The overriding shell must already be installed; pkg does not build it first.

`pkg test` uses the same shell selection and propagates test failures explicitly.
This avoids stock OPENSTEP `/bin/sh` masking a failure with a successful cleanup
trap.

Example:

```sh
#!/bin/sh

set -e

DESTDIR=$1

. "$PKG_BUILD_HELPERS"
run_configure --prefix=/usr/local
gnumake
gnumake install DESTDIR="$DESTDIR"
```

## `test`

`test` is an optional `/bin/sh` script that validates the installed package.

- `sh ./pkg test <name>` runs the installed copy from `/usr/local/var/pkg/db/installed/<name>/test`
- the package must already be installed
- `PKG_NAME`, `PKG_VERSION`, `ROOT_DIR`, and `LOCAL_ROOT` are exported for the script
- `PATH` is prefixed with `$LOCAL_ROOT/bin:$LOCAL_ROOT/sbin`

## Install database

Installed packages are tracked under:

```text
/usr/local/var/pkg/db/installed
```

The default cache/staging area is:

```text
/usr/local/var/pkg/cache
```

After a successful `pkg build`, the download cache and unpacked build tree
under:

```text
/usr/local/var/pkg/cache/sources/<name>
/usr/local/var/pkg/cache/build/<name>
```

are removed automatically to save space.

The staged install image under:

```text
/usr/local/var/pkg/cache/pkg/<name>
```

is kept so a later `pkg install` can reuse it without rebuilding.

After a successful `pkg install`, that staged install image is also removed,
so no per-package cache remains.

If a package ships a `test` script, `pkg install` copies it into the installed
package database so `pkg test <name>` can validate the installed files later.

This layout assumes `/usr/local` is writable by the installing user. That lets
non-root users build and install packages into the shared `/usr/local` tree.

Paths can still be overridden with:

- `PKG_ROOT`
- `PKG_DB`
- `PKG_CACHE`
