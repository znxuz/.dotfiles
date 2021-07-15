# prompt
source $ZDOTDIR/zsh_prompt

# color zsh
autoload -U colors && colors
setopt autocd

# misc
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt autocd extendedglob
unsetopt beep

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
setopt globdots
setopt noclobber
# _comp_options+=(globdots)       # Include hidden files.

# fzfs
source $ZDOTDIR/zsh_fzf

# vi mode
source $ZDOTDIR/zsh_vi_mode

# eye candy
echo "\n" && pfetch
eval$(thefuck --alias)

source /home/zijian/.config/zsh/todoist_functions_fzf.sh

# must be at the end
source $XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
