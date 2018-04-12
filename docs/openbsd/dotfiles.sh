#!/bin/sh
set -x

HOME='/home/romanzolotarev'
# git clone git@github.com:romanzolotarev/romanzolotarev.com "$HOME/src/rz"

for file in \
  Xdefaults \
  cwmrc     \
  gitconfig \
  gitignore \
  profile   \
  tmux.conf \
  xinitrc   \
; do
  ln -fs "$HOME/src/rz/openbsd/$file" "$HOME/.${file}"
done

ln -fs "$HOME/src/rz/bin" "$HOME/bin"
ln -fs "$HOME/src/rz/openbsd/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"

# Link private 

ln -fs "$HOME/src/ssh" "$HOME/.ssh"
ln -fs "$HOME/src/pass" "$HOME/.pass"

# Configure Vim and install plugins

ln -fs "$HOME/src/rz/openbsd/vimrc" "$HOME/.vim/vimrc"
mkdir -p "/home/romanzolotarev/.vim/undo"
mkdir -p "/home/romanzolotarev/.vim/autoload"
ftp -o "/home/romanzolotarev/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
