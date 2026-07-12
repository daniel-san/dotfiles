#!/bin/zsh
# Auto-load all alias files from the aliases/ subfolder
# To add new aliases, simply create a new file in ~/.zshrc.d/aliases/

ALIASES_DIR="${0:A:h}/aliases"

if [ -d "$ALIASES_DIR" ]; then
    for alias_file in "$ALIASES_DIR"/*; do
        if [ -f "$alias_file" ]; then
            . "$alias_file"
        fi
    done
fi
unset alias_file
