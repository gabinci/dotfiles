#!/bin/zsh

# Default configuration values
default_config() {
  exclude_dirs=(".git/" "node_modules/")
  exclude_patterns=("*.png" "*.jpg" "*.jpeg" "*.gif" "*.bmp" "*.webp" "*.tiff" "*.pdf" "*.epub" "*.zip" "*.tar" "*.gz" "*.rar" "*.7z" "*.ico" "*.woff" "*.woff2" "*.otf" "*.ttf" "*.eot")
  editor="${EDITOR:-nvim}"
  verbose=false
  hide_hidden=false
  default_split="horizontal"
  fzf_bindings="tab:toggle+down,ctrl-e:execute($editor {}),ctrl-y:execute-silent(echo -n ${dir}/{} | sed \"s|^$HOME|~|\" | $clipboard_cmd)"
  fzf_preview_cmd='([[ -d {} ]] && ls -la {} || bat --style=numbers --color=always --line-range :500 {}) 2> /dev/null | head -200'
}

# Load configuration from file and determine split flag
load_config() {
  # Source default configuration
  default_config

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
        fzf_bindings) fzf_bindings="$value" ;;
        fzf_preview_cmd) fzf_preview_cmd="$value" ;;
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
