> "...Thanks for providing ssg! It is helping me
to (slowly) put my #OpenBSD musings into words..."<br>
[fd0](https://mobile.twitter.com/fd0_nl/status/1008026424362586113 "16 Jun 2018")
(@fd0_nl)

> "...thanx again for ssg! Starting to move gists
to my site and it couldn't have been more simple."<br>
[(((Mischa &#x1F576; &#x1F421; RCX)))](https://mobile.twitter.com/mischapeters/status/1005464189807353857 "9 Jun 2018")
(@mischapeters)

> "I am loving @romanzolotarev's romanzolotarev.com/ssg.html"<br>
[Doppelvizsla](https://mobile.twitter.com/doppelvizsla/status/988742307368271872 "24 Apr 2018")
(@doppelvizsla)

> "Thanks to @romanzolotarev's static site generator, I'm back on
my "static site sausage machine for some extra pocket peanuts" kick
again."<br>
[pr1ntf](https://mobile.twitter.com/pr1ntf/status/988605007556571136 "24 Apr 2018")
(@pr1ntf)

> "It's really inspiring to see you give back much to the community. I
appreciate your work - ssg, your how-to's for less familiar
users, etc. I felt I should mention that to you &#x1F600;"<br>
[H3artbl33d](https://mobile.twitter.com/h3artbl33d/status/985173503103074304 "14 Apr 2018")
(@h3artbl33d)

---

# Static site generator with rsync and lowdown

[ssg](/bin/ssg) is a tiny POSIX-compliant shell script with few
dependencies:

- [lowdown(1)](https://kristaps.bsd.lv/lowdown/) to parse markdown,
- [rsync(1)](https://rsync.samba.org/) to copy temporary files, and
- [entr(1)](http://entrproject.org/) to watch file changes.

It generates Markdown articles to a static website.

1. It copies the current directory to a temporary on in `/tmp` skipping
   `.*` and `_*`,

1. renders all Markdown articles to HTML,

1. generates [RSS feed](/rss.xml) based on links from  `index.html`,

1. extracts the first `<h1>` tag from every article to generate a
   sitemap and use it as a page title,

1. then wraps articles with a single HTML template,

1. copies everything from the temporary directory to `$DOCS/`.

![ssg](/ssg.jpeg)
_299 LoC in Vim with Terminus 8px. [Enlarge, enhance, zoom!](/ssg.png)_

## Why not Jekyll or "$X"?

`ssg` is **one hundred times smaller** than Jekyll.

`ssg` and its dependencies are about 800KB _combined_. Compare that
to 78MB of ruby with Jekyll and all the gems. So `ssg` can be
installed in just few seconds on almost any Unix-like operating
system.

Obviously, `ssg` is tailored for my needs, it has all features I
need and only those I use.

Keeping `ssg` helps you to master your Unix-shell skills: `awk`,
`grep`, `sed`, `sh`, `cut`, `tr`. As a web developer you work with
lots of text: code and data. So you better master these wonderful
tools.

## Performance

**100 pps**. On modern computers `ssg` generates a hundred pages
per second.  Half of a time for markdown rendering and another half
for wrapping articles into the template. I heard good static site
generators work---twice as fast---at 200 pps, so there's lots of
performance that can be gained. ;)

---

## Install

If you agree with the license, feel free to use this script, its
HTML and CSS or/and re-write them for your needs.

Install dependencies and download `ssg`. For example, on OpenBSD:
as root install `entr`, `rsync`, and `lowdown`.

<pre>
# <b>pkg_add entr rsync-3.1.3-iconv lowdown</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
entr-4.0: ok
rsync-3.1.3-iconv: ok
lowdown-0.3.1: ok
The following new rcscripts were installed: /etc/rc.d/rsyncd
See rcctl(8) for details.
</pre>

Then as a regular user change into `~/.bin` directory.

<pre>
$ <b>cd ~/.bin</b>
$ <b>ftp https://www.romanzolotarev.com/bin/ssg</b>
Trying 140.82.28.210...
Requesting https://www.romanzolotarev.com/bin/ssg
100% |****************************************|  7257       00:00
7257 bytes received in 0.00 seconds (2.99 MB/s)
$ <b>chmod +x ssg</b>
</pre>

Let's customize your `ssg` setup.

---

## Configuration

To configure `ssg` you need to set two variables:

- `$DOCS` - path to web server document root directory
- `$ROOT` - root URL of your web site

There are three more variables, but these are optional:

- `$WEBSITE_TITLE` - title (suffix) for all pages
- `$RSS_AUTHOR` - author's full name for RSS feed
- `$RSS_DESCRIPTION` - RSS feed description

You can set all those variables in enviornment with `export` or
`env`, but I recommend to create `_ssg.conf` file. For example, here
is mine:

	#!/bin/sh
	: "${DOCS:=/var/www/htdocs/www.romanzolotarev.com}"
	ROOT='https://www.romanzolotarev.com'
	WEBSITE_TITLE='Roman Zolotarev'
	RSS_AUTHOR='hi@romanzolotarev.com (Roman Zolotarev)'
	RSS_DESCRIPTION='Personal website'

Note: in this example if `$DOCS` is set, then `ssg` uses the original
value, **not** the value from `_ssg.conf`.

## Required files

There is only one file required:

1. `index.html` or `index.md` - home page

Example of `index.md`:

    # Jack

    - [About](/about.html "01 Aug 2016")

`ssg` renders `index.md` to `index.html` and then generates the RSS feed
based on first 20 links, if they have the following syntax (it only uses
page URL and date from `<a>` tag):

    ...
    <li><a href="/about.html" title="01 Aug 2016">About</a></li>
    ...

## Optional files

1. `_header.html` - header of every page
1. `_footer.html` - and its footer
1. `_styles.css` - styles, [take mine and customize](/src/www/raw/_styles.css)

If you use my CSS, don't forget to wrap the content of `_header.html`
into `<div class="header>...</div>` and the content of `_footer.html`
into `<div class="footer>...</div>`.

## Reserved file names

There are also reserved filenames, these files are generated when you run
`ssg build`. Don't use these names.

1. `rss.xml` - reserved for RSS feed
1. `sitemap.xml` - for the sitemap

## Your first page

Let's create `about.html` with one header and some text about your site.

    # About this site

    ...

`ssg` converts all `.md` article into `.html` and then uses content of the
first `<h1>` tag as a page title.

Nota bene: **Don't use `=====` in titles**.

## Build

Now we are ready to build. If your current source directory looks like
this:

    .
    |-- .git/
    |-- _footer.html
    |-- _header.html
    |-- _styles.css
    |-- about.md
    `-- index.md

After you run `ssg` (don't forget to set `$DOCS`):

<pre>
$ <b>ssg build</b>
building /var/www/htdocs/www  2018-04-10T10:56:52+0000 4pp
$
</pre>

You have your static website ready in `/var/www/htdocs/www`.

    .
    |
    |-- about.html
    |-- index.html
    |-- rss.xml
    `-- sitemap.xml

## Preview

For OpenBSD I suggest to run [httpd](/openbsd/httpd.html) locally.

For macOS and Linux you can run:

<pre>
$ <b>cd /var/www/htdocs/www</b>
$ <b>python -m SimpleHTTPServer</b>
Serving HTTP on 0.0.0.0 port 8000...
</pre>

## Watch

To re-build pages on change run:

<pre>
$ <b>ssg watch</b>
watching /home/jack/src/www
building /var/www/htdocs/www  2018-04-10T11:04:11+0000 4pp
</pre>

`entr(1)` watches changes in `*.html`, `*.md`, `*.css`, `*.txt` files and
runs `ssg build` on every file change.

## Clean

If you'd like to delete all files in the destination directory during
build, then run:

<pre>
$ <b>ssg build --clean</b>
building /home/jack/src/www/docs --clean
2018-04-16T09:03:32+0000 4pp
$
</pre>

The same option works for watching.

<pre>
$ <b>ssg watch --clean</b>
watching /home/jack/src/www
building /home/jack/src/www/docs --clean
2018-04-16T09:04:25+0000 4pp
</pre>

## Deploy with `rsync`

If you don't have a public server yet, [try Vultr](/vultr.html).
To deploy to remote server you can use `rsync(1)` like this:

<pre>
$ <b> rsync -avPc     /var/www/htdocs/www \
www.example.com:/var/www/htdocs/</b>
</pre>

Or if you want to clean up the target directory on the remote server use:

<pre>
$ <b>rsync -avPc --delete-excluded \
                /var/www/htdocs/www \
www.example.com:/var/www/htdocs/</b>
</pre>

## Deploy with Git `post-receive` hook

[Set up Git on your server](/git.html).

As root install `rsync` and `lowdown` packages on that server.

<pre>
# <b>pkg_add rsync-3.1.3-iconv lowdown</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
rsync-3.1.3-iconv: ok
lowdown-0.3.1: ok
The following new rcscripts were installed: /etc/rc.d/rsyncd
See rcctl(8) for details.
</pre>

Then as `git` user download `ssg` on the server:

<pre>
# <b>cd /home/git</b>
# <b>su git</b>
$ <b>mkdir -p /home/git/bin</b>
$ <b>cd /home/git/bin</b>
$ <b>ftp https://www.romanzolotarev.com/bin/ssg</b>
Trying 140.82.28.210...
Requesting https://www.romanzolotarev.com/bin/ssg
100% |****************************************|  7257       00:00
7257 bytes received in 0.00 seconds (2.99 MB/s)
$ <b>chmod +x ssg</b>
</pre>

Then add these lines to `/home/git/REPOSITORY.git/hooks/post-receive`:

	TMPDIR="$(mktemp -d)"
	git archive --format=tar HEAD | (cd "$TMPDIR" && tar xf -)
	cd "$TMPDIR"
	DOCS='/var/www/htdocs/www.romanzolotarev.com' \
	/home/git/ssg build --clean

As root make sure `git` user owns `$DOCS` directory:

<pre>
# <b>chown -R git:git /var/www/htdocs/www.romanzolotarev.com</b>
</pre>

_Tested on OpenBSD 6.3_

---

**Thanks** to
[Denis Borovikov](https://mobile.twitter.com/metallerden) for reading the draft of this,
[h3artbl33d](https://mobile.twitter.com/h3artbl33d), and
[Mischa Peters](https://mobile.twitter.com/mischapeters), and
[Tom Atkinson](https://mobile.twitter.com/hir0pr0tagonist) for testing `ssg`,
[Kristaps Dzonsons](https://www.divelog.blue/) for
[lowdown(1)](https://kristaps.bsd.lv/lowdown/) and
[Eric Radman](http://eradman.com) for
[entr(1)](http://entrproject.org).
