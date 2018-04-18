# Mount drives on OpenBSD

Only `root` can [mount(8)](http://man.openbsd.com/mount.8) file systems on
OpenBSD, a regular user should use
[doas(1)](http://man.openbsd.com/doas.1).

Plug in your USB drive and check system messages:

    # dmesg
    sd1 at scsibus2 targ 1 lun 0: <Vendor, Model, 1.26>
    SCSI3 0/direct removable serial.12345678901234568789
    sd1: 7633MB, 512 bytes/sector, 15633408 sectors

Check partitions:

    # disklabel sd1
    ...
              size     offset  fstype [fsize bsize   cpg]
      a:    736256       1024  4.2BSD   2048 16384 16142
      c:  15633408          0  unused
      i:       960         64   MSDOS

Let's say you want to mount the first partition (`a:`), then the device
you're looking for is `/dev/sd1a`. Create the mount point directory, say
`/mnt/usb-drive`, and mount the drive:

    # mkdir -p /mnt/usb-drive
    # mount /dev/sd1a /mnt/usb-drive
    # ls /mnt/usb-drive
    ...

Hooray! Now it's mounted.

Before disconnecting the drive from the USB port, make sure it's
unmounted, to that you'll need to leave mount point directory and then
use it as an argument for [unmount(8)](https://man.openbsd.org/umount.8).

    # cd
    # umount /mnt/usb-drive
    #

Or you can address your device directly:

    # cd
    # umount /dev/sd1a
    #

That's it.

If you'd like to automate these steps, check `mnt()` and `umnt()`
functions from my [~/.profile](/openbsd/profile).
