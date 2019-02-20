_Tested on [OpenBSD](/openbsd/) 6.3 and [ThinkPad X1C5](/openbsd/hardware.html)_

# Dock laptop with xrandr(1), xinput(1), xrdb(1), and sysctl(8)

TL;DR: Check out my [dock](/bin/dock) and [undock](/bin/undock).

## Screens

Toggle displays with [xrandr(1)](https://man.openbsd.org/xrandr.1).
For example, only laptop's display (`eDP-1`) is on, then an external
one (`HDMI-1`), then both side by side:

<pre>
$ <b>xrandr --output eDP-1 --auto --output HDMI-1 --off</b>
$ <b>xrandr --output HDMI-1 --auto --output eDP-1 --off</b>
$ <b>xrandr --output HDMI-1 --auto --output eDP-1 --auto --right-of HDMI-1</b>
$
</pre>

## Mouse, track point, and touchpad

List all connected devices with
[xinput(1)](https://man.openbsd.org/xinput.1):

<pre>
$ <b>xinput</b>
&#9121; Virtual core pointer                          id=2    [master pointer  (3)]
&#9116;   &#8627; Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
&#9116;   &#8627; <em>/dev/wsmouse0</em>                             id=7    [slave  pointer  (2)]
&#9116;   &#8627; <em>/dev/wsmouse</em>                              id=8    [slave  pointer  (2)]
&#9123; Virtual core keyboard                         id=3    [master keyboard (2)]
    &#8627; Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    &#8627; /dev/wskbd                                id=6    [slave  keyboard (3)]
$
</pre>

In this example, `/dev/wsmouse0` is a built-in touchpad and
`/dev/wsmouse` is an external mouse.  Reverse scrolling (swap `4`
and `5`, `6` and `7`)  for the touchpad and slow down the mouse.

<pre>
$ <b>xinput set-button-map /dev/wsmouse0 1 2 3 5 4 7 6</b>
$ <b>xinput set-prop /dev/wsmouse 'Device Accel Constant Deceleration' 5</b>
$
</pre>

For devices (e.g. trackballs) with _two buttons_: enable `Middle
Button Emulation` and then press two buttons at the same time to
emulate the middle button.

<pre>
$ <b>xinput set-prop /dev/wsmouse 'WS Pointer Middle Button Emulation' 1</b>
$
</pre>

For devices (e.g. mices) with _three or more buttons_: Enable `Wheel
Emulation`, then hold the middle button (`2`) and move the mouse
up and down to scroll. Adjust `Inertia` and `Timeout` if needed.

<pre>
$ <b>xinput set-prop /dev/wsmouse 'WS Pointer Wheel Emulation'         1</b>
$ <b>xinput set-prop /dev/wsmouse 'WS Pointer Wheel Emulation Button'  2</b>
$ <b>xinput set-prop /dev/wsmouse 'WS Pointer Wheel Emulation Inertia' 3</b>
$ <b>xinput set-prop /dev/wsmouse 'WS Pointer Wheel Emulation Timeout' 500</b>
$
</pre>

Install `unclutter`:

<pre>
# <b>pkg_add unclutter</b>
quirks-3.16 signed on 2018-10-12T15:26:25Z
unclutter-8p1: ok
#
</pre>

...then add this line to `~/.xsession` to hide X pointer when it has not moved for a
few seconds:

<pre>
<b>unclutter -root -idle 2 -noevents &</b>
</pre>

See also my [.xsession](xsession).

## Fonts

Toggle DPI for all X programs (including Firefox) and fonts for
[xterm(1)](https://man.openbsd.org/xterm.1).  On high DPI screens,
use large TrueType fonts:

	Xft.dpi: 133
	XTerm*font:
	XTerm*faceName: DejaVu Sans Mono:size=12

On low DPI screens, use bitmap ones:

	Xft.dpi: 92
	XTerm*font: -misc-fixed-medium-r-normal--15-140-75-75-c-90-iso10646-1
	XTerm*faceName:

To apply these settings use [xrdb(1)](https://man.openbsd.org/xrdb.1)
(don't forget to restart X programs after that):

<pre>
$ <b>xrdb .Xdefaults</b>
$ <b>echo 'Xft.dpi: 92' | xrdb -merge</b>
$
</pre>

Here is my [.Xdefaults](Xdefaults).

## Lid

Define an action on laptop's lid closing. Do nothing (`0`), suspend
(`1`), or hibernate (`2`):

<pre>
# <b>sysctl machdep.lidaction=0</b>
machdep.lidaction: 2 -> 0
# <b>sysctl machdep.lidaction=1</b>
machdep.lidaction: 0 -> 1
# <b>sysctl machdep.lidaction=2</b>
machdep.lidaction: 1 -> 2
#
</pre>
