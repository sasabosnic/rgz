> TIL #OpenBSD nvi can do split window... Thanks
@romanzolotarev!"<br>&mdash;
[ParadeGrotesque](https://mobile.twitter.com/ParadeGrotesque/status/1002454625272901632 "1 Jun 2018")
(@ParadeGrotesque)

---

# Upgrade from Vim to vi(1)

Before [switching to OpenBSD](/setup.html), I used [Vim](/vim.html)
as the default text editor and used [vi(1)](https://man.openbsd.org/vi.1)
on servers. Recently I decided to switch to vi(1) full time.

On OpenBSD vi(1) is actually
[nvi](https://sites.google.com/a/bostic.com/keithbostic/vi)
based on version 1.79, written by Keith Bostic.

## Why did I switch to nvi?

- nvi is lighter and faster than Vim,
- nvi is in OpenBSD base,
- almost all of the missing Vim features I care about are replaced with
  POSIX utilities,
- nvi makes me learn OpenBSD and POSIX tools.

## What is missing?

For several Vim features, I couldn't find any workarounds and really miss
them:

Insert-mode completion, text objects, viminfo (save command history,
marks, registers), search for words under the cursor.

For some features, I managed to find workarounds.

For example, for rare cases when I need Unicode, I use
[nvi2](https://github.com/lichray/nvi2):

    # pkg_add nvi

Instead of syntax highlighting, I use cleaner formatting and linters,
but I understand that this may not work for ~~hipsters~~ some
software developers.

I've replaced some features with utilities and shell scripts:

Vim feature                  | nvi workaround
:--                          | :--
sort                         | `/usr/bin/sort`
spell checking               | `/usr/bin/spell`
diff mode                    | `/usr/bin/diff`
text formatting (`gqap`)     | `/usr/bin/fmt`
extended search patterns     | `/usr/bin/sed -E`
vimgrep                      | `/usr/bin/grep`
plugins                      | `/bin/sh`
automatic commands           | `/bin/sh`
scripts and expressions      | `/bin/sh`

## nvi tricks

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

_Tested on OpenBSD 6.3_

## See also

[.exrc](/openbsd/exrc),
[`.profile`](/openbsd/profile),
[.tmux.conf](/openbsd/tmux.conf),
[vi command help guide](http://www.jeffw.com/vi/vi_help.txt) by Jeff W.
