#!/bin/sh
D=${1:?usage: stop-servers.sh DIR}
[ -f "$D/smtpd.pid" ] && kill `cat "$D/smtpd.pid"` 2>/dev/null
[ -f "$D/run/master.pid" ] && kill `cat "$D/run/master.pid"` 2>/dev/null
exit 0
