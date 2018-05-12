#!/bin/sh

for file in \
  Xdefaults \
  cwmrc     \
  exrc      \
  forward   \
  gitconfig \
  profile   \
  tmux.conf \
  xsession  \
; do
  ln -fs "$HOME/src/www/openbsd/$file" "$HOME/.${file}"
done

ln -fsh "$HOME/src/www/bin" "$HOME/bin"
ln -fs  "$HOME/src/www/openbsd/newsboat.conf" "$HOME/.newsboat/config"
ln -fs  "$HOME/src/www/blogroll.txt" "$HOME/.newsboat/urls"
ln -fs  "$HOME/src/www/openbsd/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"
ln -fsh "$HOME/src/ssh" "$HOME/.ssh"
ln -fsh "$HOME/src/pass" "$HOME/.pass"
