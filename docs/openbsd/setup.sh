#!/bin/sh

mirror='https://fastly.cdn.openbsd.org/pub/OpenBSD'
default_user='romanzolotarev'
backup_drive='/mnt/sd2a'

##########################################################################
#
# BASE

echo /etc/installurl
echo "$mirror" | tee /etc/installurl

echo 'Run syspatch'
syspatch

echo /etc/fstab
# cp /etc/fstab /etc/fstab.bak
# sed -i 's/rw,softdep,noatime/rw/;s/rw/rw,softdep,noatime/' /etc/fstab
# diff -d /etc/fstab.bak /etc/fstab

echo /etc/login.conf
# cp /etc/login.conf /etc/login.conf.bak
# sed -i 's/datasize-max=4096M/datasize-max=768M/;s/datasize-cur=4096M/datasize-cur=768M/;s/datasize-max=768M/datasize-max=4096M/;s/datasize-cur=768M/datasize-cur=4096M/' /etc/login.conf
# diff -d /etc/login.conf.bak /etc/login.conf

echo /etc/doas.conf
# echo "permit nopass $default_user" | tee /etc/doas.conf


# export PKG_CACHE="/home/$default_user/pub/OpenBSD/6.3/packages/amd64"

##########################################################################
#
# PACKAGES

# ftp -o '/tmp/pkgs' https://www.romanzolotarev.com/openbsd/pkgs

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
# bundle install --path ~/.gem

# NODE
# npm install --global

##########################################################################
#
# BORG

BORG_REPO="$backup_drive/$(hostname -s)"
LANG=en_US.UTF-8
export BORG_REPO LANG

archive=$(borg list ::|tail -n1|cut -f1 -d' ')
borg extract -v --list "::$archive"

##########################################################################
#
# DOTFILES

# dotfiles="/home/$default_user/src/romanzolotarev.com"
# mkdir -p "$dotfiles"
echo 'Clone and setup dotfiles'

# git clone "git@github.com:$default_user/romanzolotarev.github.io" "$src/romanzolotarev.com"
# ln -fs "$src/openbsd/Xdefaults" "/home/$default_user/.Xdefaults"
# ln -fs "$src/openbsd/cwmrc" "/home/$default_user/.cwmrc"
# ln -fs "$src/openbsd/gitconfig" "/home/$default_user/.gitconfig"
# ln -fs "$src/openbsd/gitignore" "/home/$default_user/.gitignore"
# ln -fs "$src/openbsd/gitprompt" "/home/$default_user/.gitprompt"
# ln -fs "$src/openbsd/profile" "/home/$default_user/.profile"
# ln -fs "$src/openbsd/tmux.conf" "/home/$default_user/.tmux.conf"
# ln -fs "$src/openbsd/user-dirs.dirs" "/home/$default_user/.config/user-dirs.dirs"
# ln -fs "$src/openbsd/xinitrc" "/home/$default_user/.xinitrc"

# ln -fs "$src/bin" "/home/$default_user/bin"
# ln -fs "$src/pass" "/home/$default_user/.pass"

##########################################################################
#
# VIM

# mkdir -p "/home/$default_user/.vim/undo"
# mkdir -p "/home/$default_user/.vim/autoload"
# ftp -o "/home/$default_user/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# ln -fs "$src/openbsd/vimrc" "/home/$default_user/.vim/vimrc"
# doas -u "$default_user" vim +PlugInstall

##########################################################################
#
# EXTRACT BACKUP

chown -R $default_user:$default_user "/home/$default_user"
echo "Done. Please reboot and login as $default_user."
