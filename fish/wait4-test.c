/* Which of these makes wait4() report ECHILD for a child that has exited? */
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/wait.h>

extern int wait4();
#ifndef __linux__
extern int sigvec();
#endif

static void handler(int sig) { }

static void try_it(const char *what, int use_handler, int use_setpgrp, int options)
{
    int st = 0x5a5a, pid, r, e;

    if (use_handler) {
#ifdef __linux__
        struct sigaction a;
        a.sa_handler = handler;
        sigemptyset(&a.sa_mask);
        a.sa_flags = 0;
        sigaction(SIGCHLD, &a, 0);
#else
        struct sigvec v;
        v.sv_handler = handler;
        v.sv_mask = 0;
        v.sv_flags = 0;
        sigvec(SIGCHLD, &v, (struct sigvec *) 0);
#endif
    }
    pid = fork();
    if (pid == 0) {
        if (use_setpgrp)
            setpgrp(0, getpid());
        _exit(3);
    }
    sleep(1);
    errno = 0;
    r = wait4(-1, (void *) &st, options, (void *) 0);
    e = errno;
    printf("%-34s child %d: wait4 returned %d, errno %d, status 0x%x\n",
           what, pid, r, e, st);
    if (r < 0 && e == 0 + 4) { /* interrupted: try once more */
        r = wait4(-1, (void *) &st, options, (void *) 0);
        printf("%-34s   retry: returned %d, errno %d, status 0x%x\n", what, r, errno, st);
    }
    if (r < 0) {
        /* reap it so the next test starts clean */
        wait4(pid, (void *) &st, 0, (void *) 0);
    }
}

int main(void)
{
    printf("WNOHANG=%d WUNTRACED=%d\n", WNOHANG, WUNTRACED);
    try_it("plain, no handler", 0, 0, 0);
    try_it("WUNTRACED, no handler", 0, 0, WUNTRACED);
    try_it("WUNTRACED, child setpgrp", 0, 1, WUNTRACED);
    try_it("WUNTRACED, SIGCHLD handler", 1, 0, WUNTRACED);
    try_it("WUNTRACED, handler, child setpgrp", 1, 1, WUNTRACED);
    return 0;
}
