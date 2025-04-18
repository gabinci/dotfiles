#!/bin/zsh

# Find and open files with fzf
ff() {
  local dir="$PWD"
  local exclude_dirs=(".git/" "node_modules/")
  local exclude_patterns=("*.png" "*.jpg" "*.jpeg" "*.gif" "*.bmp" "*.webp" "*.tiff" "*.pdf" "*.epub" "*.zip" "*.tar" "*.gz" "*.rar" "*.7z" "*.ico" "*.woff" "*.woff2" "*.otf" "*.ttf" "*.eot")
  local fd_exclude_args=()
  local editor="${EDITOR:-vim}"
  local verbose=0

  # Function to print help message
  print_help() {
    local help_text="Usage: 
  ff [directory] [options]

Find and open files with fzf, while excluding specified directories and file patterns.

Options:
  -d <directory>                        # Add exclude directory
  -e <pattern>                          # Add exclude pattern
  -E <editor>                           # Specify editor (default: \$EDITOR or vim)
  -v                                    # Enable verbose mode
  -h, --help                            # Show this help message and exit

Examples:
  ff                                    # Run in current directory
  ff ~/projects                         # Run in specified directory
  ff -d build -d dist                   # Exclude 'build' and 'dist' directories
  ff -e \"*.log\" -e \"*.tmp\"              # Exclude '*.log' and '*.tmp' file patterns
  ff ~/projects -d dist -e \"*.log\"      # Combined usage
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
      -e) IFS=',' read -r -a patterns <<< "$2"; exclude_patterns+=("${patterns[@]}"); shift ;;
      -E) editor="$2"; shift ;;
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
  for pattern in "${exclude_patterns[@]}"; do
    fd_exclude_args+=("-E" "$pattern")
  done

  # Check if dependencies exist
  for cmd in fd fzf; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd is not installed."; return 1; }
  done

  # Verbose output
  if [[ $verbose -eq 1 ]]; then
    echo "Directory: $dir"
    echo "Exclude directories: ${exclude_dirs[*]}"
    echo "Exclude patterns: ${exclude_patterns[*]}"
    echo "Editor: $editor"
  fi

  # Run fzf to select files
  (cd "$dir" && fd -Htf --full-path "${fd_exclude_args[@]}" | fzf -m --reverse --info=inline --prompt="Choose files  " | xargs -r $editor)
}
