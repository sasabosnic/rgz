#!/bin/sh
set -x

ln -fs	"$HOME/src/www/blogroll.txt"		"$HOME/.config/newsboat/urls"
ln -fs	"$HOME/src/www/openbsd/Xdefaults"	"$HOME/.Xdefaults"
ln -fs	"$HOME/src/www/openbsd/cwmrc"		"$HOME/.cwmrc"
ln -fs	"$HOME/src/www/openbsd/exrc"		"$HOME/.exrc"
ln -fs	"$HOME/src/www/openbsd/gitconfig"	"$HOME/.gitconfig"
ln -fs	"$HOME/src/www/openbsd/newsboat.conf"	"$HOME/.config/newsboat/config"
ln -fs	"$HOME/src/www/openbsd/profile"		"$HOME/.profile"
ln -fs	"$HOME/src/www/openbsd/tmux.conf"	"$HOME/.tmux.conf"
ln -fs	"$HOME/src/www/openbsd/user-dirs.dirs"	"$HOME/.config/user-dirs.dirs"
ln -fs	"$HOME/src/www/openbsd/xsession"	"$HOME/.xsession"
ln -fsh	"$HOME/src/www/bin"			"$HOME/bin"

ln -fsh	"$HOME/prv/pass"			"$HOME/.pass"
ln -fsh	"$HOME/prv/ssh"				"$HOME/.ssh"
