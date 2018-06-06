> "Roman you have inspired me. I'm starting a project this weekend on <a
href="https://mobile.twitter.com/vultr">@vultr</a> with <a
href="https://mobile.twitter.com/hashtag/OpenBSD">#OpenBSD</a> and <a
href="https://mobile.twitter.com/hashtag/Erlang">#Erlang</a>. Will be
sharing more soon still brainstorming the project. Will post every step as
I build."<br>
[EssentialOS=OpenBSD](https://mobile.twitter.com/BrutusUnix/status/987485038630572032 "21 Apr 2018")
(@BrutusUnix)

---

# Deploy a VPS on Vultr

If you need a new server, make sure you have your [public SSH
key](/ssh.html) handy, then register at
[Vultr](https://www.vultr.com/?ref=7035749 "Disclaimer: It's a referal
link") and deploy your server.

For example:

1. Server Location: **Miami**
1. Server Type: 64 bit OS, **OpenBSD 6 x64**
1. Server Size: 20 GB SSD **$2.50/mo** 1 CPU 512MB Memory 500GB Bandwidth
1. Additional Features: None
1. Start Script: None
1. SSH Keys: Add new key
1. Firewall Group: No firewall
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

Yes, `root` login is enabled on Vultr servers by default. We better
harden a server right after its first boot, but this topic deserves its
own post.

Now you can [setup a web server](/openbsd/webserver.html).

_Tested on OpenBSD 6.3_
