# Publish your Git repositories with stagit(1) and httpd(1)

stagit(1) generates HTML files from on your git repository.

View source of this website, for example: [/src/www](/src/www/).

If you don't have a web server yet, [set up one](/openbsd/webserver.html).
If you don't host your Git repositories, it's time [to set up Git on this server](/git.html).

On OpenBSD you have to build stagit(1) from sources (the version from ports fails).

<pre>
# <b>pkg_add libgit2</b>
# <b>cd /tmp</b>
# <b>git clone git://git.codemadness.org/stagit</b>
# <b>cd stagit</b>
# <b>make && make install</b>
</pre>

Let's configure httpd(8). Add `location` section to your `server`.

	location "/src*" { root { "/src", strip 1 } }

<pre>
# <b>httpd -n</b>
# <b>rcctl restart httpd</b>
</pre>

Switch to `git` user:

<pre>
# <b>su git</b>
$ <b>cd</b>
$ <b>echo <i>'DESCRIPTION'</i> > <i>REPOSITORY.git</i>/description</b>
</pre>

Make `src` directory in `/var/www`:

<pre>
$ <b>mkdir -p /var/www/src</b>
$ <b>cd /var/www/src</b>
$ <b>stagit-index /home/git/* > index.html</b>
</pre>

Add `style.css`, `logo.png`, and `favion.png` to taste.

Then add [stagit-post-recive.sh](/stagit-post-recive.sh) script to `/home/git`.

<pre>
$ <b>cd /home/git</b>
$ <b>ftp https://www.romanzolotarev.com/stagit-post-recive.sh</b>
$ <b>chmod +x stagit-post-recive.sh</b>
</pre>

Edit the script for your needs.

## Add one more repo?

Add for files to your bare repository:

<pre>
$ <b>cd <i>/home/git/REPOSITORY.git</i></b>
$ <b>echo <i>'git://REMOTE_SERVER/src/REPOSITORY.git'</i> > url</b>
$ <b>echo <i>'OWNER_NAME'</i> > owner</b>
$ <b>echo <i>'DESCRIPTION'</i> > description</b>
</pre>

Edit `hooks/post-recive`:

	#!/bin/sh
	/home/git/stagit-post-recive.sh

Don't forget to make it executable.

<pre>
$ <b>chmod +x hooks/post-recive</b>
</pre>

When all repos are ready, update the index file:

<pre>
$ <b>cd /var/www/src</b>
$ <b>stagit-index /home/git/* > index.html</b>
</pre>

From your local host:

<pre>
$ <b>git push <i>REMOTE</i></b>
</pre>

Done!

_Tested on OpenBSD 6.3_
