source $HOME/.config/shell/profile

# startx at tty1 login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx ${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc
fi
