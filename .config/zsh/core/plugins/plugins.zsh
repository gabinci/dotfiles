#!/bin/zsh
# $ZDOTDIR/.zshrc

source $ZDOTDIR/core/plugins/fzf-zsh/fzf.zsh							# fzf functions

autoload -U select-word-style									# NOTE: must come before zsh-history-substring-search & zsh-syntax-highlighting.
select-word-style bash 										# only alphanumeric chars are considered WORDCHARS

source $ZDOTDIR/core/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# For speed: https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

source $ZDOTDIR/core/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh   	# NOTE: must come after select-word-style.

# Note that this will only ensure unique history if we supply a prefix before hitting "up" (ie. we perform a "search"). HIST_FIND_NO_DUPS won't prevent dupes from appearing when just hitting "up" without a prefix (ie. that's "zle up-line-or-history" and not classified as a "search"). So, we have HIST_IGNORE_DUPS to make life bearable for that case. # https://superuser.com/a/1494647/322531
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

source $ZDOTDIR/core/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh		# NOTE: must come after select-word-style.

