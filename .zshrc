#!/bin/zsh
# Source all modular config files from .zshrc.d/
# Files are loaded in alphabetical order (numeric prefixes control order)

if [ -d ~/.zshrc.d ]; then
    for rc in ~/.zshrc.d/*.zsh; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
