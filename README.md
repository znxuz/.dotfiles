git init --bare $HOME/.dotfiles
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
df config --local status.showUntrackedFiles no

git clone --separate-git-dir=$HOME/.dotfiles /repo-url/ $HOME/.dotfiles-temp
