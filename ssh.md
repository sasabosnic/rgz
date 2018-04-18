# How to generate and manage SSH keys

If you are using short DSA or RSA keys, it's time to generate new ones. It
only takes few minutes.

Elliptic Curve Cryptography was implemented in OpenSSH in 2011. It is safe
to assume that ECC is supported by major operating systems today. Consider
upgrading your SSH keys to ECC: the generated keys are smaller, the
algorithm is faster, and the analysis hasn't shown any weaknesses, unlike
traditional RSA or DSA.

Run this command to generate your new SSH key pair.

    $ ssh-keygen -t ed25519 -a 100
    Enter file in which to save the key
    (/home/romanzolotarev/.ssh/id_ed25519):
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

Done!

Let me clarify those options. For better security, we used Ed25519 keys
with the `-t ed25519` option and to increase resistance to brute-force
password checking we used a hundred rounds of the key derivation function
(`-a 100`).

P.S. To protect your private key, use a strong passphrase. [A few random common
words should work](/diceware.html).

## RSA fallback

If Ed25519 isn't yet supported by some of your servers, you can use long
RSA keys as a fallback.

    $ ssh-keygen -t rsa -b 4096 -o -a 100
    Enter file in which to save the key
    (/home/romanzolotarev/.ssh/id_rsa):
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

P.S. Option `-o` enables the new OpenSSH format to increase resistance to
brute-force password checking.

## Do not share private keys

Don't copy or share your private key. Generate a new key pair for every
user and every device. You can use the same key pair for multiple
destinations, though.

## Use SSH configuration

Add all your frequently used hosts to `~/.ssh/config`, like this:

    Host www
      User webmaster
      Hostname www.romanzolotarev.com
      IdentityFile /home/romanzolotarev/.ssh/id_ed25519

After adding this to your SSH configuration you can run `ssh www` instead
of `ssh -i ~/.ssh/id_ed25519 webmaster@www.romanzolotarev.com`. Neat.

It also helps you to manage your keys; it's a good practice to revoke your
keys and generate new ones from time to time.
