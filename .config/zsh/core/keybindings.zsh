#!/bin/zsh
bindkey -e # emacs bindings, set to -v for vi bindings

# Use "cbt" capability ("back_tab", as per `man terminfo`), if we have it:
if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

if [[ $(uname -a) =~ "Ubuntu" ]]; then
  bindkey "$key[Up]" history-substring-search-up
  bindkey "$key[Down]" history-substring-search-down
else
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

edit-last-command-output() {
  if [[ "$TERM" =~ "tmux" ]]; then
    tmux capture-pane -p -S - -E - -J | tac | awk '
      found && !/❯/ { print }
      /❯/ && !found { found=1; next }
      /❯/ && found {exit}
    ' | tac | nvim -
  else
    echo
    print -Pn "%F{red}error: can't capture last command output outside of tmux%f"
    zle accept-line
  fi
}

zle -N edit-last-command-output
bindkey '^x^o' edit-last-command-output

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Make CTRL-z background things and unbackground them. see $ZDOTDIR/core/functions/fg-bg.zsh
bindkey '^z' fg-bg

# Mac-like wordwise movement (Opt/Super plus left/right) in Kitty.
bindkey "^[[1;3C" forward-word # For macOS.
bindkey "^[[1;3D" backward-word # For macOS.
bindkey "^[[1;5C" forward-word # For Arch.
bindkey "^[[1;5D" backward-word # For Arch.


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

