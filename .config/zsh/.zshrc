# zmodload zsh/zprof

KEYTIMEOUT=1
bindkey -e # emacs keybinds; also resets all bindkeys

# misc

setopt globdots rmstarsilent extendedglob
unsetopt beep # prompt_cr prompt_sp

autoload edit-command-line &&
	zle -N edit-command-line &&
	bindkey '^x^e' edit-command-line

# prompt

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats ' %F{magenta}[%F{green}%b%F{magenta}]%F{blue}'
zstyle ':vcs_info:*' enable git

PROMPT=$'\033]133;A\007''%B%F{blue}%n%F{magenta}:%F{blue}%~' # pwd
PROMPT+='${vcs_info_msg_0_}' # git branch integration
[[ -n $IN_NIX_SHELL ]] && PROMPT+=" %F{magenta}[%F{yellow}$IN_NIX_SHELL%F{magenta}]%f" # nix
[[ -e /run/.toolboxenv ]] && PROMPT+=" %F{magenta}[%F{yellow}dbx%F{magenta}]%f" # distrobox
PROMPT+=$'\n'"%(1j.%F{magenta}[%F{yellow}%j%F{magenta}] .)" # job count
PROMPT+="%(?.%F{blue}.%F{red})⤷%f%b " # actual prompt on a new line

preexec() {
	timer=$(($(date +%s%0N)*0.000000001))
}
precmd () {
	if [[ -n $timer ]]; then
		now=$(($(date +%s%0N)*0.000000001))
		elapsed=$(printf "%.3f" $(($now-$timer)))
		RPROMPT="%B%F{black}${elapsed}s %{$reset_color%}%b"
		unset timer
	fi

	vcs_info # git integration
}
# RPROMPT='%F{cyan}%D{%H:%M:%S}%f' # add a timestamp on the right side

# dir colors

DIRCOLORS_SRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/dircolors"
DIRCOLORS_CACHE="${XDG_CONFIG_HOME:-$HOME/.config}/shell/dircolors.cache"
if [[ ! -f "$DIRCOLORS_CACHE" || "$DIRCOLORS_SRC" -nt "$DIRCOLORS_CACHE" ]]; then
	dircolors "$DIRCOLORS_SRC" > "$DIRCOLORS_CACHE" 2>/dev/null
fi

source "$DIRCOLORS_CACHE"
autoload -Uz colors && colors

# completion

ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[ -d "$ZSH_CACHE_DIR" ] || mkdir -p "$ZSH_CACHE_DIR"
ZCOMPDUMP="$ZSH_CACHE_DIR/zcompdump"
ZCOMPCACHE="$ZSH_CACHE_DIR/zcompcache"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZCOMPCACHE"
autoload -Uz compinit
zmodload zsh/complist
if [[ -n ${ZCOMPDUMP}(#qN.mh-24) ]]; then
	compinit -C -d "$ZCOMPDUMP"
else
	compinit -d "$ZCOMPDUMP"
	zcompile "$ZCOMPDUMP"
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[' send-break

# history

[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
SAVEHIST=100000
HISTSIZE=100000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_ignore_space

# fzf bindings

source $ZDOTDIR/fzf.zsh

# deferred loading

_deferred_execution() {
	if [[ -e /run/.toolboxenv ]]; then
		source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	else
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
	add-zsh-hook -d precmd _load_syntax_highlighting
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _deferred_execution

# compile rc into bytecode on edit

ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
if [[ -s "$ZSHRC" && (! -s "${ZSHRC}.zwc" || "$ZSHRC" -nt "${ZSHRC}.zwc") ]]; then
	zcompile "$ZSHRC"
fi

# zprof
