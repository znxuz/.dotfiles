#!/usr/bin/env sh

function setup_dotfiles()
{
	src=$HOME/dotfiles.tmp
	git clone --separate-git-dir=$HOME/.dotfiles \
		git@github.com:zijian-x/.dotfiles.git $src &&
		find $src -maxdepth 1 -not -path $src \
		-exec mv -f {} $HOME \; && rmdir $src &&
		git --git-dir=$HOME/.dotfiles --work-tree=$HOME	\
		config --local status.showUntrackedFiles no
}

function setup_poly_bat()
{
	# poly-bat module via udev rule
	[ ! -f /etc/udev/rules.d/95-battery.rules ] &&
		sudo cp ~/.scripts/polybar/95-battery.rules /etc/udev/rules.d/
}

function symlink_etc_conf()
{
	find ~/.config/etc -type f -exec sudo ln -sf {} /etc \;
}

setup_dotfiles &&
	setup_poly_bat &&
	symlink_etc_conf
