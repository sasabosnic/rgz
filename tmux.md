# Multiplex your terminals with tmux(1)

[tmux(1)](https://man.openbsd.org/tmux.1) is a terminal multiplexor and
is one of the most important tools I use every day.

I keep one active tmux session at a time and use one window per task.
Inside each window I can open as many panes as I need.

    $ tmux

Frankly, I rarely start tmux(1) like that, instead I use this shell
function to start tmux(1):

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

`start_tmux` requires three arguments:

- window name
- working directory
- initial command

So I've created shortcuts:

    www() { start_tmux 'www' "$HOME/src/www"   'vi index.md'; }
    m()   { start_tmux 'm'   "$HOME/pub/music" 'cmus'; }

And now I can run `www` or `m` from anywhere:

    $ www

It tries to create a new session (`0`),
if the session already exists and  the window (`www`) is selected,
change to its working directory (`$HOME/src/www`), otherwise
create that window (`www`) and run the initial command (`vi index.md`),

## tmux tricks

Enable mouse to select text in tmux(1), to select windows, and to resize panes.

    set -g mouse on

Add date and time to tmux status bar.

    set -g status-interval 1
    set -g status-right '#{?client_prefix, PREFIX ,#(date)}'

Bind keys to resize and switch panes:

    bind H resize-pane -L 20
    bind J resize-pane -D 20
    bind K resize-pane -U 20
    bind L resize-pane -R 20
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

Bind keys to copy into X clipboard:

    bind -T copy-mode-vi 'y' \
      send -X copy-pipe-and-cancel \
      'xclip -i -selection clipboard'

Bind mouse drag to copy into X clipboard:

    bind -T copy-mode-vi MouseDragEnd1Pane \
      send -X copy-pipe-and-cancel \
      'xclip -i -selection clipboard'

_Tested on OpenBSD 6.3._

## See also

[tmux wiki](https://github.com/tmux/tmux/wiki),
[`.profile`](/openbsd/profile),
[`status`](/openbsd/status),
[`.tmux.conf`](/openbsd/tmux.conf)
