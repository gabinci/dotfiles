#!/bin/sh
# vim:ft=zsh

source ~/.config/zsh/core/catppuccin-syntax/themes/catppuccin_macchiato.zsh
source $ZDOTDIR/core/options.zsh
source $ZDOTDIR/core/plugins.zsh
source $ZDOTDIR/core/aliases.zsh
source $ZDOTDIR/core/keybindings.zsh
source $ZDOTDIR/core/prompt/prompt.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.config/zsh/core/prompt/p10k.zsh.
[[ ! -f ~/dotfiles/.config/zsh/core/prompt/p10k.zsh ]] || source ~/dotfiles/.config/zsh/core/prompt/p10k.zsh
