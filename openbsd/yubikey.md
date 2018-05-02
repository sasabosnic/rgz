# Configure YubiKey for login and SSH on OpenBSD

Make sure [OpenBSD is installed on your computer](/openbsd/install.html),
you're `root`, and you have at least one
[YubiKey](https://www.yubico.com/store/). First of all, install and start
**YubiKey Personalization Tool**:

    # pkg_add yubikey-personalization-gui
    quirks-2.414 signed on 2018-03-28T14:24:37Z
    yubikey-personalization-gui-3.1.25: ok
    # yubikey-personalization-gui

Insert your YubiKey into USB port. Click **Yubico OTP**, then **Quick**.
Select **Configuration Slot 1** or **2**. Click **Write Configuration**.
Important: save the log into `/tmp/yubikey.csv`. Click **Exit**.

As `root` extract _uid_ and _key_ from the log, verify `/var/db/yubikey/*`
files, and remove `yubikey.csv` file.

    # cd /var/db/yubikey
    # grep Yubico /tmp/yubikey.csv | cut -f5 -d,>root.uid
    # grep Yubico /tmp/yubikey.csv | cut -f6 -d,>root.key
    # chown root:auth root.*
    # chmod 440 root.*
    # cat root.*
    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxx
    # rm /tmp/yubikey.csv

If `/var/db/yubikey/root.ctr` is present, remove it to reset the counter.

    # rm root.ctr

If you have one more YubiKey, then repeat these steps, but replace
`root.uid` with `USERNAME.uid` and `root.key` with `USERNAME.uid`, where
`USERNAME` is a name of your user.

Or, if you have only one YubiKey, then just copy those two files.

    # cp root.uid USERNAME.uid
    # cp root.key USERNAME.key

The result in my case looks like this:

    # ls -l /var/db/yubikey/*
    -r--r-----  1 root  auth  33 May  1 15:22 romanzolotarev.key
    -r--r-----  1 root  auth  13 May  1 15:22 romanzolotarev.uid
    -r--r-----  1 root  auth  33 May  1 14:59 root.key
    -r--r-----  1 root  auth  13 May  1 14:59 root.uid

We are about to change two config files, let's back up them first.

    # cp /etc/login.conf /etc/login.conf.bak
    # cp /etc/ssh/sshd_config /etc/ssh/ssh_config.bak

In case something goes wrong you'll be able to [boot in a single user
mode](https://www.openbsd.org/faq/faq8.html), revert changes, reboot and
login with a regular password as usual.

Now we can change `auth-defaults` in `/etc/login.conf`:

    auth-defaults:auth=yubikey,passwd:

And update `/etc/ssh/sshd_config`:

    PermitRootLogin yes
    AuthenticationMethods publickey,password
    PasswordAuthentication yes

Restart `sshd`, then verify: when ssh asks for a password---instead of
entering your regular password---touch YubiKey, if you have used
slot&nbsp;1 (or touch and hold it for 2-3 seconds for slot&nbsp;2)...

    # rcctl restart sshd
    # ssh root@localhost
    root@localhost's password:
    Last login: Wed May  2 17:11:06 2018 OpenBSD 6.3
    (GENERIC.MP) #1: Sat Apr 21 14:26:25 CEST 2018

    Welcome to OpenBSD: The proactively secure Unix-like
    operating system.

    Please use the sendbug(1) utility to report bugs in the
    system. Before reporting a bug, please try to reproduce it
    with the latest version of the code. With bug reports,
    please try to ensure that enough information to reproduce
    the problem is enclosed, and if a known fix for it exists,
    include that as well.


...then exit and reboot:

    # exit
    # reboot

_Tested on OpenBSD 6.3._

P.S. Also [tweak your login screen](/openbsd/login.html) if you wish.

## See also

[login.conf(5)](http://man.openbsd.com/login.conf.5),
[login_yubikey(8)](http://man.openbsd.com/login_yubikey.8),
[YubiKey Personalization GUI](https://github.com/Yubico/yubikey-personalization-gui)
