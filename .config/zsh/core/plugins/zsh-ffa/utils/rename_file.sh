#!/bin/zsh

# Function to rename files or directories
rename_file() {
  local dir="$1"
  local old_name="$2"

  # Safety checks
  if [[ -z "$dir" || -z "$old_name" ]]; then
    echo "Missing directory or filename" > /dev/tty
    read -k 1 -s < /dev/tty
    return 1
  fi

  if [[ "$old_name" == ".." ]]; then
    echo "Cannot rename the parent directory reference" > /dev/tty
    read -k 1 -s < /dev/tty
    return 1
  fi

  local old_path="${dir}/${old_name}"
  local is_dir=false
  [[ -d "$old_path" ]] && is_dir=true

  local default_name="$old_name"
  local extension=""

  # Extract extension for files
  if ! $is_dir && [[ "$old_name" == *.* ]]; then
    extension=".${old_name##*.}"
    default_name="${old_name%$extension}"
  fi

  # Print prompt with current name prefilled
  printf "Rename '%s' to (ESC to cancel): " "$old_name" > /dev/tty
  printf "%s" "$default_name" > /dev/tty

  local name="$default_name"
  local escape_pressed=false

  # Read input character by character
  while true; do
    read -k 1 -s char < /dev/tty
    # Check if ESC was pressed (ASCII 27)
    if [[ $char == $'\e' ]]; then
      escape_pressed=true
      break
    # Check if Enter was pressed
    elif [[ $char == $'\n' || $char == $'\r' ]]; then
      break
    # Handle backspace (ASCII 127 or 8)
    elif [[ $char == $'\177' || $char == $'\b' ]]; then
      if [[ ${#name} -gt 0 ]]; then
        name="${name:0:-1}"
        printf "\b \b" > /dev/tty
      fi
    # Regular character input
    else
      name+="$char"
      printf "%c" "$char" > /dev/tty
    fi
  done

  echo > /dev/tty

  if $escape_pressed; then
    echo "Operation cancelled" > /dev/tty
    read -k 1 -s < /dev/tty
    return 1
  elif [ -n "$name" ]; then
    # Add extension back for files
    if ! $is_dir && [[ -n $extension ]]; then
      name="${name}${extension}"
    fi
    
    if [[ "$old_name" == "$name" ]]; then
      echo "No changes made" > /dev/tty
      read -k 1 -s < /dev/tty
      return 0
    fi
    
    # Check if target already exists
    if [[ -e "${dir}/${name}" ]]; then
      echo "Error: Target '${name}' already exists" > /dev/tty
      read -k 1 -s < /dev/tty
      return 1
    fi
    
    # Perform the rename
    mv "${dir}/${old_name}" "${dir}/${name}" 2>/dev/null
    local result=$?
    
    if [[ $result -eq 0 ]]; then
      echo "Renamed '${old_name}' to '${name}'" > /dev/tty
    else
      echo "Failed to rename '${old_name}' to '${name}'" > /dev/tty
    fi
    read -k 1 -s < /dev/tty
    return $result
  else
    echo "No name provided" > /dev/tty
    read -k 1 -s < /dev/tty
    return 1
  fi
}

# No need to export - zsh automatically makes functions available to subshells
# We'll handle function visibility in the main script
