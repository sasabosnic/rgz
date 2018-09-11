"Just launched my first OpenBSD instance on @Vultr! I'm excited
to *finally* dig into it. I blame @romanzolotarev"<br>&mdash;
[lambdanerd](https://mobile.twitter.com/lambdanerd/status/1027817634434371584 "20 Aug 2018")
(@lambdanerd)

**DISCLAIMER**<br> I'm a customer of Vultr and the yellow button
is a referral link.  When you [sign
up](https://www.vultr.com/pricing/?ref=7035749), Vultr adds few
weeks of hosting for this site. Thank you.

_Tested on [OpenBSD](/openbsd/) 6.3_

# Deploy OpenBSD VPS on Vultr

If you need a new OpenBSD server, make sure you have your [public
SSH key](/ssh.html) handy, then...

<a href="https://www.vultr.com/pricing/?ref=7035749"><span
class="button">sign up at Vultr</span></a>

Deploy an instance, for example:

1. Server Location: _pick your prefered location_
1. Server Type: 64 bit OS, **OpenBSD 6.3 x64**
1. Server Size: 
   - _For IPv6 only_: **$2.50/mo** 20 GB SSD 512MB Memory
   - _IPv4 and IPv6_: **$5.00/mo** 25 GB SSD 1024MB Memory
1. Additional Features: **None**
1. Start Script: **None**
1. SSH Keys: **Add new key**
1. Firewall Group: **No firewall**
1. Server Hostname & Label: **www**

In a minute your sever will be deployed. Login using the new IP address
and your private SSH key (assuming it's in the default location:
`~/.ssh/id_ed25519`):

    $ ssh root@XXX.XXX.XXX.XXX
    OpenBSD 6.3 (GENERIC.MP) #107: Sat Mar 24 14:21:59 MDT 2018

    Welcome to OpenBSD: The proactively secure Unix-like operating
    system.

    Please use the sendbug(1) utility to report bugs in the system.
    Before reporting a bug, please try to reproduce it with the
    latest version of the code. With bug reports, please try to
    ensure that enough information to reproduce the problem is
    enclosed, and if a known fix for it exists, include that as
    well.

    www#

Read [afterboot(8)](https://man.openbsd.org/afterboot.8).

[Setup a web server](/openbsd/webserver.html).

