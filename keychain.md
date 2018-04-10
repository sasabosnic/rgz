# macOS Keychain

As a developer, you're juggling many API keys and access tokens. Where
can you store them securely?

You can store arbitrary keys or tokens in the keychain built in to MacOS.
This solution only works on Macs, but it works out of the box on any Mac.

## Security for rescue

`security` is a built-in command line interface to keychains and the
Security framework. To add a password to the default keychain, run:

```bash
security add-generic-password -a ${USER} -s NAME -w
```

You have to specify your account name with `-a` and the service name with
`-s`. If you put `-w` at the end of the command you'll be prompted to
enter the password.

To retrieve a password use:

```bash
security find-generic-password -a ${USER} -s NAME -w
```

You can delete the password anytime:

```bash
security delete-generic-password -a ${USER} -s NAME
```

## Use with a GitHub access token

Let's use GitHub as an example. Add these functions to your `~/.bashrc`

```bash
function get_github_access_token () {
  local token
  token=$(curl -s https://api.github.com/authorizations \
      -H "X-GitHub-OTP: ${1}" \
      -u "${USER}" \
      -d "{\"scopes\": [\"admin:public_key\"], \"note\": \"$(hostname)-$(date +%s)\"}" \
      | jq -r .token)
  security delete-generic-password -a "${USER}" -s GitHub
  security add-generic-password -a "${USER}" -s GitHub -w "$token"
}

function add_ssh_key_to_github () {
  curl -s https://api.github.com/user/keys \
    -H "Authorization: token $(security find-generic-password -a "${USER}" -s GitHub -w)" \
    -d "{\"title\": \"$(date +%s)\", \"key\": \"$(cat "$1")\"}"
}

function list_github_ssh_keys () {
  curl -s https://api.github.com/user/keys \
    -H "Authorization: token $(security find-generic-password -a "${USER}" -s GitHub -w)" \
    | jq 'map({title: .title, key:.key})'
}
```

Then call `get_github_access_token` function with your GitHub OTP code as
an argument, assuming you have enabled two-factor authentication for your
GitHub account. For example:

```bash
get_github_access_token XXXXXX
```

Enter your GitHub password and `security` will add the new GitHub access
token to your keychain.

[Generate your SSH key pair first](/ssh/). To add your public SSH key run
this command:

```bash
add_ssh_key_to_github ~/.ssh/key.pub
```

Later you can list the SSH keys associated with your GitHub account:

```bash
list_github_ssh_keys
```

To learn more, read the `security` man page:

```bash
man security
```
