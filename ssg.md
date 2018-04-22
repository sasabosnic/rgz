"It's really inspiring to see you give back much to the community. I
appreciate your work - ssg, your how-to's for less familiar
users, etc. I felt I should mention that to you &#x1F600;"
<div class="quote"><a href="https://mobile.twitter.com/h3artbl33d/status/985173503103074304">
<img src="/avatars/h3artbl33d.jpeg" class="quote__avatar" title="14 Apr 2018" alt="H3artbl33d (@h3artbl33d)"></a>
<span class="quote__name">H3artbl33d (@h3artbl33d)</span></div>


# Static site generator with rsync and lowdown

[ssg](/bin/ssg) is less than two hundred lines of POSIX-compliant shell
script. It generates Markdown articles to a static website.

1. It copies the current directory file tree to a temporary directory in
   `/tmp` with [rsync(1)](https://rsync.samba.org/), ignoring `.*` and
   `_*`,

1. renders all Markdown articles to HTML with
   [lowdown(1)](https://kristaps.bsd.lv/lowdown/),

1. generates [RSS feed](/rss.xml) based on links from  `index.html`,

1. extracts the first `<h1>` tag from every article to generate a
   sitemap and use it as a page title,

1. then wraps articles with a single HTML template,

1. copies everything from the temporary directory to `$DOCS/`.

To watch source file changes it depends on
[entr(1)](http://entrproject.org/), and for the local web server it relies
on [httpd(8)](https://man.openbsd.org/httpd.8).

If you agree with the licences feel free to use this script its HTML and
my [styles.css](/styles.css) or re-write them for your needs.

## Install

Download `ssg` and install dependencies. For example, on OpenBSD:

    $ cd ./bin
    $ ftp https://www.romanzolotarev.com/bin/ssg
    $ chmod +x ssg
    $ pkg_add entr rsync lowdown

Let's customize `ssg` for you.

---

## Variables

Before you start, obviously you'll need to replace my credentials with
yours.

    $ export WEBSITE_TITLE='Jack'
    $ export SERVER_NAME='www.example.com'
    $ export SERVER_PROTO='https'
    $ export RSS_AUTHOR='jack@example.com (Jack)'
    $ export RSS_DESCRIPTION='Personal website'
    $ export COPYRIGHT_YEAR='2016'

Define your target directory in `$DOCS`:

    $ export DOCS='/var/www/htdocs/www'

## Required files

There are few required files:

1. `index.html` or `index.md` - home page
1. `styles.css` - styles, [take mine and customize](/styles.css)

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

1. `header.html` - header of every page
1. `footer.html` - and its footer
1. `announcement.html` - added to the top of every page, if the file
   exists.

If you want to override defaults, here are examples for `header`...

    <a href="/">Home</a> -
    <a href="https://twitter.com/jack">Twitter</a>

... and `footer`:

    Copyright 2018 <a href="/about.html">Jack</a>

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
    |-- about.md
    |-- footer.html
    |-- header.html
    |-- index.md
    `-- styles.css

After you run `ssg` (don't forget to set `$DOCS`):

    $ export DOCS=/var/www/htdocs/www
    $ ssg build
    building /var/www/htdocs/www  2018-04-10T10:56:52+0000 4pp
    $

You have your static website ready in `/var/www/htdocs/www`.

    .
    |
    |-- about.html
    |-- footer.html
    |-- header.html
    |-- styles.css
    |-- index.html
    |-- rss.xml
    `-- sitemap.xml

## Preview

For OpenBSD I suggest to a [web server](/openbsd/webserver.html) locally.

For macOS and Linux you can run:

    $ cd /var/www/htdocs/www
    $ python -m SimpleHTTPServer
    Serving HTTP on 0.0.0.0 port 8000...

## Watch

To re-build pages on change run:

    $ ssg watch
    watching /home/jack/src/www
    building /var/www/htdocs/www  2018-04-10T11:04:11+0000 4pp

`entr(1)` watches changes in `*.html`, `*.md`, `*.css`, `*.txt` files and
runs `ssg build` on every file change.

## Clean

If you'd like to delete all files in the destination directory during
build, then run:

    $ ssg build --clean
    building /home/jack/src/www/docs --clean
    2018-04-16T09:03:32+0000 4pp
    $

The same option works for watching.

    $ ssg watch --clean
    watching /home/jack/src/www
    building /home/jack/src/www/docs --clean
    2018-04-16T09:04:25+0000 4pp

## Deploy

If you don't have a public server yet, [try Vultr](/vultr.html).
To deploy to remote server you can use `rsync(1)` like this:

    $ rsync -avPc     /var/www/htdocs/www \
      www.example.com:/var/www/htdocs/

Or if you want to clean up the target directory on the remote server use:

    $ rsync -avPc --delete-excluded \
                      /var/www/htdocs/www \
      www.example.com:/var/www/htdocs/

## Performance

**100 pps**. On modern computers `ssg` generates a hundred pages per second.
Half of a time for markdown rendering and another half for wrapping
articles into the template. I heard good static site generators
work---twice as fast---at 200 pps, so there's lots of performance that can
be gained. ;)

---

**Thanks** to [h3artbl33d](https://twitter.com/h3artbl33d) and [Mischa
Peters](https://twitter.com/mischapeters) for testing `ssg`, [Kristaps
Dzonsons](https://www.divelog.blue/) for
[lowdown(1)](https://kristaps.bsd.lv/lowdown/) and [Eric
Radman](http://eradman.com) for [entr(1)](http://entrproject.org).
