#!/bin/zsh
# fzf - fuzzy finder

# Support both git-based and package-manager installs
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
  [[ -f /usr/share/fzf/completion.zsh   ]] && source /usr/share/fzf/completion.zsh
fi
