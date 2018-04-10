# Manage passwords with shell and LibreSSL


`crypt` is a POSIX shell script. It works on OpenBSD and macOS
out-of-the-box, because it depends only on the software in the base (sh,
openssl, tar, grep, cat, etc).

## Install dependencies (optional)

It has only one 3rd-party dependency. For TOTP you need to install
[oathtool(1)](http://www.nongnu.org/oath-toolkit/oathtool.1.html).

    # pkg_add oath-toolkit

## Usage

## File format

- RSA private key protected by the master passphrase
- RSA public key
- password is tar archive
  - encrypted key file for AES encryption
  - encrypted (AES) text file with a secret (username, password, url, etc)

## Install

Download and run [crypt](/bin/crypt):

    $ curl -O https://www.romanzolotarev.com/bin/crypt
    $ ./crypt
    $
