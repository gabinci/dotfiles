#!/bin/zsh

# Find and open files with fzf
ff() {
  local dir="${1:-$PWD}"

  # Check if dependencies exist
  for cmd in fd fzf; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd is not installed."; return 1; }
  done

  # Run fzf to select files
  (cd "$dir" && fd -Htf --full-path --exclude .git/ | fzf -m --reverse --info=inline --prompt="Choose files  " | xargs -r $EDITOR)
}



