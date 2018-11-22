_Tested on [OpenBSD](/openbsd/) 6.4_

# Handle web forms with slowcgi(8) and httpd(8)

[form](/bin/form) is a shell script to handle web forms. It validates
and saves each posted form into a file in `/var/www/db/site/posts` directory.

[Configure httpd(8)](/openbsd/httpd.html).

Enable [slowcgi](https://man.openbsd.org/slowcgi), make a directory
for posted forms and tokens, then create a user to
[dispatch](dispatch.html) those forms, copy binaries to `/var/www`,
download `form`.

<pre>
# <b>rcctl enable slowcgi</b>
# <b>rcctl start slowcgi</b>
#
# <b>mkdir /home/db</b>
# <b>useradd db</b>
# <b>chown db:db /home/db</b>
# <b>mkdir -p -m 0770 /var/www/db</b>
# <b>chown www:db /var/www/db</b>
#
# <b>echo '/bin/cat</i>
<i>/bin/chmod</i>
<i>/bin/date</i>
<i>/bin/dd</i>
<i>/bin/mkdir</i>
<i>/bin/rm</i>
<i>/bin/sh</i>
<i>/usr/bin/awk</i>
<i>/usr/bin/b64encode</i>
<i>/usr/bin/grep</i>
<i>/usr/bin/head</i>
<i>/usr/bin/jot</i>
<i>/usr/bin/printf</i>
<i>/usr/bin/sed</i>
<i>/usr/bin/stat</i>
<i>/usr/bin/tail</i>
<i>/usr/bin/tr</i>
<i>/usr/lib/libc.so.92.5</i>
<i>/usr/lib/libm.so.10.1</i>
<i>/usr/lib/libz.so.5.0</i>
<i>/usr/libexec/ld.so' |</b></i>
<i><b>while read -r f</b></i>
<i><b>do cp "$f" "/var/www$f"</b></i>
<i><b>done</b></i>
#
# <b>ftp -Vo /var/www/bin/form https://www.romanzolotarev.com/bin/form</b>
form       100% |*********************|    6815      00:00
#
</pre>

Create a form, template, and success page. Check the new configuration and restart `httpd`:

<pre>
# <b>cd /var/www/htdocs/www/</b>
#
# <b>cat &gt; bin/feedback &lt;&lt; EOF</b>
<i>#!/bin/sh</i>
<i>MAIL_TO='<em>hi@romanzolotarev.com</em>'</i>
<i>MAIL_SUBJECT='<em>feedback</em>'</i>
<i>FIELDS='</i>
<i><em>name, 1, 255, Name</em></i>
<i><em>email, 7, 255, Email</em></i>
<i><em>comment, 0, 500, Comment</em></i>
<i>'</i>
<i>ERR_FORMAT='%s should be from %s to %s chars'</i>
<i>ERR_INVALID='Oops! Try again.'</i>
<i>ERR_EXPIRED='Expired. Try again.'</i>
<i>EXP_TIME='3600'</i>
<i>DB='/db/www'</i>
<i>TEMPLATE='/htdocs/www/feedback.html'</i>
<i>SUCCESS_URL='/thanks.html'</i>
<i>. ./form</i>
<i><b>EOF</b></i>
#
# <b>cat &gt; feedback.html &lt;&lt; EOF</b>
<i>&ltform action="feedback.html" method="post"&gt;</i>
<i><em>	&lt;input type="hidden" name="token" value="$token"&gt;</em></i>
<i><em>	&lt;input type="text"   name="name"  value="$name"&gt;</em></i>
<i><em>	&lt;input type="email"  name="email" value="$email"&gt;</em></i>
<i><em>	&lt;textarea name="comment"&gt;$comment&lt;/textarea&gt;</em></i>
<i>	&lt;p&gt;$err&lt;/p&gt;</i>
<i>	&lt;input type="submit" value="Send"&gt;</i>
<i>&lt;/form></i>
<i><b>EOF</b></i>
#
# <b>cat &gt; thanks.html &lt;&lt; EOF</b>
<i>&lt;h1&gt;Thank you&lt;/h1&gt;</i>
<i><b>EOF</b></i>
#
# <b>cat &gt; /etc/httpd.conf &lt;&lt; EOF</b>
<i>server "www" {</i>
<i>	listen on * port 80</i>
<i>	root "/htdocs/www"</i>
<i>	location "/feedback.html" {</i>
<i>		fastcgi</i>
<i>		root "/htdocs/www/bin/feedback"</i>
<i>	}</i>
<i>}</i>
<i><b>EOF</b></i>
#
# <b>httpd -n</b>
configuration ok
# <b>rcctl restart httpd</b>
httpd(ok)
httpd(ok)
#
</pre>
