#!/bin/zsh

# Find and open files or directories with fzf
ffa() {
  local dir="$PWD"
  local type_filter=""

  # Parse options
  while getopts ":fd" opt; do
    case $opt in
      f) type_filter="f" ;;
      d) type_filter="d" ;;
      \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
    esac
  done
  shift $((OPTIND -1))

  # If a directory is provided as an argument, use it
  if [ -n "$1" ]; then
    dir="$(realpath "$1")"
  fi

  # Add a special option to go up to the parent directory
  local go_up_option=".."

  # Run fzf to select files or directories with preview
  selected=$(cd "$dir" && (echo "$go_up_option"; fd --full-path --exclude .git/ ${type_filter:+--type=$type_filter}) | fzf --reverse --info=inline --prompt="Choose files or directories  " --preview '[[ -d {} ]] && tree -C {} || bat --style=numbers --color=always {}')

  # Exit if no selection is made
  if [ -z "$selected" ]; then
    return
  fi

  # Get the absolute path of the selected item
  selected_path="$(realpath "$dir/$selected")"

  # Check if the selected item is the special option to go up
  if [ "$selected" = "$go_up_option" ]; then
    # Change to parent directory and call ffa recursively
    ffa "$(dirname "$dir")"
    return
  fi

  # Check if the selected item is a directory or a file
  if [ -d "$selected_path" ]; then
    # Recursively call ffa for the selected directory
    ffa "$selected_path"
  else
    # Open the selected file in the editor
    $EDITOR "$selected_path"
  fi
}
