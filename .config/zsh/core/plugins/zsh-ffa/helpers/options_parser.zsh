#!/bin/zsh

# Parse command-line options
parse_options() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -D) IFS=',' read -A dirs <<< "$2"; exclude_dirs+=("${dirs[@]}"); shift ;;
      -e) IFS=',' read -A patterns <<< "$2"; exclude_patterns+=("${patterns[@]}"); shift ;;
      -E) editor="$2"; shift ;;
      -v) verbose=true ;;
      -i) hide_hidden=true ;;
      -f) fd_type_args+=("-t" "f") ;;
      -d) fd_type_args+=("-t" "d") ;;
      -h|--help) print_help; return 0 ;;
      *) echo "Unknown option: $1"; print_help; return 1 ;;
    esac
    shift
  done
}

# Verbose output
verbose_output() {
  if [[ $verbose == true ]]; then
    echo "Directory: $dir"
    echo "Exclude directories: ${exclude_dirs[*]}"
    echo "Exclude patterns: ${exclude_patterns[*]}"
    echo "Editor: $editor"
    echo "Hide hidden files: $hide_hidden"
    echo "Default split: $default_split"
  fi
}

# Build fd exclude arguments
build_fd_args() {
  fd_exclude_args=("-H")  # Start with the '-H' flag to include hidden files by default

  # Add directory exclusions to the arguments
  for excluded_dir in "${exclude_dirs[@]}"; do
    fd_exclude_args+=("--exclude" "$excluded_dir")
  done

  # Add pattern exclusions to the arguments
  for pattern in "${exclude_patterns[@]}"; do
    fd_exclude_args+=("-E" "$pattern")
  done

  # Remove the '-H' flag if hide_hidden is set to true
  if [[ $hide_hidden == true ]]; then
    fd_exclude_args=("${fd_exclude_args[@]/-H/}")
  fi
}
