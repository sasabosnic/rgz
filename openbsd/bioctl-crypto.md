You can use bioctl(8) for [full-disk encryption of OpenBSD
installation](/openbsd/fde.html).

# Encrypt disk with _bioctl_ and CRYPTO

[bioctl(8)][b] is a RAID management interface with CRYPTO discipline
for disk encryption.

[b]: https://man.openbsd.org/bioctl.8

## Create an encrypted volume

Plug the drive in. Assuming it's **sd3**.

**DANGER!** All data on **sd3** will be erased.

<pre>
# <b>dd if=/dev/urandom of=/dev/rsd3c bs=1m</b>
# <b>fdisk -iy  -g -b 960 sd3</b>
# <b>printf 'a a\n\n\nRAID\nw\nq\n'|disklabel -E sd3</b>
# <b>bioctl -c C -l sd3a softraid0</b>
New passphrase:
Re-type passphrase:
softraid0: CRYPTO volume attached as sd4
# <b>dd if=/dev/zero of=/dev/rsd4c bs=1m count=1</b>
# fdisk -iy sd4
# <b>printf 'a i\n\n\nRAID\nw\nq\n'|disklabel -E sd4</b>
# <b>newfs sd4i</b>
# <b>mkdir /mnt/sd4i</b>
# <b>mount /dev/sd4i /mnt/sd4i</b>
# ...
# <b>umount /dev/sd4i</b>
# <b>bictl -d sd4</b>
#
</pre>

It's safe to unplug **sd3** drive now.

## Mount and umount

Plug the drive in.

<pre>
# <b>bioctl -c C -l sd3a softraid0</b>
Passphrase:
softraid0: CRYPTO volume attached as sd4
# <b>mkdir /mnt/sd4i</b>
# <b>mount /dev/sd4i /mnt/sd4i</b>
...
# <b>umount /dev/sd4i</b>
# <b>bictl -d sd4</b>
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
# <b>fsck /dev/sd4i</b>
** /dev/rsd4i
** Last Mounted on /mnt/sd4i
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
