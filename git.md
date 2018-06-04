# Host your Git repositories

If you don't have a server yet, you should [deploy one](/vultr.html).
Login to the server.

<pre>
# <b>pkg_add install git</b>
# <b>useradd -q</b>
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
