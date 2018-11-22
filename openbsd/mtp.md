_Tested on [OpenBSD](/openbsd/) 6.4 with simple-mtpfs 0.3.0_

# Mount file system via Media Transfer Protocol on OpenBSD


First, find your `uid` and `gid`:

<pre>
$ <b>id -u</b>
1000
$ <b>id -g</b>
1000
$
</pre>

Connect your phone, camera, or any other MTP compatible device to your computer.
Set the device to MTP mode.

For example, on Android 8.0 it's called **Transfer files**.

Then as _root_ install _simple-mtpfs_ and mount a file system via MTP with your `uid`:

<pre>
# <b>pkg_add simple-mtpfs</b>
quirks-3.16 signed on 2018-10-12T15:26:25Z
simple-mtpfs-0.3.0p0:libusb1-1.0.21p1: ok
simple-mtpfs-0.3.0p0:libmtp-1.1.15: ok
simple-mtpfs-0.3.0p0: ok
# <b>mkdir -p <em>/mnt/mtp</em></b>
# <b>simple-mtpfs --device 1 /mnt/mtp -o uid=1000 -o gid=1000 -o allow_other</b>
#
</pre>

Use the file system as a regular user:

<pre>
#
$ <b>df /mnt/mtp</b>
Filesystem  512-blocks      Used     Avail Capacity  Mounted on
fusefs       291042488  42956896 248085592    15%    /mnt/mtp
$ <b>touch /mnt/mtp/test</b>
$ <b>ls -l /mnt/mtp/test</b>
-rw-r--r--  1 romanzolotarev  romanzolotarev  0 Nov  5 16:29 /mnt/mnt/test
$
</pre>

To unmount run as _root_:

<pre>
# <b>umount /mnt/mtp</b>
#
</pre>
