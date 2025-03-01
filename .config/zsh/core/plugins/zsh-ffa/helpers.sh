#!/bin/zsh

parse_options() {
  while getopts ":fdit:" opt; do
    case $opt in
      f) type_filter="f"; ffa_flags+=("-f") ;;
      d) type_filter="d"; ffa_flags+=("-d") ;;
      i) hide_hidden=true; ffa_flags+=("-i") ;;   # Hide hidden files
      t) file_type="$OPTARG"; ffa_flags+=("-t" "$OPTARG") ;;  # File type filter
      \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
    esac
  done
  shift $((OPTIND -1))
}

construct_fd_command() {
  local dir="$1"
  local type_filter="$2"
  local hide_hidden="$3"
  local file_type="$4"

  local fd_cmd="fd --full-path --exclude .git/"

  # Add type filter if set
  if [ -n "$type_filter" ]; then
    fd_cmd+=" --type=$type_filter"
  fi

  # Add hidden files handling
  if [ "$hide_hidden" = true ]; then
    # When -i is specified, don't include hidden files (default fd behavior)
    :
  else
    # By default, show hidden files
    fd_cmd+=" --hidden"
  fi

  # Add file type filter if specified
  if [ -n "$file_type" ]; then
    # Check if it starts with a dot, if not, add it
    if [[ "$file_type" == .* ]]; then
      fd_cmd+=" -e \"${file_type#.}\""  # Remove leading dot and add as extension
    else
      fd_cmd+=" -e \"$file_type\""  # Use as is
    fi
  fi

  echo "$fd_cmd"
}

determine_preview_command() {
  file_preview_cmd="bat --style=numbers --color=always {}"
  dir_preview_cmd="tree -C {}"

  command -v bat >/dev/null 2>&1 || file_preview_cmd="cat {}"
  command -v tree >/dev/null 2>&1 || dir_preview_cmd="ls -l --color=always {}"
}

handle_selection() {
  local selected="$1"
  local dir="$2"
  local -a ffa_flags=("${(@P)3}")

  local selected_path
  selected_path="$(realpath "$dir/$selected")"

  if [ "$selected" = ".." ]; then
    ffa "${ffa_flags[@]}" "$(dirname "$dir")"
    return
  fi

  if [ -d "$selected_path" ]; then
    ffa "${ffa_flags[@]}" "$selected_path"
  else
    $EDITOR "$selected_path"
  fi
}

# Helper function for displaying messages and waiting for a keypress
show_message() {
  local message="$1"
  echo "$message" > /dev/tty
  read -k 1 -s < /dev/tty
}
