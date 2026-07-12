#!/bin/zsh
# Zinit plugin manager

### Zinit installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$(dirname $ZINIT_HOME)" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

# Annexes
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
