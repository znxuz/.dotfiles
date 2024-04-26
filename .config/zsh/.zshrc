KEYTIMEOUT=1

# aliases

source $XDG_CONFIG_HOME/shell/aliasrc

# prompt

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{magenta}[%F{green}%b%F{magenta}]%F{blue} '
zstyle ':vcs_info:*' enable git

precmd () { vcs_info }
PROMPT='%B%F{blue}%~ ${vcs_info_msg_0_}%F{yellow}%(1j.[%j] .)%(?.%F{blue}.%F{red})|>%f%b '

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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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
    source /opt/ros/humble/setup.zsh

    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
    eval "$(register-python-argcomplete ros2)"
}

ross-ws()
{
    ross

    ws_setup="./install/setup.zsh"
    [[ ! -f $ws_setup ]] && echo "Not in a ROS2 workspace" && return 1
    source "$ws_setup"

    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
    eval "$(register-python-argcomplete ros2)"
}

# gotta be at the end

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
