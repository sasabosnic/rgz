> "It's a nice .cwmrc! I even modeled mine after it. Recommended.
5&nbsp;stars."<br>&mdash;
[(((Mischa &#x1F576; &#x1F421; RCX)))](https://twitter.com/mischapeters/status/987004963682430976 "19 Apr 2018")
(@mischapeters)

_Tested on [OpenBSD](/openbsd/) 6.3_

# Configure cwm(1)  

[cwm(1)](http://man.openbsd.org/cwm.1) is my favorite window manager
for X11. It has tiling mode, so I don't have to rearrange windows
manually. 

cwm(1) is in OpenBSD base.

<pre>
$ echo 'exec cwm' >> ~/.xsession
</pre> 

Here is my [.cwmrc](/openbsd/cwmrc). Quite often I keep just two
windows open. On the left side: [tmux](/tmux.html) in
[xterm(1)](http://man.openbsd.org/xterm.1). On the right side:
Firefox.

[![cwm](/cwm.jpeg)](/cwm.png)
