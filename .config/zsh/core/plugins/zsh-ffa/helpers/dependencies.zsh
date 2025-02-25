#!/bin/zsh

source "${0:A:h}/logging.zsh"

# Initialize global variables for preview commands
preview_dir_cmd=""
preview_file_cmd=""

# Check if dependencies exist and set preview commands
check_deps() {
  local deps=(fd fzf bat tree)
  for cmd in "${deps[@]}"; do
    if ! command -v $cmd >/dev/null 2>&1; then
      log_error "Error: $cmd is not installed."
      if [[ $cmd == "bat" ]]; then
        preview_file_cmd="cat {}"
      elif [[ $cmd == "tree" ]]; then
        preview_dir_cmd="ls -la {}"
      fi
    else
      log_info "$cmd is installed."
      if [[ $cmd == "bat" ]]; then
        preview_file_cmd="bat --style=numbers --wrap=never --color=always --line-range :500 {}"
      elif [[ $cmd == "tree" ]]; then
        preview_dir_cmd="tree -C {}"
      fi
    fi
  done

  # Set default commands if not set by the loop
  if [[ -z $preview_dir_cmd ]]; then
    preview_dir_cmd="ls -la {}"
  fi
  if [[ -z $preview_file_cmd ]]; then
    preview_file_cmd="cat {}"
  fi

  log_debug "Final preview_dir_cmd: $preview_dir_cmd"
  log_debug "Final preview_file_cmd: $preview_file_cmd"
}
