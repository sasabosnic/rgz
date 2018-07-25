_Tested on [macOS](/macos/) 10.13_

# Edit text with Vim

Vim has everything you may need for text editing out-of-the-box:
syntax highlighting, autocompletion, split screen, diff, spell
checking, text formatting, text objects, persistent undo, automatic
commands, macros, scripting, and many more.

Most of Vim features are kind of hidden and it makes sense, nothing
stands on your way when you are working. Although, such minimalism
makes learning curve a bit steeper.

On the other hand, everything in Vim is thoroughly documented and
the documentation is always available via `:help` command.

## Vim is keyboard-based

Usual Vim command is a sequence of keystrokes. You rarely use key
chords in Vim and you don't need a mouse.

You can effortlessly make large edits [with few
keystrokes](https://www.vimgolf.com), because Vim has commands,
movements, and can operate text objects: paragraphs, sentences,
words, etc.  Everything is mnemonic. For example, you can type `dap`
in normal mode to _"delete a paragraph"_, and `ciw` to _"change in
word"_, and so on.

## Vim is extensible

Vim can do a lot without any customization or plugins, but you can
tailor Vim for your needs. There are tons of plugins for Vim (you
may need just few), you can install and update them with ease.

Vim is well integrated with command line tools (`grep`, `git`,
`head`, `tail`, `tee`, `find`, `cp`, `mv`, `rm`, `cut`, `uniq`,
`sort`, etc). With pipes and redirects you can compose programs to
do any text manipulations you may need.

## Vim is fast

Vim doesn't need a lot of resources [to perform
well](https://github.com/jhallen/joes-sandbox/tree/master/editor-perf).
Its startup time is **under six milliseconds**:

<pre>
$ <b>vim -u NONE --startuptime vim.log +q</b>
$ <b>tail -n 1 vim.log | cut -f1 -d' '</b>
005.287
$
</pre>

To be fair, to start Vim with a dozen of plugins and to open a file
takes about 60 ms. Still impressive.

Vim almost never lags and typing latency is very low.
[Typometer](https://github.com/pavelfatin/typometer) shows 4.8 ms
for Vim in Terminal.app on macOS.

Even when you are editing files on a remote machine over SSH and
the internet connection is slow, you still are in control, because
in Vim you can do a lot with a single command: quick jumps inside
a large file, switching among multiple files, searching and replacing
across all files in a project, etc.

Yes, Vim works perfectly in a terminal over SSH. You can edit files
remotely and be as productive as on your computer.

## Vim is future-proof

Vim (or its predecessor vi) is pre-installed on all Unix-like
machines (macOS, BSD, Linux). Vim has been ported to almost all
operating systems, including Windows.

Vim is a free and open-source software. It's a time-tested software:
vi released in 1976, Vim &mdash; in 1991. Vim will stay around for
a long time.  Once you learned Vim you may use it for decades. You
workflow may change, programming languages come and go, but Vim
always does its job well.

Still undecided? Try Vim for a few days.
