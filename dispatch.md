_Tested on [OpenBSD](/openbsd/) 6.4_

# Send emails with smtpd(8) and sendmail(8)

Replace [smtpd.conf(5)], add `secrets`, set permissions, test the
configuration and restart [smtpd(8)]:

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

Create `db` [user(8)], add `dispatch` script to send submitted
[forms](form.html), change owner and group for `/home/db/`, and a
[cron(8)] table to run that script every five minutes (`*/5`):

<pre>
# <b>mkdir -p /home/db/www</b>
# <b>useradd db</b>
#
# <b>cat &gt; /home/db/www/dispatch &lt;&lt; EOF</b>
<i>#!/bin/sh</i>
<i>no_dir() { echo "${0##*/}: $1: No such directory" &gt;&2; exit 2; }</i>
<i></i>
<i>DB='/var/www/db/www'</i>
<i>EXP_TIME='3600'</i>
<i>FROM='<em>hi@romanzolotarev.com</em>'</i>
<i>NAME='<em>Roman Zolotarev</em>'</i>
<i>POSTS="$DB/posts"</i>
<i>TOKENS="$DB/tokens"</i>
<i>test -d "$POSTS" || no_dir "$POSTS"</i>
<i>test -d "$TOKENS" || no_dir "$TOKENS"</i>
<i></i>
<i>find "${POSTS}" -type f |</i>
<i>while read -r post</i>
<i>do</i>
<i>	test -f "$post" || break</i>
<i>	sendmail -t -F "$NAME" -f "$FROM" < "$post"</i>
<i>	rm "$post"</i>
<i>done</i>
<i></i>
<i>find "$TOKENS" -type f -cmin "+$(( EXP_TIME / 60 ))" -delete</i>
<i><b>EOF</b></i>
#
# <b>chown -R db:db /home/db</b>
# <b>echo '*/5 * * * * /home/db/www/dispatch' > /tmp/tab</b>
# <b>crontab -u db /tmp/tab</b>
#
</pre>


[cron(8)]: https://man.openbsd.org/cron.8
[smtpd(8)]: https://man.openbsd.org/smtpd.8
[smtpd.conf(5)]: https://man.openbsd.org/smtpd.conf.5
[user(8)]: https://man.openbsd.org/user.8
