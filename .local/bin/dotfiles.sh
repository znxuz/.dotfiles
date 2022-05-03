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

    symlink_etc_conf()
    {
	[ ! -f /etc/udev/rules.d/95-battery.rules ] &&
	    sudo cp ~/.local/bin/polybar/95-battery.rules /etc/udev/rules.d/

	path="$HOME/.config/etc"
	configs=$(find "$path" -type f)
	for src in $configs; do
	    target="$(echo "$src" | sed "s;$HOME/.config;;")"
	    echo "=> symlink "$src" to "$target""
	    sudo ln -sf "$src" "$target"
	done
    }

    setup_dotfiles && symlink_etc_conf
