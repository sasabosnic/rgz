This minimalist script depends only on programs from OpenBSD base.
To encrypt your files use [bioctl(8) with
CRYPTO](/openbsd/bioctl-crypto.html),
[openssl(1)](https://man.openbsd.org/openssl.1), or
[scrypt](https://www.tarsnap.com/scrypt.html).

If you are looking for a deduplicating archiver, try [borg(1)](/borg.html).

_Tested on [OpenBSD](/openbsd/) 6.3_

# Archive with mtree(8) and pax(1)

[arc](/bin/arc) is an archiver with compression. It creates a spec
of the original file tree with [mtree(8)][m], then creates a
compressed archive with [pax(1)][p] and [gzip(1)][g].

[g]: https://man.openbsd.org/gzip.1
[m]: https://man.openbsd.org/mtree.8
[p]: https://man.openbsd.org/pax.1
[s]: https://man.openbsd.org/sed.1
[h]: https://man.openbsd.org/sha256.1

## Install

<pre>
$ <b>ftp -Vo ~/bin/arc https://www.romanzolotarev.com/bin/arc</b>
arc          100% |********************| 18711       00:00
$ <b>chmod +x ~/bin/arc</b>
</pre>

## Create an archive

<pre>
$ <b>arc ~/src /tmp/archive</b>
/home/romanzolotarev/src 24080K /tmp/archive 16752K OKAY
$ <b>ls -1 /tmp/archive*</b>
/tmp/archive
/tmp/archive.tree.gz
/tmp/archive.tree.sha256
$
</pre>

## Extract a file

Restore one file from the archive and compare its
contents with the original.

<pre>
$ <b>cd /tmp</b>
$ <b>pax -pe -rzf /tmp/archive ./www/arc.md</b>
$ <b>diff ~/src/www/arc.md ./www/arc.md</b>
$
</pre>

## Extract all files

[arc_extract](/bin/arc_extract) restores whole archive into _current
directory_ and compares restored files with the spec created by
mtree(8).

Note: time of original files in spec is in nanoseconds, while pax(1)
restores time in seconds. Therefore, we use sed to cut nanoseconds.

<pre>
$ <b>mkdir -p /tmp/restored && cd /tmp/restored</b>
$ <b>arc_extract archive</b>
$
</pre>

or just do the same manually:

<pre>
$ <b>mkdir -p /tmp/restored && cd /tmp/restored</b>
$ <b>pax -pe -rzf /tmp/archive</b>
$ <b>gunzip < /tmp/archive.tree.gz > /tmp/archive.tree</b>
$ <b>sha256 < tree; cat /tmp/archive.tree.sha256</b>
a4bc68e9d1144b3d7ece8dfea77fa4db3ab32460b3d6296bdb1085d5a074e37f
a4bc68e9d1144b3d7ece8dfea77fa4db3ab32460b3d6296bdb1085d5a074e37f
$ <b>sed 's/time=\([0-9]*\)\.[0-9]*/time=\1.0/' /tmp/archive.tree|mtree</b>
$
</pre>
