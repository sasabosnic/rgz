_Tested on [OpenBSD](/openbsd/) 6.3 with git-2.16.2_

# Host Git repositories on OpenBSD

[Deploy a server](/openbsd/) and login into it.

On the remote host install
[git(1)](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/),
add `git` user, add your public [SSH key](/ssh.html), change owner
and group, then exit.

<pre>
# <b>pkg_add git</b>
...
git-2.16.2: ok
The following new rcscripts were installed: /etc/rc.d/gitdaemon
See rcctl(8) for details.
Look in /usr/local/share/doc/pkg-readmes for extra documentation.
#
# <b>mkdir /home/git</b>
# <b>user add git</b>
# <b>mkdir -m 700 /home/git/.ssh</b>
# <b>cp /root/.ssh/authorized_keys /home/git/.ssh/</b>
# <b>chown -R git:git /home/git</b>
#
</pre>

From your local host initialize a bare repository on the remote,
add the remote and push a local copy to it.

<pre>
$ <b>ssh git@<em>REMOTE</em> git init --bare <em>REPOSITORY.git</em></b>
Initialized emtpy Git repository in /home/git/REPOSITORY.git/
$ <b>cd <em>REPOSITORY</em></b>
$ <b>git remote add <em>REMOTE</em> <em>git@REMOTE_SERVER:REPOSITORY.git</em></b>
$ <b>git push <em>REMOTE</em> master</b>
Counting objects: 1049, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (1041/1041), done.
Writing objects: 100% (1049/1049), 3.80 MiB | 257.00 KiB/s, done.
Total 1049 (delta 676), reused 0 (delta 0)
remote: Resolving deltas: 100% (676/676), done.
To <em>REMOTE_SERVER:REPOSITORY.git</em>
 * [new branch]      master -> master
$
</pre>

[Publish Git repositories](/stagit.html).
