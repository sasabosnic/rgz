#!/usr/bin/env bash
set -e

if node -v &>/dev/null; then
  echo 'Node has been installed.'
else
  echo 'Installing Node...'
  brew install node@6
fi

echo 'Install modules globally...'
npm -g install \
  elm \
  elm-oracle \
  elm-test \
  jsonlint \
  prettier \
  remark \
  speed-test
