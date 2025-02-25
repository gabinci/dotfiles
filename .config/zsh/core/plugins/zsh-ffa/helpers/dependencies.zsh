#!/bin/zsh

source $ZDOTDIR/core/plugins/zsh-ffa/helpers/logging.zsh

# Check if dependencies exist
check_deps() {
  for cmd in fd fzf bat; do
    if ! command -v $cmd >/dev/null 2>&1; then
      log_error "Error: $cmd is not installed."
    else
      log_info "$cmd is installed."
    fi
  done
}
