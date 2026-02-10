#!/usr/bin/env bash
# =============================================================================
# LIB/COLORS.SH - Shared Color Definitions and Print Functions
# =============================================================================
# Source this file to get consistent colors and print functions across all
# dotfiles components. Prevents duplication and ensures consistency.
#
# Usage:
#   source "$DOTFILES_DIR/lib/colors.sh"
#   print_success "Operation completed"
#
# Dependencies: None
# =============================================================================

# Guard against multiple sourcing
if [[ -n "${_DOTFILES_COLORS_SOURCED:-}" ]]; then
    return 0
fi

# =============================================================================
# COLOR DEFINITIONS
# =============================================================================

# Standard Colors
readonly C_RESET='\033[0m'
readonly C_BOLD='\033[1m'
readonly C_DIM='\033[2m'
readonly C_UNDERLINE='\033[4m'
readonly C_BLINK='\033[5m'
readonly C_REVERSE='\033[7m'
readonly C_HIDDEN='\033[8m'

# Foreground Colors
readonly C_BLACK='\033[0;30m'
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_YELLOW='\033[0;33m'
readonly C_BLUE='\033[0;34m'
readonly C_PURPLE='\033[0;35m'
readonly C_CYAN='\033[0;36m'
readonly C_WHITE='\033[0;37m'

# Bright Foreground Colors
readonly C_BBLACK='\033[1;30m'
readonly C_BRED='\033[1;31m'
readonly C_BGREEN='\033[1;32m'
readonly C_BYELLOW='\033[1;33m'
readonly C_BBLUE='\033[1;34m'
readonly C_BPURPLE='\033[1;35m'
readonly C_BCYAN='\033[1;36m'
readonly C_BWHITE='\033[1;37m'

# Background Colors
readonly C_BG_BLACK='\033[40m'
readonly C_BG_RED='\033[41m'
readonly C_BG_GREEN='\033[42m'
readonly C_BG_YELLOW='\033[43m'
readonly C_BG_BLUE='\033[44m'
readonly C_BG_PURPLE='\033[45m'
readonly C_BG_CYAN='\033[46m'
readonly C_BG_WHITE='\033[47m'

# =============================================================================
# PRINT FUNCTIONS
# =============================================================================

# Print success message (green checkmark)
print_success() {
    printf "%b✓%b %s\n" "$C_GREEN" "$C_RESET" "$*"
}

# Print error message (red X)
print_error() {
    printf "%b✗%b %s\n" "$C_RED" "$C_RESET" "$*" >&2
}

# Print info message (blue i)
print_info() {
    printf "%bℹ%b %s\n" "$C_BLUE" "$C_RESET" "$*"
}

# Print warning message (yellow warning)
print_warning() {
    printf "%b⚠%b %s\n" "$C_YELLOW" "$C_RESET" "$*"
}

# Print step message (purple arrow)
print_step() {
    printf "%b→%b %s\n" "$C_PURPLE" "$C_RESET" "$*"
}

# Print debug message (dimmed)
print_debug() {
    [[ "${DOTFILES_DEBUG:-0}" == "1" ]] && printf "%b[D]%b %s\n" "$C_DIM" "$C_RESET" "$*"
}

# Print header with border
print_header() {
    local title="$1"
    local width=60
    local padding=$(( (width - ${#title}) / 2 ))
    
    printf "%b╔%s╗\n" "$C_BCYAN" "$(printf '═%.0s' $(seq 1 $((width-2))))"
    printf "║%*s%s%*s║\n" $padding "" "$title" $((padding - (width - ${#title}) % 2)) ""
    printf "╚%s╝%b\n" "$(printf '═%.0s' $(seq 1 $((width-2))))" "$C_RESET"
}

# Print section divider
print_divider() {
    printf "%b%s%b\n" "$C_DIM" "$(printf '─%.0s' $(seq 1 60))" "$C_RESET"
}

# =============================================================================
# ERROR HANDLING FUNCTIONS
# =============================================================================

# Die with error message
_die() {
    print_error "$*"
    exit 1
}

# Warn but continue
_warn() {
    print_warning "$*"
}

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Check if command exists
_has_command() {
    command -v "$1" &>/dev/null
}

# Check if function exists
_has_function() {
    declare -f "$1" &>/dev/null
}

# Check if directory exists
_has_dir() {
    [[ -d "$1" ]]
}

# Check if file exists
_has_file() {
    [[ -f "$1" ]]
}

# Check if running interactively
_is_interactive() {
    [[ $- == *i* ]]
}

# Check if running in a terminal
_is_tty() {
    [[ -t 1 ]]
}

# Get OS ID
_get_os() {
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "$ID"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Check if running on specific OS
_is_os() {
    [[ "$(_get_os)" == "$1" ]]
}

# =============================================================================
# VALIDATION FUNCTIONS
# =============================================================================

# Validate non-empty argument
_require_arg() {
    [[ -n "$1" ]] || _die "Usage: $2"
}

# Validate command exists
_require_cmd() {
    _has_command "$1" || _die "Required command not found: $1"
}

# Validate file exists
_require_file() {
    _has_file "$1" || _die "Required file not found: $1"
}

# Validate directory exists
_require_dir() {
    _has_dir "$1" || _die "Required directory not found: $1"
}

# =============================================================================
# PATH MANAGEMENT
# =============================================================================

# Append to PATH (only if directory exists and not already in PATH)
_path_append() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="${PATH:+$PATH:}$1"
    fi
}

# Prepend to PATH (only if directory exists and not already in PATH)
_path_prepend() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1${PATH:+:$PATH}"
    fi
}

# Remove from PATH
_path_remove() {
    export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "^$1$" | tr '\n' ':')
}

# =============================================================================
# CACHE FUNCTIONS
# =============================================================================

# Get cache file path
_cache_file() {
    local name="$1"
    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles"
    [[ -d "$cache_dir" ]] || mkdir -p "$cache_dir"
    echo "$cache_dir/$name"
}

# Check if cache is fresh (default 1 hour)
_cache_fresh() {
    local cache_file="$1"
    local max_age="${2:-3600}"  # seconds
    
    [[ -f "$cache_file" ]] || return 1
    
    local file_age=$(( $(date +%s) - $(stat -c %Y "$cache_file" 2>/dev/null || stat -f %m "$cache_file" 2>/dev/null || echo 0) ))
    [[ $file_age -lt $max_age ]]
}

# Write to cache
_cache_write() {
    local cache_file="$1"
    shift
    echo "$*" > "$cache_file"
}

# Read from cache
_cache_read() {
    local cache_file="$1"
    [[ -f "$cache_file" ]] && cat "$cache_file"
}

# =============================================================================
# MARK AS SOURCED
# =============================================================================

_DOTFILES_COLORS_SOURCED=1

# =============================================================================
# EXPORTS
# =============================================================================

export -f print_success print_error print_info print_warning print_step print_debug
export -f print_header print_divider
export -f _die _warn
export -f _has_command _has_function _has_dir _has_file
export -f _is_interactive _is_tty _get_os _is_os
export -f _require_arg _require_cmd _require_file _require_dir
export -f _path_append _path_prepend _path_remove
export -f _cache_file _cache_fresh _cache_write _cache_read
