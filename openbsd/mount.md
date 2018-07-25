_Tested on [OpenBSD](/openbsd/) 6.3._

# mount(1) on OpenBSD

Only _root_ can [mount(8)](http://man.openbsd.com/mount.8) file
systems on OpenBSD, a regular user should run mount(8) via
[doas(1)](http://man.openbsd.com/doas.1).

Plug in a USB drive and check system messages:

<pre>
# <b>dmesg</b>
sd1 at scsibus2 targ 1 lun 0: <Vendor, Model, 1.26>
SCSI3 0/direct removable serial.12345678901234568789
sd1: 7633MB, 512 bytes/sector, 15633408 sectors
#
</pre>

Check partitions:

<pre>
# <b>disklabel sd1</b>
...
      size     offset  fstype [fsize bsize   cpg]
a:    736256       1024  4.2BSD   2048 16384 16142
c:  15633408          0  unused
i:       960         64   MSDOS
#
</pre>

To mount a partition, for example, _a:_), use _/dev/sd1a_ device.

Create a mount point directory, for example, _/mnt/usb-drive_, and
mount the drive:

<pre>
# <b>mkdir -p /mnt/usb-drive</b>
# <b>mount /dev/sd1a /mnt/usb-drive</b>
# <b>ls /mnt/usb-drive</b>
...
#
</pre>

It's mounted.

Before disconnecting the drive from the USB port, unmount it. Leave
mount point directory and then use it as an argument for
[unmount(8)](https://man.openbsd.org/umount.8).

<pre>
# <b>cd</b>
# <b>umount /mnt/usb-drive</b>
#
</pre>

Or you can address your device directly:

<pre>
# <b>umount /dev/sd1a</b>
#
</pre>
