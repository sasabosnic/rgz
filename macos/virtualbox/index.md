_Tested on [macOS](/macos/) 10.13. [GUI version?](manual.html)_

# Install VirtualBox on macOS

[Install Homebrew](/macos/brew.html).

Install _virtualbox_ package:

<pre>
$ <b>brew cask install virtualbox</b>
==> Caveats
To install and/or use virtualbox you may need to enable their kernel
extension in

  System Preferences -> Security & Privacy -> General
...
==> Downloading https://download.../VirtualBox-5.2.16-123759-OSX.dmg
############################################################### 100.0%
==> Verifying checksum for Cask virtualbox
==> Installing Cask virtualbox
==> Purging files for version 5.2.16,123759 of Cask virtualbox
==> Running installer for virtualbox; your password may be necessary.
installer: Package name is Oracle VM VirtualBox
installer: Installing at base path /
installer: The install was successful.
&#x1F37A;  virtualbox was successfully installed!
$
</pre>

## Uninstall

<pre>
$ <b>brew cask uninstall virtualbox</b>
$ <b>brew cask cleanup</b>
$
</pre>
