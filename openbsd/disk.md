_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4 (amd64)_

# Find disk name and partition with sysctl(1) and dmesg(1)

Make sure you are using the device name and partition you need,
before your ~~destroy all your data~~ run any destructive commands like dd(1).


## Disk names

You can address disk/partitions...

**by disklabel UID** | &nbsp;
:--                      | :--
`d2L6wcn2dlggwqel`       | raw device
`d2L6wcn2dlggwqel.c`     | entire disk
`d2L6wcn2dlggwqel.a`     | partition `a`
&nbsp;                   | &nbsp;
**or by full path**            | &nbsp;
`/dev/rsd1c`             | entire disk raw device `sd1`
`/dev/rsd1a`             | `a` partition
`/dev/sd1c`              | entire disk same, but as a _block device_
`/dev/sd1a`              | `a` partition

> a _raw device_ (or _character device_) is accessed directly,
bypassing the operating system's caches and buffers.

When to use block devices then?

> "Use block dev only for mounting, use raw for anything else"<br>&mdash;
[Otto Moerbeek](https://twitter.com/ottom6k/status/1042437641860460544 "19 Sep 2018")
(@ottom6k)

There are programs like
[disklabel(8)](https://man.openbsd.org/disklabel.8), they accept
all kinds of names (`/dev/sd0c`, or `/dev/sd0`, or even `sd0`) and
parse them into full path `/dev/rsd0c`.

<pre>
# <b>disklabel sd1</b>
# <em>/dev/rsd1c</em>:
...
#
</pre>

Some programs, like [fdisk(8)](https://man.openbsd.org/fdisk.8),
accept some abbreviations, like `sd1` or `sd1c`, but refuse to work
with block devices.

<pre>
# <b>fdisk /dev/sd1c</b>
fdisk: <em>/dev/sd1c</em> is not a character device
#
</pre>

Other programs, for example, [dd(1)](https://man.openbsd.org/dd.1),
just do what you told them to do.

Don't repeat at home:

<pre>
# <b>dd if=/dev/zero of=/dev/sd3 bs=1m</b>

/: write failed, file system is full
dd: /dev/sd3: No space left on device
919+0 records in
918+0 records out
962592768 bytes transferred in 2.466 secs (390316750 bytes/sec)
#
</pre>

This `dd` creates the file `/dev/sd3` and fills up your root
partition.

## Find disks

<pre>
$ <b>sysctl hw.disknames</b>
hw.disknames=sd0:ew9w8ueO9m0t1wda,sd1:66160c68a67e00e6
$
</pre>

`sd0` is the device connected first, its DUID is `ew9w8ueO9m0t1wda`<br>
`sd1` is the second and DUID is `66160c68a67e00e6`.

These numbers (`sd0` and `sd1`) may change after reboot or
pluging/unpluging USB devices, but DUIDs are persitent until you
rewrite it with disklabel.

If you are looking for a just connected USB drive, then grep(1) word
`removable` in the output of dmesg(1).

<pre>
$ <b>dmesg | grep removable | tail -1</b>
<em>sd1</em> at scsibus5 ...  SCSI3 0/direct removable ...
$
</pre>

`sd1` is what you are looking for.

## Find partitions

Run disklabel(1) with a disk name or DUID.

<pre>
# <b>disklabel sd1</b>
# /dev/rsd1c:
type: SCSI
disk: SCSI disk
label: XXXXXXXXXX
duid: 66160c68a67e00e6
flags:
bytes/sector: 512
sectors/track: 63
tracks/cylinder: 255
sectors/cylinder: 16065
cylinders: 1945
total sectors: 31260672
boundstart: 0
boundend: 31260672
drivedata: 0

16 partitions:
#                size      offset  fstype [fsize bsize   cpg]
<em>  a:</em>         31260672           0  4.2BSD   2048 16384     1
  c:         31260672           0  unused
#
</pre>

If you are looking for OpenBSD partition (`4.2BSD`) it's the partition `a`.

The entire disk is represented as the partition `c` (marked as
`unused`, because you can't create a file system on this partition).

---

**Thanks** to
[Tim Chase](https://twitter.com/gumnos),
[Devin Teske](https://twitter.com/freebsdfrau),
[Mischa Peters](https://twitter.com/mischapeters),
[Bryan Steele](https://twitter.com/canadianbryan)
for reading drafts of
this.
