# aliases
source $HOME/.config/shell/aliasrc

# set prompt
precmd()
{
	PROMPT="%F{blue}%~ %F{yellow}%(1j.[%j] .)%(?.%F{blue}.%F{red})❯%f "
	echo "" # extra new line
}
preexec()
{
	printf '\e[2 q' # reset to steady block cursor
}

# clear screen with extra new line
custom_clear_screen()
{
	zle -I # Enable output to terminal.
	print -n '\e[2J\e[3;0H' # Clear screen and move cursor to (4, 0).
	zle .redisplay # Redraw prompt.
}
zle -N clear-screen custom_clear_screen

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
unsetopt prompt_cr prompt_sp

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
setopt globdots
setopt noclobber
# _comp_options+=(globdots)		  # Include hidden files.

# fzf
source $ZDOTDIR/zsh_fzf

# vi mode
source $ZDOTDIR/zsh_vi

# todos
source $ZDOTDIR/zsh_todoist

# csharp autocompletion
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet

# must be at the end
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
