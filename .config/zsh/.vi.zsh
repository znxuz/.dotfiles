bindkey -v
# bindkey -rpM viins '\e'
KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

zle-line-init() zle-keymap-select()
{
	if [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]];
	then
		PROMPT="%F{blue}%~ %F{yellow}%(1j.[%j] .)%(?.%F{blue}.%F{red})❯%f "
	else
		PROMPT="%F{blue}%~ %F{yellow}%(1j.[%j] .)%(?.%F{magenta}.%F{red})❮%f "
	fi
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# edit in vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey -M viins '^x^e' edit-command-line
bindkey -M vicmd '^x^e' edit-command-line

# better yankin'
vi-yank-xclip()
{
	zle vi-yank
	echo "$CUTBUFFER" | xclip
}
vi-paste-right()
{
	LBUFFER="${BUFFER}$(xclip -o -p)"
	zle reset-prompt
}
vi-paste-left()
{
	RBUFFER="$(xclip -o -p)${RBUFFER}"
	zle end-of-line && zle reset-prompt
}
zle -N vi-yank-xclip
zle -N vi-paste-right
zle -N vi-paste-left
bindkey -M vicmd 'y' vi-yank-xclip
bindkey -M viins -M vicmd ' p' vi-paste-right
bindkey -M viins -M vicmd ' P' vi-paste-left
