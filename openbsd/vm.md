_Tested on [OpenBSD](/openbsd/) 6.3 and 6.4_

# OpenBSD VM

[vmd(8)](https://man.openbsd.org/vmd.8) runs virtual machines (VMs) on a host, it's controlled
via [vmctl(8)](https://man.openbsd.org/vmctl.8).

## Providers

- [OpenBSD Amsterdam](https://openbsd.amsterdam/)

## Compatibility

	* boot2docker  ok  needs a dummy disc to boot off ISO (fixed in 6.4)

	* xv6          no  hangs with 100% CPU after "Booting from 0000:7c00"
	* HelenOS      no  hangs at kernel monitor prompt
	* TempleOS     no
	* Minix 3      no  VGA to Serial stuff breaks down

`*` tested by [Jon Williams](https://bsd.network/@jon/100719091239815531)
