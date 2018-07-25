If your computer **works with OpenBSD out-of-the-box**,<br>
submit your dmesg to [_NYC_*BUG](http://dmesgd.nycbug.org/index.cgi?do=submit) and
[tweet the link at me](https://mobile.twitter.com/romanzolotarev).<br>
Don't forget to send dmesg to [developers](https://www.openbsd.org/faq/faq4.html#SendDmesg),<br>

_Tested on various [OpenBSD](/openbsd/) releases_

# OpenBSD compatible hardware

## [Lenovo ThinkPad X1 Carbon (5th Gen)](https://www.lenovo.com/us/en/laptops/thinkpad/thinkpad-x/ThinkPad-X1-Carbon-5th-Gen/p/22TP2TXX15G)

<img src="/hardware/lenovo-thinkpad-x1c5.png" style="width: 200px;">

<pre>
14" FHD/WQHD, 7th Gen Intel i5/i7, 1.13 kg

tested by  <a href="https://mobile.twitter.com/romanzolotarev/status/1019920973653569536">romanzolotarev</a>
           <a href="https://jcs.org/2017/09/01/thinkpad_x1c">jcs</a>

<b><s>fpr</s></b>        <a href="https://bsd.network/@kristapsdz/100391368292782019">patch for libfprint required</a>
<b>cam</b>        not tested
<b>wifi</b>       iwm(4) required
<b>lcd</b>        via xbacklight(1)

<b>&#x2744;</b>          fan is off most of a time (turns on, when CPU > 60&deg;C)
batt       9 hours, ok
kbr        keyboard backlight, mute, vol up/down, ok
tp         touchpad, trackpoint, ok
eth        em, ok
video      ok
hdmi       ok
headphones ok
mic        ok
speakers   ok
ZZZ        ok
zzz        ok
usb        ok
usb-c      ok
sd         ok
</pre>

## [ZOTAC CI527 Nano](https://www.zotac.com/us/product/mini_pcs/ci527-nano)

<pre>
<img src="/hardware/zotac-ci527nano.jpg" style="width: 200px;">

7th Gen Intel i3, passive cooling

tested by  <a href="https://mobile.twitter.com/romanzolotarev/status/909807608252551169">romanzolotarev</a>

<b><s>zzz</s></b>        doesn't resume from suspend
<b>video</b>      S3 resume doesn't work, the rest is ok
<b>dp</b>         DisplayPort not tested
<b>usb-c</b>      not tested

<b>wifi</b>       iwm(4) required

<b>&#x2744;</b>          43&deg;C, fanless
eth        re, em, ok
HDMI       ok
headphones ok
mic        ok
ZZZ        ok
usb        ok
sd         ok
mic        ok
</pre>

---

## FAQ

**What hardware is supported?**

OpenBSD runs on [a dozen of
platforms](https://www.openbsd.org/faq/faq1.html#Platforms), but
binary packages of popular programs are availble only for
[amd64](https://fastly.cdn.openbsd.org/pub/OpenBSD/snapshots/packages/amd64/)
and
[i386](https://fastly.cdn.openbsd.org/pub/OpenBSD/snapshots/packages/i386/).

**What platform to choose for Intel&reg; 64-bit processors?**

[OpenBSD amd64](https://www.openbsd.org/amd64.html). For example, it runs
on Core&trade; i3, i5, i7.

**What about 8th Generation Intel&reg; Core&trade; processors?**

[OpenBSD amd64](https://www.openbsd.org/amd64.html) works well, but
these computers are not well supported yet. For example, they have
an issue with suspend/resume.

**Any known issues?**

[Only few wireless chipsets](https://man.openbsd.org/?query=wireless&apropos=1) are supported.<br>
Bluetooth, NVIDIA&reg; video chipsets, and USB3 audio are not supported.

