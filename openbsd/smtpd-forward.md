_Tested on [OpenBSD](/openbsd/) 6.4_

# Forward outgoing mail to a remote SMTP server

Replace [smtpd.conf(5)], add `secrets`, set permissions, test the
configuration, and restart [smtpd(8)]:

<pre>
# <b>cat > /etc/mail/smtpd.conf << EOF</b>
<i>table aliases file:/etc/mail/aliases</i>
<i>table secrets file:/etc/mail/secrets</i>
<i>listen on lo0</i>
<i>action "local" mbox alias <aliases></i>
<i>action "relay" relay host smtp+tls://<em>foo@server:port</em> auth &lt;secrets&gt;</i>
<i>match for local action "local"</i>
<i>match for any action "relay"</i>
<i><b>EOF</b></i>
#
# <b>touch /etc/mail/secrets</b>
# <b>chmod 640 /etc/mail/secrets</b>
# <b>chown root:_smtpd /etc/mail/secrets</b>
# <b>echo "<em>foo username:password</em>" &gt; /etc/mail/secrets</b>
#
# <b>smtpd -n</b>
configuration OK
# <b>rcctl restart smtpd</b>
smtpd (ok)
smtpd (ok)
#
</pre>

[smtpd(8)]: https://man.openbsd.org/smtpd.8
[smtpd.conf(5)]: https://man.openbsd.org/smtpd.conf.5
