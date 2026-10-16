"""SMTP receiver for tests: 1025 (STARTTLS offered, AUTH after TLS) and 1465 (implicit TLS).
Usage: smtpd.py DIR CERT KEY.  Every accepted message is written to DIR/NNN.eml with its envelope in NNN.env."""
import asyncio, ssl, sys, os
from aiosmtpd.controller import Controller
from aiosmtpd.smtp import AuthResult, LoginPassword

OUT = sys.argv[1]
os.makedirs(OUT, exist_ok=True)
count = [0]

class Handler:
    async def handle_DATA(self, server, session, envelope):
        count[0] += 1
        n = '%03d' % count[0]
        open(os.path.join(OUT, n + '.eml'), 'wb').write(envelope.original_content)
        open(os.path.join(OUT, n + '.env'), 'w').write('from=%s\nto=%s\nauth=%s\ntls=%s\n' % (
            envelope.mail_from, ','.join(envelope.rcpt_tos), bool(getattr(session, 'authenticated', False)),
            session.ssl is not None))
        return '250 OK queued as ' + n

def authenticator(server, session, envelope, mechanism, auth_data):
    if isinstance(auth_data, LoginPassword) and auth_data.login == b'test' and auth_data.password == b'secret':
        return AuthResult(success=True)
    return AuthResult(success=False, handled=False)

ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ctx.load_cert_chain(sys.argv[2], sys.argv[3])
common = dict(authenticator=authenticator, auth_required=False, auth_require_tls=False)
c1 = Controller(Handler(), hostname='127.0.0.1', port=1025, tls_context=ctx, require_starttls=False, **common)
c2 = Controller(Handler(), hostname='127.0.0.1', port=1465, ssl_context=ctx, **common)
c1.start(); c2.start()
print('smtpd ready', flush=True)
try:
    asyncio.get_event_loop().run_forever()
except KeyboardInterrupt:
    pass
