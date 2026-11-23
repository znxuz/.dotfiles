if [[ -e /run/.toolboxenv ]]; then
	source /usr/share/doc/fzf/examples/key-bindings.zsh
else
	source /usr/share/fzf/key-bindings.zsh
fi

# reset defaults
stty -ixon
bindkey -r '^g' # fzf prefix key

# remap fzf defaults
bindkey -r '^T'; bindkey '^gs' fzf-file-widget
bindkey -r '\ec'; bindkey '^gt' fzf-cd-widget

cd-fzf() {
	local ret="$(fd -td -H -L \
		--search-path $1 -0 | fzf --scheme=path --read0 \
		--preview='tree -L 1 {}' --bind='ctrl-space:toggle-preview' \
		--preview-window=:hidden)"

	[[ ! -z "$ret" ]] && cd "$ret"
	vcs_info
	zle reset-prompt
}
cd-fzf-home() { cd-fzf "$HOME" }
zle -N cd-fzf-home && bindkey '^gT' cd-fzf-home

find-fzf() {
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
fzf-home() { find-fzf $HOME }
zle -N fzf-home && bindkey '^gS' fzf-home

lpac() {
	local ret="$(pacman -Qq | fzf -m --preview='pacman -Qi {}' | tr '\n' ' ')"

	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N lpac && bindkey '^gp' lpac

rpac() {
	local ret="$(pacman -Sql | fzf -m --preview='pacman -Si {}' | tr '\n' ' ')"

	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N rpac && bindkey '^gP' rpac

apac() {
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

	local ret="$(zcat "$aur_list" | fzf -m --preview="yay -Si {}" | tr '\n' ' ')"
	LBUFFER=${LBUFFER}${ret}
	zle reset-prompt
}
zle -N apac && bindkey '^g^p' apac

git-branch-local() {
	local branch
	branch=$(git branch --format="%(refname:short)" 2>/dev/null | fzf)
	[[ -n "$branch" ]] && LBUFFER+="${(q)branch}"
	zle reset-prompt
}
zle -N git-branch-local && bindkey '^gb' git-branch-local

git-branch-remote() {
	local branch
	branch=$(git branch -r --format="%(refname:short)" 2>/dev/null | fzf)
	[[ -n "$branch" ]] && LBUFFER+="${(q)branch/origin\//}"
	zle reset-prompt
}
zle -N git-branch-remote && bindkey '^gB' git-branch-remote
