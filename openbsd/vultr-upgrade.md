_Tested on [OpenBSD](/openbsd/) 6.4_

# Upgrade OpenBSD on Vultr

If you have [OpenBSD installed on Vultr](vultr.html) and want
to upgrate it, then backup your data first.

## Prepare

Login to your VM, download, and verify `bsd.rd`:

<pre>
# <b>ftp -V https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/bsd.rd</b>
bsd.rd       100% |*******************************|  9782 KB    00:00
# <b>ftp -V https://cdn.openbsd.org/pub/OpenBSD/6.4/amd64/SHA256.sig</b>
SHA256.sig   100% |*******************************|  2141       00:00
# <b>signify -C -p /etc/signify/openbsd-64-base.pub -x SHA256.sig bsd.rd</b>
Signature Verified
bsd.rd: OK
# <b>cp /bsd.rd /bsd.rd.63</b>
# <b>cp bsd.rd /</b>
#
</pre>

[Read the official FAQ](https://www.openbsd.org/faq/upgrade64.html).

Update your configuration files, if needed for 6.4.

## Access the console

- Login to [my.vultr.com](https://my.vultr.com).
- Navigate to _Servers > Instances_ and select a server.
- Click on **View Console** icon.
- In a pop-up window login with your password.

## Upgrade

Login via the console and boot from `/bsd.rd`.

<pre>
OpenBSD/amd64 (xxx.xxx.xx) (tty00)

login: <b>root</b>
password: <b>********</b>

OpenBSD 6.3 (GENERIC) #100: Sat Mar 24 14:17:45 MDT 2018
...
# <b>reboot</b>
...
boot> <b>boot /bsd.rd</b>

booting hd0a:/bsd.rd: 3511114+1500160+3892040+0+598016
...
</pre>

Choose `(U)pgrade`:

<pre>
Welcome to the OpenBSD/amd64 6.4 installation program.
(I)nstall, (U)pgrade, (A)utoinstall or (S)hell? <b>u</b>
...
</pre>

Answer the questions:

<pre>
Which disk is the root disk = <b>sd0</b>
Force checking of clean non-root filesystems = <b>no</b>
Location of sets = <b>http</b>
HTTP proxy URL = <b>none</b>
HTTP Server = <b>cdn.openbsd.org</b>
Server directory = <b>pub/OpenBSD/6.4/amd64</b>
Set name(s) = <b>done</b>
Location of sets = <b>done</b>
</pre>

Wait for the installer and boot normally:

<pre>
...
CONGRATULATIONS! Your OpenBSD upgrade has been successfully completed!
...
boot> <b>boot /bsd</b>
...

OpenBSD/amd64 (xx.xxx.xx) (tty00)

login:
</pre>

Close the console.

## Update packages

Login and update the installed packages:

<pre>
# <b>pkg_add -uv</b>
...
#
</pre>
