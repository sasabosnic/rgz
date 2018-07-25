_Tested on [OpenBSD 6.3](/openbsd/) with mupdf-1.11p2, firefox-59.0.2,
and libreoffice-6.0.2.1v0_

# Set default programs with xdg-mime(1)

When you click on a downloaded PDF file in Firefox or when you run
[xdg-open(1)](https://man.openbsd.org/xdg-open.1), the file opens
with ths default program for its mimetype.

Check the mimetype with
[xdg-mime(1)](https://man.openbsd.org/xgd-mime.html):

<pre>
$ <b>xdg-mime query filetype example.pdf</b>
application/pdf
$
</pre>

Let's check the default application for `application/pdf`?

<pre>
$ <b>xdg-mime query default application/pdf</b>
gimp.desktop
$
</pre>

What? Why would you want to open your PDF files in Gimp? Weird.
Let's fix this.

First off, install MuPDF, if you didn't yet.

<pre>
# <b>pkg_add mupdf</b>
...
mupdf-1.11p2:glfw-3.2.1p0: ok
mupdf-1.11p2: ok
#
</pre>

Then create `mupdf.desktop` in `~/.local/share/applications` directory
with just two lines.

```
[Desktop Entry]
Exec=/usr/local/bin/mupdf %u
```

Or use the full version:

```
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=/usr/local/bin/mupdf %u
Name=MuPDF
Comment=A lightweight PDF viewer
```

Set the new default application:

<pre>
$ <b>xdg-mime default mupdf.desktop application/pdf</b>
$
</pre>

Let's verify:

<pre>
$ <b>xdg-mime query default application/pdf</b>
mupdf.desktop
$
</pre>


P.S. Types for Word and Excel documents are not exactly what would
you expect:

<pre>
$ <b>xdg-mime query filetype example.doc</b>
application/octet-stream
$ <b>xdg-mime query filetype example.xls</b>
application/octet-stream
$ <b>xdg-mime query filetype example.docx</b>
application/zip
$ <b>xdg-mime query filetype example.xlsx</b>
application/zip
$
</pre>
