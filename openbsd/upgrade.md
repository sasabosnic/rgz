# Upgrade OpenBSD

[Read the official FAQ first](https://www.openbsd.org/faq/upgrade63.html).
Backup all your data first, then verify your backups. Download the install
image and verify its checksum:

    # PKG_PATH='http://fastly.cdn.openbsd.org/pub/OpenBSD'
    # ftp $PKG_PATH/6.3/amd64/install63.fs
    # ftp $PKG_PATH/6.3/amd64/SHA256.sig
    # sha256 -C SHA256.sig install63.fs
    (SHA256) install63.fs: OK

Plug in and check your USB flash drive:

    # dmesg | grep removable | tail -n1
    sd3 at scsibus5 targ 1 lun 0: <Vendor, Model, 1.11>
    SCSI3 0/direct removable serial.12345678901234567890987654

In my case it appears as `sd3`. Now you can copy the installer image to
the USB flash drive. **Be extremely cautious**:

    # dd if=install63.fs of=/dev/rsd3c bs=1m

Boot from that USB drive, then choose the `(S)hell` option to mount your
[encrypted disk](/openbsd/fde.html).

    # bioctl -c C -l /dev/sd0c softraid0
    passphrase:
    scsibus1 at softraid0: 1 targets
    sd2 at scsibus2 targ 0 lun 0: <OPENBSD, SR RAID 1, 005>
    SCSI2 0/direct fixed
    sd2: 10244MB, 512 bytes/sec, 20980362 sec total
    # exit

Choose the `(U)pgrade` option and follow the prompts.
