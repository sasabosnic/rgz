_Tested on [OpenBSD](/openbsd/) 6.4_

# Upgrade OpenBSD on OpenBSD.Amsterdam

If you have [OpenBSD 6.3 installed on your VM](oams.html) and want
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

Login to your [OpenBSD.Amsterdam](https://openbsd.amsterdam/) server
(find the _HOSTNAME_, _PORT_, and _ID_ in the email message you got after
the registration):

<pre>
$ <b>ssh \</b>
<i><b>-p <em>PORT</em> \</b></i>
<i><b>-e none \</b></i>
<i><b>-o VerifyHostKeyDNS=ask \</b></i>
<i><b><em>HOSTNAME</em>.openbsd.amsterdam \</b></i>
<i><b>vmctl console <em>ID</em></b></i>
</pre>

Hit _Enter_ to see the console.

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
&gt;&gt; OpenBSD/amd64 BOOT 3.41
boot&gt; <b>boot /bsd.rd</b>

booting hd0a:/bsd.rd: 3511114+1500160+3892040+0+598016
...
</pre>

Choose `(A)utoinstall`:

<pre>
Welcome to the OpenBSD/amd64 6.4 installation program.
(I)nstall, (U)pgrade, (A)utoinstall or (S)hell? <b>a</b>
...
CONGRATULATIONS! Your OpenBSD upgrade has been successfully completed!
...
&gt;&gt; OpenBSD/amd64 BOOT 3.41
boot&gt; <b>boot /bsd</b>
...

OpenBSD/amd64 (s1.romanzolotarev.com) (tty00)

login:
</pre>

Type `~.` to close the console.

## Update packages

Login and update the installed packages:

<pre>
# <b>pkg_add -uv</b>
...
#
</pre>
