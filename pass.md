"zOMG! This is AWESOME! Great job, going to set this up first thing in the morning. &#x1F495;" <div class="quote"><a
href="https://mobile.twitter.com/h3artbl33d/status/983827387409403904"><img
src="/avatars/h3artbl33d.jpeg"
title="11 Apr 2018"
alt="H3artbl33d (@h3artbl33d)" class="quote__avatar"></a><span class="quote__name">
H3artbl33d (@h3artbl33d)</span></div>

# Password manager powered by LibreSSL

[pass](/bin/pass) is a POSIX-compliant shell script. It works on OpenBSD
and macOS out-of-the-box, because it depends only on the software in the
base (for example: sh, openssl, tar, grep, cat).

Frankly, it has one 3rd-party dependency, if you need time-based one-time
passwords. If that is the case you need to install
[oathtool(1)](http://www.nongnu.org/oath-toolkit/oathtool.1.html).

    # pkg_add oath-toolkit

Download and run `pass`. Assuming `./bin` is in `PATH`.

    $ cd bin
    $ ftp https://www.romanzolotarev.com/bin/pass
    $ chmod +x pass
    $ pass
    usage: export BASE_DIR=~/.pass
           export PRIVATE_KEY=~/.pass/.key
           export PUBLIC_KEY=~/.pass/.key.pub

           pass init
              | passphrase
              | add        id
              | import     id <pass>
              | show       id
              | export     id <pass>
              | ls        <id>

## Initialization

Create a directory for your passwords and generate your key pair.
Please pick [a strong master pass phrase](/diceware.html) for your keys.

    $ pass init
    Generating public/private key pair.
    New pass phrase:
    Confirm:
    Generating RSA private key, 2048 bit long modulus
    ..........................+++
    ..................+++
    e is 65537 (0x10001)
    writing RSA key
    $ ls -1 ~/.pass
    .key
    .key.pub
    $

Yep, as result you will get two files in `~/.pass` directory. These files are
your keys and they are protected with your master passphrase.

---

**Important!** Backup these files, you won't be able to recover any of
your passwords without the private key. Also make sure you remember your
pass phrase, there is no way to recover it either.

---

## Change pass phrase

You can always change the master pass phrase for your private key.

    $ pass passphrase
    Changing /home/romanzolotarev/.pass/.key pass phrase.
    Current pass phrase:
    New pass phrase:
    Confirm:
    Pass phrase changed.
    $

## Add a password

Ready for the next step? Let's add your first password. Run the following
command and enter your master pass phrase, then type-in the password and
hit Enter. In the second line type username and in the third line type
url. Press Enter and CTRL-D to save the password.

    $ pass add github
    Pass phrase:
    Press Enter and CTRL-D to complete.
    always mule boots jaguar agnostic singles dalmatian vixen
    username: romanzolotarev
    url: https://github.com
    $

## Import a password

Instead of typing your passwords manually you can pipe [your favorite password
generator](/diceware.html) right into `pass`.

    $ diceware | pass import twitter
    Enter pass phrase for /home/romanzolotarev/.pass/.key:
    $

## Edit the password

If you want to update your password run:

    $ pass edit github
    Enter pass phrase for /home/romanzolotarev/.pass/.key:

As soon as you enter the pass phrase `pass` opens `vi` with the content of
your password file. Let's enable [2FA at
GitHub](https://help.github.com/articles/providing-your-2fa-authentication-code/)
paste the TOTP seed from GitHub into the password file. For example:

    totp: fx33dwhsbw7esrda

When you're done press `ZZ` to save and exit `vi`.

## Show the password

To show a password you can run:

    $ pass show twitter
    pelican mule satchel headband yo-yo lemon luscious older
    $

But if a password file has a line staring with `totp:`, then `pass` shows
one time password in the second line.

    $ pass show github
    Enter pass phrase for /home/romanzolotarev/.pass/.key:
    always mule boots jaguar agnostic singles dalmatian vixen
    122635
    $

## Export the password

If you want to see all lines of your password file, you can use `export`

    $ pass export github
    always mule boots jaguar agnostic singles dalmatian vixen
    username: romanzolotarev
    url: https://github.com
    $

## List all passwords

To list all your passwords run:

    $ pass ls
    github
    twitter
    $

## Files

    .pass
    |-- .key           - RSA private key protected by pass phrase
    |-- .key.pub       - RSA public key
    |-- github         - tar archive of two files:
    |   |-- github.key - AES key encrypted with RSA public key
    |   `-- github.enc - text file encrypted with AES key
    |-- github.sig     - signature of tar archive created with
    |                    RSA private key

Every time you change your password file `pass` generates tar archive with
a new AES key and a new signature. `pass` verifies the signature every
time you show or export the password.

## Environment variables

To change path to the working directory or your keys, define
environment variables `BASE_DIR`, `PRIVATE_KEY`, `PUBLIC_KEY`. For example:

    $ BASE_DIR=~/.pass \
    PRIVATE_KEY=~/.pass/.key \
    PUBLIC_KEY=~/.pass/.key.pub pass init
    ...

## Completions in Korn shell

If you run `pass` on OpenBSD you may want to add completions in
[ksh(1)](https://man.openbsd.org/ksh.1)---its default shell. Add these
functions to your `~/.profile`:

    update_complete_pass() {
      pass_list=$(pass ls)
      set -A complete_pass_edit -- $pass_list
      set -A complete_pass_export -- $pass_list
      set -A complete_pass_show -- $pass_list
    }
    update_complete_pass
    pass_edit() { pass edit "$1"; }
    pass_export() { pass export "$1" && update_complete_pass; }
    pass_show() { pass show "$1" && update_complete_pass; }


Now open a terminal or source `~/.profile` and try `pass`:

    $ pass <Tab>
    init  passphrase  add  import  show  export  ls

Or most importantly try `pass_show`:

    $ pass_show twit<Tab>
    twitch  twitter
