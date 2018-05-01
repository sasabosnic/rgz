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

    xlogin.Login.height:           180
    xlogin.Login.width:            280
    xlogin.Login.y:                440
    xlogin.Login.frameWidth:       0
    xlogin.Login.innerFramesWidth: 0

    xlogin.Login.background:       black
    xlogin.Login.foreground:       #cccccc
    xlogin.Login.failColor:        white
    xlogin.Login.inpColor:         black
    xlogin.Login.promptColor:      #888888

    xlogin.Login.face:             dejavu sans mono:size=12
    xlogin.Login.failFace:         dejavu sans mono:size=12
    xlogin.Login.promptFace:       dejavu sans mono:size=12

Then edit `/etc/X11/xenodm/Xsetup_0`

    #!/bin/sh
    xsetroot -solid black

Done!

    # reboot

_Tested on OpenBSD 6.3._

P.S. If you have YubiKey, [use it for login and SSH](/openbsd/yubikey.html).
