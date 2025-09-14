source $HOME/.config/shell/profile
source $XDG_CONFIG_HOME/shell/aliasrc

# unlocking bitwarden (and gpg-agent) before starting x11 server
if [[ -z "$BW_SESSION" && -z "$DISPLAY" ]] && pass ls | grep -qo 'bw_session'; then
	while [[ -z "$BW_SESSION" ]]; do
		export BW_SESSION=$(pass bw_session)
	done
fi

# startx at tty1 login
if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
	startx $XDG_CONFIG_HOME/X11/xinitrc
fi
