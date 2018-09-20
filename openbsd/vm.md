_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4_

# OpenBSD VM Guest OS Compatibility

[vmd(8)](https://man.openbsd.org/vmd.8) runs virtual machines (VMs) on a host, it's controlled
via [vmctl(8)](https://man.openbsd.org/vmctl.8).

Works       | &nbsp;
:--         | :--
Ubuntu 18   | [@canadianbryan](https://twitter.com/canadianbryan/status/1042791776271171584)
Debian 9    | [@vext01] needs qemu
Alpine      | [@voutilad]
boot2docker | [@jon]: needs a dummy disc to boot off ISO
&nbsp;      |
<br>**Doesn't** |
OpenIndiana Hipster | [@jon](https://bsd.network/@jon/100754685568019558)
netboot.xyz | [@jon](https://bsd.network/@jon/100754685568019558)
xv6         | [@jon]: hangs after _Booting from 0000:7c00_
HelenOS     | [@jon]: hangs at kernel monitor prompt
TempleOS    | [@jon]
Minix 3     | [@jon]: VGA to Serial stuff breaks down
tor-ramdisk | [@jon]: no serial console, no network traffic

[@voutilad]: https://gist.github.com/voutilad/a5080909e88e8dcffd1960312b5f9510
[@jon]: https://bsd.network/@jon/100719091239815531
[@vext01]: https://github.com/vext01/recipes/blob/master/recipes/debian9_inside_vmm.md
