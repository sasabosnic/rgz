# Deploy a VM in Amsterdam

[OpenBSD in Amsterdam](https://openbsd.amsterdam) is running dedicated
[vmd(8)](https://man.openbsd.org/vmd.8) servers to host opinionated
VMs.

Send your name, email address, hostname, username, and public SSH key to OpenBSDAms
via [contact form](https://openbsd.amsterdam/contact.html),
[Twitter](https://mobile.twitter.com/OpenBSDAms), or
[Mastodon](https://bsd.network/@OpenBSDAms), before you pay.

For example:

	Roman Zolotarev
	hi@romanzolotarev.com
	www.romanzolotarev.com
	romanzolotarev
	ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqh7BmO... 1500469202

Please allow few hours for your VM to be started. You'll get IPv4
(and IPv6) address as soon as your VM is deployed. Login to the
VM (assuming your private SSH key is in its default location):

<pre>
$ <b>ssh <i>username@XXX.XXX.XXX.XXX</i></b>
OpenBSD 6.3 (GENERIC) #4: Sun Jun 17 11:09:51 CEST 2018

Welcome to OpenBSD: The proactively secure Unix-like operating
system.

Please use the sendbug(1) utility to report bugs in the system.
Before reporting a bug, please try to reproduce it with the
latest version of the code. With bug reports, please try to
ensure that enough information to reproduce the problem is
enclosed, and if a known fix for it exists, include that as
well.
$
</pre>

Get a password from `~/pass.txt` and switch to `root`.

<pre>
$ <b>cat pass.txt</b>
<i>XXXXXXXXXXXXXXXXXXXXXXXXXX</i>
$ <b>su -</b>
password:
#
</pre>

Add your _username_ to `/etc/doas.conf`:

<pre>
# <b>echo 'permit <i>username</i>' > /etc/doas.conf</b>
#
</pre>

Edit `/etc/ssh/sshd_config`:

<pre>
PermitRootLogin no
PasswordAuthentication no
</pre>

Verify the new config and restart `sshd`:

<pre>
# <b>sshd -t</b>
# <b>rcctl restart sshd</b>
sshd(ok)
sshd(ok)
#
</pre>

Run `sysctl` to set the time counter then run `ntpd` to set the
local clock and terminate it by pressing `^C`.

<pre>
# <b>echo 'kern.timecounter.hardware=tsc' > /etc/sysctl.conf</b>
# <b>sysctl kern.timecounter.hardware=tsc</b>
kern.timecounter.hardware: i8254 -> tsc
# <b>ntpd -sd</b>
/var/db/ntpd.drift is empty
ntp engine ready
...
sensor vmmci0: offset 44.961541
set local clock to Sat Jun 30 21:15:05 CEST 2018 (offset 44.961541s)
...
^Cntp engine exiting
Terminating
#
</pre>

Edit `/etc/hostname.vio0`:

	inet 46.23.xx.xx 255.255.255.0
	inet6 2a03:6000:xxxx::xxx 64 -soii

Edit `/etc/mygate`:

	46.23.xx.1
	2a03:6000:xxxx::1

Reinitialize the network:

<pre>
# <b>sh /etc/netstart vio0</b>
#
</pre>

Update `/etc/pf.conf`, test, and load it:

<pre>
# <b>echo 'pass in quick proto { icmp, icmp6 } all' >> /etc/pf.conf</b>
# <b>pfctl -nf /etc/pf.conf</b>
# <b>pfctl -f /etc/pf.conf</b>
# <b>pfctl -sr</b>
block return all
pass all flags S/SA
block return in on ! lo0 proto tcp from any to any port 6000:6010
block return out log proto tcp all user = 55
block return out log proto udp all user = 55
pass in quick proto icmp all
pass in quick proto ipv6-icmp all
#
</pre>

Stop and disable `sndiod`:

<pre>
# <b>rcctl stop sndiod</b>
sndiod(ok)
# <b>rcctl disable sndiod</b>
#
</pre>

Check [6.3 errata](https://www.openbsd.org/errata63.html) and apply
available patches.

<pre>
# <b>syspatch</b>
...
Get/Verify syspatch63-011_perl.tgz 100% |***************| 24401       00:00
Installing patch 011_perl
Relinking to create unique kernel... done.
# <b>reboot</b>
Connection to XXX.XXX.XXX.XXX closed.
</pre>

---

Now you may want [to setup a web server](/openbsd/webserver.html).

_Tested on OpenBSD 6.3_

---

**Thanks** to 
[Mischa Peters](https://mobile.twitter.com/mischapeters) for reading drafts fo this,
to [Mike Larkin](https://mobile.twitter.com/mlarkin2012), 
[Bryan Steele](https://mobile.twitter.com/canadianbryan), 
[h3artbl33d](https://mobile.twitter.com/h3artbl33d), and
[Jeff Neitzel](https://mobile.twitter.com/v6shell) for tips and hints.
