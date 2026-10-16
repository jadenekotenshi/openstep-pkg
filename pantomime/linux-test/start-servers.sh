#!/bin/sh
# start-servers.sh DIR
set -e
D=${1:?usage: start-servers.sh DIR}
HERE=`cd \`dirname $0\` && pwd`
mkdir -p "$D/run" "$D/home/test/Maildir/cur" "$D/home/test/Maildir/new" "$D/home/test/Maildir/tmp" "$D/smtp-inbox"
id vmail > /dev/null 2>&1 || useradd -r -M -s /usr/sbin/nologin vmail
chown -R vmail:vmail "$D/home" "$D/run"
chmod 755 "$D" "$D/home"
echo 'test:{PLAIN}secret' > "$D/users"
# A throw-away certificate authority and a server certificate for the name
# "localhost" only (no IP address in it), so that certificate and host name
# checking can be tested both ways.
mkdir -p "$D/tls"
if [ ! -f "$D/tls/server.pem" ]; then
    openssl req -x509 -newkey rsa:2048 -nodes -days 30 -subj "/CN=pmail test CA" \
        -keyout "$D/tls/ca.key" -out "$D/tls/ca.pem" > /dev/null 2>&1
    openssl req -newkey rsa:2048 -nodes -subj "/CN=localhost" \
        -keyout "$D/tls/server.key" -out "$D/tls/server.csr" > /dev/null 2>&1
    printf 'subjectAltName=DNS:localhost\n' > "$D/tls/san.cnf"
    openssl x509 -req -in "$D/tls/server.csr" -CA "$D/tls/ca.pem" -CAkey "$D/tls/ca.key" \
        -CAcreateserial -days 30 -extfile "$D/tls/san.cnf" -out "$D/tls/server.pem" > /dev/null 2>&1
fi
chmod 644 "$D/tls/server.key"
# a few messages, one with an attachment and non-ASCII text
n=0
for f in "$HERE"/messages/*.eml; do
    n=`expr $n + 1`
    cp "$f" "$D/home/test/Maildir/new/17000000$n.M1P1.test"
done
chown -R vmail:vmail "$D/home"
cat > "$D/dovecot.conf" <<CONF
base_dir = $D/run
log_path = $D/dovecot.log
info_log_path = $D/dovecot.log
protocols = imap pop3
listen = 127.0.0.1
disable_plaintext_auth = no
auth_mechanisms = plain login
ssl = yes
ssl_cert = <$D/tls/server.pem
ssl_key = <$D/tls/server.key
ssl_min_protocol = TLSv1.2
mail_location = maildir:$D/home/%u/Maildir
mail_uid = vmail
mail_gid = vmail
first_valid_uid = 1
passdb {
  driver = passwd-file
  args = scheme=PLAIN username_format=%u $D/users
}
userdb {
  driver = static
  args = uid=vmail gid=vmail home=$D/home/%u
}
service imap-login {
  inet_listener imap {
    port = 1143
  }
  inet_listener imaps {
    port = 1993
    ssl = yes
  }
}
service pop3-login {
  inet_listener pop3 {
    port = 1110
  }
  inet_listener pop3s {
    port = 1995
    ssl = yes
  }
}
namespace inbox {
  inbox = yes
  mailbox Sent {
    auto = create
    special_use = \\Sent
  }
  mailbox Drafts {
    auto = create
    special_use = \\Drafts
  }
}
CONF
dovecot -c "$D/dovecot.conf" < /dev/null > /dev/null 2>&1
python3 "$HERE/smtpd.py" "$D/smtp-inbox" "$D/tls/server.pem" "$D/tls/server.key" < /dev/null > "$D/smtpd.log" 2>&1 &
echo $! > "$D/smtpd.pid"
sleep 2
echo "servers started in $D"
