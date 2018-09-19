_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4_

# OpenBSD VM Guest OS Compatibility

[vmd(8)](https://man.openbsd.org/vmd.8) runs virtual machines (VMs) on a host, it's controlled
via [vmctl(8)](https://man.openbsd.org/vmctl.8).

Works       | &nbsp;
:--         | :--
Debian 9    | [@vext01]
Alpine      | [@voutilad]
boot2docker | [@jon]: needs a dummy disc to boot off ISO (fixed in 6.4)
&nbsp;      |
**Doesn't** |
netboot.xyz | [@jon][@jon2]
xv6         | [@jon]: hangs with 100% CPU after "Booting from 0000:7c00"
HelenOS     | [@jon]: hangs at kernel monitor prompt
TempleOS    | [@jon]
Minix 3     | [@jon]: VGA to Serial stuff breaks down
tor-ramdisk | [@jon]: serial console doesn't work, no network traffic

[@voutilad]: https://gist.github.com/voutilad/a5080909e88e8dcffd1960312b5f9510
[@jon]: https://bsd.network/@jon/100719091239815531
[@vext01]: https://github.com/vext01/recipes/blob/master/recipes/debian9_inside_vmm.md
[@jon2]: https://bsd.network/@jon/100754359458914508
