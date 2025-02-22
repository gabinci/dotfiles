#!/bin/zsh
# ~/.config/zsh/.zshrc 						# MY ZSHRC PATH

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh} 			# Change zsh default config path to be inside dotfiles

path=(					 			# PATH configurations
	$path                            			# keeps current path
	$HOME/bin/			 			# Adds bin to path
	$HOME/.local/bin/		 			# Adds .local/bin to path
)

typeset -U path 						# Remove duplicate entries and non-existing directories
path=($^path(N-/))
export PATH

# Environment Exports
export VISUAL=nvim						# default file visualizer
export EDITOR=nvim						# default file editor

export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/config" 	# bat
