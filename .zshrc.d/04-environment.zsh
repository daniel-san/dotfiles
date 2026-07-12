#!/bin/zsh
# Environment variables

export EDITOR=nvim

if [ -f $HOME/apps/nvim.appimage ]; then
    export MANPAGER="$HOME/apps/nvim.appimage +Man!"
fi
