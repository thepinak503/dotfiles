#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'
check_tool() {
    local tool=$1
    local importance=$2
    if command -v "$tool" &>/dev/null; then
        printf "  %b%-15s%b [ FOUND ]\n" "${GREEN}" "$tool" "${NC}"
        return 0
    else
        printf "  %b%-15s%b [ MISSING ] - %s\n" "${RED}" "$tool" "${NC}" "$importance"
        return 1
    fi
}
echo -e "\n${CYAN}═══════════════════════════════════════════${NC}"
echo -e "${BOLD}   PINAK'S DOTFILES HEALTH CHECK${NC}"
echo -e "${CYAN}═══════════════════════════════════════════${NC}\n"
echo -e "${BOLD}Core Productivity:${NC}"
check_tool "starship" "Required for the world-class prompt."
check_tool "zoxide"   "Required for fast navigation (fz/z)."
check_tool "fzf"      "Required for interactive select (v/fshow)."
check_tool "rg"       "Required for fast search (grep replacement)."
echo -e "\n${BOLD}Modern Visuals:${NC}"
check_tool "eza"      "Required for beautiful file listing (ls replacement)."
check_tool "bat"      "Required for syntax highlit previews (cat replacement)."
check_tool "fastfetch" "Required for fast system info (neofetch replacement)."
check_tool "delta"    "Required for beautiful git diffs (diff replacement)."
echo -e "\n${BOLD}DevOps & Tools:${NC}"
check_tool "docker"   "Enables 60+ container aliases."
check_tool "kubectl"  "Enables 70+ kubernetes aliases."
check_tool "terraform" "Enables 30+ terraform aliases."
check_tool "helm"      "Enables 25+ helm aliases."
echo -e "\n${BOLD}System Status:${NC}"
if [[ "$DOTFILES_MODE" == "ultra-nerd" ]]; then
    echo -e "  Mode: ${GREEN}ULTRA-NERD${NC} (Maximum Potential Enabled)"
else
    echo -e "  Mode: ${YELLOW}$DOTFILES_MODE${NC} (Try: 'chmode ultra-nerd' for full power)"
fi
echo -e "\n${CYAN}═══════════════════════════════════════════${NC}"
echo -e "Recommendation: Install missing tools to reach 100% potential."
echo -e "Use your package manager (pacman/apt/brew) to upgrade."
echo -e "${CYAN}═══════════════════════════════════════════${NC}\n"
