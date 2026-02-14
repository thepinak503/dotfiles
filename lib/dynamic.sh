#!/usr/bin/env bash
# =============================================================================
# DYNAMIC LIBRARY - Auto-detection and Environment Setup
# This file provides elastic/dynamic functionality that adapts to the system
# =============================================================================

# Prevent multiple sourcing
[[ -n "${_DOTFILES_DYNAMIC_LIB_SOURCED}" ]] && return 0
_DOTFILES_DYNAMIC_LIB_SOURCED=1

# =============================================================================
# COLOR DEFINITIONS (Dynamic - checks terminal capability)
# =============================================================================

# Check if terminal supports colors
if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    export HAS_COLORS=1
    export C_RESET='\033[0m'
    export C_BOLD='\033[1m'
    export C_DIM='\033[2m'
    export C_UNDERLINE='\033[4m'
    export C_BLINK='\033[5m'
    export C_REVERSE='\033[7m'
    export C_HIDDEN='\033[8m'
    
    # Standard colors
    export C_BLACK='\033[0;30m'
    export C_RED='\033[0;31m'
    export C_GREEN='\033[0;32m'
    export C_YELLOW='\033[0;33m'
    export C_BLUE='\033[0;34m'
    export C_MAGENTA='\033[0;35m'
    export C_CYAN='\033[0;36m'
    export C_WHITE='\033[0;37m'
    
    # Bright colors
    export C_BBLACK='\033[1;30m'
    export C_BRED='\033[1;31m'
    export C_BGREEN='\033[1;32m'
    export C_BYELLOW='\033[1;33m'
    export C_BBLUE='\033[1;34m'
    export C_BMAGENTA='\033[1;35m'
    export C_BCYAN='\033[1;36m'
    export C_BWHITE='\033[1;37m'
    
    # Background colors
    export C_BG_BLACK='\033[40m'
    export C_BG_RED='\033[41m'
    export C_BG_GREEN='\033[42m'
    export C_BG_YELLOW='\033[43m'
    export C_BG_BLUE='\033[44m'
    export C_BG_MAGENTA='\033[45m'
    export C_BG_CYAN='\033[46m'
    export C_BG_WHITE='\033[47m'
else
    export HAS_COLORS=0
    export C_RESET=''
    export C_BOLD=''
    export C_DIM=''
    export C_UNDERLINE=''
    export C_BLINK=''
    export C_REVERSE=''
    export C_HIDDEN=''
    export C_BLACK=''
    export C_RED=''
    export C_GREEN=''
    export C_YELLOW=''
    export C_BLUE=''
    export C_MAGENTA=''
    export C_CYAN=''
    export C_WHITE=''
    export C_BBLACK=''
    export C_BRED=''
    export C_BGREEN=''
    export C_BYELLOW=''
    export C_BBLUE=''
    export C_BMAGENTA=''
    export C_BCYAN=''
    export C_BWHITE=''
    export C_BG_BLACK=''
    export C_BG_RED=''
    export C_BG_GREEN=''
    export C_BG_YELLOW=''
    export C_BG_BLUE=''
    export C_BG_MAGENTA=''
    export C_BG_CYAN=''
    export C_BG_WHITE=''
fi

# =============================================================================
# LOGGING FUNCTIONS (Dynamic - adapt to environment)
# =============================================================================

# Print with color if supported
_print_colored() {
    local color="$1"
    shift
    if [[ "$HAS_COLORS" -eq 1 ]]; then
        echo -e "${color}$*${C_RESET}"
    else
        echo "$*"
    fi
}

# Logging functions that work in any environment
log_ok() { _print_colored "$C_GREEN" "[✓] $*"; }
log_error() { _print_colored "$C_RED" "[✗] $*"; }
log_warn() { _print_colored "$C_YELLOW" "[⚠] $*"; }
log_info() { _print_colored "$C_BLUE" "[ℹ] $*"; }
log_note() { _print_colored "$C_CYAN" "[→] $*"; }
log_action() { _print_colored "$C_MAGENTA" "[⚡] $*"; }

# =============================================================================
# DETECTION FUNCTIONS (Dynamic environment detection)
# =============================================================================

# Detect OS
_detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            arch|manjaro|endeavouros) echo "arch" ;;
            debian|ubuntu|pop|linuxmint) echo "debian" ;;
            fedora|rhel|centos|amzn) echo "fedora" ;;
            opensuse*|suse*) echo "opensuse" ;;
            *) echo "$ID" ;;
        esac
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}
export DETECTED_OS=$(_detect_os)

# Detect package manager
_detect_pkg_manager() {
    if command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    elif command -v brew &>/dev/null; then
        echo "brew"
    else
        echo "unknown"
    fi
}
export DETECTED_PKG_MANAGER=$(_detect_pkg_manager)

# Detect desktop environment
_detect_de() {
    if [[ -n "$XDG_CURRENT_DESKTOP" ]]; then
        echo "$XDG_CURRENT_DESKTOP"
    elif [[ -n "$DESKTOP_SESSION" ]]; then
        echo "$DESKTOP_SESSION"
    elif pgrep -x "sway" >/dev/null; then
        echo "sway"
    elif pgrep -x "hyprland" >/dev/null; then
        echo "hyprland"
    elif pgrep -x "i3" >/dev/null; then
        echo "i3"
    else
        echo "unknown"
    fi
}
export DETECTED_DE=$(_detect_de)

