#!/bin/zsh

# Check if dependencies exist
check_deps() {
  for cmd in fd fzf bat; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd is not installed."; return 1; }
  done
}
