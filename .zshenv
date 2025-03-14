#!/bin/zsh
# ~/.config/zsh/.zshrc 						                              # MY ZSHRC PATH

export ZDOTDIR=${ZDOTDIR:-~/.config/zsh} 		                	# Change zsh default config path to be inside dotfiles

path=(					 			                                        # PATH configurations
	$path                            			                      # keeps current path
	$HOME/bin/			 			                                      # Adds bin to path
	$HOME/.local/bin/		 			                                  # Adds .local/bin to path
)

typeset -U path 						                                  # Remove duplicate entries and non-existing directories
path=($^path(N-/))
export PATH

# Environment Exports
export VISUAL=nvim						                                # default file visualizer
export EDITOR=nvim						                                # default file editor

export BAT_CONFIG_PATH="$HOME/dotfiles/.config/bat/config" 	  # bat
# export EZA_CONFIG_DIR="$HOME/dotfiles/.config/eza" 		        # eza

export EZA_ICONS_AUTO=1 # Enable icons for eza by default
