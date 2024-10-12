KEYTIMEOUT=1

# aliases

source $XDG_CONFIG_HOME/shell/aliasrc

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

# dir colors

eval $(dircolors $XDG_CONFIG_HOME/shell/dircolors)
autoload -U colors && colors

# history

HISTFILE=$ZDOTDIR/.zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_ignore_space

# misc

unsetopt beep
setopt extendedglob
setopt rmstarsilent
setopt globdots
setopt noclobber
unsetopt prompt_cr prompt_sp
setopt nolistambiguous

# completion
autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
compinit -d $XDG_CONFIG_HOME/zsh/.zcompdump
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[' send-break

bindkey -e
autoload edit-command-line &&
	zle -N edit-command-line &&
	bindkey '^x^e' edit-command-line

# fzf bindings

source $ZDOTDIR/zfzf

# ROS

ross()
{
	source /opt/ros/jazzy-base/setup.zsh

	source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
	eval "$(register-python-argcomplete ros2)"
}

ross-ws()
{
	ross

	ws_setup="./install/local_setup.zsh"
	[[ ! -f $ws_setup ]] && echo "Not in a ROS2 workspace" && return 1
	source "$ws_setup"

	source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
	eval "$(register-python-argcomplete ros2)"
}

# gotta be at the end

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh
