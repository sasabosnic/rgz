# SSH keys

If you are using short DSA or RSA keys, it's time to generate new ones. It
only takes few minutes.

Elliptic Curve Cryptography was implemented in OpenSSH in 2011. It is safe
to assume that ECC is supported by major operating systems today. Consider
upgrading your SSH keys to ECC: the generated keys are smaller, the
algorithm is faster, and the analysis hasn't shown any weaknesses, unlike
traditional RSA or DSA.

## Recipe

Run this command to generate your new SSH key pair.

    $ ssh-keygen \
      -t ed25519 \
      -o \
      -a 100 \
      -f ~/.ssh/key \
      -C 'key'

Then enter your passphrase twice. Use a strong passphrase. To protect your
private key, use a strong passphrase. [A few random common words should
work](/diceware/).

Your public key will be placed into `~/.ssh/key.pub`.

Done!

Let me clarify those options. For better security, we used Ed25519 keys
with the `-t ed25519` option. To increase resistance to brute-force
password checking we used the new OpenSSH format (`-o`) and a hundred
rounds of the key derivation function (`-a 100`). We specified a path to
the new file with `-f ~/.ssh/key` and added a comment to your public key
with `-C 'key'`.

---

There are some simple guidelines to ensure your keys are as secure as
possible.

## Fallback

If Ed25519 does not work, you can use long RSA keys as a fallback.

    $ ssh-keygen -t rsa -b 4096 -o -a 100 -f ~/.ssh/key -C 'key'


## Do not share private keys

Don't copy or share your private key. Generate a new key pair for every
user and every device. You can use the same key pair for multiple
destinations, though. Add this function to your `~/.bashrc`:

    generate_ssh_key() {
      local id
      id=$(date +%s)
      ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/"$id" -C "$id"
    }

Then the next time you need a new key, run `generate_ssh_key`.

## Use SSH configuration

Add all your frequently used hosts to `~/.ssh/config`, like this:

    Host rz
      User webmaster
      Hostname romanzolotarev.com
      IdentityFile /home/romanzolotarev/.ssh/key

After adding this to your SSH configuration you can run `ssh rz` instead
of `ssh -i ~/.ssh/key webmaster@romanzolotarev.com`. Neat.

It also helps you to manage your keys; it's a good idea to revoke your
keys and generate new ones from time to time.
