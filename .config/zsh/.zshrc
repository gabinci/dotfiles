source $ZDOTDIR/core/exports.zsh
source $ZDOTDIR/core/plugin.zsh
source $ZDOTDIR/core/prompt.zsh
source $ZDOTDIR/core/option.zsh
source $ZDOTDIR/core/keybinding.zsh
source $ZDOTDIR/after/alias.zsh
source $ZDOTDIR/after/hooks.zsh
source $ZDOTDIR/after/functions.zsh
source $ZDOTDIR/after/plugin/fzf.zsh

~/dotfiles/.config/zsh/after/visual/nofetch #fetch

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
