# Host your Git repositories

[Deploy OpenBSD server on Vultr](/vultr.html) and login into it.

## On the remote host

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
# <b>mkdir /home/git</b>
# <b>user add git</b>
</pre>

Add your public SSH keys:

<pre>
# <b>mkdir -m 700 /home/git/.ssh</b>
# <b>cp /root/.ssh/authorized_keys /home/git/.ssh/</b>
</pre>

Set the proper owner and group, then exit.

<pre>
# <b>chown -R git:git /home/git</b>
#
</pre>

## On the local host

Initialize bare repository on the remote:

<pre>
$ <b>ssh git@<i>REMOTE</i> git init --bare <i>REPOSITORY.git</i></b>
Initialized emtpy Git repository in /home/git/REPOSITORY.git/
</pre>

Add the remote and push a local copy to it:

<pre>
$ <b>cd <i>REPOSITORY</i></b>
$ <b>git remote add <i>REMOTE</i> <i>git@REMOTE_SERVER:REPOSITORY.git</i></b>
$ <b>git push <i>REMOTE</i> master</b>
Counting objects: 1049, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (1041/1041), done.
Writing objects: 100% (1049/1049), 3.80 MiB | 257.00 KiB/s, done.
Total 1049 (delta 676), reused 0 (delta 0)
remote: Resolving deltas: 100% (676/676), done.
To REMOTE_SERVER:REPOSITORY.git
 * [new branch]      master -> master
$
</pre>

Done! Now you may want [to publish your Git repositories on the web](/stagit.html).

_Tested on OpenBSD 6.3 with git-2.16.2_
