#!/usr/bin/env sh
# =============================================================================
# Tool Status and Installation System
# =============================================================================
#
# Comprehensive tool management system that tracks the availability of
# 50+ command-line tools across 8 feature phases. Provides status
# reports, installation hints, and feature phase summaries.
#
# Architecture:
#   Tools are organized into categories (phases) representing different
#   use cases: core, shell enhancement, file operations, development,
#   DevOps, cloud CLI, security, and extras.
#
#   Each tool has an associated HINT variable (DOTTOOLS_HINT_<tool>)
#   containing its description and package names for various managers.
#   The hint format: "Description|ArchPkg|DebPkg|BrewPkg"
#
# Phases:
#   Phase 1 - CORE (required):      git, curl, wget, tar, gzip, unzip, openssl
#   Phase 2 - SHELL ENHANCEMENT:    starship, zoxide, fzf
#   Phase 3 - FILE OPERATIONS:      eza, bat, fd, rg, delta, ncdu, duf
#   Phase 4 - DEVELOPER DAILY:      nvim, tmux, lazygit, yazi, zellij, fastfetch
#   Phase 5 - DEVOPS/CONTAINERS:    docker, kubectl, helm, terraform, ansible
#   Phase 6 - CLOUD CLI:            aws, gcloud, az
#   Phase 7 - SECURITY:             gpg, shred, nmap, netstat, ss, lsof
#   Phase 8 - EXTRAS:               jq, yq, hyperfine, tokei, glow, tldr, gping, duf, dust, procs
#
# Functions:
#   dottools    - Display formatted tool status report
#   dotinstall  - Show install commands for missing tools
#   dotphase    - Show active feature phases
#
# Display:
#   - Color-coded output: green (✓) for installed, yellow (✗) for missing
#   - Red (✗) for missing core tools (critical)
#   - Summary line with installed/total count
#   - Core tool count with warning if any are missing
#
# Compatibility:
#   Works on: All Unix-like systems
#   Shell: sh, bash, zsh
#
# See also:
#   - core/universal.sh - distro_family() and install_shell_support()
#   - core/arch_aliases.sh - Arch-specific tool aliases
#   - core/debian_aliases.sh - Debian-specific tool aliases
#
# =============================================================================
# Tool Checking Utility
# =============================================================================
#
# Internal helper that checks if a command is available on the system.
# Wraps command -v with stdout/stderr suppression.
#
# Returns:
#   0 - Tool is available in PATH
#   1 - Tool is not found

_has() { command -v "$1" >/dev/null 2>&1; }

# =============================================================================
# Tool Category Definitions
# =============================================================================
#
# Tool lists organized by phase/category. Each list is a space-separated
# string of tool names that will be checked by the status functions.
#
# Core tools are REQUIRED for basic dotfiles functionality. Missing
# core tools generate a red warning in the status report.
#
# Phase organization:
#   1. CORE       - Essential tools for dotfiles operation
#   2. SHELL      - Shell prompt and navigation enhancements
#   3. FILES      - Modern replacements for coreutils
#   4. DEV        - Daily development tools
#   5. DEVOPS     - Container and infrastructure tools
#   6. CLOUD      - Cloud provider CLIs
#   7. SECURITY   - Security and network tools
#   8. EXTRAS     - Nice-to-have utilities

DOTTOOLS_CORE="git curl wget tar gzip unzip openssl"
DOTTOOLS_SHELL="starship zoxide fzf"
DOTTOOLS_FILES="eza bat fd rg delta ncdu duf"
DOTTOOLS_DEV="nvim tmux lazygit yazi zellij fastfetch"
DOTTOOLS_DEVOPS="docker kubectl helm terraform ansible"
DOTTOOLS_CLOUD="aws gcloud az"
DOTTOOLS_SECURITY="gpg shred nmap netstat ss lsof"
DOTTOOLS_EXTRAS="jq yq hyperfine tokei glow tldr gping duf dust procs"

