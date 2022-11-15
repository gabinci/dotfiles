# vim:set ft=zsh  
# No bell: Shut up Zsh
unsetopt beep

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# zap plugin manager:

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Example install plugins
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"

# Prompt
plug "romkatv/powerlevel10k"

# Example install completion
plug "esc/conda-zsh-completion"

# syntax highlighting
source ~/dotfiles/catppuccin_macchiato-zsh-syntax-highlighting.zsh
plug "zsh-users/zsh-syntax-highlighting"

export EDITOR=nvim
alias nv="nvim"
alias q="exit"
alias dot="~/dotfiles/"
alias conf="~/dotfiles/.config/"
alias home="~/"
alias c="clear ; exec zsh"

alias cat="bat"
alias lg="lazygit"
# launch pfetch on startup 
~/.config/pfetch/pfetch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
