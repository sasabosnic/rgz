# Try OpenBSD

Why OpenBSD as a desktop? I like how simple and reliable it is. This guide
is the shortest way to try OpenBSD. This may take just few minutes. Here
is the step-by-step instruction for macOS users.

## Backup everything

As you follow this guide you may accidentally erase your drives, so before
we continue, please **back up all your data**.

## Download the installer

    cd /tmp
    export URL=https://cloudflare.cdn.openbsd.org/pub/OpenBSD
    curl $URL/6.3/amd64/install63.fs
    curl $URL/6.3/amd64/SHA256

    grep install63.fs SHA256
    shasum -a 256 install63.fs

## Create install media

Plug your flash drive in. It should be at least 400 MB. Run `diskutil
list` to find an identifier of the flash drive. Usually it's `/dev/disk2`.

Substitute `/dev/diskX` with the identifier of the flash drive. **All data
on `/dev/diskX` will be erased!**

    $ sudo dd if=install62.fs of=/dev/diskX bs=1m

If you want to automate these steps, here is how I make [bootable OpenBSD
installer on macOS](/macos/openbsd.sh) and [on OpenBSD](/openbsd/install).

## Boot the installer

In this guide I don't [enable full disk encryption](/openbsd/fde.html),
but you definitely should use it for all your computers with sensitive
data.

Boot from that flash drive. If you can't boot OpenBSD try to enable
legacy-boot in your BIOS.

## Install OpenBSD base

Select `(I)nstall` and answer the questions. Some hints:

- Location of sets: `disk`
- Which disk contains the install media: `sd1`
- Continue without verification: `yes`

You can automate these steps too, here is [one of my configuration
examples for autoinstall](/openbsd/mercury-install.conf).

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

As you may expect, these steps are easy to automate as well, here is how
I [setup dotfiles and install all the packages I use](/openbsd/setup.sh).

## See also

[OpenBSD FAQ - Installation Guide](https://www.openbsd.org/faq/faq4.html)
