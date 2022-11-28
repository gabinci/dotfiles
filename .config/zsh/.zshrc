source $ZDOTDIR/core/exports.zsh
source $ZDOTDIR/core/plugin.zsh
source $ZDOTDIR/core/prompt.zsh
source $ZDOTDIR/core/option.zsh
source $ZDOTDIR/core/keybinding.zsh
source $ZDOTDIR/after/alias.zsh
source $ZDOTDIR/after/hooks.zsh
source $ZDOTDIR/after/functions.zsh

~/dotfiles/.config/zsh/after/visual/fetch/catppuccin #fetch

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
