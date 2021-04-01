Init:
    git init --bare $HOME/.dotfiles

Config.:
    alias df='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
    df config --local status.showUntrackedFiles no

Clone:
    git clone --separate-git-dir=$HOME/.dotfiles /repo-url/ $HOME/.dotfiles-temp
    
    then cp/mv/replace everything inside .dotfiles-temp
