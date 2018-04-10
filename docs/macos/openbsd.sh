#!/bin/sh
set -e

drive='/dev/disk2'
fs='install63.fs'
src='https://fastly.cdn.openbsd.org/pub/OpenBSD/6.3/amd64'
dst="$HOME/Downloads/pub/OpenBSD/6.3/amd64"

mkdir -p "$dst"
cd "$dst"

curl -O "$src/SHA256"
curl -O "$src/$fs"

a=$(grep "$fs"<"$dst/SHA256"|cut -f4 -d' ')
b=$(shasum -a 256 "$dst/$fs"|cut -f1 -d' ')

if [ "$a" = "$b" ]; then
  echo "DANGER! All data on $drive will be erased. Press CTRL-C to cancel."
  read -r
  echo "sudo dd if=\"$dst/$fs\" of=\"$drive\" bs=1m"
  sudo dd if="$dst/$fs" of="$drive" bs=1m
else
  echo "$a SHA256"
  echo "$b $fs"
  echo 'Checksum mismatch.'
fi
