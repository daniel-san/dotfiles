#!/bin/zsh
# Environment variables

export EDITOR=nvim

if command -v nvim &> /dev/null; then
    export MANPAGER="nvim +Man!"
elif [ -f $HOME/apps/nvim.appimage ]; then
    export MANPAGER="$HOME/apps/nvim.appimage +Man!"
fi
