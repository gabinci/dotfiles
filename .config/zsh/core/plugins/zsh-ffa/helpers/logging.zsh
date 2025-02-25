#!/bin/zsh

# Default log file (can be overridden in configuration or command line)
LOG_FILE="$HOME/.ffa.log"

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
  local level="$1"
  local message="$2"
  local timestamp=$(date +"%H:%M:%S")

  local color_level
  case "$level" in
    INFO)
      color_level="${YELLOW}"
      ;;
    DEBUG)
      color_level="${GREEN}"
      ;;
    ERROR)
      color_level="${RED}"
      ;;
    *)
      color_level="${NC}"
      ;;
  esac

  local log_message="${BLUE}[$timestamp]${NC} ${color_level}[$level]${NC} $message"

  case "$level" in
    INFO)
      if [[ $verbose == true || $debug == true ]]; then
        echo -e "$log_message"
      fi
      ;;
    DEBUG)
      if [[ $debug == true ]]; then
        echo -e "$log_message"
      fi
      ;;
    ERROR)
      echo -e "$log_message" >&2
      ;;
    *)
      echo -e "${BLUE}[$timestamp]${NC} [UNKNOWN] $message"
      ;;
  esac

  # Log to file if enabled
  if [[ $log_to_file == true ]]; then
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
  fi
}

# Log an info message
log_info() {
  log "INFO" "$1"
}

# Log a debug message
log_debug() {
  log "DEBUG" "$1"
}

# Log an error message and return with a non-zero status code
log_error() {
  log "ERROR" "$1"
  return 1
}
