#!/bin/zsh

source $ZDOTDIR/core/plugins/zsh-ffa/helpers/logging.zsh

# Parse command-line options
parse_options() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -D) 
        if [[ -n $2 ]]; then
          IFS=',' read -A dirs <<< "$2"
          exclude_dirs+=("${dirs[@]}")
          shift
        else
          log_error "Option -D requires a directory argument."
          return 1
        fi
        ;;
      -e) 
        if [[ -n $2 ]]; then
          IFS=',' read -A patterns <<< "$2"
          exclude_patterns+=("${patterns[@]}")
          shift
        else
          log_error "Option -e requires a pattern argument."
          return 1
        fi
        ;;
      -E)
        if [[ -n $2 ]]; then
          editor="$2"
          shift
        else
          log_error "Option -E requires an editor argument."
          return 1
        fi
        ;;
      -v) verbose=true ;;
      --debug) debug=true ;;
      --log-to-file) log_to_file=true ;;
      -i) hide_hidden=true ;;
      -f) fd_type_args+=("-t" "f") ;;
      -d) fd_type_args+=("-t" "d") ;;
      -h|--help) print_help; return 1 ;;  # Return 1 after printing help to indicate no further processing
      *) log_error "Unknown option: $1"; print_help; return 1 ;;  # Return 1 for unknown options
    esac
    shift
  done
}

# Verbose output
verbose_output() {
  if [[ $verbose == true ]]; then
    log_info "Directory: $dir"
    log_info "Exclude directories: ${exclude_dirs[*]}"
    log_info "Exclude patterns: ${exclude_patterns[*]}"
    log_info "Editor: $editor"
    log_info "Hide hidden files: $hide_hidden"
    log_info "Default split: $default_split"
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
