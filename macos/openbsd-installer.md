_Tested on [macOS](/macos/) 10.13 with [OpenBSD](/openbsd/) 6.3_

# Prepare bootable USB drive with OpenBSD installer on macOS

Download the installer and verify its checksum:

<pre>
$ <b>cd /tmp</b>
$ <b>export URL=https://cloudflare.cdn.openbsd.org/pub/OpenBSD</b>
$ <b>curl -Os $URL/6.3/amd64/SHA256</b>
$ <b>curl -O  $URL/6.3/amd64/install63.fs</b>
...
$ <b>grep install63.fs SHA256|cut -f4 -d' '</b>
df19266be16079ccd6114447f7bb13bdedb9c5cb66ecc1ea98544290fa4dc138
$ <b>shasum -a 256 install63.fs|cut -f1 -d' '</b>
df19266be16079ccd6114447f7bb13bdedb9c5cb66ecc1ea98544290fa4dc138
$
</pre>

Plug in the USB drive. Its size should be at least 400 MB. Run
`diskutil list` to find an identifier of the flash drive. Usually
it's `/dev/disk2`.

Replace `/dev/diskX` with the identifier of the flash drive.
**All data on `/dev/diskX` will be erased!**

<pre>
$ <b>sudo diskutil unmount /dev/diskX</b>
$ <b>sudo dd if=install63.fs of=/dev/diskX bs=1m</b>
...
$
</pre>

Wait few minutes.

[Install OpenBSD](/openbsd/install.html).
