/* Which wait calls work for a child that has exited?  Prints one line each. */
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/wait.h>

extern int wait4();
extern int wait3();
extern void _exit();


static int do_wait(int how, int child, int *st, int options)
{
    static struct rusage ru;

    switch (how) {
    case 0: return wait4(-1, (void *) st, options, (void *) 0);
    case 1: return wait4(child, (void *) st, options, (void *) 0);
    case 2: return wait4(0, (void *) st, options, (void *) 0);
    case 3: return wait4(-1, (void *) st, options, (void *) &ru);
    case 4: return wait3((void *) st, options, (void *) 0);
    case 5: return wait((void *) st);
    }
    return -1;
}

static void try_it(const char *what, int how, int options)
{
    int st = 0x5a5a, pid, r, e;

    pid = fork();
    if (pid == 0)
        _exit(3);
    sleep(1);
    errno = 0;
    r = do_wait(how, pid, &st, options);
    e = errno;
    printf("%-36s child %d: returned %d, errno %d, status 0x%x\n",
           what, pid, r, e, st);
    if (r < 0) {
        /* reap it with wait3 so the next test starts clean */
        wait3((void *) &st, 0, (void *) 0);
    }
}

int main(void)
{
    printf("WNOHANG=%d WUNTRACED=%d\n", WNOHANG, WUNTRACED);
    try_it("wait4(-1, st, 0, 0)", 0, 0);
    try_it("wait4(-1, st, WUNTRACED, 0)", 0, WUNTRACED);
    try_it("wait4(child, st, 0, 0)", 1, 0);
    try_it("wait4(child, st, WUNTRACED, 0)", 1, WUNTRACED);
    try_it("wait4(0, st, 0, 0)", 2, 0);
    try_it("wait4(-1, st, 0, &rusage)", 3, 0);
    try_it("wait3(st, 0, 0)", 4, 0);
    try_it("wait3(st, WUNTRACED, 0)", 4, WUNTRACED);
    try_it("wait(st)", 5, 0);
    return 0;
}
