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

## Usage

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

Download and run `ssg`:

    $ ftp https://www.romanzolotarev.com/bin/ssg
    $ chmod +x ssg
    $ ssg build
    2018-04-10T10:56:52+0000 4pp
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

To re-build pages on change run:

    $ ssg watch
    2018-04-10T11:04:11+0000 4pp
    $

`entr(1)` watches changes in `*.html`, `*.md`, `*.css`, `*.txt` files and
runs `ssg build` on every file change.

To start web server run:

    $ ssg serve
    serving /home/romanzolotarev/src/romanzolotarev.com/docs
    listening http://127.0.0.1:4000
    startup

`ssg` starts `httpd(1)` in a debug mode and serves pages from
<http://127.0.0.1:4000>.

You can build, watch changes, and serve pages with a single command:

    $ ssg
    watching /home/romanzolotarev/src/romanzolotarev.com
    serving /home/romanzolotarev/src/romanzolotarev.com/docs
    listening http://127.0.0.1:4000
    startup
    2018-04-10T11:06:43+0300 4pp

## Environment variables

To change the destination directory, server address or port, define
environment variables `DOCS`, `HOST`, `PORT`. For example:

    $ DOCS=_static ssg build
    $ DOCS=/var/www/htdocs ssg watch
    $ HOST=192.168.1.111 PORT=8000 ssg serve

## Performance

**100 pps**. On modern computers `ssg` generates a hundred pages per second.
Half of a time for markdown rendering and another half for wrapping
articles into the template. I heard good static site generators
work---twice as fast---at 200 pps, so there's lots of performance that can
be gained. ;)

---

**Thanks** to [h3artbl33d](https://twitter.com/h3artbl33d) and [Mischa
Peters](https://twitter.com/mischapeters) for testing `ssg`.
