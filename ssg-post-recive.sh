#!/bin/sh
TMPDIR="$(mktemp -d)"
git clone --depth 1 . "$TMPDIR/repo"
cd "$TMPDIR/repo" &&
  DOCS='/var/www/htdocs/www.romanzolotarev.com' /home/git/ssg build --clean
cd &&
  rm -rf "$TMPDIR"
