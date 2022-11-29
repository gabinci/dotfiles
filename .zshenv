#!/bin/zsh

# system
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"

# bat
export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/config"
