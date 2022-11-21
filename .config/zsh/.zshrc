#!/bin/sh
# vim:ft=zsh

source ~/.config/zsh/core/catppuccin-syntax/themes/catppuccin_macchiato.zsh
source $ZDOTDIR/core/options.zsh
source $ZDOTDIR/core/plugins.zsh
source $ZDOTDIR/core/aliases.zsh
source $ZDOTDIR/core/keybindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
~/dotfiles/.config/pfetch/pfetch # launch pfetch on startup 
