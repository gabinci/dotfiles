#!/bin/zsh

# Function to toggle between foreground and background processes
function fg-bg() {
  if [[ -n $BUFFER ]]; then
    # If a job number or command is entered, attempt to foreground it
    zle accept-line  # Execute the entered command
  else
    # If no command is entered, suspend the current process (CTRL-Z behavior)
    fg >/dev/null 2>&1 || zle push-input
  fi
}

zle -N fg-bg
