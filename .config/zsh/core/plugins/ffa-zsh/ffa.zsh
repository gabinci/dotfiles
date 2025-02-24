#!/bin/zsh

# Source the terminal detection function
source $ZDOTDIR/core/functions/detect_terminal.zsh

# Source the separated function files
source $ZDOTDIR/core/plugins/ffa-zsh/load_config.zsh
source $ZDOTDIR/core/plugins/ffa-zsh/print_help.zsh

# Find and open files and directories with fzf
ffa() {
  local dir="$PWD"
  local fd_exclude_args=("-H")
  local editor="${EDITOR:-nvim}"
  local verbose=false
  local hide_hidden=false
  local default_split="horizontal"

  # Default exclude directories and patterns
  exclude_dirs=(".git/" "node_modules/")
  exclude_patterns=("*.png" "*.jpg" "*.jpeg" "*.gif" "*.bmp" "*.webp" "*.tiff" "*.pdf" "*.epub" "*.zip" "*.tar" "*.gz" "*.rar" "*.7z" "*.ico" "*.woff" "*.woff2" "*.otf" "*.ttf" "*.eot")

  # Load configuration and determine split flag
  load_config

  # Check if the first argument is a directory
  if [[ -d $1 ]]; then
    dir="$1"
    shift
  fi

  # Parse options
  while [[ $# -gt 0 ]]; do
    case $1 in
      -d) IFS=',' read -A dirs <<< "$2"; exclude_dirs+=("${dirs[@]}"); shift ;;
      -e) IFS=',' read -A patterns <<< "$2"; exclude_patterns+=("${patterns[@]}"); shift ;;
      -E) editor="$2"; shift ;;
      -v) verbose=true ;;
      -i) hide_hidden=true ;;
      -h|--help) print_help; return 0 ;;
      *) echo "Unknown option: $1"; print_help; return 1 ;;
    esac
    shift
  done

  # Build fd exclude arguments
  for excluded_dir in "${exclude_dirs[@]}"; do
    fd_exclude_args+=("--exclude" "$excluded_dir")
  done
  for pattern in "${exclude_patterns[@]}"; do
    fd_exclude_args+=("-E" "$pattern")
  done

  # Handle hiding hidden files if specified
  if [[ $hide_hidden == true ]]; then
    fd_exclude_args=("${fd_exclude_args[@]/-H/}")
  fi

  # Check if dependencies exist
  for cmd in fd fzf bat; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd is not installed."; return 1; }
  done

  # Verbose output
  if [[ $verbose == true ]]; then
    echo "Directory: $dir"
    echo "Exclude directories: ${exclude_dirs[*]}"
    echo "Exclude patterns: ${exclude_patterns[*]}"
    echo "Editor: $editor"
    echo "Hide hidden files: $hide_hidden"
    echo "Default split: $default_split"
  fi

  # Detect terminal emulator
  local terminal_emulator=$(detect_terminal)
  if [[ $terminal_emulator == "termux" ]]; then
    # Check if termux-api is installed
    if ! command -v termux-clipboard-set >/dev/null 2>&1; then
      echo "Error: termux-api is not installed."
      return 1
    fi
    local clipboard_cmd="termux-clipboard-set"
  else
    local clipboard_cmd="pbcopy"
  fi

  # Run fzf to select files and directories with ".." to go up one level
  while true; do
    local prompt_dir="$dir"
    if [[ "$dir" == "$HOME" ]]; then
      prompt_dir="~/"
    elif [[ "$dir" == "$HOME/"* ]]; then
      prompt_dir="~/${dir#$HOME/}"
    fi
    local selected_item=$( (echo ".." && cd "$dir" && fd --full-path "${fd_exclude_args[@]}") | fzf --preview '([[ -d {} ]] && ls -la {} || bat --style=numbers --color=always --line-range :500 {}) 2> /dev/null | head -200' --preview-window=right:60%:wrap --bind "tab:toggle+down" --bind "ctrl-e:execute($EDITOR {})" --bind "ctrl-y:execute-silent(echo -n ${dir}/{} | sed \"s|^$HOME|~|\" | $clipboard_cmd)" -m --reverse --info=inline --prompt="$prompt_dir  ")

    if [[ -z $selected_item ]]; then
      if [[ $verbose == true ]]; then
        echo "No item selected."
      fi
      return
    elif [[ $selected_item == ".." ]]; then
      dir=$(dirname "$dir")
      cd "$dir"
    elif [[ -d "$dir/$selected_item" ]]; then
      cd "$dir/$selected_item"
      ffa
      return
    else
      # Handle multi-selection
      IFS=$'\n' read -d '' -r -A items <<< "$selected_item"
      if [[ ${#items[@]} -gt 0 ]]; then
        if [[ ${#items[@]} -gt 1 && $editor == "nvim" ]]; then
          $editor $split_flag "${(@)items}"
        else
          $editor "${(@)items}"
        fi
        return
      fi
    fi
  done
}
