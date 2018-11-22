_Tested on [OpenBSD](/openbsd/) 6.4_

# Send emails with smtpd(8) and sendmail(8)

## Configure mail server

As `root` edit `/etc/mail/smtpd.conf`

<pre>
table aliases file:/etc/mail/aliases
table secrets file:/etc/mail/secrets

listen on lo0

action "local" mbox alias <aliases>
action "relay" relay host smtp+tls://<i>user@server:port</i> auth &lt;secrets&gt;

match for local action "local"
match for any action "relay"
</pre>

Add `/etc/mail/secrets`:

<pre>
# <b>touch /etc/mail/secrets</b>
# <b>chmod 640 /etc/mail/secrets</b>
# <b>chown root:_smtpd /etc/mail/secrets</b>
# <b>echo "<i>user username:password</i>" &gt; /etc/mail/secrets</b>
#
</pre>

Restart `smtpd`:

<pre>
# <b>rcctl restart smtpd</b>
smtpd (ok)
smtpd (ok)
#
</pre>

## Setup

Add `bin/dispatch` script to your website:

<pre>
#!/bin/sh
no_dir() { echo "${0##*/}: $1: No such directory" &gt;&2; exit 2; }

CHROOT='/var/www'
DB='/db/www'
EXP_TIME='3600'
FROM='hi@romanzolotarev.com'
NAME='Roman Zolotarev'
POSTS="${CHROOT}$DB/posts"
TOKENS="${CHROOT}$DB/tokens"
test -d "$POSTS" || no_dir "$POSTS"
test -d "$TOKENS" || no_dir "$TOKENS"

find "${POSTS}" -type f |
while read -r post
do
	test -f "$post" || break
	sendmail -t -F "$NAME" -f "$FROM" < "$post"
	rm "$post"
done

find "$TOKENS" -type f -cmin "+$(( EXP_TIME / 60 ))" -delete
</pre>

## Schedule

As `root` create a user and add a cron table:

<pre>
# <b>user add -g =uid -o -m db</b>
# <b>echo '*/2 * * * * /var/www/htdocs/www/bin/dispatch' > /tmp/tab</b>
# <b>crontab -u db /tmp/tab</b>
#
</pre>
