_Tested on [macOS](/macos/) 10.13_

# Manage passwords with security(1) on macOS

Add a password to the default keychain:

<pre>
$ <b>security add-generic-password -a ${USER} -s NAME -w</b>
</pre>

Retrieve the password:

<pre>
$ <b>security find-generic-password -a ${USER} -s NAME -w</b>
</pre>

Delete the password:

<pre>
$ <b>security delete-generic-password -a ${USER} -s NAME</b>
</pre>
