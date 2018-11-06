_Tested on [OpenBSD](/openbsd/) 6.4 with rsync 3.1.3_

# Copy files with rsync

## Install

<pre>
# <b>pkg_add rsync-3.1.3</b>
quirks-3.16 signed on 2018-10-12T15:26:25Z
rsync-3.1.3: ok
The following new rcscripts were installed: /etc/rc.d/rsyncd
See rcctl(8) for details.
#
</pre>

## Paths

[rync](https://rsync.samba.org/) copies `src/` to `dst` and on
the second run it does nothing if `src/` hasn't changed. But if run
_rsync_ with `src` (without the trailing slash), it copies `src/` to
`dst/src`.

<pre>
$ <b>mkdir src</b>
$ <b>rsync -r src/ dst</b>
$ <b>find dst</b>
dst
$ <b>rsync -r src/ dst</b>
$ <b>find dst</b>
dst
$ <b>rsync -r src dst</b>
$ <b>find dst</b>
dst
dst/src
</pre>

Where<br>
`-r` &mdash; recursive<br>

Remember: Add the **trailing slash** to copy contents of `src`.

## Archive

To create an exact copy of `src` to `dst` use `-a` option:

<pre>
$ <b>rsync -a src/ dst</b>
$
</pre>

Where<br>
`-a` &mdash; archive mode; equals `-rlptgoD`:<br>
`-l` &mdash; copy symlinks as _symlinks_<br>
`-p` &mdash; preserve _permissions_<br>
`-t` &mdash; _time_<br>
`-g` &mdash; _group_<br>
`-o` &mdash; _owner_<br>
`-D` &mdash; _device_ and _special_ files

## Don't preserve some attributes

Useful for FAT/[exFAT](/openbsd/exfat.html) filesystems.

<pre>
$ <b>rsync -rt --size-only src/ dst</b>
$
</pre>

Where<br>
`-t` &mdash; preserve modification times<br>
`--size-only` &mdash; skip files that match in size

## Verbose output and progress

<pre>
$ <b>touch src/test</b>
$ <b>rsync -avP src/ dst</b>
sending incremental file list
src/test
              0 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=0/2)

sent 112 bytes  received 36 bytes  296.00 bytes/sec
total size is 0  speedup is 0.00
$
</pre>

Where<br>
`-v` &mdash; verbose<br>
`-P` &mdash; show progress during transfer

## Remote hosts

A source or/and destination can be located on remove hosts.
For example, _server_ &mdash; is a remove source.

<pre>
$ <b>rsync -a server:src/ dst</b>
$
</pre>

## Exclude files

<pre>
$ <b>find src</b>
src/bar
src/bar/foo
src/foo
src/foobar
$ <b>rsync -r --exclude='foo' src/ dst</b>
$ <b>find dst</b>
dst
dst/bar
dst/foobar
$
</pre>

You can use patterns. For example:

`*` &mdash; match any path, but stop at slashes.<br>
`**` &mdash; anything, including slashes.<br>
`?` &mdash; any character, except a slash.

To delete files from `dst` that don't exist in `src/` use `--delete`
option and to delete excluded as well use `--delete-excluded`:

<pre>
$ <b>rsync -r --exclude='foo*' --delete-excluded src/ dst</b>
$ <b>find dst</b>
dst
dst/bar
$
</pre>
