# Package status

Which packages have been built, installed and tested on real (emulated)
OPENSTEP, and where.  "validated" means the package built, installed and its
`test` hook passed.  "—" means no result has been recorded, not that it fails.

Last updated 2026-10-19.  Results come from test runs on the x86 and SPARC
OPENSTEP 4.2 machines.  M68k: only gcc42 has a result (see below).

**SPARC, 2026-10-14:** `test world` passes: every package in the tree that
supports SPARC has been built, installed and tested there (cctools-as is i386-only).
The SPARC fixes of October 2026 (unaligned and big-endian code in duktape, quickjs,
emacs, ntp and others; unsigned `memcmp`; the `ldexp()` that flushes subnormals in
python311) are in the tree.

**M68k, 2026-10-19:** gcc 4.2.1 (gcc42) for `m68k-next-openstep4` is validated: it
bootstraps natively on the 68k and `pkg test gcc42` passes (C, C++ and Objective-C,
including the return-ABI and forwarding checks).  The machine is scimitar, a Previous
emulator of a NeXTcube Turbo with Dimension; the bootstrap took about 24.5 hours
real.  The port is described in `gcc42/M68K.md`; two compiler bugs found on the way
(Apple's cse of ZERO/SIGN EXTEND, and a negative shift when folding a bit-field
extraction from a constant) are fixed in the patch.  The dependencies were built with
the stock cc, which aborts at `-O0` on some 64-bit-heavy files (`tar` now builds at
`-O1` on every architecture; `wget-bootstrap`, `openssl` and others have m68k-only
workarounds) and, like SPARC's, compares bytes as signed in `memcmp()`/`strcmp()`.
The packages gcc42 needs to build (make, tar, coreutils, patch, texinfo, gawk, m4,
bison, flex, and pdksh and grep below them) have also built, installed and tested
there.  Next is the chain to git.

**x86, 2026-10-08:** a rebootstrap on a fresh host built, installed and tested
all 93 packages in the tree, including the October 2026 security fixes (bzip2,
freetype, libmad, wget, gzip, zip, patch, tar, openssl, emacs) and the
version bumps (mpg123 1.33.7, ca-certificates 2026.09.25, expat 2.9.0, libpng
1.6.59, python311 3.11.17, vim 9.2.1091).  vim needed seven build fixes for the
9.2.1091 bump (`wait()` in `osdef.h`, int `W*()` macros, no `<sys/utsname.h>`, no
`<utime.h>`, `FD_CLOEXEC`, `struct sockaddr_storage`, and `tcgetattr`/`tcsetattr`
from the BSD ioctls).  The tables below show the result per package.  pkg itself gained a
retry through `tarfix` for tarballs whose uid/gid exceed OPENSTEP's 16-bit uid_t.

lha was removed from the tree (October 2026): its test failed on x86 even unpatched on the
rebootstrapped host (`lha a` of a directory adds only the directory entry), and p7zip can
extract .lzh/.lha archives.  It can be put back from git history (the last version was
1.14i-ac20050924p1 with a hand-ported security patch).

In the SPARC column, the number after "validated" is the package version that
was tested (taken from the tree at the commit that recorded the result).  The
SPARC `test world` of 2026-10-14 covers every row.

