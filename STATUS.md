# Package status

Which packages have been built, installed and tested on real (emulated)
OPENSTEP, and where.  "validated" means the package built, installed and its
`test` hook passed.  "—" means no result has been recorded, not that it fails.

Last updated 2026-10-06.  Results come from test runs on the x86 and SPARC
OPENSTEP 4.2 machines; most packages have only been tried on x86 so far.  M68k
has not been attempted.

| Package | x86 | SPARC |
|---|---|---|
| bash | validated | — |
| bison | validated | — |
| bzip2 | validated | — |
| ca-certificates | validated | — |
| class-dump | validated | — |
| coreutils | validated | — |
| curl | validated | — |
| diffutils | validated | — |
| duktape | validated | — |
| emacs | queued for testing | — |
| expat | validated | — |
| ffmpeg | queued for testing | — |
| findutils | validated | — |
| flex | validated | — |
| freetype | validated | — |
| freeze | validated | — |
| gawk | validated | — |
| gcc42 | validated | validated (port; bootstraps, compare passes, `pkg test` passes) |
| git | validated | — |
| gperf | validated | — |
| grep | validated | — |
| gzip | validated | — |
| help2man | queued for testing | — |
| jpeg | validated | — |
| less | validated | — |
| lha | validated | — |
| liba52 | validated | — |
| libcss | validated | — |
| libdom | validated | — |
| libhubbub | validated | — |
| libiconv | validated | — |
| libmad | validated | — |
| libmpeg2 | queued for testing | — |
| libnsbmp | validated | — |
| libnsfb | validated | — |
| libnsgif | validated | — |
| libnslog | validated | — |
| libnsutils | validated | — |
| libparserutils | validated | — |
| libpng | validated | — |
| libsvgtiny | validated | — |
| libwapcaplet | validated | — |
| libxml2 | validated | — |
| lua | validated | — |
| lz4 | being tested | — |
| m4 | validated | — |
| make | validated | — |
| mktemp | validated | — |
| mpg123 | validated | — |
| nano | validated | — |
| ncurses | validated | validated |
| netsurf-buildsystem | validated | — |
| nsgenbind | validated | — |
| ntp | written; never built on OPENSTEP | — |
| openssh | validated | — |
| openssl | validated | — |
| p7zip | in progress; fixes pushed, no result yet | — |
| patch | validated | — |
| pdksh | validated | — |
| perl | not recorded | building; fixes pushed, no result yet |
| pkg-config | validated | — |
| python311 | validated | — |
| quake2 | builds and installs; the content-free startup test has no recorded result (no game data) | — |
| quickjs | validated | — |
| rsync | validated | — |
| sdl12 | validated | — |
| sed | validated | — |
| sudo | validated | — |
| tar | validated | — |
| tcsh | in progress; fixes pushed, no result yet | — |
| termcap | validated | — |
| texinfo | validated | — |
| top | validated | — |
| unzip | validated | — |
| utf8proc | validated | — |
| vim | validated | — |
| wget | validated | — |
| xxhash | validated | fix pushed (manual build); no result recorded |
| xz | being tested | — |
| zip | validated | — |
| zlib | validated | — |
| zsh | validated | validated |
| zstd | being tested | — |

## Notes

- **sudo** is 1.7.10p9, not a current release.  1.8 and later need `siginfo_t`,
  `SA_SIGINFO` and `struct timespec`, which OPENSTEP lacks.  1.7.10p9 has known
  CVEs; do not expose a machine running it.  I/O logging (`log_output`) and
  `sudoreplay` are built (with zlib), but the `log_output` path has only been
  checked by compiling, not exercised.
- **tar** installs as `gtar`; it never installs `tar` or `gnutar`.
- **termcap** never installs `/etc/termcap`.
- **bash** is 5.3, built with `-DGETCWD_BROKEN` and a compat patch for
  `waitpid`, `tcgetattr` and friends.
- **perl** (5.8.9) on SPARC is waiting on a first full build.
- **ntp** is 4.2.8p18 (ntpsec needs pthreads, which OPENSTEP lacks); `ntpd`
  installs into `sbin` and a default `ntpd.conf` is copied into place only if
  none exists.
- A failed build can be resumed with `PKG_RESUME=1` (see `README.md`).
