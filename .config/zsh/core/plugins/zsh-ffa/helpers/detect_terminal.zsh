#!/bin/zsh

source "${0:A:h}/logging.zsh"

# Function to detect the terminal emulator
detect_terminal() {
  local terminal_emulator="unknown"

  # Check for Termux environment
  if [[ -n $TERMUX_VERSION ]]; then
    terminal_emulator="termux"
  elif [[ -n $TERM_PROGRAM ]]; then
    terminal_emulator="$TERM_PROGRAM"
  elif [[ -n $TERMINAL_EMULATOR ]]; then
    terminal_emulator="$TERMINAL_EMULATOR"
  elif [[ -n $XTERM_VERSION ]]; then
    terminal_emulator="xterm"
  else
    # Fallback to checking the process tree
    local parent_pid=$PPID
    while [[ $parent_pid -ne 1 ]]; do
      terminal_emulator=$(ps -p $parent_pid -o comm= 2>/dev/null | tr -d ' ')
      case $terminal_emulator in
        gnome-terminal*|konsole*|xfce4-terminal*|xterm*|alacritty*|kitty*|hyper*|termite*|st*|urxvt*|tilix*|guake*|tilda*|wezterm*|foot*|qterminal*|sakura*|termux*|vscode*|contour*|termit*|lxterminal*)
          break
          ;;
        *)
          terminal_emulator="unknown"
          ;;
      esac
      parent_pid=$(ps -p $parent_pid -o ppid= 2>/dev/null | tr -d ' ')
      if [[ -z $parent_pid ]]; then
        break
      fi
    done
  fi

  log_debug "Terminal emulator detected: $terminal_emulator"
  echo "$terminal_emulator"
}

# Detect terminal emulator and clipboard command
detect_terminal_and_clipboard() {
  local terminal_emulator=$(detect_terminal)
  if [[ $terminal_emulator == "termux" ]]; then
    # Check if termux-api is installed
    if ! command -v termux-clipboard-set >/dev/null 2>&1; then
      log_error "Error: termux-api is not installed."
      return 1
    fi
    clipboard_cmd="termux-clipboard-set"
  elif command -v pbcopy >/dev/null 2>&1; then
    clipboard_cmd="pbcopy"
  elif command -v xclip >/dev/null 2>&1; then
    clipboard_cmd="xclip -selection clipboard"
  elif command -v xsel >/dev/null 2>&1; then
    clipboard_cmd="xsel --clipboard --input"
  else
    log_error "Error: No clipboard command found."
    return 1
  fi

  log_debug "Clipboard command set to: $clipboard_cmd"
}