| Package | x86 | SPARC | M68k |
|---|---|---|---|
| afterstep | validated 1.8.11 (2026-10-23; builds with the NeXT-style default title bar, installs, test passes, runs under CubXWindow; needs libXpm) | validated 1.8.11 (2026-10-24; builds, installs and tests on SPARC) | — |
| aterm | validated 0.4.2 (2026-10-23; builds with the termios/waitpid/setsid/putenv shims, installs, test passes, runs under CubXWindow) | validated 0.4.2 (2026-10-23; builds, installs, tests and runs) | — |
| base64 | validated 1.5 (2026-10-24; builds, installs and tests clean on the first attempt; Fourmilab base64 with LF line ends) | validated 1.5 (2026-10-24; builds, installs and tests) | — |
| bash | validated | validated 5.3 (rebuilt on the rebootstrapped host) | validated (2026-10-21; built with gcc42, tests pass) |
| bison | validated | validated 2.4.3 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| bzip2 | validated | validated 1.0.8 (rebootstrap, 2026-10-08) | — |
| ca-certificates | validated | validated 2026.09.25 (rebootstrap, 2026-10-08) | validated (2026-10-19; as a dependency of wget-bootstrap) |
| cctools | validated (from upstream, 2026-10-19: `ar`, `ranlib` and the cctools-806 linker; gcc42 bootstraps with them) | n/a (i386 only) | n/a (i386 only) |
| cctools-as | 806 validated (reinstalled on messer 2026-10-10) | n/a (i386 only) | n/a (i386 only) |
| class-dump | validated | validated (2026-10-10; builds with `-arch $PKG_ARCH`) | — |
| coreutils | validated (rebuilt on a host with libiconv installed, iconv off, 2026-10-09) | validated 5.0 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| cowsay | validated 3.03+dfsg2 (2026-10-21; build, install and test pass; `fortune \| cowsay` works) | validated 3.03+dfsg2 (2026-10-22; build, install and test pass) | — |
| curl | validated | validated 8.17.0 (rebuilt 2026-10-09 against the rebuilt libcrypto: links with the ostep_* routines from libcrypto.a, installs and tests) | validated (2026-10-21; built with gcc42, tests pass) |
| darkhttpd | validated 1.13 (2026-10-25; builds, installs and tests; the test serves a directory and fetches from it) | validated 1.13 (2026-10-25; builds, installs, tests; the system printf misread %llu/%zu, so output goes through the snprintf shim) | — |
| dash | validated 0.5.12 on x86 (2026-10-25; builds, installs, tests, and an interactive session with job control works; private stdint/inttypes, <dirent.h> and <sys/wait.h>, a sigaction-on-sigvec shim and waitpid/setpgid/getpgrp/tcgetpgrp/getcwd/strtoll/strsignal/vsnprintf shims) | validated 0.5.12 (2026-10-25; builds, installs and tests) | — |
| diffutils | validated | validated 2.8.1 (2026-10-09) | — |
| duktape | validated | validated (2026-10-10; installed archive needs `ranlib`) | — |
| emacs | validated | validated (2026-10-10; needed the pdumper alignment fixes for the 64-bit wide-int Lisp_Object, and a SPARC `netinet/in.h` big-endian branch) | — |
| expat | validated | validated 2.9.0 (rebootstrap, 2026-10-08) | validated (2026-10-20; built with gcc42, tests pass) |
| ffmpeg | validated (reinstalled on messer 2026-10-10, after curl stopped using zstd) | validated (2026-10-10) | — |
| findutils | validated | validated 4.2.33 (2026-10-10; unsigned memcmp/strcmp linked in with `pkg_cmp_obj`) | — |
| flex | validated | validated 2.5.39 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| freetype | validated | validated 2.14.3 (2026-10-09) | — |
| freeze | validated | validated 2.5 (rebootstrap, 2026-10-08) | — |
| fribidi | 0.19.7 validated | validated 0.19.7 (2026-10-09) | — |
| fortune | validated 1.99.1 (2026-10-21; build, install and test pass; built without `-m` pattern search: this libc has no `re_comp`) | validated 1.99.1 (2026-10-22; build, install and test pass; no `-m` pattern search without `re_comp`) | — |
| gawk | validated | validated 3.1.8 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| gcc42 | validated | validated 4.2.1-apple-5666.3 (port; bootstraps, compare passes, `pkg test` passes; clean rebuild on a rebootstrapped host, 2026-10-08) | validated 4.2.1-apple-5666.3 (2026-10-19; `pkg test gcc42` passes with no failures; full native bootstrap on scimitar, a Previous emulator of a NeXTcube Turbo with Dimension, CPU at full speed: `pkg reinstall gcc42` took 88381 s real, 69547 s user, 13409 s system, about 24.5 hours; needs the cse and simplify-rtx fixes in `gcc42/M68K.md`) |
| git | validated (reinstalled on messer 2026-10-10, after curl stopped using zstd) | validated 2.55.0 (needs the unsigned memcmp/strcmp fix and -O0) | validated (2026-10-23; built with gcc42 at -O0, tests pass; python311 was pulled in as a dependency) |
| gnupg | validated 1.4.23 (2026-10-26; builds, installs, tests; no mmap/munmap here, so gpg uses malloc for secure memory and warns about insecure memory unless `no-secmem-warning` is set; compat for putenv, strdup, snprintf, sighold/sigrelse, uname, ENOSYS and the int wait macros) | validated 1.4.23 (2026-10-26; builds, installs, tests; compiled with -mcpu=v8 and a C __udiv_qrnnd, since the assembly modules are not used) | — |
| gperf | validated | validated 3.3 (2026-10-09) | — |
| grep | validated | validated 2.5.4 (rebuilt with the unsigned memcmp via pkg_cmp_obj, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| gzip | validated | validated 1.3.12 (rebootstrap, 2026-10-08) | validated 1.3.12 (2026-11-04; builds, installs and `pkg test gzip` passes) |
| help2man | validated | validated 1.27 | — |
| jpeg | validated | validated 8d (rebootstrap, 2026-10-08) | — |
| less | validated | validated 710 (rebootstrap, 2026-10-08) | validated (2026-11-05; builds, installs and `pkg test less` passes) |
| liba52 | validated | validated 0.7.4 (rebootstrap, 2026-10-08) | — |
| libcss | validated | validated 0.9.2 (2026-10-09) | — |
| libdom | validated | validated 0.4.2 (2026-10-09) | — |
| libgcrypt | 1.5.6 validated (reinstalled on messer 2026-10-10) | validated 1.5.6 (2026-10-10; needs `-D__sparc_v8__` for the V8 udiv/umul in mpi) | — |
| libgpg-error | 1.12 validated | validated 1.12 (2026-10-09) | — |
| libhubbub | validated | validated 0.3.8 (2026-10-09) | — |
| libiconv | validated | validated 1.15 (rebootstrap, 2026-10-08) | validated (2026-10-20; built with gcc42, tests pass) |
| libmad | validated (reinstalled on messer 2026-10-10; `VERSION` is exported to the build) | validated 0.15.1b (2026-10-09) | — |
| libmpeg2 | validated | validated (2026-10-10) | — |
| libnsbmp | validated | validated 0.1.7 (2026-10-09) | — |
| libnsfb | validated | validated 0.2.2 (2026-10-09) | — |
| libnsgif | validated | validated (2026-10-10) | — |
| libnslog | validated | validated (2026-10-10) | — |
| libnsutils | validated | validated 0.1.1 (2026-10-09) | — |
| libparserutils | validated | validated 0.2.5 (rebootstrap, 2026-10-08) | — |
| libpng | validated | validated 1.6.59 (2026-10-09) | — |
| libsvgtiny | validated | validated 0.1.8 (2026-10-09) | — |
| libwapcaplet | validated | validated 0.4.3 (rebootstrap, 2026-10-08) | — |
| libxml2 | validated on x86 (2.15.4: build, install, test; reinstalled on messer 2026-10-10, LZMA test case dropped with 2.15) | validated 2.15.4 (2026-10-13) | — |
| lua | validated | validated (2026-10-10) | — |
| lua51 | 5.1.5 validated | validated 5.1.5 (2026-10-10) | — |
| lz4 | validated | validated (2026-10-10) | — |
| m4 | validated | validated 1.4.6 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| make | validated (built with the system cc) | validated 3.81 (built with the system cc; rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| mktemp | validated | validated 1.7 (rebootstrap, 2026-10-08) | — |
| mpg123 | validated (1.33.7, with private stdint.h/inttypes.h shims; rebuilt on a fresh host) | validated (2026-10-10) | — |
| nano | validated | validated 2.9.8 | — |
| ncurses | validated | validated 6.5 (rebootstrap, 2026-10-08) | validated 6.5 (2026-11-04; builds, installs and `pkg test ncurses` passes) |
| nedit | validated 5.7 (2026-10-27; builds, installs, test passes and the editor runs under CubXWindow; Motif comes from /usr/X11R5 or /usr/X11R6, whichever has it; needs a handful of header stand-ins and no glob()) | validated 5.7 (2026-10-27; builds, installs, tests and runs; needed -DYYMALLOC=malloc -DYYFREE=free for the bison-generated parser) | — |
| nethack | validated (tty and X11; 2026-11-05: rebuilt with the curses interface through ncurses, `pkg test` passes and the game runs correctly with `-w curses`) | validated 3.6.7 (`pkg test` passes, game starts; a stray "pkg: Stock: not found" after the install was a script replaced mid-run, fixed in pkg; rebootstrap, 2026-10-08) | — |
| nethack5 | validated 5.0.0 (2026-10-27; installed beside 3.6.7 as `nethack5` in /usr/local/lib/nethack5dir; builds its own Lua 5.4.8 with the lua package's OPENSTEP patch ported; `pkg test` passes and the game starts and runs; 2026-11-05: rebuilt with the curses interface through ncurses and it works with `-w curses`; the message window shows plain characters, not wide ones) | builds, installs and tests, but the game crashes right after the role is chosen (heap damage inside the allocator; unsigned compares added, rebuild with a heap log under way) | — |
| sporkhack | validated 0.6.5 (2026-10-29; x86: builds, installs, `pkg test` passes and the game plays; tty and curses interfaces, curses via the ncurses package; installed as `sporkhack` in /usr/local/lib/sporkhackdir; source is GitHub's archive of commit 8d6bc8e) | — | — |
| evilhack | validated 0.9.3 (2026-11-04; x86: builds, installs, `pkg test` passes and the game plays in both the tty and curses interfaces; NetHack 3.6-based, tag v0.9.3; curses runs without wide characters and with plain colours; installed as `evilhack` in /usr/local/lib/evilhackdir with a sysconf stripped of the stock server settings; reinstalled with the current build script (2026-11-04): starts without sysconf warnings and `pkg test` passes) | — | — |
| hackem | — (new 2026-11-06: Hack'EM 1.3.2, an EvilHack-based (NetHack 3.6) successor to Slash'EM, last upstream commit 2024-09-01 from nethack-cleaner/HackEM commit ef72a41; tty and curses interfaces via the ncurses package; the build is evilhack's, without the wide-character, extended-colour and Guidebook patches its sources do not need; installed as `hackem` in /usr/local/lib/hackemdir with a sysconf stripped of the stock server settings; the checksum of GitHub's archive needs confirming on first download; nothing has been built on OPENSTEP yet) | — | — |
| unnethack | validated 6.0.17 (2026-11-01; x86: builds, installs, `pkg test` passes and the game runs; GitHub master commit 0eafa32; tty and curses interfaces, terminfo through the ncurses package; installed as `unnethack` in /usr/local/share/unnethack; fcntl locking is off because it fails here, so files are locked with link()) | — | — |
| splicehack | validated 1.2.0 (2026-11-05; x86: builds, installs, `pkg test` passes and the game plays in both the tty and curses interfaces; NetHack 3.7-based, last upstream commit 2022-09-19, from NullCGT/SpliceHack commit 8d70ade; builds the staged Lua 5.4.8 with the nethack5 package's OPENSTEP patch; installed as `splicehack` in /usr/local/lib/splicehackdir with a sysconf stripped of the stock server settings) | — | — |
| netsurf-buildsystem | validated | validated 1.10 (rebootstrap, 2026-10-08) | — |
| netsurf-openstep | validated 3.12-dev.20261002 (2026-10-22; builds from turbolent/netsurf-openstep at 5fd3476, installs NetSurf.app into /usr/local/Apps, test passes; connects to slashdot.org over TLS) | n/a (i386 only) | n/a (i386 only) |
| neXtaw | validated | validated (2026-10-10) | — |
| nsgenbind | validated | validated 0.9 (2026-10-09; needed `-include stdlib.h -DYYMALLOC=malloc -DYYFREE=free`: the bison skeleton's own malloc prototype clashed with the system's) | — |
| ntp | validated (build, install, test; ntpdate and ntpd run against a server); on a fresh host configure's `setrlimit` check failed (prototype clash with `<sys/resource.h>`), so `ntp/build` supplies a no-op `ntp_rlimit()` (x86 rebuilt with it); `rc.ntp` boot script tested on Linux only; 2026-10-10: ntpdate stepped the clock again on x86 after `ntp/build` told configure that `settimeofday` and `adjtime` exist (their link tests are defeated by the forced header; without them ntpdate failed with "step-systime: error 0"); `pkg test ntp` now checks for a linked clock-setting call and queries public servers (needs the internet; `PKG_TEST_NTP_OFFLINE=1` skips) | validated (2026-10-10; builds without `<memory.h>`/NetInfo, `sigsetjmp` mapped onto `setjmp`; test hooks pass and ntpdate sets the clock) | — |
| openmail | — (new 2026-10-16: the session code is tested against Dovecot on Linux; the AppKit windows are checked against the 4.2 headers but have not been built or run on OPENSTEP) | — | — |
| openssh | validated (10.6p1: sshd, ssh login by password and key, scp); `rc.sshd` boot script tested on Linux only | validated 10.6p1 (2026-10-09; builds and passes its tests, against the rebuilt libcrypto; needed `PICFLAG=` since the SPARC assembler cannot relocate the position-independent code that openbsd-compat is otherwise compiled as) | validated (2026-10-22; built with gcc42, tests pass) |
| openssl | validated | validated 1.1.1w (rebuilt 2026-10-09 with the unsigned memcmp via pkg_cmp_named, which fixed OID lookups by DER bytes: SHA1, AES, SHA-2, secp384r1 and others had failed; the broadened `pkg test` passes: OIDs, digests, EC keys, signatures, chains, AES). The original failure is fixed: a secp384r1 key now round-trips through `openssl ec -pubout`. curl and openssh rebuilt against it link and pass their tests. Still to check on SPARC: `oidtest` recompiled (an old binary carries the old static library) | validated (2026-10-19; m68k-only workarounds) |
| p7zip | validated | validated (2026-10-10) | — |
| pantomime | validated 1.4.0 (2026-10-16; build, install and the 46 offline checks pass; `pmail` has connected to a local server; the full IMAP/POP3/SMTP flows are tested against Dovecot on Linux) | validated 1.4.0 (2026-10-16; build, install and the offline checks pass; `pmail` connected to a local server) | — |
| patch | validated | validated 2.6.1 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| pdksh | validated | validated 5.2.14 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| perl | validated 5.8.9 (rebuilt on messer 2026-10-10, tests pass; the first make has bus-errored in ext/Encode on every clean build there, `perl/build` now retries it once, cause unknown) | validated 5.8.9 (rebuilt with the unsigned memcmp, 2026-10-09) | — |
| pkgconf | validated on x86 (3.0.7: build, install, test; replaces pkg-config 0.29) | validated 3.0.7 (rebootstrap, 2026-10-08) | — |
| python311 | validated | validated 3.11.17 (2026-10-13; needs a correct `ldexp()` on SPARC: the libm one returns 0 for subnormal results) | validated 3.11.17 (2026-10-31; builds, installs and `pkg test python311` passes; the 68k FPU flushes subnormal operands to zero, so `frexp()` is replaced by an integer-shift version in the OPENSTEP patch) |
| quake2 | validated (content-free dedicated-server startup test; no game data) | validated (2026-10-10; content-free dedicated-server startup test) | — |
| quickjs | validated | validated 2025-09-13-2 (2026-10-13; SPARC needs memcpy accessors and an 8-byte aligned constant pool) | — |
| roboclient | validated (1.1 with `rc.dhcp` installs and tests clean on x86) | validated 1.1 (2026-10-09) | — |
| rsync | validated | validated (2026-10-10) | — |
| sdl12 | validated | validated (2026-10-10; per-arch cc flags instead of a hardcoded -m486) | — |
| sed | validated | validated 4.0.9 (with pkg_cmp_shim; rebootstrap, 2026-10-08) | validated 4.0.9 (2026-11-04; builds, installs and `pkg test sed` passes; unsigned compares via pkg_cmp_shim) |
| slashem | validated 0.0.7E7F3 (2026-10-26; builds, installs, test passes, and the game plays; tty interface only, set up as a BSD/termcap build like nethack; menu colours match plain strings, not regexes, since there is no regex.h) | validated 0.0.7E7F3 (2026-10-27; builds, installs and tests) | — |
| sudo | validated | validated 1.7.10p9 (2026-10-09) | — |
| tar | 1.15.1 validated | validated 1.15.1 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| tcsh | validated | validated 6.24.13 (rebootstrap, 2026-10-08; vfork.h fix) | — |
| termcap | validated | validated 1.3.1 (rebootstrap, 2026-10-08) | — |
| texinfo | validated | validated 4.8 (rebootstrap, 2026-10-08) | validated (2026-10-19; built, installed and tested as a dependency of gcc42) |
| top | validated | validated 3.6.1 (2026-10-09; needed work: the SPARC kernel refuses the `utask` read through /dev/kmem that holds the command name, so reads are non-fatal and names come from one `ps -axc` snapshot per refresh; the process list matches the x86 one; the earlier SPARC result was only an install) | — |
| unzip | validated | validated 6.0 (rebootstrap, 2026-10-08) | — |
| utf8proc | validated | validated (2026-10-10) | — |
| vim | validated | validated 9.2.1091 (rebuilt 2026-10-09) | — |
| vlc | 0.9.10 validated (runs as root) | validated (2026-10-10; the i386-only flags and Mach-O subtype fix are skipped, the audio test expects host byte order) | — |
| wget | 1.25.0 validated on x86 (HTTPS via OpenSSL) | 1.25.0 validated (2026-10-10) | — |
| wget-bootstrap | 1.19.5 validated | validated 1.19.5 (needs the localtime and unsigned-compare fixes; rebootstrap, 2026-10-08) | validated (2026-10-19; m68k-only workarounds) |
| windowmaker | validated 0.80.0 (2026-10-24; builds, installs, test passes, runs under CubXWindow; Dock and Clip off by default) | validated 0.80.0 (2026-10-24; builds, installs, tests and runs under CubXWindow) | — |
| xxhash | validated (manual build, after replacing `ln -sf`; rebuilt on a fresh host) | validated 0.8.4 (`XXH_FORCE_MEMORY_ACCESS=0`: the default packed-union reads bus-error with gcc 4.2; compiling `xxhash.c` is very slow; rebootstrap, 2026-10-08) | — |
| xz | validated | validated 5.8.4 | — |
| zip | validated | validated 3.0 (2026-10-09) | — |
| zlib | validated | validated 1.2.13 (rebootstrap, 2026-10-08) | validated (2026-10-20; built with gcc42, tests pass) |
| zsh | validated | validated 5.9 | — |
| zstd | validated | rebuilt 2026-10-09 with memcpy memory access (MEM_FORCE_MEMORY_ACCESS=0); tests clean | — |

## Notes

- **sudo** is 1.7.10p9, not a current release.  1.8 and later need `siginfo_t`,
  `SA_SIGINFO` and `struct timespec`, which OPENSTEP lacks.  The package patches
  CVE-2021-3156 (Baron Samedit), CVE-2019-14287 (`-u#-1`) and CVE-2019-18634
  (`pwfeedback` overflow); other known issues remain (see `sudo/` patch comments),
  so do not expose a machine running it.  I/O logging (`log_output`) and
  `sudoreplay` are built (with zlib), but the `log_output` path has only been
  checked by compiling, not exercised.
- **tar** (1.15.1, upstream's) installs `/usr/local/bin/gnutar`; `pkg` prefers it for unpacking sources and for xz/zstd/bzip2 archives. It never replaces the system `tar`.
- **termcap** never installs `/etc/termcap`.
- **bash** is 5.3, built with `-DGETCWD_BROKEN` and a compat patch for
  `waitpid`, `tcgetattr` and friends.
- **ntp** is 4.2.8p18 (ntpsec needs pthreads, which OPENSTEP lacks); `ntpd`
  installs into `sbin` and a default `ntpd.conf` is copied into place only if
  none exists.
- A failed build can be resumed with `PKG_RESUME=1` (see `README.md`).
- **git** on SPARC builds at `-O0` and uses unsigned `memcmp`/`strcmp`/`strncmp`
  replacements: the SPARC libc compares bytes as signed, which corrupted pack
  indexes.  Packages that rely on byte-order comparisons use `pkg_cmp_shim`
  (see `README.md`); their SPARC rebuilds are still pending.

## Removed packages

**fish 1.23.1** (October 2026): tried and dropped.  It is the last all-C release, but this
libc has no wide-character functions or `<wchar.h>`, no POSIX signals, termios or
`regex.h`, and `fnmatch`, `mmap`/`munmap` and `wait4(-1, ...)` are missing or broken, so
the build needed a small wide-character library and about a dozen shims.  It built and
ran simple commands from `fish -c`, but its universal-variable server (`fishd`) never
stayed up, interactive use was never tried, and getting there cost two machine
resets: fish's fallback `getopt_long()` ignored long options, so `fish --version` started
an interactive shell, and a connection failing to `fishd` respawned it without end.  The NeXTcommunity users
did not want it, so it was removed.  The last commit that still has the package is
`2b25054` on `claude/happy-volta-ng35dy` (`git show 2b25054:fish/build`); the findings that
apply elsewhere are already in the other packages' shims (`wait3()` for "any child",
`EAGAIN`/`EWOULDBLOCK`, `sys/wait.h` for an int status).  `ulimit -u` does nothing on OPENSTEP.
