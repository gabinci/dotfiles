#!/bin/zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FD_OPTIONS="-H --full-path --exclude '.git' --exclude 'node_modules'  "

# fzf

export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS ${1:-$PWD}"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--height 50% --border \
--preview 'bat --style=numbers --color=always --line-range :500 {}'"

export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --prompt='Directory ﰲ '"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --full-path "$1" 
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --full-path "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    vim|nvim|nv)  fd -tf -tl --hidden --exclude '.git' --exclude 'node_modules' | fzf "$@" --prompt='File ﰲ ';;
    cd)           fzf "$@" --preview 'tree -C {} | head -200' --prompt='Directory ﰲ' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fd -tf -tl --hidden --exclude '.git' --exclude 'node_modules' | fzf "$@" ;;
  esac
}

# # Custom fuzzy completion for "doge" command
#   # e.g. doge **<TAB>
# _fzf_complete_doge() {
#   _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
#     echo very
#     echo wow
#     echo such
#     echo doge
#   )
# }


# # post processing outputs from fzf
# _fzf_complete_foo() {
#   _fzf_complete --multi --reverse --header-lines=3 -- "$@" < <(
#     ls -al
#   )
# }
#
# _fzf_complete_foo_post() {
#   awk '{print $NF}'
# }
