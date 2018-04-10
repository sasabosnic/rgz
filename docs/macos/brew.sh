#!/usr/bin/env bash
set -e

if brew --version &>/dev/null; then
  echo 'Homebrew has been installed.'
  echo 'Running brew doctor...'
  brew update && brew doctor
else
  echo 'Installing Homebrew...'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Install formulas...'
brew tap osx-cross/avr

brew install \
  ag \
  aria2 \
  avr-libc \
  bash \
  bash-completion \
  dfu-programmer \
  duti \
  fzf \
  git \
  graphviz \
  gpg \
  hub \
  jq \
  mas \
  proselint \
  reattach-to-user-namespace \
  ruby \
  sqlite3 \
  python \
  shellcheck \
  teensy_loader_cli \
  tmux doxygen \
  youtube-dl

echo 'Installing apps via cask...'
brew tap caskroom/cask
brew tap caskroom/fonts

for app in \
  'arq' \
  'font-fira-code' \
  'github-desktop' \
  'google-chrome' \
  'imageoptim' \
  'skype' \
  'vlc'; do
  brew cask install ${app}
done

echo 'Cleaning up...'
brew cask cleanup
brew cleanup
brew doctor

sudo echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash
