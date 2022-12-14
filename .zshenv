#!/bin/zsh

# system
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# enable NIX
export NIX_REMOTE=daemon

# export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH=$HOME/.cargo/bin:$PATH$(find $HOME/.local/bin/ -type d -printf ":%p")

# bat
export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/config"

. "$HOME/.cargo/env"
