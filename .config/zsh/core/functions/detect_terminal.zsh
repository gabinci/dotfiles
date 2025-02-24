#!/bin/zsh

# Function to detect the terminal emulator
detect_terminal() {
  # Check for Termux environment
  if [[ -n $TERMUX_VERSION ]]; then
    echo "termux"
    return
  fi

  # Check common environment variables set by terminal emulators
  if [[ -n $TERM_PROGRAM ]]; then
    echo "$TERM_PROGRAM"
    return
  fi

  if [[ -n $TERMINAL_EMULATOR ]]; then
    echo "$TERMINAL_EMULATOR"
    return
  fi

  if [[ -n $XTERM_VERSION ]]; then
    echo "xterm"
    return
  fi

  # Fallback to checking the process tree
  local parent_pid=$PPID
  while [[ $parent_pid -ne 1 ]]; do
    local terminal_emulator=$(ps -p $parent_pid -o comm= 2>/dev/null | tr -d ' ')
    case $terminal_emulator in
      gnome-terminal*|konsole*|xfce4-terminal*|xterm*|alacritty*|kitty*|hyper*|termite*|st*|urxvt*|tilix*|guake*|tilda*|wezterm*|foot*|qterminal*|sakura*|termux*|vscode*|contour*|termit*|lxterminal*)
        echo "$terminal_emulator"
        return
        ;;
    esac
    parent_pid=$(ps -p $parent_pid -o ppid= 2>/dev/null | tr -d ' ')
    if [[ -z $parent_pid ]]; then
      break
    fi
  done

  echo "unknown"
}
