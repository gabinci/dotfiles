#!/bin/zsh
# Function to print help message
print_help() {
  local help_text="Usage: 
  ffa [directory] [options]

Find and open files and directories with fzf, while excluding specified directories and file patterns.

Options:
  -d <directory>                        # Add exclude directory
  -e <pattern>                          # Add exclude pattern
  -E <editor>                           # Specify editor (default: \$EDITOR or nvim)
  -v                                    # Enable verbose mode
  -h, --help                            # Show this help message and exit
  -i                                    # Hide hidden files and directories

Examples:
  ffa                                   # Run in current directory
  ffa ~/projects                        # Run in specified directory
  ffa -d build -d dist                  # Exclude 'build' and 'dist' directories
  ffa -e \"*.log\" -e \"*.tmp\"             # Exclude '*.log' and '*.tmp' file patterns
  ffa ~/projects -d dist -e \"*.log\"     # Combined usage
"

  if command -v bat >/dev/null 2>&1; then
    echo "$help_text" | bat --paging=never --plain
  else
    echo "$help_text" | cat
  fi
}
