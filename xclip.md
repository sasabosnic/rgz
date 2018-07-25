_Tested on [OpenBSD](/openbsd/) 6.3_

# Use X11 clipboard with xclip(1)

Use [X11](https://man.openbsd.org/X.7) clipboard to copy paste text and
images between X11 programs.

Install [xclip(1)](https://github.com/astrand/xclip):

<pre>
# <b>pkg_add xclip</b>
...
xclip-0.13p0: ok
#
</pre>

Edit `~/.tmux.conf`:

```
...
bind -T copy-mode-vi 'y' send -X copy-pipe-and-cancel \
  'xclip -i -selection clipboard'

bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel \
  'xclip -i -selection clipboard'

bind -n MouseDown2Pane run \
  'tmux set-buffer "$(xclip -o -selection clipboard)";tmux paste-buffer'
...
```

Edit `~/.exrc`:

```
...
map gp :r!xclip -o -s clipboard^M
...
```

where `^M` is **CTRL+V** then **Enter**.
