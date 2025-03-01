#!/bin/zsh

# Get the absolute path to the script directory
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"

# Source the helper and command files
source "${SCRIPT_DIR}/helpers.sh"
source "${SCRIPT_DIR}/commands.sh"

# Source utility functions
source "${SCRIPT_DIR}/utils/rename_file.sh"

ffa() {
  local dir="$PWD"
  local ffa_flags=()
  local type_filter=""
  local hide_hidden=false
  local file_type=""

  # Parse options
  parse_options "$@"

  if [ -n "$1" ]; then
    dir="$(realpath "$1")"
  fi

  local go_up_option=".."

  # Determine preview command with fallback
  determine_preview_command

  # Build fd command based on options
  local fd_cmd
  fd_cmd=$(construct_fd_command "$dir" "$type_filter" "$hide_hidden" "$file_type")

  # Create file/directory command
  local create_cmd
  create_cmd=$(construct_create_command "$dir")

  # Create an inline wrapper to call our rename function
  local rename_wrapper="source \"${SCRIPT_DIR}/utils/rename_file.sh\"; rename_file \"$dir\" {}"
  
  # Run fzf with preview and custom key bindings
  export dir

  selected=$(cd "$dir" && (echo "$go_up_option"; eval "$fd_cmd") | \
    fzf --reverse --info=inline --prompt="Choose files or directories  " \
    --preview "if [[ -d {} ]]; then $dir_preview_cmd; else $file_preview_cmd; fi" \
    --bind "ctrl-a:execute($create_cmd)+reload(echo '$go_up_option'; $fd_cmd)" \
    --bind "ctrl-r:execute($rename_wrapper)+reload(echo '$go_up_option'; $fd_cmd)")

  [ -z "$selected" ] && return

  handle_selection "$selected" "$dir" "ffa_flags"
}

# Register commands - simplified as we're using function calls
register_commands() {
  # Commands are now handled directly via bindings
  :
}

