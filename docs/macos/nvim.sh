#!/usr/bin/env bash
set -e
echo -e "You are about to replace \e[33m~/.config/nvim\e[0m"
echo 'Sure?'
read -r

brew install neovim
rm -rf "$HOME/.config/nvim" && mkdir "$HOME/.config/nvim" && mkdir "$HOME/.config/nvim/undo"
curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -fs "$PWD/nvimrc" "$HOME/.config/nvim/init.vim"
nvim +PlugInstall
