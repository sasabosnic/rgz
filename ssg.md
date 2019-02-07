_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4_

# Make a static site with find(1), grep(1), and lowdown(1)

[ssg](/bin/ssg4) is a static site generator written in shell. Optionally it
converts Markdown files to HTML with
[lowdown(1)](https://kristaps.bsd.lv/lowdown/).

Unless a page has `<HTML>` tag _ssg4_ extracts its title from `<H1>`
tag, wraps the page with `_header.html`, `_footer.html`.

Then copies everything (excluding `.*`, `CVS`, and `_*`) from `src`
to `dst` directory.

[![ssg4](ssg4.png)](ssg4.png)
_180 LoC. [Enlarge, enhance, zoom!](ssg4.png)_

## Install

Download and chmod it:

<pre>
$ <b>mkdir -p bin</b>
$ <b>ftp -Vo bin/ssg4 https://www.romanzolotarev.com/bin/ssg4</b>
ssg4       100% |*********************|    4916      00:00
$ <b>chmod +x bin/ssg4</b>
$ <b>doas pkg_add lowdown</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
lowdown-0.3.1: ok
$
</pre>

lowdown(1) is optional. It's required only if there are
any `*.md` files.

## Usage

<pre>
$ <b>mkdir src dst</b>
$ <b>echo '# Hello, World!' > src/index.md</b>
$ <b>ftp -Vo src/_header.html https://www.romanzolotarev.com/raw/_header.html</b>
_header.html 100% |**************************|  3362       00:00
$ <b>ftp -Vo src/_footer.html https://www.romanzolotarev.com/raw/_footer.html</b>
_header.html 100% |**************************|   727       00:00
$ <b>ftp -Vo src/favicon.png https://www.romanzolotarev.com/raw/favicon.png</b>
favicon.png  100% |**************************|   408       00:00
$ <b>bin/ssg4 src dst 'Test' 'http://www'</b>
./index.md
./favicon.png
[ssg] 2 files, 1 url
$ <b>find dst</b>
dst
dst/.files
dst/index.html
dst/favicon.png
dst/sitemap.xml
$ <b>open dst/index.html</b>
</pre>

## Markdown and HTML files

_ssg4_ renders Markdown files first and then HTML files. In the
following example `src/a.html` wins:

	src/a.md   -> dst/a.html
	src/a.html -> dst/a.html

## Favicon

Make sure you have `/favicon.png` in place.

Some browsers fetch `/favicon.ico` despite what you specified in
the `<LINK>` tag, so you can use [an empty one](/favicon.ico) (180
bytes) as a placeholder.

## Sitemap

_ssg4_ generates `sitemap.xml` with the list of all page.  Don't
forget to add absolute URL of the sitemap to your `robot.txt`.<br>For
example:

	user-agent: *
	sitemap: https://www.romanzolotarev.com/sitemap.xml

## RSS

To generate RSS feeds use [rssg](rssg.html), then add their URLs
to `_header.html`.<br>For example:

	<link rel="alternate" type="application/atom+xml" href="/rss.xml">

## Incremental updates

On every run _ssg4_ saves a list of files in `dst/.files` and updates
only newer files. If no files were modified after that, _ssg4_ does
nothing.

<pre>
$ <b>bin/ssg4 src dst 'Test' 'https://www'</b>
[ssg] no files, 1 url
$
</pre>

To force the update delete `dst/.files` and re-run _ssg4_.

<pre>
$ <b>rm dst/.files</b>
$ <b>bin/ssg4 src dst 'Test' 'https://www'</b>
index.md
[ssg] 1 file, 1 url
$
</pre>

## Watch

Save this helper to `~/bin/sssg`. It re-runs _ssg4_ with
[entr(1)](http://entrproject.org) on every file change.

<pre>
$ <b>cat $HOME/bin/sssg</b>
#!/bin/sh
while :
do
	find . -type f ! -path '*/.*' |
	entr -d "$HOME/bin/ssg4" . "$1" "$(date)" '//www'
done
$
</pre>

Install entr(1):

<pre>
$ <b>doas pkg_add entr</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
entr-4.0: ok
$
</pre>

Start the helper and keep it running:

<pre>
$ <b>~/bin/s /var/www/htdocs/www</b>
[ssg] 1 file, 1 url
</pre>

## Upgrade

_[Previous version of ssg](ssg3.html) has been retired._

Add `<!DOCTYPE html>`, `<STYLE>...</STYLE>` with your styles and
an empty `<TITLE></TITLE>` tags to `_header.html`.

_ssg4_ captures page's title from the first `<H1>` tag of the page
and inject it into `<TITLE>`, if it's present and empty.

Move `_rss.html` to `_header.html`, `_styles.css` to `<STYLE>` tag
in `_header.html`, and `_scripts.js` to `<SCRIPT>` tag.

_ssg3_                               | _ssg4_
:--                                  | :--
Builds 1,730 files in **8.54s**      | in **5.43s**
&nbsp;                               |
Contains basic HTML tags.            | Contains no HTML tags.
wc(1) is required.                   | Doesn't use wc(1).
&nbsp;                               |
List of feeds read from `_rss.html`, | `_rss.html`,
styles from `_styles.css`, and       | `_styles.css`, and
scripts from `_scripts.js`.          | `_scripts.js` have been removed.

## Dependencies

_ssg4_ depends on few programs from OpenBSD base:

<pre>
$ <b>for f in $(which cat cpio date sh awk find grep printf readlink sort tee)</b>
<i><b>do ldd "$f"</b></i>
<i><b>done | awk '/\//{print$7}' | grep '.' | sort -u</b></i>
/bin/cat
/bin/cpio
/bin/date
/bin/sh
/usr/bin/awk
/usr/bin/find
/usr/bin/grep
/usr/bin/printf
/usr/bin/readlink
/usr/bin/sort
/usr/bin/tee
/usr/lib/libc.so.92.5
/usr/lib/libm.so.10.1
/usr/lib/libutil.so.13.0
/usr/lib/libz.so.5.0
/usr/libexec/ld.so
</pre>

---

## Users

[blog.solobsd.org](https://blog.solobsd.org/)<br>
[bloguslibrus.fr](https://www.bloguslibrus.fr)<br>
[bsdjobs.com](https://www.bsdjobs.com/)<br>
[cryogenix.net](https://cryogenix.net)<br>
[dethronedemperor.com](https://www.dethronedemperor.com)<br>
[grosu.nl](https://grosu.nl/)<br>
[h3artbl33d.nl](https://h3artbl33d.nl/)<br>
[high5.nl](https://high5.nl/)<br>
[matthewgraybosch.com](https://matthewgraybosch.com/)<br>
[mvidal.net](https://mvidal.net/)<br>
[openbsd.amsterdam](https://openbsd.amsterdam/?rz)<br>
[openbsd.space](https://openbsd.space/)<br>
[romanzolotarev.com](https://www.romanzolotarev.com/) &mdash; obviously ;)<br>
[runbsd.info](https://runbsd.info/)<br>
[stockersolutions.com](https://www.stockersolutions.com/)<br>

---

**Thanks** to
[Devin Teske](https://twitter.com/freebsdfrau/status/1075797843460288512)
for helping with awk(1),
[Kristaps Dzonsons](https://www.divelog.blue/) for
[lowdown(1)](https://kristaps.bsd.lv/lowdown/), and
[Eric Radman](http://eradman.com) for
[entr(1)](http://entrproject.org).
