#!/bin/zsh

# Function to print help message
print_help() {
  local help_text="${CYAN}Usage:${NC} 
  ${GREEN}ffa [directory] [options]${NC}

${CYAN}Find and open files and directories with fzf, while excluding specified directories and file patterns.${NC}

${CYAN}Options:${NC}
  ${MAGENTA}-D <directory>${NC}                        # Add exclude directory
  ${MAGENTA}-e <pattern>${NC}                          # Add exclude pattern
  ${MAGENTA}-E <editor>${NC}                           # Specify editor (default: \$EDITOR or nvim)
  ${MAGENTA}-v${NC}                                    # Enable verbose mode
  ${MAGENTA}--debug${NC}                               # Enable debug mode
  ${MAGENTA}--log-to-file${NC}                         # Enable logging to file
  ${MAGENTA}-h, --help${NC}                            # Show this help message and exit
  ${MAGENTA}-i${NC}                                    # Hide hidden files and directories
  ${MAGENTA}-f${NC}                                    # Show only files
  ${MAGENTA}-d${NC}                                    # Show only directories

${CYAN}Examples:${NC}
  ${GREEN}ffa${NC}                                   # Run in current directory
  ${GREEN}ffa ~/projects${NC}                        # Run in specified directory
  ${GREEN}ffa -D build -D dist${NC}                  # Exclude 'build' and 'dist' directories
  ${GREEN}ffa -e \"*.log\" -e \"*.tmp\"${NC}             # Exclude '*.log' and '*.tmp' file patterns
  ${GREEN}ffa ~/projects -D dist -e \"*.log\"${NC}     # Combined usage
  ${GREEN}ffa -f${NC}                                # Show only files
  ${GREEN}ffa -d${NC}                                # Show only directories

${CYAN}Keybindings:${NC}
  ${YELLOW}tab${NC}                                   # Toggle selection and move down
  ${YELLOW}ctrl-e${NC}                                # Open selected file in editor
  ${YELLOW}ctrl-y${NC}                                # Copy file path to clipboard
  ${YELLOW}shift-up${NC}                              # Scroll preview up
  ${YELLOW}shift-down${NC}                            # Scroll preview down

${CYAN}Features:${NC}
  - Navigate directories and open files seamlessly using fzf.
  - Exclude specific directories and file patterns to refine your search.
  - Use multi-select to select multiple files or directories at once.
  - Exit with ESC and automatically change to the selected directory.
  - Navigate back to the parent directory using \`..\`.

${CYAN}Additional Information:${NC}
  - The default editor is nvim, but you can specify a different editor using the -E option.
  - Enable verbose mode with the -v option to get detailed output.
  - Enable debug mode with the --debug option for debugging purposes.
  - Log output to a file with the --log-to-file option."

  if command -v bat >/dev/null 2>&1; then
    echo "$help_text" | bat --paging=never --plain
  else
    echo "$help_text" | cat
  fi
}
