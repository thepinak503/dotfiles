#!/bin/bash
# =============================================================================
# SYSTEM INFO SCRIPT
# Quick system diagnostics
# =============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║           SYSTEM INFORMATION                               ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# OS Info
print_os() {
    echo -e "${BOLD}Operating System:${NC}"
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "  Name: $NAME"
        echo "  Version: $VERSION"
        echo "  ID: $ID"
    fi
    echo "  Kernel: $(uname -r)"
    echo "  Architecture: $(uname -m)"
    echo ""
}

# Hardware Info
print_hardware() {
    echo -e "${BOLD}Hardware:${NC}"
    echo "  CPU: $(grep -m1 'model name' /proc/cpuinfo | cut -d':' -f2 | xargs)"
    echo "  CPU Cores: $(nproc)"
    
    if command -v free &>/dev/null; then
        echo "  Memory:"
        free -h | grep -E "Mem|Swap" | sed 's/^/    /'
    fi
    
    echo "  Disk Usage:"
    df -h / | tail -1 | sed 's/^/    /'
    echo ""
}

# Shell Info
print_shell() {
    echo -e "${BOLD}Shell Environment:${NC}"
    echo "  Current Shell: $SHELL"
    echo "  Terminal: $TERM"
    echo "  User: $(whoami)"
    echo "  Home: $HOME"
    echo "  Working Directory: $(pwd)"
    echo ""
}

# Dotfiles Status
print_dotfiles() {
    echo -e "${BOLD}Dotfiles Status:${NC}"
    
    if [[ -d ~/.dotfiles ]]; then
        echo "  Location: ~/.dotfiles"
        cd ~/.dotfiles
        echo "  Branch: $(git branch --show-current 2>/dev/null || echo 'N/A')"
        echo "  Version: $(git describe --tags --always 2>/dev/null || echo 'dev')"
        echo "  Last Commit: $(git log -1 --format=%cd --date=short 2>/dev/null || echo 'N/A')"
        
        # Check shells
        echo ""
        echo "  Configured Shells:"
        [[ -f ~/.bashrc ]] && echo "    ✓ Bash" || echo "    ✗ Bash"
        [[ -f ~/.zshrc ]] && echo "    ✓ Zsh" || echo "    ✗ Zsh"
        [[ -d ~/.config/fish ]] && echo "    ✓ Fish" || echo "    ✗ Fish"
        [[ -d ~/.config/nushell ]] && echo "    ✓ Nushell" || echo "    ✗ Nushell"
    else
        echo "  ${RED}✗ Dotfiles not installed${NC}"
    fi
    echo ""
}

# Tool Status
print_tools() {
    echo -e "${BOLD}Modern Tools:${NC}"
    
    tools=("starship" "fzf" "zoxide" "eza" "bat" "ripgrep" "fd" "delta" "fastfetch")
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            version=$($tool --version 2>/dev/null | head -1 || echo "installed")
            echo -e "  ${GREEN}✓${NC} $tool: $version"
        else
            echo -e "  ${RED}✗${NC} $tool: not installed"
        fi
    done
    echo ""
}

# Network Info
print_network() {
    echo -e "${BOLD}Network:${NC}"
    echo "  Hostname: $(hostname)"
    
    # Internal IPs
    echo "  Internal IPs:"
    ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1" | sed 's/^/    /'
    
    # External IP (optional)
    echo "  External IP: $(curl -s -4 https://ifconfig.me 2>/dev/null || echo 'Unable to fetch')"
    echo ""
}

# Main
main() {
    print_header
    print_os
    print_hardware
    print_shell
    print_dotfiles
    print_tools
    print_network
}

main
