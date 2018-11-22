_Tested on [OpenBSD](/openbsd/) 6.4 with stagit-0.8_

# Publish Git repositories with stagit(1) on OpenBSD

[stagit(1)](https://git.codemadness.org/stagit/) generates HTML files
from your git repository. The source of this website, for example:
[/src/](/src/).

## Install

Set up [git](/git.html) and [httpd](/openbsd/httpd.html), then install stagit.

<pre>
# <b>pkg_add stagit</b>
quirks-3.16 signed on 2018-10-12T15:26:25Z
stagit-0.8:libssh2-1.8.0p0: ok
stagit-0.8:libgit2-0.27.2: ok
stagit-0.8: ok
#
</pre>

## Update Git repository

Add `owner` and `description` to the Git repository:

<pre>
$ <b>cd <em>REPOSITORY.git</em></b>
$ <b>echo <em>'OWNER_NAME'</em> > owner</b>
$ <b>echo <em>'DESCRIPTION'</em> > description</b>
$
</pre>

Add `post-receive` hook to `REPOSITORY.git/hooks/`:

	#!/bin/sh
	set -e
	dst="/var/www/htdocs/$(basename "$(pwd)" '.git')"

	mkdir -p "$dst/src"
	(cd "$dst/src" && stagit "$src")
	cp -f "$dst/src/log.html" "$dst/src/index.html"

Check out my files: [post-receive](/post-receive) hook and
[style.css](/stagit/style.css).

## Test

To test `post-receive` hook push from your local host to the server:

<pre>
$ <b>git push <em>REMOTE</em> master</b>
...
$
</pre>
