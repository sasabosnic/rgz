# Install OpenBSD on your desktop

Why OpenBSD as a desktop? I like how simple and reliable it is. This guide
is the shortest way to try OpenBSD on your hardware. This may take just
few minutes. [Read the official FAQ
first](https://www.openbsd.org/faq/faq4.html).

Prepare a bootable USB drive. By the way, here is [the step-by-step
instruction for macOS](/macos/openbsd.html).

Backup everything. As you follow this guide you may accidentally erase
your drives, so before we continue, please **back up all your data** and
verify your backups.

## Boot the installer

[Enable full disk encryption](/openbsd/fde.html), if you want to.

Boot from that USB drive. If you can't boot OpenBSD try to enable
legacy-boot in your BIOS.

## Install OpenBSD base

Select `(I)nstall` and answer the questions. Some hints:

- Location of sets: `disk`
- Which disk contains the install media: `sd1`
- Continue without verification: `yes`

If everything is okay:

    $ reboot

...and unplug the flash drive.

## After the first boot

Boot OpenBSD from your drive, login as root, and run:

Set URL to download packages and updates

    echo 'https://cloudflare.cdn.openbsd.org/pub/OpenBSD'\
    > /etc/installurl

Allow the user to run commands as root

```
echo 'permit nopass romanzolotarev'\
> /etc/doas.conf
```

Done. Reboot and login as a regular user.

## Post-install

Install a tilling window manager and Firefox.

    doas pkg_add firefox

Make `cwm` your default window manager and start X11.

    echo 'cwm' >> ~/.xinitrc
    startx

As you may expect, these steps are easy to automate as well. [Check my
post-install script](/openbsd/setup.sh).
