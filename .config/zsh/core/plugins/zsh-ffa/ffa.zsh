#!/bin/zsh

# Source the separated function files
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/detect_terminal.zsh
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/load_config.zsh
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/print_help.zsh
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/options_parser.zsh
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/dependencies.zsh
source $ZDOTDIR/core/plugins/zsh-ffa/helpers/run_fzf.zsh

# Main function
ffa() {
  local dir="$PWD"
  local fd_exclude_args=()
  local fd_type_args=()

  # Initialize debug and log_to_file flags
  debug=false
  log_to_file=false

  # Load configuration and determine split flag
  load_config

  # Check if the first argument is a directory
  if [[ -d $1 ]]; then
    dir="$1"
    shift
  fi

  # Parse options
  parse_options "$@" || return 0  # Return if help or error

  # Build fd exclude arguments
  build_fd_args

  # Check if dependencies exist
  check_deps || return 1

  # Verbose output
  verbose_output

  # Detect terminal emulator and clipboard command
  detect_terminal_and_clipboard || return 1

  # Run fzf to select files and directories
  run_fzf
}
