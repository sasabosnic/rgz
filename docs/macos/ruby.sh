#!/usr/bin/env bash
set -e
brew install ruby
brew cleanup
/usr/local/bin/gem update --no-document
/usr/local/bin/gem install --no-document \
  bundler \
  mdl

/usr/local/bin/gem cleanup
