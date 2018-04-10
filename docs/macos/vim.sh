#!/usr/bin/env bash
set -e
echo -e "You are about to replace \\e[33m~/.vim\\e[0m"
echo 'Sure?'
read -r

brew install vim --with-lua
rm -rf "$HOME/.vim" && mkdir "$HOME/.vim" && mkdir "$HOME/.vim/undo"
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -fs "$PWD/../vimrc" "$HOME/.vim/vimrc"
vim +PlugInstall
