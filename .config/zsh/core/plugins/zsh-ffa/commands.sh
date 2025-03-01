#!/bin/zsh

# Define a structure to hold command details
typeset -A commands
commands=()

# Function to register a new command
register_command() {
  local name="$1"
  local description="$2"
  local execute="$3"

  commands["$name,description"]="$description"
  commands["$name,execute"]="$execute"
}

# Function to execute a registered command
execute_command() {
  local name="$1"
  shift
  
  local cmd="${commands["$name,execute"]}"
  if [[ -n "$cmd" ]]; then
    eval "$cmd" "$@"
    return $?
  else
    echo "Command '$name' not found" >&2
    return 1
  fi
}

# Function to get all registered command keys
get_command_keys() {
  local keys=()
  for key in ${(k)commands}; do
    if [[ $key == *,description ]]; then
      keys+=(${key%,description})
    fi
  done
  echo ${(j: :)keys}
}

# Function to construct the create command
construct_create_command() {
  local dir="$1"

  local create_cmd="printf 'Enter name (end with / for directory, press ESC to cancel): ' > /dev/tty; 
  name='';
  escape_pressed=false;
  while true; do
    read -k 1 -s char < /dev/tty;
    # Check if ESC was pressed (ASCII 27)
    if [[ \$char == \$'\e' ]]; then
      escape_pressed=true;
      break;
    # Check if Enter was pressed
    elif [[ \$char == \$'\n' ]]; then
      echo > /dev/tty;
      break;
    # Handle backspace (ASCII 127 or 8)
    elif [[ \$char == \$'\177' || \$char == \$'\b' ]]; then
      if [[ -n \"\$name\" ]]; then
        name=\${name:0:-1};
        printf \"\b \b\" > /dev/tty;
      fi;
    # Regular character input
    else
      name+=\"\$char\";
      printf \"%c\" \"\$char\" > /dev/tty;
    fi;
  done;
  
  if \$escape_pressed; then
    echo > /dev/tty;
    echo \"Operation cancelled\" > /dev/tty;
    return 1;
  elif [ -n \"\$name\" ]; then
    if [[ \"\$name\" == */ ]]; then
      mkdir -p \"$dir/\$name\" 2>/dev/null && 
      echo \"Created directory: \$name\" > /dev/tty ||
      echo \"Failed to create directory\" > /dev/tty;
    else
      touch \"$dir/\$name\" 2>/dev/null && 
      echo \"Created file: \$name\" > /dev/tty ||
      echo \"Failed to create file\" > /dev/tty;
    fi;
  else
    echo \"No name provided\" > /dev/tty;
  fi"

  echo "$create_cmd"
}

# Function to construct the rename command
construct_rename_command() {
  local dir="$1"

  local rename_cmd="
  if [[ {1} == \"..\" ]]; then
    echo \"Cannot rename the parent directory reference\" > /dev/tty;
    read -k 1 -s > /dev/tty;
    return 1;
  fi;
  
  local old_name=\"{1}\";
  local old_path=\"$dir/\$old_name\";
  local is_dir=false;
  [[ -d \"\$old_path\" ]] && is_dir=true;
  
  local default_name=\"\$old_name\";
  local extension=\"\";
  
  # Extract extension for files
  if ! \$is_dir && [[ \"\$old_name\" == *.* ]]; then
    extension=\".\${old_name##*.}\";
    default_name=\"\${old_name%\$extension}\";
  fi;
  
  # Print prompt with current name prefilled
  printf \"Rename '\$old_name' to (ESC to cancel): \" > /dev/tty;
  printf \"\$default_name\" > /dev/tty;
  
  name=\"\$default_name\";
  local cursor_pos=\${#name};
  local escape_pressed=false;
  
  # Enable raw terminal mode for arrow key handling
  stty raw -echo < /dev/tty;
  
  while true; do
    read -k 1 -s char < /dev/tty;
    # Check if ESC was pressed (ASCII 27)
    if [[ \$char == \$'\e' ]]; then
      read -k 2 -t 0.1 -s nextchar < /dev/tty 2>/dev/null;
      if [[ -z \$nextchar ]]; then
        escape_pressed=true;
        break;
      else
        # Arrow keys or other escape sequences - ignore for now
        continue;
      fi;
    # Check if Enter was pressed
    elif [[ \$char == \$'\n' || \$char == \$'\r' ]]; then
      break;
    # Handle backspace (ASCII 127 or 8)
    elif [[ \$char == \$'\177' || \$char == \$'\b' ]]; then
      if [[ \$cursor_pos -gt 0 ]]; then
        cursor_pos=\$((cursor_pos-1));
        name=\"\${name:0:\$cursor_pos}\${name:\$cursor_pos+1}\";
        printf \"\r\033[K\" > /dev/tty;  # Clear line
        printf \"Rename '\$old_name' to (ESC to cancel): \$name\" > /dev/tty;
        if [[ \$cursor_pos -lt \${#name} ]]; then
          printf \"\033[\$((\${#name} - \$cursor_pos))D\" > /dev/tty;  # Move cursor back
        fi;
      fi;
    # Regular character input
    else
      name=\"\${name:0:\$cursor_pos}\$char\${name:\$cursor_pos}\";
      cursor_pos=\$((cursor_pos+1));
      printf \"\r\033[K\" > /dev/tty;  # Clear line
      printf \"Rename '\$old_name' to (ESC to cancel): \$name\" > /dev/tty;
      if [[ \$cursor_pos -lt \${#name} ]]; then
        printf \"\033[\$((\${#name} - \$cursor_pos))D\" > /dev/tty;  # Move cursor back
      fi;
    fi;
  done;
  
  # Restore normal terminal mode
  stty -raw echo < /dev/tty;
  echo > /dev/tty;
  
  if \$escape_pressed; then
    echo \"Operation cancelled\" > /dev/tty;
    read -k 1 -s > /dev/tty;
    return 1;
  elif [ -n \"\$name\" ]; then
    # Add extension back for files
    if ! \$is_dir && [[ -n \$extension ]]; then
      name=\"\$name\$extension\";
    fi;
    
    # Add trailing slash for directories if needed
    if \$is_dir && [[ \"\$name\" != */ ]]; then
      name=\"\$name\";
    fi;
    
    if [[ \"\$old_name\" == \"\$name\" ]]; then
      echo \"No changes made\" > /dev/tty;
      read -k 1 -s > /dev/tty;
      return 0;
    fi;
    
    # Check if target already exists
    if [[ -e \"$dir/\$name\" ]]; then
      echo \"Error: Target '\$name' already exists\" > /dev/tty;
      read -k 1 -s > /dev/tty;
      return 1;
    fi;
    
    # Perform the rename
    mv \"$dir/\$old_name\" \"$dir/\$name\" 2>/dev/null;
    local result=\$?;
    if [[ \$result -eq 0 ]]; then
      echo \"Renamed '\$old_name' to '\$name'\" > /dev/tty;
    else
      echo \"Failed to rename '\$old_name' to '\$name'\" > /dev/tty;
    fi;
    read -k 1 -s > /dev/tty;
    return \$result;
  else
    echo \"No name provided\" > /dev/tty;
    read -k 1 -s > /dev/tty;
    return 1;
  fi"

  echo "$rename_cmd"
}
