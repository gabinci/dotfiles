#!/bin/zsh

# system
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export MANPAGER='nvim +Man!'
# bat

export BAT_PAGER="less -R"