# Detect if running in container
_detect_container() {
    if [[ -f /.dockerenv ]] || grep -q "docker" /proc/1/cgroup 2>/dev/null; then
        echo "docker"
    elif [[ -f /run/.containerenv ]] || grep -q "containerd" /proc/1/cgroup 2>/dev/null; then
        echo "containerd"
    elif [[ -n "$container" ]]; then
        echo "$container"
    else
        echo "none"
    fi
}
export DETECTED_CONTAINER=$(_detect_container)

# Detect display server
_detect_display_server() {
    if [[ -n "$WAYLAND_DISPLAY" ]]; then
        echo "wayland"
    elif [[ -n "$DISPLAY" ]]; then
        echo "x11"
    else
        echo "none"
    fi
}
export DETECTED_DISPLAY_SERVER=$(_detect_display_server)

# Detect terminal emulator
_detect_terminal() {
    if [[ -n "$TERM_PROGRAM" ]]; then
        echo "$TERM_PROGRAM"
    elif [[ "$TERM" == "xterm-kitty" ]]; then
        echo "kitty"
    elif [[ "$TERM" == "alacritty" ]]; then
        echo "alacritty"
    elif [[ -n "$WEZTERM_EXECUTABLE" ]]; then
        echo "wezterm"
    elif [[ "$TERM" == "xterm-256color" ]] || [[ "$TERM" == "xterm" ]]; then
        echo "xterm"
    else
        echo "$TERM"
    fi
}
export DETECTED_TERMINAL=$(_detect_terminal)

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Check if command exists (more robust than 'command -v')
has_command() {
    command -v "$1" &>/dev/null
}

# Check if function exists
has_function() {
    declare -f "$1" &>/dev/null
}

# Check if in interactive shell
is_interactive() {
    [[ $- == *i* ]]
}

# Check if in TTY
is_tty() {
    [[ "$(tty)" == /dev/tty* ]]
}

# Check if has internet connection
has_internet() {
    ping -c 1 -W 2 8.8.8.8 &>/dev/null || \
    ping -c 1 -W 2 1.1.1.1 &>/dev/null
}

# Get CPU count
get_cpu_count() {
    nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo "1"
}
export CPU_COUNT=$(get_cpu_count)

# Get total memory in MB
get_total_memory() {
    if [[ -f /proc/meminfo ]]; then
        awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo
    elif command -v sysctl &>/dev/null; then
        sysctl -n hw.memsize 2>/dev/null | awk '{print int($1/1024/1024)}'
    else
        echo "unknown"
    fi
}
export TOTAL_MEMORY=$(get_total_memory)

# =============================================================================
# PROGRESS FUNCTIONS (Arch-Hyprland style with adaptations)
# =============================================================================

# Show spinner progress (non-blocking)
show_spinner() {
    local pid=$1
    local message="${2:-Loading...}"
    local spin_chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local i=0
    
    # Hide cursor
    tput civis 2>/dev/null || true
    
    while ps -p "$pid" &>/dev/null; do
        printf "\r%s %s" "${spin_chars[i]}" "$message"
        i=$(( (i + 1) % 10 ))
        sleep 0.1
    done
    
    printf "\r✓ %s%-20s\n" "$message" ""
    
    # Show cursor
    tput cnorm 2>/dev/null || true
}

# Progress bar
show_progress_bar() {
    local current=$1
    local total=$2
    local width=${3:-40}
    local message="${4:-Progress}"
    
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    printf "\r%s [" "$message"
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" "$percentage"
    
    if [[ $current -eq $total ]]; then
        echo ""
    fi
}

# =============================================================================
# DYNAMIC MODE SELECTION
# =============================================================================

# Auto-select dotfiles mode based on system resources
auto_select_mode() {
    local mode="advanced"
    
    # If low memory (< 2GB), use basic mode
    if [[ "$TOTAL_MEMORY" != "unknown" ]] && [[ "$TOTAL_MEMORY" -lt 2048 ]]; then
        mode="basic"
    # If in container, use basic mode
    elif [[ "$DETECTED_CONTAINER" != "none" ]]; then
        mode="advanced"
    # If no colors, use basic mode
    elif [[ "$HAS_COLORS" -eq 0 ]]; then
        mode="basic"
    # If TTY, use basic mode
    elif is_tty; then
        mode="basic"
    fi
    
    echo "$mode"
}

# Set mode if not already set
if [[ -z "$DOTFILES_MODE" ]]; then
    export DOTFILES_MODE=$(auto_select_mode)
fi

# =============================================================================
# ENVIRONMENT INFO DISPLAY
# =============================================================================

# Show environment info (useful for debugging)
show_env_info() {
    echo "╔════════════════════════════════════════════════╗"
    echo "║     DYNAMIC ENVIRONMENT DETECTION              ║"
    echo "╚════════════════════════════════════════════════╝"
    echo ""
    log_info "Operating System: $DETECTED_OS"
    log_info "Package Manager:  $DETECTED_PKG_MANAGER"
    log_info "Desktop Env:      $DETECTED_DE"
    log_info "Display Server:   $DETECTED_DISPLAY_SERVER"
    log_info "Terminal:         $DETECTED_TERMINAL"
    log_info "Container:        $DETECTED_CONTAINER"
    log_info "Dotfiles Mode:    $DOTFILES_MODE"
    log_info "Colors Support:   $([[ $HAS_COLORS -eq 1 ]] && echo "Yes (256 colors)" || echo "No")"
    log_info "CPU Count:        $CPU_COUNT"
    log_info "Total Memory:     ${TOTAL_MEMORY}MB"
    echo ""
}

# Only show in ultra-nerd mode and interactive
if [[ "$DOTFILES_MODE" == "ultra-nerd" ]] && is_interactive; then
    show_env_info
fi