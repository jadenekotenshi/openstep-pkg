#!/bin/sh
# guard.sh MAX COMMAND [ARGS...]
#
# Runs COMMAND, and once a second counts the processes whose name contains "fish"
# (fish, fishd, fish_pager ...).  If there are more than MAX, it kills them all with
# SIGKILL, kills COMMAND, says so, and exits with status 99.  For trying fish when a
# runaway would wedge the machine; this system has no working "ulimit -u".
#
#   sh guard.sh 8 /usr/local/bin/fish -c 'echo hello'
#
max=$1
shift
PATH=/usr/local/bin:/usr/ucb:/bin:/usr/bin
export PATH

"$@" < /dev/null &
cmd=$!

# PIDs of processes whose command (fifth column of BSD ps -axw) is fish, fishd,
# fish_pager and so on.
fish_pids() {
    ps -axw | awk '$5 ~ /(^|\/)fish[a-z_]*$/ { print $1 }'
}

killall_fish() {
    for p in `fish_pids`; do
        kill -9 $p 2> /dev/null
    done
}

tripped=0
while kill -0 $cmd 2> /dev/null; do
    n=`fish_pids | wc -l | awk '{print $1}'`
    if [ "$n" -gt "$max" ]; then
        killall_fish
        kill -9 $cmd 2> /dev/null
        echo "guard.sh: $n fish processes (limit $max): killed them all" >&2
        tripped=1
        break
    fi
    sleep 1
done
if [ $tripped = 1 ]; then
    sleep 1
    killall_fish
    exit 99
fi
wait $cmd
