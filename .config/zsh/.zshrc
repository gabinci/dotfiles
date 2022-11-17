#!/bin/sh
# vim:ft=zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/options/catppuccin-syntax/themes/catppuccin_macchiato.zsh
source $ZDOTDIR/options/aliases.zsh
source $ZDOTDIR/options/exports.zsh

unsetopt beep # No bell: Shut up Zsh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions" #zsh-autosuggestions
# plug "zap-zsh/vim" #vim motions
plug "romkatv/powerlevel10k" # Prompt
plug "esc/conda-zsh-completion" # Example install completion
plug "zsh-users/zsh-syntax-highlighting" # syntax highlighting

[[ ! -f ~/.config/zsh/options/prompt/.p10k.zsh ]] || source ~/.config/zsh/options/prompt/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
~/.config/pfetch/pfetch # launch pfetch on startup 
