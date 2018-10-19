_Tested on [OpenBSD](/openbsd/) 6.2, 6.3, and 6.4_

# Upgrade OpenBSD

[Read the official FAQ](https://www.openbsd.org/faq/upgrade64.html).

Backup your data.

Download OpenBSD installer and verify its checksum:

<pre>
# <b>PKG_PATH='http://fastly.cdn.openbsd.org/pub/OpenBSD'</b>
# <b>ftp -V $PKG_PATH/6.4/amd64/install64.fs</b>
# <b>ftp -V $PKG_PATH/6.4/amd64/SHA256.sig</b>
# <b>signify -C -p /etc/signify/openbsd-64-base.pub -x SHA256.sig install64.fs</b>
Signature Verified
install63.fs: OK
#
</pre>

Plug in a USB drive:

<pre>
# <b>dmesg | grep removable | tail -n1</b>
sd3 at scsibus5 targ 1 lun 0: &lt;Vendor, Model, 1.11&gt;
SCSI3 0/direct removable serial.12345678901234567890987654
</pre>

In this case it appears as _sd3_.

Copy the installer image to the USB flash drive.

**Be extremely cautious**:

<pre>
# <b>dd if=install64.fs of=/dev/rsd3c bs=1m</b>
...
#
</pre>

Boot from that USB drive, then choose the `(S)hell` option to mount
the encrypted drive.

<pre>
# <b>bioctl -c C -l /dev/sd0a softraid0</b>
passphrase:
<span class="blue">scsibus1 at softraid0: 1 targets
sd3 at scsibus2 targ 0 lun 0: &lt;OPENBSD, SR RAID 1, 005&gt;
SCSI2 0/direct fixed</span>
sd3: 10244MB, 512 bytes/sec, 20980362 sec total
# <b>exit</b>
</pre>

Choose the `(U)pgrade` option and follow the prompts similar to (install.html).

When OpenBSD upgrade is done, upgrade installed packages.

<pre>
# <b>pkg_add -uv</b>
...
#
</pre>
