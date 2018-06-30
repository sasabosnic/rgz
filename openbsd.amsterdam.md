# Deploy a VM in Amsterdam

[OpenBSD in Amsterdam](https://openbsd.amsterdam) is running dedicated
[vmd(8)](https://man.openbsd.org/vmd.8) servers to host opinionated
VMs.

<a style="border: none;" href="https://openbsd.amsterdam"><img
  src="/openbsd/amsterdam-avatar.png"
  style="border: 0; width: 60px; height: 60px; border-radius: 60px;"
  width="60" height="60"
  alt="OpenBSD in Amsterdam"
  title="OpenBSD in Amsterdam"></a>

---

Contact [OpenBSDAms](https://mobile.twitter.com/openbsdams) on
Twitter.

Send them your username and your public [SSH key](/ssh.html).

You'll get IPv4 (and IPv6) address as soon as your VM is deployed.

---

Login to the VM (assuming your private SSH key is in its default
location):

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

---

Get a password from `~/pass.txt` and switch to `root`.

<pre>
$ <b>cat pass.txt</b>
<i>XXXXXXXXXXXXXXXXXXXXXXXXXX</i>
$ <b>su -</b>
password:
#
</pre>

---

Run `sysctl` to set the time counter:

<pre>
# <b>sysctl kern.timecounter.hardware=tsc</b>
kern.timecounter.hardware: i8254 -> tsc
# <b>echo 'kern.timecounter.hardware=tsc' > /etc/sysctl.conf</b>
#
</pre>

---

Run `ntpd` to set the local clock and terminate it by pressing `^C`.

<pre>
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

---

Edit `/etc/ssh/sshd_config`:

<pre>
PermitRootLogin no
PasswordAuthentication no
</pre>

Verify the new `sshd` config:

<pre>
# <b>sshd -t</b>
#
</pre>

Restart `sshd`:

<pre>
# rcctl restart sshd
sshd(ok)
sshd(ok)
#
</pre>

---

Add your username to `/etc/doas.conf`:

<pre>
# <b>echo 'permit <i>username</i>' > /etc/doas.conf</b>
</pre>

---

Don't forget to check [6.3 errata](https://www.openbsd.org/errata63.html)
and apply available patches.

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
