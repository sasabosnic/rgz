# Mount drives on OpenBSD

Only `root` can mount file systems, a regular user may use
[doas(1)](http://man.openbsd.com/doas).

Plug in your USB drive and check system messages:

    # dmesg
    sd1 at scsibus2 targ 1 lun 0: <Vendor, Model, 1.26>
    SCSI3 0/direct removable serial.12345678901234568789
    sd1: 7633MB, 512 bytes/sector, 15633408 sectors

Check partitions:

    # disklabel sd1
    ...
                     size           offset  fstype [fsize bsize   cpg]
      a:           736256             1024  4.2BSD   2048 16384 16142
      c:         15633408                0  unused
      i:              960               64   MSDOS

Let's say you want to mount the first partition (`a:`), then your drive is `/dev/sd1a`.
Create the mount point and mount the drive:

    # mkdir -p /mnt/openbsd-installer
    # mount /dev/sd1a /mnt/openbsd-installer
    # ls /mnt/openbsd-installer

## See also

[mount(8)](https://man.openbsd.org/mount)
