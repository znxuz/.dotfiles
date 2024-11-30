source /usr/share/fzf/key-bindings.zsh

# reset defaults

stty -ixon
bindkey -r '^T'; bindkey '^s' fzf-file-widget
bindkey -r '\ec'; bindkey '^t' fzf-cd-widget

cd_fzf()
{
	local ret="$(fd -td -u -L \
		--search-path $1 -0 | fzf --read0 --preview="tree -L 1 {}" \
		--bind="ctrl-space:toggle-preview" --preview-window=:hidden)"

	[[ ! -z "$ret" ]] && cd "$ret"
	vcs_info
	zle reset-prompt
}

cd_fzf_home() { cd_fzf "$HOME" }

zle -N cd_fzf_home && bindkey '^[^t' cd_fzf_home

find_fzf()
{
	[[ -z $1 ]] && exit 1
	local ret="$(fd -H --search-path $1 -0 | fzf --read0 -m)"
	if [[ -n "$ret" ]]; then
		echo "$ret" | while read -r elem; do
		elem="$(printf "%q " "$elem")"
		LBUFFER=${LBUFFER}${elem}
	done
	fi
	zle reset-prompt
}

fzf_home() { find_fzf $HOME }

zle -N fzf_home && bindkey '^[^s' fzf_home

rpac()
{
	local ret="$(pacman -Sql | fzf -m --preview='pacman -Si {}' | tr '\n' ' ')"

	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N rpac && bindkey '^[^r' rpac

lpac()
{
	local ret="$(pacman -Qq | fzf -m --preview='pacman -Qi {}' | tr '\n' ' ')"

	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N lpac && bindkey '^[^l' lpac

apac()
{
	aur_list="/tmp/packages.gz"

	if [[ ! -f "$aur_list" ]]; then
		curl -s "https://aur.archlinux.org/packages.gz" > "$aur_list" ||
			return 1
	else
		now=$(date +"%s")
		pkg_time=$(stat -c "%Y" "$aur_list")
		diff=$(( now - pkg_time ))
		if [[ $diff -gt 86400 ]]; then
			rm "$aur_list" &&
				curl -s "https://aur.archlinux.org/packages.gz" > "$aur_list" ||
				return 1
		fi
	fi

	local ret="$(zcat "$aur_list" | fzf -m --preview="paru -Si {}" | tr '\n' ' ')"

	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N apac && bindkey '^[^a' apac
