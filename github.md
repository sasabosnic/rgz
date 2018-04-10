# GitHub and the command line

Why use the command line? Okay, GitHub has a clean and straightforward
website, but when I'm in Terminal all day long, it's much easier to write
a function and put it into my `.bashrc` than switch to a web browser and
click buttons.

## Basic setup

First, make sure you have enabled [two-factor
authentication](https://github.com/settings/two_factor_authentication/configure)
for your GitHub account.

Then [generate SSH keys](/ssh/) and add your public key to [your profile
on GitHub](https://github.com/settings/keys) so you can connect to GitHub
via SSH. Test it right away.

```bash
ssh -T git@github.com
```

By the way, did you know GitHub makes your public key available via HTTPS?
Having your keys accessible is convenient, for example, when you're on one
of your remote servers.

```bash
touch ~/.ssh/authorized_keys
curl https://github.com/USERNAME.keys >> ~/.ssh/authorized_keys
```

## `hub`

If you work in Terminal most of the time, install
[hub](https://hub.github.com). It's a CLI tool made by GitHub that makes
it easier to use GitHub from the command line. With `hub` you can create
repositories, create pull requests, compare branches, etc.

To install it on macOS with [Homebrew](https://brew.sh) run:

```bash
brew install hub
```

As soon as you have `hub` you can do more things from the command line.

```bash
# Use short repository names, so...
hub clone dotfiles
# ...runs "git clone git://github.com/YOUR_USERNAME/dotfiles.git"

hub clone romanzolotarev/dotfiles
# git clone git://github.com/romanzolotarev/dotfiles.git

# Open the current repository in a web browser
hub browse

# Open the current repository's issues page
hub browse -- issues

# List the current repository's issues
hub issue

# Open a text editor for your pull request message
hub pull-request

# Open a compare view between two releases
hub compare v0.9..v1.0

# Create a repository with the name of the current directory
hub create
```

## API

[Explore the documentation](https://developer.github.com/v3/).

To parse the JSON from API responses, I suggest you install
[jq](https://stedolan.github.io/jq/).

```
brew install jq
```

Let's play with the `/user/keys` endpoint to see what's possible with the
GitHub API. For this endpoint you need your personal access token. Get one
on [your profile page](https://github.com/settings/tokens) or via command
line. To make the following examples work your token should be in the
`admin:public_key` scope.

## Get access token

Replace `USERNAME`, `OTP_CODE`, and `NOTE` with actual values:

```bash
curl -s https://api.github.com/authorizations \
  -H 'X-GitHub-OTP: OTP_CODE' \
  -u USERNAME \
  -d '{"scopes": ["admin:public_key"], "note": "NOTE"}' \
  | jq -r .token
```

In response you will receive your personal access token. [Treat it as
carefully as a password](/keychain/).

## List your public keys

You can now check your public keys via API. Replace `ACCESS_TOKEN` with
your personal access token:

```bash
curl -s https://api.github.com/user/keys \
  -H 'Authorization: token ACCESS_TOKEN' \
  | jq
```

## Add your public key

You can even add new public keys. Replace `ACCESS_TOKEN`, `TITLE`,
`PUBLIC_KEY` with actual values, where `PUBLIC_KEY` is a path to your
public SSH key:

```bash
curl -s https://api.github.com/user/keys \
  -H 'Authorization: token ACCESS_TOKEN' \
  -d "{\"title\": \"TITLE\", \"key\": \"$(cat PUBLIC_KEY)\"}" \
  | jq
```

## Delete your public key

To delete a key you need to get its `ID` at GitHub. Do not forget to
replace `ACCESS_TOKEN` and `ID` with actual values.

```bash
curl -X 'DELETE' https://api.github.com/user/keys/ID \
  -H 'Authorization: token ACCESS_TOKEN'
```

Happy curling.
