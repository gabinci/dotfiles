#!/bin/zsh

# Find and change directory with fzf
ffd() {
  local dir="$PWD"
  local exclude_dirs=(".git/" "node_modules/")
  local fd_exclude_args=()
  local verbose=0

  # Function to print help message
  print_help() {
    local help_text="Usage: 
  ffd [directory] [options]

Find and change directory with fzf, while excluding specified directories.

Options:
  -d <directory>                        # Add exclude directory
  -v                                    # Enable verbose mode
  -h, --help                            # Show this help message and exit

Examples:
  ffd                                   # Run in current directory
  ffd ~/projects                        # Run in specified directory
  ffd -d build -d dist                  # Exclude 'build' and 'dist' directories

"

    if command -v bat >/dev/null 2>&1; then
      echo "$help_text" | bat --paging=never --plain
    else
      echo "$help_text" | cat
    fi
  }

  # Check if the first argument is a directory
  if [[ -d $1 ]]; then
    dir="$1"
    shift
  fi

  # Parse options
  while [[ $# -gt 0 ]]; do
    case $1 in
      -d) IFS=',' read -r -a dirs <<< "$2"; exclude_dirs+=("${dirs[@]}"); shift ;;
      -v) verbose=1 ;;
      -h|--help) print_help; return 0 ;;
      *) echo "Unknown option: $1"; print_help; return 1 ;;
    esac
    shift
  done

  # Build fd exclude arguments
  for excluded_dir in "${exclude_dirs[@]}"; do
    fd_exclude_args+=("--exclude" "$excluded_dir")
  done

  # Check if dependencies exist
  for cmd in fd fzf; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd is not installed."; return 1; }
  done

  # Verbose output
  if [[ $verbose -eq 1 ]]; then
    echo "Directory: $dir"
    echo "Exclude directories: ${exclude_dirs[*]}"
  fi

  # Run fzf to select directories
  local selected_dir
  selected_dir=$(cd "$dir" && fd -Ht d --full-path "${fd_exclude_args[@]}" | fzf -m --reverse --info=inline --prompt="Choose directory  ")

  # Change to selected directory
  if [[ -n $selected_dir ]]; then
    cd "$selected_dir"
  else
    echo "No directory selected."
  fi
}
