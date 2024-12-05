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
precmd () { vcs_info }

PROMPT='%B%F{blue}%n%F{magenta}:%F{blue}%~' # pwd
PROMPT+='${vcs_info_msg_0_}' # git branch integration
[[ -n $IN_NIX_SHELL ]] && PROMPT+=" %F{magenta}[%F{yellow}$IN_NIX_SHELL%F{magenta}]%f" # nix

PROMPT+=$'\n'"%(1j.%F{magenta}[%F{yellow}%j%F{magenta}] .)" # job count
PROMPT+="%(?.%F{blue}.%F{red})⤷%f%b " # actual prompt on a new line

# RPROMPT='%F{cyan}%D{%H:%M:%S}%f' # add a timestamp on the right side

# dir colors

eval $(dircolors $XDG_CONFIG_HOME/shell/dircolors)
autoload -U colors && colors

# completion

[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
bindkey -M menuselect '^[[Z' reverse-menu-complete
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

# ROS2

source $ZDOTDIR/ros.zsh

# gotta be at the end

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh
