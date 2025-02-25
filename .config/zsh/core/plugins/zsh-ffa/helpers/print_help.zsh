#!/bin/zsh

# Function to print help message
print_help() {
  local help_text="Usage: 
  ffa [directory] [options]

Find and open files and directories with fzf, while excluding specified directories and file patterns.

Options:
  -D <directory>                        # Add exclude directory
  -e <pattern>                          # Add exclude pattern
  -E <editor>                           # Specify editor (default: \$EDITOR or nvim)
  -v                                    # Enable verbose mode
  --debug                               # Enable debug mode
  --log-to-file                         # Enable logging to file
  -h, --help                            # Show this help message and exit
  -i                                    # Hide hidden files and directories
  -f                                    # Show only files
  -d                                    # Show only directories

Examples:
  ffa                                   # Run in current directory
  ffa ~/projects                        # Run in specified directory
  ffa -D build -D dist                  # Exclude 'build' and 'dist' directories
  ffa -e \"*.log\" -e \"*.tmp\"             # Exclude '*.log' and '*.tmp' file patterns
  ffa ~/projects -D dist -e \"*.log\"     # Combined usage
  ffa -f                                # Show only files
  ffa -d                                # Show only directories

Keybindings:
  tab                                   # Toggle selection and move down
  ctrl-e                                # Open selected file in editor
  ctrl-y                                # Copy file path to clipboard
"

  if command -v bat >/dev/null 2>&1; then
    echo "$help_text" | bat --paging=never --plain
  else
    echo "$help_text" | cat
  fi
}
