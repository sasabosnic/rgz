_Tested on [OpenBSD](/openbsd/) 6.3._

# Find and remove whitespaces with grep(1) and sed(1)

TL;DR: Checkout my [fws](/bin/fws), [tws](/bin/tws), and
[.gitconfig](/openbsd/gitconfig).

---

Find lines with trailing spaces in all non-binary files (recursively
starting from the current directory).

<pre>
$ <b>grep -rIl '[[:space:]]$' .</b>
file-with-trailing-spaces.txt
$
</pre>

Find and remove those spaces.

<pre>
$ <b>grep -rIl '[[:space:]]$' . | xargs sed -i 's/[[:space:]]*$//'</b>
$
</pre>

## A slightly faster version

Exclude `*.git` directories and use all CPU cores.

<pre>
$ <b>find . \
	\( -type d -name '*.git' -prune \) -o \
	\( -type f -print0 \) |
xargs -0 \
	-P "$(sysctl -n hw.ncpu)" \
	-r 2>/dev/null grep -Il '[[:space:]]$'</b>
file-with-trailing-spaces.txt
$
</pre>

## Configure vi

Add to `.exrc`:

	map gt mm:%s/[[:space:]]*$//^M`m

Where `^M` is the actual CR character: press `^V`, then `<Enter>`.


## Configure git

Git can [detect whitespaces](https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_code_core_whitespace_code).

<pre>
$ <b>git config --global core.whitespace \
	trailing-space,-space-before-tab,indent-with-non-tab,cr-at-eol</b>
$
</pre>

Add `pre-commit` hook to `.git/hooks`:

	#!/bin/sh
	exec git diff-index --check --cached HEAD --

If there are whitespace errors, it prints the file names and fails.

---

**Thanks** to [Tim Chase](https://twitter.com/gumnos) for performance
hints.
