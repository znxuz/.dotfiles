# prompt
fpath+=$XDG_CONFIG_HOME/zsh/pure
autoload -U promptinit; promptinit
# zstyle :prompt:pure:prompt:success color '#ebdbb2'
# zstyle :prompt:pure:path color yellow
prompt pure

# one line prompt
prompt_newline='%666v'

# show jobs count
PROMPT=' %F{magenta}%(1j.[%j] .)%(?.%F{magenta}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '

# clear screen with extra new line
custom_prompt_pure_clear_screen() {
zle -I # Enable output to terminal.
print -n '\e[2J\e[3;0H' # Clear screen and move cursor to (4, 0).
zle .redisplay # Redraw prompt.
}
zle -N clear-screen custom_prompt_pure_clear_screen

# color zsh
autoload -U colors && colors
setopt autocd

# Lines configured by zsh-newuser-install
HISTSIZE=10000
SAVEHIST=10000
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

# vi mode
source $ZDOTDIR/zsh_vi_mode

# fzfs
source $ZDOTDIR/zsh_fzf

# eye candy
echo "\n"
pfetch
eval$(thefuck --alias)

# must be at the end
source $XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
