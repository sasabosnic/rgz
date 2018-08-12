_Tested on [OpenBSD](/openbsd/) 6.3 with stagit
[187daa](https://git.codemadness.org/stagit/commit/187daac42007c87e6af9317a20446e3b81907f63.html)_

# Publish Git repositories with stagit(1) on OpenBSD

[stagit(1)](https://git.codemadness.org/stagit/) generates HTML files
from your git repository. The source of this website, for example:
[/src/www](/src/www/).

Set up [git](/git.html) and [httpd](/openbsd/httpd.html).

## Build stagit(1)

On OpenBSD we have to build stagit(1) from sources:

<pre>
# <b>pkg_add libgit2</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
libgit2-0.26.3:libssh2-1.8.0: ok
libgit2-0.26.3: ok
# <b>cd /tmp</b>
# <b>git clone git://git.codemadness.org/stagit</b>
Cloning into 'stagit'...
remote: Counting objects: 946, done.
remote: Compressing objects: 100% (396/396), done.
remote: Total 946 (delta 620), reused 834 (delta 549)
Receiving objects: 100% (946/946), 164.47 KiB | 230.00 KiB/s, done.
Resolving deltas: 100% (620/620), done.
# <b>cd /tmp/stagit</b>
# <b>make && make install</b>
cc -c -O2 -std=c99 -I/usr/local/include -D_XOPEN_SOURCE=700
-D_DEFAULT_SOURCE -D_BSD_SOURCE -I/usr/local/include -o stagit.o
-c stagit.c
...
</pre>

## Configure httpd(8)

Edit `/etc/httpd.conf` to add `location` section to your `server`.

```
...
location "/src/*" { root { "/src", strip 1 } }
...
```

Make `src` directory in `/var/www`:

<pre>
# <b>mkdir -p /var/www/src</b>
# <b>chown git:git /var/www/src</b>
#
</pre>

Verify the new httpd configuration and restart it:

<pre>
# <b>httpd -n</b>
configuration OK
# <b>rcctl restart httpd</b>
httpd(ok)
httpd(ok)
#
</pre>

## Add repositories

Switch to `git` user:

<pre>
# <b>cd /home/git</b>
# <b>su git</b>
$
</pre>

Repeat these steps for every of your repositories:

<pre>
$ <b>cd <i>/home/git/REPOSITORY.git</i></b>
$ <b>echo <i>'git://REMOTE_SERVER/src/REPOSITORY.git'</i> > url</b>
$ <b>echo <i>'OWNER_NAME'</i> > owner</b>
$ <b>echo <i>'DESCRIPTION'</i> > description</b>
$
</pre>

Edit a hook script `/home/git/REPOSITORY.git/hooks/post-receive`:

```
#!/bin/sh
export LC_CTYPE='en_US.UTF-8'
src="$(pwd)"
name=$(basename "$src")
dst="/var/www/src/$(basename "$name" '.git')"
mkdir -p "$dst"
cd "$dst" || exit 1

echo "[stagit] building $dst"
stagit "$src"

ln -sf log.html index.html
ln -sf ../style.css style.css
ln -sf ../logo.png logo.png
```

Or download a bit more advanced [post-receive](/post-receive) hook:

<pre>
$ <b>cd /home/git/REPOSITORY.git/hooks</b>
$ <b>ftp -V https://www.romanzolotarev.com/post-receive</b>
post-receive 100% |*****************************|  1032       00:00
$ <b>chmod +x post-receive</b>
$
</pre>

Edit the script to suit your needs.

When all repos are ready, generate the index page:

<pre>
$ <b>cd /var/www/src</b>
$ <b>stagit-index /home/git/*.git > index.html</b>
$
</pre>

Add `style.css`, `logo.png`, and `favicon.png` to `/var/www/src` if
needed.

<pre>
$ <b>ftp -V https://www.romanzolotarev.com/stagit/style.css</b>
style.css    100% |*****************************|   959       00:00
$ <b>ftp -V https://www.romanzolotarev.com/stagit/logo.png</b>
logo.png     100% |*****************************|  6406       00:00
$ <b>ftp -V https://www.romanzolotarev.com/favicon.png</b>
favicon.png  100% |*****************************|   408       00:00
$
</pre>

To test `post-receive` hook push from your local host to the server:

<pre>
$ <b>git push <i>REMOTE</i> master</b>
...
$
</pre>

---

**Thanks** to
[Adriano Barbosa](https://twitter.com/barbosaaob)
for catching a bug in httpd.conf.
