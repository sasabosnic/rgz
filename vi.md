> TIL #OpenBSD nvi can do split window... Thanks
@romanzolotarev!"<br>&mdash;
[ParadeGrotesque](https://mobile.twitter.com/ParadeGrotesque/status/1002454625272901632 "1 Jun 2018")
(@ParadeGrotesque)

_Tested on [OpenBSD](/openbsd/) 6.3_

# Edit text with vi(1)

On OpenBSD [vi(1)](https://man.openbsd.org/vi.1) is based on [nvi
1.79](https://sites.google.com/a/bostic.com/keithbostic/vi), written
by Keith Bostic.

You can't _record_ macros in nvi, but you still can use them. Add
a sequence of commands into a buffer (for example, `"q...`), then
apply the macro as usual (with `@q`).

To edit multiple files: `vi file1 file2`, then `:n[ext]`, `:prev` to
switch, and `:ar[gs]` to list them all.

To open one more file `:e[dit] file`, then `^6` to alternate between
two, or use `:e#` command.

To open in a split `:E[dit] file`, then `^W` to switch between windows,
and to set the window height to 20 lines `:res[ize] 20`.

To scroll current line to the top `z<Enter>`, to the center `z.`,
and to the bottom of screen `z-`. Scroll lines with `^Y` and
`^E` as usual.

To search for the "expression" and place the next occurence of it
to the center of screen: `/expression/z.`.

Undo and redo: Press `u` to undo previous edit, then press `.` (dot)
to undo, to redo press `u` again.

Increment a number: place cursor at the first digit and press `#`.

To redraw the screen press `^L`.

If you miss _Visual_ mode, try marks. For example, mark the line
by pressing `mm`, then move to the line you need, then delete from
the current to the marked line with `d'm`.

Break lines at column 72 in _Insert_ and _Append_ modes.

    :set wraplen=72

Format a paragraph with goal line length 72, allow indented paragraphs.

    :?^$?,//!fmt -pw 72

Sort lines in a paragraph (in _Command_ mode):

    !}sort

To remove trailing spaces:

    :%s/[[:space:]]\{1,\}/


To edit command-history:

    :set cedit=\<TAB>

Where `<TAB>` is the actual tab character: press `^V`, then `<TAB>`.

To read help:

    :help

If you need Unicode, use [nvi2](https://github.com/lichray/nvi2):

<pre>
# <b>pkg_add nvi</b>
...
nvi-2.1.3p1-iconv: ok
#
</pre>

## See also

[.exrc](/openbsd/exrc),
[`.profile`](/openbsd/profile),
[.tmux.conf](/openbsd/tmux.conf),
[vi command help guide](http://www.jeffw.com/vi/vi_help.txt) by Jeff W.
