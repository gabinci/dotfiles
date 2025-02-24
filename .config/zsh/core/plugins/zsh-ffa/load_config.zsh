#!/bin/zsh
# Load configuration from file and determine split flag
load_config() {
  local config_file="$HOME/.ffa.conf"
  if [[ -f $config_file ]]; then
    while IFS='=' read -r key value; do
      case $key in
        exclude_dirs) exclude_dirs=("${(@s/,/)value}") ;;
        exclude_patterns) exclude_patterns=("${(@s/,/)value}") ;;
        editor) editor="$value" ;;
        verbose) verbose="$value" ;;
        hide_hidden) hide_hidden="$value" ;;
        default_split) default_split="$value" ;;
      esac
    done < "$config_file"
  fi

  # Determine the split flag for the editor
  case $default_split in
    horizontal) split_flag="-O" ;;
    vertical) split_flag="-o" ;;
    *) split_flag="-O" ;; # Default to horizontal if the configuration is incorrect
  esac
}
