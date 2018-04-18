"Oh god. The first paragraph is so spot on it's almost spooky. I've always dreamed of being able to boot into the terminal then open web browser just when I needed."
<div class="quote"><a href="https://m.twitter.com/jesusgollonet/status/930376114110951424">
<img src="/avatars/jesusgollonet.jpeg" class="quote__avatar" title="14 November 2017" alt="jes&uacute;s gollonet (@jesusgollonet)"></a>
<span class="quote__name">jes&uacute;s gollonet (@jesusgollonet)</span></div>

Few minutes later...

"Convinced. I'm trying <a href="https://m.twitter.com/hashtag/OpenBSD">#OpenBSD</a> as soon as I have time."
<div class="quote"><a href="https://m.twitter.com/jesusgollonet/status/930381616173764608">
<img src="/avatars/jesusgollonet.jpeg" class="quote__avatar" title="14 November 2017" alt="jes&uacute;s gollonet (@jesusgollonet)"></a>
<span class="quote__name">jes&uacute;s gollonet (@jesusgollonet)</span></div>

"I've said it before, but <a href="https://m.twitter.com/mwlauthor">@mwlauthor</a> and <a href="https://m.twitter.com/romanzolotarev">@romanzolotarev</a> are the reasons I use OpenBSD"
<div class="quote"><a href="https://m.twitter.com/hir0pr0tagonist/status/986292987566149632">
<img src="/avatars/hir0pr0tagonist.jpeg" class="quote__avatar" title="17 April 2018" alt="Tom A (@hir0pr0tagonist)"></a>
<span class="quote__name">Tom A (@hir0pr0tagonist)</span></div>

# Why OpenBSD?

[OpenBSD](https://www.openbsd.org) shines on servers, but if you do just
basic things on your desktop computer, then you'd love OpenBSD. In my case
switching from macOS was easy decision: _I use my computer as an
internet-enabled typewriter_. All I need for my work is a web browser,
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

**[Install OpenBSD](/openbsd/try.html)**

---

If you never tried BSD, don't be afraid. [We are here to
help](https://mobile.twitter.com/romanzolotarev/lists/bsd/members).
<br>Have questions? [Ping me on Twitter](https://m.twitter.com/romanzolotarev).
