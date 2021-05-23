if exists('g:vscode')
    source $XDG_CONFIG_HOME/nvim/codium.vim
else
    source $XDG_CONFIG_HOME/nvim/misc.vim
    source $XDG_CONFIG_HOME/nvim/plugins.vim
endif
