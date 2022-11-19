[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions" #zsh-autosuggestions
plug "zsh-users/zsh-syntax-highlighting" # syntax highlighting
plug "romkatv/powerlevel10k" #prompt
plug "esc/conda-zsh-completion" # completions

eval "$(zoxide init zsh --cmd cd)" # zoxide
