#!/usr/bin/env bash

setup_dotfiles()
{
    [ -d $HOME/.dotfiles ] && echo "dotfiles already exist" && return
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
	dir="$(dirname "$target")"
	[ ! -d "$dir" ] && sudo mkdir "$dir" &&
	    echo "=> mkdir $dir"
	echo "=> force symlink $src to $target"
	sudo ln -sf "$src" "$target"
    done
}

read -rp "Setup dotfiles? (y|n)?: " ret
[[  -n "$ret" && "$ret" =~ [N|n] ]] && setup_dotfiles

read -rp "Setup symlinks? (y|n)?: " ret
[[  -n "$ret" && "$ret" =~ [N|n] ]] && symlink_etc_conf
