# Dotfiles
A git bare repository is used for managing my dotfiles. More info: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

# How to
Run the following commands:
```
git init --bare $HOME/.cfg # or any other directory
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Adding new files
```
config add .config/termite/
config commit -m "Adding termite config"
config push
```
