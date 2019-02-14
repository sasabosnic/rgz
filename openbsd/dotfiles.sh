#!/bin/sh
set -x

ln -fsh	"$HOME/src/rgz/bin"			"$HOME/bin"
ln -fsh	"$HOME/prv/pass"			"$HOME/.pass"
ln -fsh	"$HOME/prv/ssh"				"$HOME/.ssh"

ln -fs	"$HOME/src/rgz/openbsd/Xdefaults"	"$HOME/.Xdefaults"
ln -fs	"$HOME/src/rgz/openbsd/cwmrc"		"$HOME/.cwmrc"
ln -fs	"$HOME/src/rgz/openbsd/exrc"		"$HOME/.exrc"
ln -fs	"$HOME/src/rgz/openbsd/gitconfig"	"$HOME/.gitconfig"
ln -fs	"$HOME/src/rgz/openbsd/profile"		"$HOME/.profile"
ln -fs	"$HOME/src/rgz/openbsd/tmux.conf"	"$HOME/.tmux.conf"
ln -fs	"$HOME/src/rgz/openbsd/xsession"	"$HOME/.xsession"

mkdir -p "$HOME/.config/"
ln -fs	"$HOME/src/rgz/openbsd/user-dirs.dirs"	"$HOME/.config/user-dirs.dirs"

mkdir -p "$HOME/.config/newsboat"
ln -fs	"$HOME/src/rgz/blogroll.txt"		"$HOME/.config/newsboat/urls"
ln -fs	"$HOME/src/rgz/openbsd/newsboat.conf"	"$HOME/.config/newsboat/config"
