# Enable full disk encryption on OpenBSD

If you store sensitive data on your computer (e.g. passwords, keys,
private files) you better enable full disk encryption.

First of all you need to generate [a secure passphrase](/diceware.html),
then boot OpenBSD installer and select `(S)hell`.

Note: Substitute `sd0` with the identifier of the target drive. All data
on `sd0` will be erased! Also check an identifier of the new crypto volume.
In my example it's `sd3`.

    #!/bin/sh
    set -e
    drive='/dev/rsd0c'
    echo "DANGER! All data on $drive will be erased. Press CTRL-C to cancel."
    read -r
    dd if=/dev/urandom of="$drive" bs=1m count=1 status=none
    fdisk -iy sd0 >/dev/null
    disklabel -E sd0 >/dev/null << EOF
    z
    a a
    1024
    *
    RAID
    w
    q
    EOF
    bioctl -c C -l sd0a softraid0
    cd /dev && sh MAKEDEV sd3
    dd if=/dev/zero of=/dev/rsd3c bs=1m count=1 status=none
    echo 'Done! Please exit this shell to return to the main installer.'

Optionally, you can automate few steps. Here is how I do it. Frist, enable
your internet connection:

    # ifconfig re0 up
    # dhclient re0

Then download and execute [the script](/openbsd/fde.sh):

Be very careful, **at this step you may lose all your data**.

    # ftp https://www.romanzolotarev.com/openbsd/fde.sh
    # chmod +x
    # fde.sh
    # exit

## Return to the main installer

When the installer asks _which disk is the root disk_, specify `sd3`.

## Post-install

When you booted OpenBSD from that crypto volume you can change the
passphrase with this command:

    doas bioctl -P sd3

_Tested on OpenBSD 6.3._

## See also

[OpenBSD FAQ - Disk Setup](https://www.openbsd.org/faq/faq14.html)
