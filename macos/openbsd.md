# Prepare a bootable OpenBSD drive on macOS

Download the installer:

    $ cd /tmp
    $ export URL=https://cloudflare.cdn.openbsd.org/pub/OpenBSD
    $ curl $URL/6.3/amd64/install63.fs
    $ curl $URL/6.3/amd64/SHA256

    $ grep install63.fs SHA256|cut -f4 -d' '
    $ shasum -a 256 install63.fs|cut -f1 -d' '

Create install media. Plug your flash drive in. It should be at least 400
MB. Run `diskutil list` to find an identifier of the flash drive. Usually
it's `/dev/disk2`.

Substitute `/dev/diskX` with the identifier of the flash drive. **All data
on `/dev/diskX` will be erased!**

    $ sudo dd if=install62.fs of=/dev/diskX bs=1m

Wait few minutes and when it's done, [try to boot and install
OpenBSD](/openbsd/install.html).

_Tested on macOS 10.13._