# =============================================================================
# Tool Package Hints Database
# =============================================================================
#
# Each DOTTOOLS_HINT_<tool> variable contains pipe-separated metadata:
#   Field 1: Human-readable description
#   Field 2: Arch Linux package name
#   Field 3: Debian/Ubuntu package name
#   Field 4: Homebrew package name
#
# Format: "Description|ArchPkg|DebPkg|BrewPkg"
#
# These hints are used by dotinstall() to generate the correct
# installation command for the detected package manager.
#
# Examples:
#   DOTTOOLS_HINT_fzf="Fuzzy finder|fzf|fzf|fzf"
#   DOTTOOLS_HINT_delta="Git diff pager|git-delta|git-delta|git-delta"
#   DOTTOOLS_HINT_lazygit="Git TUI|lazygit|<gh release>|lazygit"
#
# When a tool is not available in a distro's repository, the hint
# may contain "<gh release>" or "<curl installer>" to indicate
# alternative installation methods.
#
# See also:
#   - dotinstall() - Uses these hints for install commands
#   - dottools() - Status report references these descriptions

DOTTOOLS_HINT_starship="Smart prompt|starship|<curl installer>|starship"
DOTTOOLS_HINT_zoxide="Smart cd|zoxide|zoxide|zoxide"
DOTTOOLS_HINT_fzf="Fuzzy finder|fzf|fzf|fzf"
DOTTOOLS_HINT_eza="Modern ls|eza|eza|eza"
DOTTOOLS_HINT_bat="Syntax cat|bat|bat|bat"
DOTTOOLS_HINT_fd="Fast find|fd|fd-find|fd"
DOTTOOLS_HINT_rg="Fast grep|ripgrep|ripgrep|ripgrep"
DOTTOOLS_HINT_delta="Git diff pager|git-delta|git-delta|git-delta"
DOTTOOLS_HINT_nvim="Neovim editor|neovim|neovim|neovim"
DOTTOOLS_HINT_tmux="Terminal mux|tmux|tmux|tmux"
DOTTOOLS_HINT_lazygit="Git TUI|lazygit|<gh release>|lazygit"
DOTTOOLS_HINT_yazi="File manager|yazi|<gh release>|yazi"
DOTTOOLS_HINT_fastfetch="System info|fastfetch|fastfetch|fastfetch"
DOTTOOLS_HINT_docker="Containers|docker|docker.io|docker"
DOTTOOLS_HINT_kubectl="Kubernetes CLI|kubectl|kubectl|kubectl"
DOTTOOLS_HINT_helm="Helm|helm|helm|helm"
DOTTOOLS_HINT_terraform="IaC|terraform|terraform|terraform"
DOTTOOLS_HINT_gpg="GPG crypto|gnupg|gnupg|gnupg"
DOTTOOLS_HINT_nmap="Network scan|nmap|nmap|nmap"
DOTTOOLS_HINT_jq="JSON processor|jq|jq|jq"
DOTTOOLS_HINT_yq="YAML processor|yq|yq|yq"
DOTTOOLS_HINT_hyperfine="Benchmarking|hyperfine|hyperfine|hyperfine"
DOTTOOLS_HINT_tokei="Code counter|tokei|tokei|tokei"
DOTTOOLS_HINT_glow="Markdown viewer|glow|glow|glow"
DOTTOOLS_HINT_tldr="Simplified man|tealdeer|tldr|tldr"
DOTTOOLS_HINT_ncdu="Disk usage TUI|ncdu|ncdu|ncdu"
DOTTOOLS_HINT_duf="Better df|duf|duf|duf"
DOTTOOLS_HINT_dust="Better du|dust|du-dust|dust"
DOTTOOLS_HINT_procs="Better ps|procs|procs|procs"
DOTTOOLS_HINT_gping="Graphical ping|gping|gping|gping"
DOTTOOLS_HINT_aws="AWS CLI|aws-cli|awscli|awscli"
DOTTOOLS_HINT_gcloud="GCP CLI|google-cloud-sdk|google-cloud-sdk|google-cloud-sdk"
DOTTOOLS_HINT_az="Azure CLI|azure-cli|azure-cli|azure-cli"
DOTTOOLS_HINT_zellij="Terminal mux|zellij|<gh release>|zellij"

