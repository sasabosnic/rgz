_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4_

# Configure cwm(1)

[cwm(1)](http://man.openbsd.org/cwm.1) is my favorite window manager
for X11. It has a tiling mode, so I don't have to rearrange windows
manually.

cwm(1) is in OpenBSD base.

<pre>
$ echo 'exec cwm' >> ~/.xsession
</pre>

Here is my [.cwmrc](/openbsd/cwmrc). Quite often I keep just two
windows open. On the left side: [tmux](/tmux.html) in
[xterm(1)](http://man.openbsd.org/xterm.1). On the right side:
Firefox.

[![desktop](desktop.jpeg)](desktop.png)
