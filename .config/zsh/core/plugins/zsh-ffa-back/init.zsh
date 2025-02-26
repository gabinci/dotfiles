#!/bin/zsh

# Source all necessary files
source "${0:A:h}/helpers/colors.zsh" || { echo "Failed to source colors.zsh"; return 1 }
source "${0:A:h}/helpers/logging.zsh" || { echo "Failed to source logging.zsh"; return 1 }
source "${0:A:h}/helpers/detect_terminal.zsh" || { echo "Failed to source detect_terminal.zsh"; return 1 }
source "${0:A:h}/helpers/dependencies.zsh" || { echo "Failed to source dependencies.zsh"; return 1 }
source "${0:A:h}/helpers/load_config.zsh" || { echo "Failed to source load_config.zsh"; return 1 }
source "${0:A:h}/helpers/print_help.zsh" || { echo "Failed to source print_help.zsh"; return 1 }
source "${0:A:h}/helpers/options_parser.zsh" || { echo "Failed to source option_parserr.zsh"; return 1 }
source "${0:A:h}/helpers/run_fzf.zsh" || { echo "Failed to source run_fzf.zsh"; return 1 }
