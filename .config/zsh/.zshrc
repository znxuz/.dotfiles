KEYTIMEOUT=1

# aliases

source $HOME/.config/shell/aliasrc

# prompt

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{magenta}[%F{green}%b%F{magenta}]%F{blue} '
zstyle ':vcs_info:*' enable git

precmd () { vcs_info }
PROMPT='%F{blue}%~ %B${vcs_info_msg_0_}%F{yellow}%(1j.[%j] .)%b%(?.%F{blue}.%F{red})|>%f '

# colors

eval $(dircolors $XDG_CONFIG_HOME/shell/colors)
autoload -U colors && colors

# misc

HISTSIZE=100000
SAVEHIST=100000
unsetopt beep
setopt hist_ignore_all_dups
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

source $ZDOTDIR/zsh_fzf

# ros2

ros2init()
{
    export ROS_DOMAIN_ID=42
    . /opt/ros/iron/setup.zsh
    . /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

    eval "$(register-python-argcomplete ros2)"

    ws_setup="./install/setup.zsh"
    [[ -f "$ws_setup" ]] && . "$ws_setup"
    return 0
}

# gotta be at the end

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
