#!/usr/bin/env sh

setup_dotfiles()
{
	src=$HOME/dotfiles.tmp
	git clone --separate-git-dir=$HOME/.dotfiles \
		git@github.com:zijian-x/.dotfiles.git $src &&
		find $src -maxdepth 1 -not -path $src \
		-exec mv -f {} $HOME \; && rmdir $src &&
		git --git-dir=$HOME/.dotfiles --work-tree=$HOME	\
		config --local status.showUntrackedFiles no
}

setup_poly_bat()
{
	# poly-bat module via udev rule
	[ ! -f /etc/udev/rules.d/95-battery.rules ] &&
		sudo cp ~/.scripts/polybar/95-battery.rules /etc/udev/rules.d/
}

symlink_etc_conf()
{
	find ~/.config/etc -type f -exec sudo ln -sf {} /etc \;
}

pkg_install()
{
	sudo pacman -Syyy archlinux-keyring &&
		sudo pacman -Syu --needed - < $HOME/.config/misc/Qqen

	aur=$HOME/aur

	git clone git@github.com:zijian-x/aur.git $aur &&
		git -C $aur submodule update --init

	pkgs="$(find $aur -maxdepth 1 -type d -not -path '*.git' -and -not -path $aur)"
	for pkg in ${pkgs[@]}; do
		git -C "$pkg" checkout master && aur-build "$pkg"
	done
}

setup_dotfiles &&
	setup_poly_bat &&
	symlink_etc_conf &&
	pkg_install
