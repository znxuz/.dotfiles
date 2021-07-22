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
setopt hist_ignore_all_dups
setopt extendedglob
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
eval $(thefuck --alias)

source $ZDOTDIR/todoist_functions_fzf.sh

# nnn
export NNN_FCOLORS="000004020005050009060B00"
export NNN_OPTS="eEHR"

# must be at the end
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
