_Tested on [OpenBSD](/openbsd/) 6.3 and [macOS](/macos/) 10.13_

# Host repositories on GitHub

[Generate a new SSH key pair](/ssh.html) and copy public key to
[the clipboard](/xclip.html).

<pre>
$ <b>xclip -selection clipboad ~/.ssh/id_ed25519.pub</b>
$
</pre>

Open your [GitHub profile](https://github.com/settings/keys).

On _Personal Settings > SSH and GPG keys_ page click **New SSH key**.

Type-in a **Title**, for example, a hostname of your computer.

Paste your public key into **Key** textarea.

Click **Add SSH key**.

Expect email _A new public key was added to your account_ from GitHub.

<pre>
$ <b>ssh -T git@github.com</b>
Hi romanzolotarev! You've successfully authenticated, but GitHub
does not provide shell access.
$
</pre>

GitHub makes your public key available via HTTPS.

<pre>
$ <b>curl https://github.com/romanzolotarev.keys</b>
ssh-ed25519 AAAAC3NzaC...
$
</pre>
