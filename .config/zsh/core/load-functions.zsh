#!/bin/zsh

# Define the directory containing function scripts
FUNCTIONS_DIR="$ZDOTDIR/core/functions"

# Check if the directory exists before proceeding
if [[ -d "$FUNCTIONS_DIR" ]]; then
  for file in "$FUNCTIONS_DIR"/*(.N); do
    # Source the file only if it's readable
    [[ -r "$file" ]] && source "$file"
  done
else
  echo "Warning: Directory $FUNCTIONS_DIR does not exist." >&2
fi
