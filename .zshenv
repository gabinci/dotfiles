#!/bin/zsh

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}

# bat
export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/config"
export BAT_PAGER="less -R"

# FD
FD_OPTIONS="--follow --exlude .git --exlude node_modules"

# fzf
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standars | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

