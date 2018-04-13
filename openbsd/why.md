# Why OpenBSD?

Looking for a minimalist operating system? If you are software developer
or system administrator, you should try OpenBSD.

[OpenBSD](https://www.openbsd.org) shines on servers, but if you do just
basic things on your desktop computer, then you'd love OpenBSD. In my case
switching from macOS to OpenBSD was easy decision: I use my computer as an
internet-enabled typewriter. All I need for my work is a web browser,
terminal, and Vim.

## Known issues

OpenBSD works perfectly on mainstream hardware, but it doesn't support
all the hardware. Bluetooth is not supported, at all; [only few wireless
chipsets](https://man.openbsd.org/?query=wireless&apropos=1) are
supported; 3D acceleration is supported for limited number of video cards;
USB3 audio is not here yet; etc.

The most popular open source software is ported to OpenBSD, but some of
the ports and packages can be outdated.

## Secure, correct, reliable

OpenBSD is a relatively small system, the dead code is actively removed to
reduce maintenance costs, improve quality, and minimize attack surface.

Everything I need is in the base: POSIX shell, X11, vi, tmux, httpd,
smptd. There are only things I need, almost nothing else. The base is well
documented, actively maintained, well integrated, nothing breaks
unexpectedly.

Files are neatly organized. They are always where you expect them to be.
Configuration files are clean. Defaults are sane, there is almost nothing
to customize.

Easy to upgrade. If you don't use exotic software or hardware, upgrade
takes just few minutes (spent mostly on reading release notes).

[If it installs](/openbsd/try.html), it works.
