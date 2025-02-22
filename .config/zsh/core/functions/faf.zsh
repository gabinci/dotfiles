#!/bin/zsh

faf() {
  # Define the global history file in the home directory
  local history_file="$HOME/.faf_history"

  # Create the temporary list from fd command
  local temp_file_list="$HOME/.temp_file_list"
  
  # Run fd to get updated file list and store in the temporary list
  fd -Htf --full-path --exclude .git/ \
     -E "*.png" -E "*.jpg" -E "*.jpeg" -E "*.gif" -E "*.bmp" -E "*.webp" -E "*.tiff" \
     -E "*.pdf" -E "*.epub" -E "*.zip" -E "*.tar" -E "*.gz" -E "*.rar" -E "*.7z" \
     -E "*.ico" -E "*.woff" -E "*.woff2" -E "*.otf" -E "*.ttf" -E "*.eot" \
     | awk '{print 0, $0}' > "$temp_file_list"

  # Check if the history file exists and compare it with the temp list
  if [[ ! -f $history_file ]]; then
    # If no history file, use the current file list to create it
    echo "History file not found, creating new history file."
    mv "$temp_file_list" "$history_file"
  else
    # If history file exists, compare it with the temp list by file size and timestamp
    local temp_modified_file=$(mktemp)
    local history_modified_file=$(mktemp)

    # Store the modified timestamp and file size for the current files in history
    while read -r line; do
      file_path=$(echo "$line" | cut -d ' ' -f2-)
      file_info=$(stat --format='%s %Y' "$file_path")
      echo "$file_info $file_path" >> "$history_modified_file"
    done < "$history_file"

    # Store the modified timestamp and file size for the files in the temp list
    while read -r file; do
      file_info=$(stat --format='%s %Y' "$file")
      echo "$file_info $file" >> "$temp_modified_file"
    done < "$temp_file_list"

    # Compare the file size and timestamp of the temp list with the history file
    if ! cmp -s "$temp_modified_file" "$history_modified_file"; then
      echo "Files have changed or new files have been added, updating history file."
      
      # Update the history file with the new file list, preserving the score
      awk 'NR==FNR {a[$2]=$0; next} $2 in a {print a[$2]; next} {print 0, $0}' "$history_file" "$temp_file_list" > "${history_file}.tmp"
      
      # Replace the old history file with the updated one
      mv "${history_file}.tmp" "$history_file"
    fi

    # Clean up the temporary modified files
    rm "$temp_modified_file" "$history_modified_file"
  fi

  # Sort the history file by score (highest first)
  sort -nr "$history_file" -o "$history_file"

  # Prepare the file list for fzf by displaying the number but passing only the file path for preview
  local file_list
  file_list=$(awk '{print $1 " " $2}' "$history_file")

  # Pass the sorted list to fzf with the desired preview configuration
  local selected_line
  selected_line=$(echo "$file_list" | fzf -m --reverse --info=inline --prompt="Choose files  " --preview="bat {2}")

  if [[ -n $selected_line ]]; then
    # Extract the score and file path
    local score file_path
    score=$(echo "$selected_line" | awk '{print $1}')
    file_path=$(echo "$selected_line" | cut -d ' ' -f2-)

    # Update the score in the history file
    awk -v path="$file_path" '
      $2 == path { $1++; print $0; next }
      { print $0 }
    ' "$history_file" > "${history_file}.tmp" && mv "${history_file}.tmp" "$history_file"

    # Resort the file so higher-ranked files stay on top
    sort -nr "$history_file" -o "$history_file"

    # Open the selected file in the editor
    $EDITOR "$file_path"
  fi

  # Clean up the temporary file list
  rm -f "$temp_file_list"
}
