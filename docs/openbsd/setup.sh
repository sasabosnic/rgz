#!/bin/sh
set -x
mirror='https://cloudflare.cdn.openbsd.org/pub/OpenBSD'
backup_drive='/mnt/sd2a'

cp /etc/fstab /etc/fstab.bak
sed -i 's/rw,softdep,noatime/rw/;s/rw/rw,softdep,noatime/' /etc/fstab
diff -d /etc/fstab.bak /etc/fstab

cp /etc/login.conf /etc/login.conf.bak
sed -i 's/datasize-max=4096M/datasize-max=768M/;s/datasize-cur=4096M/datasize-cur=768M/;s/datasize-max=768M/datasize-max=4096M/;s/datasize-cur=768M/datasize-cur=4096M/' /etc/login.conf
diff -d /etc/login.conf.bak /etc/login.conf

echo 'permit nopass romanzolotarev' | tee /etc/doas.conf

##########################################################################
#
# PACKAGES

echo /etc/installurl
echo "$mirror" | tee /etc/installurl

echo 'Run syspatch'
syspatch

ftp -o '/tmp/pkgs' https://www.romanzolotarev.com/openbsd/pkgs
export PKG_CACHE='/home/romanzolotarev/pub/OpenBSD/6.3/packages/amd64'
mkdir -p "$PKG_CACHE"
pkg_add -l '/tmp/pkgs'

# PYTHON
ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3
ln -sf /usr/local/bin/python2.7-config /usr/local/bin/python-config
ln -sf /usr/local/bin/pydoc2.7  /usr/local/bin/pydoc
ln -sf /usr/local/bin/pip2.7 /usr/local/bin/pip
pip install --upgrade pip
pip install vim-vint

# RUBY
ln -sf /usr/local/bin/ruby25 /usr/local/bin/ruby
ln -sf /usr/local/bin/erb25 /usr/local/bin/erb
ln -sf /usr/local/bin/irb25 /usr/local/bin/irb
ln -sf /usr/local/bin/rdoc25 /usr/local/bin/rdoc
ln -sf /usr/local/bin/ri25 /usr/local/bin/ri
ln -sf /usr/local/bin/rake25 /usr/local/bin/rake
ln -sf /usr/local/bin/gem25 /usr/local/bin/gem

doas -u romanzolotarev gem install --user-install bundler
doas -u romanzolotarev ln -sf "$HOME/.gem/ruby/2.5/bin/bundler25" "$HOME/.gem/ruby/2.5/bin/bundler"
bundle install --path ~/.gem

# NODE
npm install --global npm

##########################################################################
#
# BORG

BORG_REPO="$backup_drive/$(hostname -s)"
LANG=en_US.UTF-8
export BORG_REPO LANG

archive=$(borg list ::|tail -n1|cut -f1 -d' ')
borg extract -v --list "::$archive"

chown -R romanzolotarev:romanzolotarev '/home/romanzolotarev'
echo 'Done. Please reboot and login as romanzolotarev.'
