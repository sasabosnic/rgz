# Use GitHub from your command line

Why use the command line? Okay, GitHub has a clean and straightforward
website, but when I'm in Terminal all day long, it's much easier to write
a function and put it into my `.bashrc` than switch to a web browser and
click buttons.

## Basic setup

First, make sure you have enabled [two-factor
authentication](https://github.com/settings/two_factor_authentication/configure)
for your GitHub account.

Then [generate SSH keys](/ssh.html) and add your public key to [your profile
on GitHub](https://github.com/settings/keys) so you can connect to GitHub
via SSH. Test it right away.

    $ ssh -T git@github.com

By the way, did you know GitHub makes your public key available via HTTPS?
Having your keys accessible is convenient, for example, when you're on one
of your remote servers.

    $ curl https://github.com/USERNAME.keys >> ~/.ssh/authorized_keys

## API

[Explore the documentation](https://developer.github.com/v3/).

To parse the JSON from API responses, I suggest to install
[jq](https://stedolan.github.io/jq/).

Let's play with the `/user/keys` endpoint to see what's possible with the
GitHub API. For this endpoint you need your personal access token. Get one
on [your profile page](https://github.com/settings/tokens) or via command
line. To make the following examples work your token should be in the
`admin:public_key` scope.

## Get access token

Replace `USERNAME`, `OTP_CODE`, and `NOTE` with actual values:

    $ curl -s https://api.github.com/authorizations \
    -H 'X-GitHub-OTP: OTP_CODE' \
    -u USERNAME \
    -d '{"scopes": ["admin:public_key"], "note": "NOTE"}' |
    jq -r .token

In response you will receive your personal access token. [Treat it as
carefully as a password](/pass.html).

## List your public keys

You can now check your public keys via API. Replace `ACCESS_TOKEN` with
your personal access token:

    $ curl -s https://api.github.com/user/keys \
    -H 'Authorization: token ACCESS_TOKEN' |
    jq

## Add your public key

You can even add new public keys. Replace `ACCESS_TOKEN`, `TITLE`,
`PUBLIC_KEY` with actual values, where `PUBLIC_KEY` is a path to your
public SSH key:

    $ curl -s https://api.github.com/user/keys \
    -H 'Authorization: token ACCESS_TOKEN' \
    -d "{\"title\": \"TITLE\", \"key\": \"$(cat PUBLIC_KEY)\"}" |
    jq

## Delete your public key

To delete a key you need to get its `ID` at GitHub. Do not forget to
replace `ACCESS_TOKEN` and `ID` with actual values.

    $ curl -X 'DELETE' https://api.github.com/user/keys/ID \
    -H 'Authorization: token ACCESS_TOKEN'

Happy curling.

_Tested on macOS 10.13_
