#!/bin/zsh
# start zap plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"


plug "zsh-users/zsh-autosuggestions" #zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

plug "zsh-users/zsh-syntax-highlighting" # syntax highlighting
plug "esc/conda-zsh-completion" # completions
plug "zsh-users/zsh-history-substring-search" # History
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
