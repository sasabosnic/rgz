# Configure YubiKey for login and SSH on OpenBSD

Make sure [OpenBSD is installed on your computer](/openbsd/install.html),
you're `root`, and you have at least one
[YubiKey](https://www.yubico.com/store/). First of all, install and start
**YubiKey Personalization Tool**:

    # pkg_add yubikey-personalization-gui
    # yubikey-personalization-gui

Insert your YubiKey into USB port. Click **Yubico OTP**, then **Quick**.
Select **Configuration Slot 1** or **2**. Click **Write Configuration**.
Important: save the log into `/tmp/log`. Click **Exit**.

Extract _uid_ and _key_ from the log, verify `/var/db/yubikey/*` files, and
remove the log.

    # cd /var/db/yubikey
    # grep Yubico /tmp/log | cut -f5 -d,>$(whoami).uid
    # grep Yubico /tmp/log | cut -f6 -d,>$(whoami).key
    # chown root:auth $(whoami).*
    # chmod 440 $(whoami).*
    # cat $(whoami).*
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxx
    # rm /tmp/log
    # rm $(whoami).ctr # reset the counter, if present

Change `auth-defaults` in `/etc/login.conf`:

    auth-defaults:auth=yubikey,passwd:

Update `/etc/ssh/sshd_config`:

    PermitRootLogin yes
    AuthenticationMethods publickey,password
    PasswordAuthentication yes

Restart `sshd`, verify, and `reboot`:

    # rcctl restart sshd
    # ssh root@localhost
    root@localhost's password:
    Last login: Fri Mar 30 12:36:23 2018
    OpenBSD 6.2 (GENERIC.MP) #7: Sat Mar 17 21:38:36 CET 2018

    Welcome to OpenBSD: The proactively secure Unix-like operating system.

    Please use the sendbug(1) utility to report bugs in the system.
    Before reporting a bug, please try to reproduce it with the latest
    version of the code. With bug reports, please try to ensure that
    enough information to reproduce the problem is enclosed, and if a
    known fix for it exists, include that as well.

    # exit
    # reboot

## See also

[login.conf(5)](http://man.openbsd.com/login.conf.5),
[login_yubikey(8)](http://man.openbsd.com/login_yubikey.8),
[YubiKey Personalization GUI](https://github.com/Yubico/yubikey-personalization-gui)
