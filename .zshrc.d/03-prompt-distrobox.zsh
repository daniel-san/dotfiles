#!/bin/zsh
# Custom prompt for Distrobox containers

# Save the original prompt once
if [[ -z "$ORIGINAL_PROMPT" ]]; then
  ORIGINAL_PROMPT="$PROMPT"
fi

function _distrobox_name() {
  [[ -f /.dockerenv ]] || return
  hostname
}

function distrobox_prompt() {
  if [[ -f /.dockerenv ]]; then
    local name=$(_distrobox_name) || return
    if [[ $EUID -eq 0 ]]; then
        echo "%F{red}[📦 $name ROOT]%f "
    else
        echo "%F{yellow}[📦 $name]%f "
    fi
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _distrobox_precmd

function _distrobox_precmd() {
  PROMPT="$(distrobox_prompt)$ORIGINAL_PROMPT"
}
