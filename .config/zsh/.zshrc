#!/bin/sh
# vim:ft=zsh
unsetopt beep # No bell: Shut up Zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/options/catppuccin-syntax/themes/catppuccin_macchiato.zsh
source $ZDOTDIR/core/plugins.zsh
source $ZDOTDIR/core/aliases.zsh
source $ZDOTDIR/core/exports.zsh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.config/zsh/.p10k.zsh.
[[ ! -f ~/dotfiles/.config/zsh/.p10k.zsh ]] || source ~/dotfiles/.config/zsh/.p10k.zsh
~/dotfiles/.config/pfetch/pfetch # launch pfetch on startup 

