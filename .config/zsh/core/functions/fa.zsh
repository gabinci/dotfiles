fa() {
  local dir="${1:-$PWD}"  # Start in the given directory or PWD
  local item=$(echo ".." && fd -H -t f -t d . "$dir" | fzf --reverse --info=inline --prompt="[$dir] Choose a file or directory  ")

  if [[ -n "$item" ]]; then
    if [[ "$item" == ".." ]]; then
      fa "$(dirname "$dir")"  # Go up one level and reload
    elif [[ -d "$item" ]]; then
      fa "$item"  # If a directory is selected, reload inside it
    else
      echo "$item"  # If a file is selected, print its path
    fi
  fi
}
