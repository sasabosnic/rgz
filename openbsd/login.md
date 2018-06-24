# Configure minimalist login on OpenBSD

![login screen](/openbsd/login.jpeg)

---

Enable X Display Manager:

<pre>
# <b>rcctl enable xenodm</b>
#
</pre>

---

Edit `/etc/X11/xenodm/Xresources`:

	xlogin.Login.echoPasswd:       true
	xlogin.Login.fail:             fail
	xlogin.Login.greeting:
	xlogin.Login.namePrompt:       \040login
	xlogin.Login.passwdPrompt:     passwd

	xlogin.Login.height:           180
	xlogin.Login.width:            280
	xlogin.Login.y:                320
	xlogin.Login.frameWidth:       0
	xlogin.Login.innerFramesWidth: 0

	xlogin.Login.background:       black
	xlogin.Login.foreground:       #cccccc
	xlogin.Login.failColor:        white
	xlogin.Login.inpColor:         black
	xlogin.Login.promptColor:      #888888

	xlogin.Login.face:             fixed-13
	xlogin.Login.failFace:         fixed-13
	xlogin.Login.promptFace:       fixed-13

---

Edit `/etc/X11/xenodm/Xsetup_0`:

	#!/bin/sh
	xsetroot -solid black

---

Logout to check the login screen.

---

_Tested on OpenBSD 6.3._

## See also

[YubiKey for login and SSH](/openbsd/yubikey.html),
[xenodm(1)](http://man.openbsd.org/xenodm.1)
