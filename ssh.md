_Tested on [OpenBSD](/openbsd/) 6.3 and [macOS](/macos/) 10.13_

# Generate SSH keys

Generate a strong passphrase to protect your private key. For
example, with [diceware](/diceware.html).

Generate a new SSH key pair and enter that passphrase.

<pre>
$ <b>ssh-keygen -t ed25519 -a 100</b>
Enter file in which to save the key
(/home/<i>username</i>/.ssh/id_ed25519):
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in ~/.ssh/id_ed25519.
Your public key has been saved in ~/.ssh/id_ed25519.pub.
The key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx comment
The key's randomart image is:
+--[ED25519 256]--+
|       .o=@*=    |
|        oX = .=  |
|        * o +    |
|       = o =     |
|        S o +    |
|       * + o     |
|      = X.o.=    |
|       O =+o     |
|      . E++++    |
+----[SHA256]-----+
$
</pre>


## RSA fallback

If Ed25519 isn't yet supported by your operating systems, use long
RSA keys as a fallback.

<pre>
$ <b>ssh-keygen -t rsa -b 4096 -o -a 100</b>
Enter file in which to save the key
(/home/<i>username</i>/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in ~/.ssh/id_rsa.
Your public key has been saved in ~/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx comment
The key's randomart image is:
+---[RSA 2048]----+
|  .ooo ...ooo    |
|  ..o.+  .o+  E  |
|.o.o.o = . o     |
|.Boo= + +        |
|+ Bo . =S        |
| o . ...+. o     |
|    . o  ++      |
|     o o .o      |
|      + ..*      |
+----[SHA256]-----+
$
</pre>

Option `-o` enables the new OpenSSH format to increase resistance to
brute-force password checking.

## Do not share private keys

Don't copy or share your private key. Generate a new key pair for
every user and every device. Use the same key pair for multiple
destinations.

## Use SSH configuration

Add all your frequently used hosts to `~/.ssh/config`, like this:

<pre>
Host <b><i>remote_host</i></b>
  User <b><i>username_on_remote_host</i></b>
  Hostname <b><i>www.example.com</i></b>
  IdentityFile <b>/home/<i>username</i>/.ssh/id_ed25519</b>
</pre>

After adding this to your SSH configuration you can run `ssh www` instead
of:

<pre>
$ <b>ssh -i ~/.ssh/id_ed25519 username_on_remote_host@www.example.com</b>
</pre>