# =============================================================================
# Terminal Color Definitions
# =============================================================================
#
# ANSI escape codes for colorized output in tool status reports.
# These are used internally by _section(), _ok(), _miss(), _crit()
# to produce the color-coded status display.
#
# Color codes:
#   _c_reset   - Reset all attributes
#   _c_bold    - Bold text
#   _c_green   - Installed/OK indicator
#   _c_yellow  - Missing/warning indicator
#   _c_red     - Critical error indicator
#   _c_cyan    - Section header color
#   _c_blue    - Information text
#   _c_magenta - Banner/title color
#
# Usage:
#   printf "${_c_green}✓${_c_reset} tool_name\n"
#
# See also:
#   - console_codes(4) - Linux console escape codes
#   - terminfo(5) - Terminal capability database

_c_reset='\033[0m'
_c_bold='\033[1m'
_c_green='\033[0;32m'
_c_yellow='\033[0;33m'
_c_red='\033[0;31m'
_c_cyan='\033[0;36m'
_c_blue='\033[0;34m'
_c_magenta='\033[0;35m'

# =============================================================================
# Internal Display Helpers
# =============================================================================
#
# Formatting functions for the tool status report. Each function
# produces a single line with the appropriate color coding.
#
#   _section(text)  - Phase/section header with cyan bold text
#   _ok(tool, info) - Green checkmark for installed tools
#   _miss(tool)     - Yellow X for missing (non-core) tools
#   _crit(tool)     - Red X for missing core (required) tools
#
# Output format:
#   Section:  "▶ Phase Name"
#   OK:       "  ✓ tool-name           description"
#   Missing:  "  ✗ tool-name           not installed"
#   Critical: "  ✗ tool-name           MISSING (required)"
#
# See also:
#   - dottools() - Uses all four helpers for the status report
_section() { printf "\n${_c_bold}${_c_cyan}▶ %s${_c_reset}\n" "$1"; }
_ok()       { printf "  ${_c_green}✓${_c_reset} %-20s %s\n" "$1" "${2:-}"; }
_miss()     { printf "  ${_c_yellow}✗${_c_reset} %-20s ${_c_yellow}%s${_c_reset}\n" "$1" "${2:-not installed}"; }
_crit()     { printf "  ${_c_red}✗${_c_reset} %-20s ${_c_red}%s${_c_reset}\n" "$1" "MISSING (required)"; }
# =============================================================================
# dottools - Tool Status Report
# =============================================================================
#
# Displays a comprehensive formatted report showing the availability of
# all tracked tools organized by phase/category. The report uses color
# coding and icons for quick visual scanning.
#
# Report sections:
#   Header: Mode, OS, Distro
#   Phase 1: Core (required) — must-have tools for dotfiles
#   Phase 2: Shell enhancement (recommended) — starship, zoxide, fzf
#   Phase 3: File operations (recommended) — eza, bat, fd, rg, delta
#   Phase 4: Developer daily (recommended) — nvim, tmux, lazygit, yazi
#   Phase 5: DevOps/containers (optional) — docker, kubectl, helm
#   Phase 6: Cloud CLI (optional) — aws, gcloud, az
#   Phase 7: Security (recommended) — gpg, nmap, netstat, ss, lsof
#   Phase 8: Extras (optional) — jq, yq, hyperfine, tokei, glow
#
# Status indicators:
#   ✓ - Tool is installed
#   ✗ - Tool is missing (yellow for recommended, red for core)
#
# Summary line:
#   Shows installed/total count with warning if core tools are missing.
#
# Usage:
#   dottools         # Show full tool status report
#
# See also:
#   - dotinstall() - Install commands for missing tools
#   - dotphase() - Feature phase activation status
#   - _has() - Tool availability check
#
dottools() {
    printf "${_c_bold}${_c_magenta}"
    printf "╔══════════════════════════════════════════════════╗\n"
    printf "║          DOTFILES TOOL STATUS REPORT            ║\n"
    printf "╚══════════════════════════════════════════════════╝${_c_reset}\n"
    printf "  Mode: ${_c_cyan}%s${_c_reset}   OS: ${_c_cyan}%s${_c_reset}   Distro: ${_c_cyan}%s${_c_reset}\n" \
        "${DOTFILES_MODE:-?}" "${DOTFILES_OS:-?}" "${DOTFILES_DISTRO:-?}"
    _section "Phase 1 — CORE (required)"
    for t in $DOTTOOLS_CORE; do
        _has "$t" && _ok "$t" || _crit "$t"
    done
    _section "Phase 2 — SHELL ENHANCEMENT (recommended)"
    for t in $DOTTOOLS_SHELL; do
        _has "$t" && _ok "$t" || _miss "$t"
    done
    _section "Phase 3 — FILE OPERATIONS (recommended)"
    for t in $DOTTOOLS_FILES; do
        _has "$t" && _ok "$t" || _miss "$t"
    done
    _section "Phase 4 — DEVELOPER DAILY (recommended)"
    for t in $DOTTOOLS_DEV; do
        _has "$t" && _ok "$t" || _miss "$t"
    done
    _section "Phase 5 — DEVOPS / CONTAINERS (optional)"
    for t in $DOTTOOLS_DEVOPS; do
        _has "$t" && _ok "$t" || _miss "$t" "optional"
    done
    _section "Phase 6 — CLOUD CLI (optional)"
    for t in $DOTTOOLS_CLOUD; do
        _has "$t" && _ok "$t" || _miss "$t" "optional"
    done
    _section "Phase 7 — SECURITY (recommended)"
    for t in $DOTTOOLS_SECURITY; do
        _has "$t" && _ok "$t" || _miss "$t"
    done
    _section "Phase 8 — EXTRAS (optional)"
    for t in $DOTTOOLS_EXTRAS; do
        _has "$t" && _ok "$t" || _miss "$t" "optional"
    done
    local total=0 installed=0 missing_core=0
    for t in $DOTTOOLS_CORE $DOTTOOLS_SHELL $DOTTOOLS_FILES $DOTTOOLS_DEV \
              $DOTTOOLS_DEVOPS $DOTTOOLS_CLOUD $DOTTOOLS_SECURITY $DOTTOOLS_EXTRAS; do
        total=$(( total + 1 ))
        _has "$t" && installed=$(( installed + 1 ))
    done
    for t in $DOTTOOLS_CORE; do
        _has "$t" || missing_core=$(( missing_core + 1 ))
    done
    printf "\n${_c_bold}  Summary: ${_c_green}%d${_c_reset}/${_c_bold}%d${_c_reset} installed" "$installed" "$total"
    [ "$missing_core" -gt 0 ] && printf "  ${_c_red}(%d CORE tools missing!)${_c_reset}" "$missing_core"
    printf "\n"
    printf "  Run ${_c_cyan}dotinstall${_c_reset} to see install commands for missing tools.\n\n"
}
# =============================================================================
# dotinstall - Installation Command Generator
# =============================================================================
#
# Generates package manager-specific install commands for all missing
# tools. Uses DOTTOOLS_HINT_* variables to map each tool to its correct
# package name for the detected package manager.
#
# Features:
#   - Only shows commands for tools that are actually missing
#   - Uses DOTFILES_PKG to determine the correct package manager
#   - Falls back to showing all three managers (pacman, apt, brew)
#     when the package manager cannot be detected
#   - Package names are maintained in DOTTOOLS_HINT_* variables
#   - Handles special cases: <gh release>, <curl installer>
#
# Supported managers:
#   pacman - Arch Linux (includes AUR via paru/yay)
#   apt    - Debian, Ubuntu, Linux Mint, Pop!_OS
#   dnf    - Fedora, RHEL, CentOS, Rocky, Alma
#   brew   - macOS (Homebrew) and Linux (Linuxbrew)
#
# Output format:
#   tool_name     Description
#     sudo pacman -S <package>
#     sudo apt install <package>
#     brew install <package>
#
# Usage:
#   dotinstall     # Show install commands for missing tools
#
# See also:
#   - dottools() - Tool status report
#   - DOTTOOLS_HINT_* - Package name database
#   - DOTFILES_PKG - Current package manager
#
dotinstall() {
    local pkg="${DOTFILES_PKG:-unknown}"
    printf "${_c_bold}${_c_cyan}Missing tools — install commands for: %s${_c_reset}\n\n" "$pkg"
    local any_missing=0
    for t in $DOTTOOLS_CORE $DOTTOOLS_SHELL $DOTTOOLS_FILES $DOTTOOLS_DEV \
              $DOTTOOLS_SECURITY $DOTTOOLS_EXTRAS; do
        _has "$t" && continue
        any_missing=1
        local hint_var="DOTTOOLS_HINT_${t}"
        local hint; hint="$(eval "echo \"\${${hint_var}:-${t}|${t}|${t}|${t}}\"")"
        local desc arch_pkg apt_pkg brew_pkg
        desc="$(echo "$hint" | cut -d'|' -f1)"
        arch_pkg="$(echo "$hint" | cut -d'|' -f2)"
        apt_pkg="$(echo "$hint" | cut -d'|' -f3)"
        brew_pkg="$(echo "$hint" | cut -d'|' -f4)"
        printf "  ${_c_yellow}%-14s${_c_reset} %s\n" "$t" "$desc"
        case "$pkg" in
            pacman) printf "    ${_c_cyan}sudo pacman -S %s${_c_reset}\n" "$arch_pkg" ;;
            apt)    printf "    ${_c_cyan}sudo apt install %s${_c_reset}\n" "$apt_pkg" ;;
            dnf)    printf "    ${_c_cyan}sudo dnf install %s${_c_reset}\n" "$apt_pkg" ;;
            brew)   printf "    ${_c_cyan}brew install %s${_c_reset}\n" "$brew_pkg" ;;
            *)
                printf "    Arch:  sudo pacman -S %s\n" "$arch_pkg"
                printf "    Apt:   sudo apt install %s\n" "$apt_pkg"
                printf "    Brew:  brew install %s\n" "$brew_pkg"
                ;;
        esac
    done
    [ "$any_missing" -eq 0 ] && printf "  ${_c_green}All recommended tools are installed! 🎉${_c_reset}\n\n"
}
# =============================================================================
# dotphase - Feature Phase Status
# =============================================================================
#
# Shows which feature phases are active (enabled) based on tool
# availability. Each phase represents a capability group that is
# enabled when its key tool is installed.
#
# Feature phases tracked:
#   starship:Prompt   - Smart shell prompt
#   zoxide:SmartCD    - Smarter directory navigation
#   fzf:FuzzyFinder   - Fuzzy file/command search
#   eza:ModernLS      - Modern ls replacement
#   bat:SyntaxCat     - Syntax-highlighted cat
#   fd:FastFind       - Fast file finder
#   rg:FastGrep       - Fast code search
#   delta:GitDiff     - Enhanced git diffs
#   nvim:Editor       - Neovim editor
#   tmux:Multiplexer  - Terminal multiplexer
#   lazygit:GitTUI    - Git TUI interface
#   yazi:FileMgr      - Terminal file manager
#   fastfetch:SysInfo - System information
#   docker:Containers - Container runtime
#   kubectl:Kubernetes- Container orchestration
#   terraform:IaC     - Infrastructure as code
#   gpg:GPGCrypto     - Encryption/crypto
#   jq:JSON           - JSON processor
#
# Display:
#   ● ACTIVE   - Green indicator (tool is installed)
#   ○ DISABLED - Yellow indicator (tool is missing)
#
# Usage:
#   dotphase     # Show active feature phases
#
# See also:
#   - dottools() - Detailed tool status report
#   - dotinstall() - Install commands for missing tools
#   - _has() - Tool availability check
#
dotphase() {
    printf "${_c_bold}${_c_cyan}Active feature phases:${_c_reset}\n"
    local phases="starship:Prompt zoxide:SmartCD fzf:FuzzyFinder eza:ModernLS \
bat:SyntaxCat fd:FastFind rg:FastGrep delta:GitDiff nvim:Editor \
tmux:Multiplexer lazygit:GitTUI yazi:FileMgr fastfetch:SysInfo \
docker:Containers kubectl:Kubernetes terraform:IaC gpg:GPGCrypto jq:JSON"
    for pair in $phases; do
        local tool="${pair%%:*}" label="${pair##*:}"
        if _has "$tool"; then
            printf "  ${_c_green}●${_c_reset} %-12s ${_c_green}ACTIVE${_c_reset}\n" "$label ($tool)"
        else
            printf "  ${_c_yellow}○${_c_reset} %-12s ${_c_yellow}DISABLED${_c_reset} — install $tool\n" "$label"
        fi
    done
    printf "\n"
}
