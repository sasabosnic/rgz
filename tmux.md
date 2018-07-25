_Tested on [OpenBSD](/openbsd/) 6.3_

# Manage terminals with tmux(1)

[tmux(1)](https://man.openbsd.org/tmux.1) is a terminal multiplexor.

## Session

To create and attach to a new session run:

<pre>
$ <b>tmux</b>
</pre>

You've got a green status bar at the bottom of the window. That
means now you're attached to a tmux session with name `0` (in the
left bottom corner `[0]`) in the first and only window open number
`0` and name `ksh` (`0:ksh*`).

To detach from tmux session press `C-b d` (`Ctrl-b` and then `d`)
or you can just kill your terminal window. `C-b` is the default
`PREFIX` key in tmux(1). The session stays intact.

To attach to existing session instead of `tmux` run:

<pre>
$ <b>tmux new -A -s 0</b>
</pre>

tmux(1) tries to attach (`-A`) to the existing session (`-s 0`) and if
fails then it creates a new session.

## Windows

To create a new window press `PREFIX c`. You've got
another window created and selected (`1:ksh*`).

To select window `0` press `PREFIX 0`, to select `1` press `PREFIX 1`.

To close a window close program its running (to exit shell press `C-d`)
or you can kill the window with `PREFIX d`. By default name of a window
changes to its active program (for example, `ksh`).

To rename a window press `PREFIX ,` then edit its name and hit `Enter`.
Once a window is renamed its name will persist for the session.

## Panes

With tmux(1) you can split a window into panes. `PREFIX "` to split
horizontally and `PREFIX %' to split the window vertically.

To select another pane use `PREFIX arrow`, where `arrow` is `up`,
`down`, `left`, or `right`.

To resize panes use `PREFIX c-arrow`.

Press `PREFIX` just once, then press `arrow` as many times as you need
to select (or `c-arrow` to resize).  But key press intervals should be
under 500 ms (see `repeat-time` option), otherwise you need to press
`PREFIX` again.


Action                | Keys
:--                   | :--
Open a window         | `PREFIX c`
Select windows 0 to 9 | `PREFIX 0` ... `PREFIX 9`
Rename the window     | `PREFIX ,`
Kill the window       | `PREFIX x`
Veritical split       | `PREFIX %`
Horizontal            | `PREFIX "`
Select a pane         | `PREFIX up`
                      | `PREFIX down`
                      | `PREFIX left`
                      | `PREFIX right`
Resize the pane       | `PREFIX c-up`
                      | `PREFIX c-down`
                      | `PREFIX c-left`
                      | `PREFIX c-right`

## Workflow

Keep one session at a time and use one window per task. Inside each
window open multiple panes.

To start tmux(1) use this shell function:

```
start_tmux() {
  if ! tmux new-session \
    -As 0 -n "$1" "cd $2 && $3" 2>/dev/null;then
    if tmux select-window -t "$1" 2>/dev/null;then
      if tmux list-windows|
        grep ": ${1}\\*">/dev/null;then
        cd "$2"||return
      fi
    else
      if tmux show-window-option \
        automatic-rename|grep off>/dev/null;then
        tmux new-window -n "$1" -c "$2" sh -c "$3"
      else
        tmux rename-window "$1" && cd "$2" && sh -c "$3"
      fi
    fi
  fi
}
```

`start_tmux()` requires three arguments: a window name, its working
directory, and initial command.

Here is a shortcut:

```
www() { start_tmux 'www' "$HOME/src/www" 'vi index.md'; }
```

Run `www` from anywhere:

<pre>
$ <b>www</b>
</pre>

It tries to create a new session (`0`),
if the session already exists and  the window (`www`) is selected,
it changes to the working directory (`$HOME/src/www`), otherwise
it creates that window (`www`) and runs the initial command (`vi index.md`),

## See also

[.tmux.conf](/openbsd/tmux.conf),
[.profile](/openbsd/profile),
[status](/bin/status),
[tmux wiki](https://github.com/tmux/tmux/wiki).
