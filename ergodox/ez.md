<style>
body { max-width: 500px; }
img { width: 100%; }
</style>

## 1) Who are you, and what do you do?

I make software for the web, started my career as a webmaster in
the nineties, then focused on frontend and now on backend. 

I run a [job board](https://bsdjobs.com) and make [tutorials for
BSD users](https://www.romanzolotarev.com). I'm fan of OpenBSD,
POSIX-shell, vi, and mechanical keyboards, of course.

![romanzolotarev](/romanzolotarev.jpeg)

## 2) What hardware do you use?

Since 2016 I've been a happy user of ErgoDox EZ. 

I bet you like when your computer is silent, thanks to passive
cooling, we can get rid of moving parts nowadays. If you don't care
about CPU/GPU performance or mobility too much, but you need a large
screen and a good keyboard, you may like this setup.  It's ergonomic
and relatively cheap.

Item                                      | Price, USD
:--                                       | --:
ErgoDox EZ V3, Cherry MX Brown, blank DCS | 325
Zotac CI527 NANO-BE                       | 371
16GB RAM Crucial DDR4-2133                | 127
250GB SSD Samsung 850 EVO                 | 104
Asus VZ249HE 23.8" IPS Full HD            | 129
Kensington Orbit Trackball                | 33
                                          | **1,107**

If you are a programmer, sysadmin, or author, probably all you need
is a keybroad. Yes, you still may need a trackball in rare cases,
for example, for selecting text in a web browser or selecting a
screen area to make a screenshot.

![setup](/setup.jpeg)

My current setup is good for web development, but few times a year
I use my old MacBooks mostly for printing and scaning documents,
for video editing, or audio recording.

## 3) And what software?

Almost everything you need for web development is in OpenBSD base.

I run **vi** (nvi 1.79) in **tmux** in **xterm**. **cwm** is my
favorite window manager. I use many programs from `/bin` and
`/usr/bin` and glue them with shell scripts.

For example, I wrote my own [password
manager](https://www.romanzolotarev.com/pass.html) and [static site
generator](https://www.romanzolotarev.com/ssg.html) in Bourne shell.

When I need more than OpenBSD base software, I install from ports:

- firefox, chromium, ffmpeg, youtube-dl, unclutter,
- git, entr, expect, shellcheck, lowdown, scrypt,
- cmus, mpv, sxiv, mupdf,
- ImageMagic, jpegoptim, optipng, xpaint, inkscape.

Firefox is my default web browser.

![cwm](/cwm.jpeg)

## 4) What's your keyboard setup like? Do you use a custom layout or custom keycaps?

ErgoDox EZ v3 with Cherry MX Brown switches, blank black keycaps
(and one red DSA keycap), tilt kit, and wrist rest.

![ergodox](/ergodox-ez.jpeg)

**Cherry MX Brown** are good for typing and not that loud as blue ones.

My typing accuracy is at its best with **DCS** keycaps. I tried DSA
for a month or so, but then returned to sculpted keycaps so my
fingers always know where they are.

I picked **blank keycaps**, because when I'm typing I look at my
screen, not my keyboard.

**Tilt kit and wrist rest** is absolute must have. Don't know how
other ErdoDox users survive without them.

On ErgoDox I use [Norman layout](https://normanlayout.info).
David&mdash;layout author&mdash; claims it's _46% less effort than
QWERTY_ and I tend to agree. I'm still fluent in QWERTY on regular
keyboards, to reach my full speed takes a couple of minutes.

Note for Vim/vi users: I don't remap any keys and **HJKL** works just
fine for me.

![norman](/typing-norman.png)

[Download my layout from ergodox-ez.com](https://configure.ergodox-ez.com/keyboard_layouts/ldzaea/edit)

Tips and hints:

- Vim key works this way: tap for `ESC` or hold to use it as `CTRL`.
- To activate N-rollover hold left and right `SHIFT`, then press `N`.
- To activate Mouse layer hold `TT1`.
- To toggle between layers press and release `TT1`.

## 5) What would be your dream setup?

My current setup is almost perfect for me, I'd like to make it more
portable, though.

A portable and durable internet-enabled typewriter: maybe an OpenBSD
powered tablet with a bit smaller ErgoDox. I'd use its small screen
when I travel and connect to my large screen at my home office.
