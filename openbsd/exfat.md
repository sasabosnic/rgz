_Tested on [OpenBSD](/openbsd/) 6.4 with exfat-fuse 1.2.8_

# Mount exFAT file system on OpenBSD

First, find your `uid`:

<pre>
$ <b>id -u</b>
1000
$
</pre>

Then as _root_ install _exfat-fuse_ and mount exFAT file system with your `uid`:

<pre>
# <b>pkg_add exfat-fuse</b>
quirks-3.16 signed on 2018-10-12T15:26:25Z
exfat-fuse-1.2.8: ok
# <b>mkdir -p <i>/mnt/sd1i</i></b>
# <b>mount.exfat -o <i>uid=1000</i> <i>/dev/sd1i /mnt/sd1i</i></b>
FUSE exfat 1.2.8
#
</pre>

Use the file system as a regular user:

<pre>
$ <b>df /mnt/sd1i</b>
Filesystem  512-blocks      Used     Avail Capacity  Mounted on
fusefs         7716800      1344   7710336     0%    /mnt/sd1i
$ <b>touch /mnt/sd1i/test</b>
$ <b>ls -l /mnt/sd1i/test</b>
-rwxrwxrwx  1 romanzolotarev  wheel  0 Nov  5 16:11 /mnt/sd1i/test
$
</pre>

To unmount run as _root_:

<pre>
# <b>umount /mnt/sd1i</b>
#
</pre>
