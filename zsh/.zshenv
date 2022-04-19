#!/usr/bin/env bash
: "${XDG_CONFIG_HOME:="$HOME/.config"}"
: "${XDG_DATA_HOME:="$HOME/.local/share"}"
: "${XDG_CACHE_HOME:="$HOME/.cache"}"
: "${ZDOTDIR:="$XDG_CONFIG_HOME/zsh"}"

[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && \
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"

export HISTFILE="${ZDOTDIR}/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTCONTROL=ignoreboth

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='mvim -v -u NONE'
else
  export EDITOR='mvim -v'
fi
export VISUAL="$EDITOR"

DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
