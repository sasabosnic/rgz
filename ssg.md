# Static site generator with rsync and lowdown

[ssg](/bin/ssg) is less than two hundred lines of POSIX-compliant shell
script. It generates Markdown articles to a static website.

1. It copies the current directory file tree to `docs/` with
   [rsync(1)](https://rsync.samba.org/), ignoring `.*` and `_*`,

1. renders all Markdown articles to HTML with
   [lowdown(1)](https://kristaps.bsd.lv/lowdown/),

1. extracts the first `<h1>` tag from every article to generate a
   sitemap and use it as a page title,

1. then wraps articles with a single HTML template.

To watch source file changes it depends on
[entr(1)](http://entrproject.org/), and for the local web server it relies
on [httpd(8)](https://man.openbsd.org/httpd.8).

Feel free to fork it and re-write for your needs.

## Install


Download `ssg`. For example, on OpenBSD:

    $ ftp https://www.romanzolotarev.com/bin/ssg
    $ chmod +x ssg

## Build

For example your current directory looks like this:

    .
    |-- .git/
    |   |-- ...
    |-- projects/
    |   |-- build-a-rocket.md
    |   |-- me-and-my-dog-on-the-moon.jpeg
    |   `-- visit-the-moon.md
    |-- about.md
    |-- index.html
    `-- index.css

    $ ssg build
    building /home/alice/src/www/docs  2018-04-10T10:56:52+0000 4pp
    $

You have got a new directory `docs`.

    .
    |
    |-- .git/
    |   |-- ...
    |-- docs/
    |   |-- projects/
    |   |   |-- build-a-rocket.html
    |   |   |-- me-and-my-dog-on-the-moon.jpeg
    |   |   `-- visit-the-moon.html
    |   |-- about.html
    |   |-- index.html
    |   |-- index.css
    |   `-- sitemap.xml
    |-- projects/
    |   |-- ...

## Watch

To re-build pages on change run:

    $ ssg watch
    watching /home/alice/src/www
    building /home/alice/src/www/docs  2018-04-10T11:04:11+0000 4pp

`entr(1)` watches changes in `*.html`, `*.md`, `*.css`, `*.txt` files and
runs `ssg build` on every file change.

## Clean

If you'd like to delete all files in the destination directory before
the build, then run:

    $ ssg build --clean
    building /home/alice/src/www/docs --clean
    2018-04-16T09:03:32+0000 4pp
    $

The same option works for watching.

    $ ssg watch --clean
    watching /home/alice/src/www
    building /home/alice/src/www/docs --clean
    2018-04-16T09:04:25+0000 4pp

## Preview

To start a local web server run:

    $ ssg serve
    listening http://127.0.0.1:4000
    startup

`ssg` starts `httpd(1)` in a debug mode and serves pages from
<http://127.0.0.1:4000>.

## Deploy

To deploy to remote server over SSH run:

    $ export DOCS=/var/www/htdocs
    $ export REMOTE_HOST=www
    $ export REMOME_DOCS=/var/www/htdocs
    $ ssg delpoy
    deploying /var/www/htdocs
    to www:/var/www/htdocs... 4s
    $


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
