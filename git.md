# Host your Git repositories

[Deploy OpenBSD server on Vultr](/vultr.html) and login into it.

Install [git(1)](https://git-scm.com/):

<pre>
# <b>pkg_add install git</b>
quirks-2.414 signed on 2018-03-28T14:24:37Z
git-2.16.2: ok
The following new rcscripts were installed: /etc/rc.d/gitdaemon
See rcctl(8) for details.
Look in /usr/local/share/doc/pkg-readmes for extra documentation.
</pre>

Add `git` user:

<pre>
# <b>useradd -q</b>
</pre>
# <b>su git</b>
$ <b>cd</b>
$ <b>mkdir -m 700 .ssh</b>
$ <b>ftp -o .ssh/authorized_keys <i>URL</i></b>
$ <b>git init --bare <i>REPOSITORY.git</i></b>
</pre>

On your local host:

<pre>
$ <b>cd <i>REPOSITORY</i></b>
$ <b>git remote add <i>REMOTE</i> <i>git@REMOTE_SERVER:REPOSITORY.git</i></b>
$ <b>git push <i>REMOTE</i></b>
</pre>

Done! Now you may want [to publish your Git repositories on the web](/stagit.html).

_Tested on OpenBSD 6.3_
