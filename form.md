_Tested on [OpenBSD](/openbsd/) 6.4_

# Handle web forms with slowcgi(8) and httpd(8)

[form](/bin/form) is a shell script to handle web forms. It validates
and saves each posted form into a file in `/var/www/db/site/posts` directory.

## Configure web server

[Configure httpd(8)](/openbsd/httpd.html).

As `root` enable [slowcgi](https://man.openbsd.org/slowcgi):

<pre>
# <b>rcctl enable slowcgi</b>
# <b>rcctl start slowcgi</b>
#
</pre>

Make a directory for posted forms and tokens, then create a user
to [dispatch](dispatch.html) those forms:

<pre>
# <b>mkdir -p -m 0770 /var/www/db</b>
# <b>groupadd _db</b>
# <b>useradd -g _db -d /var/www/db _db</b>
# <b>chown www:_db /var/www/db</b>
# <b>su _db</b>
</pre>

Copy binaries to `/var/www`:

<pre>
# <b>echo '/bin/cat
/bin/chmod
/bin/date
/bin/dd
/bin/mkdir
/bin/rm
/bin/sh
/usr/bin/awk
/usr/bin/b64encode
/usr/bin/grep
/usr/bin/head
/usr/bin/jot
/usr/bin/printf
/usr/bin/sed
/usr/bin/stat
/usr/bin/tail
/usr/bin/tr
/usr/lib/libc.so.92.5
/usr/lib/libm.so.10.1
/usr/lib/libz.so.5.0
/usr/libexec/ld.so' |</b>
> <b>while read -r file</b>
> <b>do cp "$file" "/var/www$file"</b>
> <b>done</b>
#
</pre>

## Install

Add `form` to your website:

<pre>
$ <b>mkdir -p bin</b>
$ <b>ftp -Vo bin/form https://www.romanzolotarev.com/bin/form</b>
form       100% |*********************|    6815      00:00
$
</pre>

## Create a form

`bin/feedback`:

	#!/bin/sh
	MAIL_TO='hi@romanzolotarev.com'
	MAIL_SUBJECT='feedback'
	FIELDS='
	name, 1, 255, Name
	email, 7, 255, Email
	comment, 0, 500, Comment
	'
	ERR_FORMAT='%s should be from %s to %s chars'
	ERR_INVALID='Oops! Try again.'
	ERR_EXPIRED='Expired. Try again.'
	EXP_TIME='3600'
	DB='/db/www'
	TEMPLATE='../feedback.html'
	SUCCESS_URL='/thanks.html'
	. ./form


`feedback.html`:

	<form action="feedback.html" method="post">
	  <input type="hidden" name="token" value="$token">
	  <input type="text"   name="name"  value="$name">
	  <input type="email"  name="email" value="$email">
	  <textarea name="comment">$comment</textarea>
	  <p>$err</p>
	  <input type="submit" value="Send">
	</form>

`thanks.html`:

	<h1>Thank you</h1>

As `root` edit `/etc/httpd.conf`:

	...
	location "/feedback.html" {
		fastcgi
		root "/htdocs/www/bin/feedback"
	}
	...

Check this configuration and restart `httpd`:

<pre>
# <b>httpd -n</b>
configuration ok
# <b>rcctl restart httpd</b>
httpd(ok)
httpd(ok)
#
</pre>
