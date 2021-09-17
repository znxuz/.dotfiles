# aliases
source $HOME/.config/shell/aliasrc

# prompt
source $ZDOTDIR/zsh_prompt

# color zsh
eval $(dircolors $XDG_CONFIG_HOME/shell/gruvbox_dircolors)
autoload -U colors && colors

# misc
HISTSIZE=100000
SAVEHIST=100000
unsetopt beep
setopt hist_ignore_all_dups
setopt extendedglob
setopt rmstarsilent

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
setopt globdots
setopt noclobber
# _comp_options+=(globdots)       # Include hidden files.

# fzf
source $ZDOTDIR/zsh_fzf

# vi mode
source $ZDOTDIR/zsh_vi_mode

# todos
source $ZDOTDIR/todoist_functions_fzf.sh

# must be at the end
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# eye candy
echo "\n" && pfetch
