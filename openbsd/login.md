# Configure minimalist login on OpenBSD

![login screen](/openbsd/login.jpeg)

First of all, enable [xenodm(1)](http://man.openbsd.org/xenodm.1):

    # rcctl enable xenodm

As `root` edit `/etc/X11/xenodm/Xresources`:

    xlogin.Login.echoPasswd:       true
    xlogin.Login.fail:             fail
    xlogin.Login.greeting:
    xlogin.Login.namePrompt:       \040login
    xlogin.Login.passwdPrompt:     passwd

    xlogin.Login.logoFileName:     /etc/X11/xenodm/pixmaps/OpenBSD_1bpp.xpm
    xlogin.Login.height:           180
    xlogin.Login.width:            500
    xlogin.Login.y:                440
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

Then edit `/etc/X11/xenodm/Xsetup_0`

    #!/bin/sh
    xsetroot -solid black

Done!

    # reboot

_Tested on OpenBSD 6.3._

P.S. If you have YubiKey, [use it for login and SSH](/openbsd/yubikey.html).
