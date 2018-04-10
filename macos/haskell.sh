#!/usr/bin/env bash
set -e

if ghc --version &>/dev/null; then
  echo 'Haskell has been installed.'
else
  echo 'Installing Haskell...'
  brew cask install haskell-platform
fi
cabal update
cabal install stack
stack setup
stack install \
  ghc-mod \
  hdevtools \
  hindent \
  hlint

echo -e "\033[33mstackconfig.yaml\033[m -> \033[32m.stack/config.yaml\033[0m"
ln -Fhis "${PWD}/stackconfig.yaml" "${HOME}/.stack/config.yaml"
