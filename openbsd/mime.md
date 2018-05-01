# Set default applications on X Window System

When you click on a downloaded PDF file in Firefox or when you run
`xdg-open example.pdf`, the file will be opened with the default
application.

What is the mimetype for a PDF file?

    $ xdg-mime query filetype example.pdf
    application/pdf

Let's check the default application for `application/pdf`?

    $ xdg-mime query default application/pdf
    gimp.desktop

What? Why would you want to open your PDF files in Gimp? Weird. Let's fix
this.

First off, install MuPDF, if you didn't yet.

    # pkg_add mupdf

Then create `mupdf.desktop` in `~/.local/share/applications` directory
with just two lines.

    [Desktop Entry]
    Exec=/usr/local/bin/mupdf %u

Or use the full version:

    [Desktop Entry]
    Encoding=UTF-8
    Version=1.0
    Type=Application
    NoDisplay=true
    Exec=/usr/local/bin/mupdf %u
    Name=MuPDF
    Comment=A lightweight PDF viewer

Set the new default application:

    $ xdg-mime default mupdf.desktop application/pdf

Let's verify:

    $ xdg-mime query default application/pdf
    mupdf.desktop

Done.

---

P.S. Interestingly types for Word and Excel documents are not exactly what
would you expect:

    $ xdg-mime query filetype example.doc
    application/octet-stream
    $ xdg-mime query filetype example.xls
    application/octet-stream
    $ xdg-mime query filetype example.docx
    application/zip
    $ xdg-mime query filetype example.xlsx
    application/zip

_Tested on OpenBSD 6.3 with mupdf-1.11p2, firefox-59.0.2, and
libreoffice-6.0.2.1v0._
