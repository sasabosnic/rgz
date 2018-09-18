**DRAFT**<br>
This page is about not released software.

_Tested on [OpenBSD](/openbsd/) 6.3_

# Generate RSS feeds with cat(1), grep(1), and sed(1)

[rssg](/bin/rssg) is a RSS feed generator written in shell. It's a
good companion for [ssg](ssg.html).

It gets RSS feed title, description, author email,
feed URL, and the list of items from an HTML file.

Then for every item it extracts a title and treats the rest of the
file as an item description, replacing all relative URLs with absolute
ones.

Finally, _rssg_ outputs the feed in XML format.

[![rssg](rssg.jpeg)](rssg.png)
_... LoC. [grep and cat everything](rssg.png)_

## Install

Download and chmod it:

<pre>
$ <b>ftp -Vo bin/rssg https://www.romanzolotarev.com/bin/rssg</b>
rssg       100% |*********************|    4137      00:00
$ <b>chmod +x bin/ssg2</b>
$ <b>doas pkg_add lowdown entr</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
lowdown-0.3.1: ok
entr-4.0: ok
$
</pre>

## Usage

<pre>
$ <b>rssg index.html &gt; rss.xml</b>
$
</pre>

Here is an example of a minimal `index.html` file:

<pre>
&lt;h1&gt;&lt;b&gt;<b>People who run BSD</b>&lt;/h1&gt;

&lt;p&gt;<i>
Stories written by users of BSD operating systems.
Hosted by &lt;a href="mailto:<b>hi@romanzolotarev.com</b>"&gt;<b>Roman Zolotarev</b>&lt;/a&gt;
</i>&lt;/p&gt;

&lt;p&gt;
Subscribe via &lt;a href="<b>https://bsdjobs.com/people/rss.xml</b>"&gt;RSS&lt;/a&gt;.
&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;&lt;a href="<b>mischapeters.html</b>" title="<b>2018-08-07</b>"&gt;<b>Mischa Peters</b>&lt;/a&gt;&lt;/li&gt;
&lt;li&gt;&lt;a href="<b>h3artbl33d.html</b>" title="<b>2018-08-06</b>"&gt;<b>h3artbl33d</b>&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
</pre>

HTML parsing rules:

- `<H1>` and `<A>` tags should not contain line breaks.
- **title** is the first `<H1>` tag.
- **description** is the first `<P>` tag.<br>
All `<H1>` tags are excluded from description.
- **name** is the first `<A>` with `mailto:` protocol.
- **email** is `HREF` attribute of that line.
- **url** is `HREF` attribute of the first `<A>` tag
with `RSS` content.<br>
- **items** are lines with `<A>` tags and `TITLE` attribute.
- **item file** is `HREF` attribute of that line, **item date** is
`TITLE` attribute, and **item title** is the content of `<A>` tag.

---

**Thanks** to [Devin Teske](https://twitter.com/devinteske) for
[her awk(1)
wizardry](https://twitter.com/freebsdfrau/status/1042076552400265219).
