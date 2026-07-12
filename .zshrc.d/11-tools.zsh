#!/bin/zsh
# Miscellaneous tools

# Xresources
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Zoxide (cd replacement)
eval "$(zoxide init zsh --cmd cd)"

# Linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
