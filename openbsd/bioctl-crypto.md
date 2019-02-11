_Tested on [OpenBSD](/openbsd/) 6.3_

# Encrypt disk with bioctl(8) and CRYPTO

[bioctl(8)][b] is a RAID management interface with CRYPTO discipline
for disk encryption.

[b]: https://man.openbsd.org/bioctl.8

## Create an encrypted volume

Plug the drive in. Assuming it's **sd3**.

**DANGER!** All data on **sd3** will be erased.

<pre>
# <b>dd if=/dev/urandom of=/dev/rsd3c bs=1m</b>
# <b>fdisk -iy -g -b 960 sd3</b>
# <b>printf 'a a\\n\\n\\nRAID\\nw\\nq\\n'|disklabel -E sd3</b>
# <b>bioctl -c C -l sd3a softraid0</b>
New passphrase:
Re-type passphrase:
<strong>softraid0: CRYPTO volume attached as sd4</strong>
# <b>dd if=/dev/zero of=/dev/rsd4c bs=1m count=1</b>
# <b>fdisk -iy sd4</b>
# <b>printf 'a i\\n\\n\\n\\nw\\nq\\n'|disklabel -E sd4</b>
# <b>newfs sd4a</b>
# <b>mkdir /mnt/sd4a</b>
# <b>mount /dev/sd4a /mnt/sd4a</b>
# ...
# <b>umount /dev/sd4a</b>
# <b>bioctl -d sd4</b>
#
</pre>

It's safe to unplug **sd3** drive now.

## Mount and umount

Plug the drive in.

<pre>
# <b>bioctl -c C -l sd3a softraid0</b>
Passphrase:
softraid0: CRYPTO volume attached as sd4
# <b>mkdir /mnt/sd4a</b>
# <b>mount /dev/sd4a /mnt/sd4a</b>
...
# <b>umount /dev/sd4a</b>
# <b>bioctl -d sd4</b>
#
</pre>

Check out my helpers
[mnt_crypto](/bin/mnt_crypto) and
[umnt_crypto](/bin/umnt_crypto) and how to use them:

<pre>
# <b>bin/mnt_crypto  'XXXXXXXXXXXXXXXX.x' 'YYYYYYYYYYYYYYYY.y'</b>
# <b>bin/umnt_crypto 'XXXXXXXXXXXXXXXX.x'</b>
</pre>

Where `XXXXXXXXXXXXXXXX.x` is DUID and partition of a CRYPTO
volume and `YYYYYYYYYYYYYYYY.y`&mdash;of a physical device.

You can find DUIDs by running this:

<pre>
# <b>disklabel /dev/sd3a | grep -E 'duid|RAID'</b>
duid: XXXXXXXXXXXXXXXX
  a:          7716864                 0    RAID
# <b>disklabel /dev/sd4a | grep -E 'duid|BSD'</b>
duid: YYYYYYYYYYYYYYYY
  i:          7716864                64    4.2BSD   4096 32768 26062
#
</pre>

## Check file system consistency

A drive was accidentally disconnected (before you could unmount it properly).
That happens. Run [fsck(8)](https://man.openbsd.org/fsck.8):

<pre>
# <b>bioctl -c C -l sd3a softraid0</b>
softraid0: sd4 was not shutdown properly
Passphrase:
softraid0: sd4 was not shutdown properly
softraid0: CRYPTO volume attached as sd4
# <b>fsck /dev/sd4a</b>
** /dev/rsd4a
** Last Mounted on /mnt/sd4a
** Phase 1 - Check Blocks and Sizes
** Phase 2 - Check Pathnames
** Phase 3 - Check Connectivity
** Phase 4 - Check Reference Counts
** Phase 5 - Check Cyl groups
38996 files, 58177423 used, 62950830 free
(10766 frags, 7867508 blocks, 0.0% fragmentation)

MARK FILE SYSTEM CLEAN? [Fyn?] <b>y</b>

***** FILE SYSTEM WAS MODIFIED *****
#
</pre>

## Change the passphrase

<pre>
# <b>bioctl -P sd4</b>
Old passphrase:
New passphrase:
Re-type passphrase:
#
</pre>
