#!/bin/sh
set -x

HOME='/home/romanzolotarev'
# git clone git@github.com:romanzolotarev/romanzolotarev.com "$HOME/src/www"

for file in \
  Xdefaults \
  cwmrc     \
  gitconfig \
  gitignore \
  profile   \
  tmux.conf \
  xinitrc   \
; do
  ln -fs "$HOME/src/www/openbsd/$file" "$HOME/.${file}"
done

ln -fsh "$HOME/src/www/bin" "$HOME/bin"
ln -fs  "$HOME/src/www/openbsd/newsboat.conf" "$HOME/.newsboat/config"
ln -fs  "$HOME/src/www/blogroll.txt" "$HOME/.newsboat/urls"
ln -fs  "$HOME/src/www/openbsd/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

# Link private 

ln -fsh "$HOME/src/ssh" "$HOME/.ssh"
ln -fsh "$HOME/src/pass" "$HOME/.pass"

# Configure Vim and install plugins

ln -fs "$HOME/src/www/openbsd/vimrc" "$HOME/.vim/vimrc"
mkdir -p "/home/romanzolotarev/.vim/undo"
mkdir -p "/home/romanzolotarev/.vim/autoload"
ftp -o "/home/romanzolotarev/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
