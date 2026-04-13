#!/usr/bin/env sh
# =============================================================================
# lib/tools.sh — Tool registry & phased feature gating
#
# USAGE (sourced by .bashrc / .zshrc / config.fish):
#   _has <cmd>        → 0 if installed, 1 if not  (silent)
#   _feature <cmd> <description>   → enables feature, logs if missing
#   dottools          → show full tool status report
#   dotinstall        → print install commands for missing tools
#
# PHASES:
#   Phase 1 – CORE     (git curl wget tar)          always expected
#   Phase 2 – SHELL    (starship zoxide fzf)        recommended
#   Phase 3 – FILES    (eza bat fd rg delta)         recommended
#   Phase 4 – DEV      (nvim tmux lazygit yazi)     recommended
#   Phase 5 – DEVOPS   (docker kubectl terraform)   optional
#   Phase 6 – CLOUD    (aws gcloud az)              optional
#   Phase 7 – SECURITY (gpg openssl nmap shred)    recommended
#   Phase 8 – EXTRAS   (hyperfine tokei glow jq)   optional
# =============================================================================

# Lightweight "has" helper — works in sh, bash, zsh
_has() { command -v "$1" >/dev/null 2>&1; }

# ── Phase 1: CORE ─────────────────────────────────────────────────────────
DOTTOOLS_CORE="git curl wget tar gzip unzip openssl"

# ── Phase 2: SHELL ENHANCEMENT ────────────────────────────────────────────
DOTTOOLS_SHELL="starship zoxide fzf"

# ── Phase 3: FILE OPERATIONS ──────────────────────────────────────────────
DOTTOOLS_FILES="eza bat fd rg delta ncdu duf"

# ── Phase 4: DEVELOPER DAILY ──────────────────────────────────────────────
DOTTOOLS_DEV="nvim tmux lazygit yazi zellij fastfetch"

# ── Phase 5: DEVOPS / CONTAINERS ──────────────────────────────────────────
DOTTOOLS_DEVOPS="docker kubectl helm terraform ansible"

# ── Phase 6: CLOUD ────────────────────────────────────────────────────────
DOTTOOLS_CLOUD="aws gcloud az"

# ── Phase 7: SECURITY ─────────────────────────────────────────────────────
DOTTOOLS_SECURITY="gpg shred nmap netstat ss lsof"

# ── Phase 8: EXTRAS ───────────────────────────────────────────────────────
DOTTOOLS_EXTRAS="jq yq hyperfine tokei glow tldr gping duf dust procs"

# ── Install hints (pkg name may differ per distro) ─────────────────────────
# Format: DOTTOOLS_HINT_<CMD>=<description>|<arch-pkg>|<apt-pkg>|<brew-pkg>
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

# ── Colour helpers ─────────────────────────────────────────────────────────
_c_reset='\033[0m'
_c_bold='\033[1m'
_c_green='\033[0;32m'
_c_yellow='\033[0;33m'
_c_red='\033[0;31m'
_c_cyan='\033[0;36m'
_c_blue='\033[0;34m'
_c_magenta='\033[0;35m'

_section() { printf "\n${_c_bold}${_c_cyan}▶ %s${_c_reset}\n" "$1"; }
_ok()       { printf "  ${_c_green}✓${_c_reset} %-20s %s\n" "$1" "${2:-}"; }
_miss()     { printf "  ${_c_yellow}✗${_c_reset} %-20s ${_c_yellow}%s${_c_reset}\n" "$1" "${2:-not installed}"; }
_crit()     { printf "  ${_c_red}✗${_c_reset} %-20s ${_c_red}%s${_c_reset}\n" "$1" "MISSING (required)"; }

# ── dottools: full status report ───────────────────────────────────────────
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

    # Summary
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

# ── dotinstall: print install commands for missing tools ──────────────────
dotinstall() {
    local pkg="${DOTFILES_PKG:-unknown}"
    printf "${_c_bold}${_c_cyan}Missing tools — install commands for: %s${_c_reset}\n\n" "$pkg"

    local any_missing=0
    for t in $DOTTOOLS_CORE $DOTTOOLS_SHELL $DOTTOOLS_FILES $DOTTOOLS_DEV \
              $DOTTOOLS_SECURITY $DOTTOOLS_EXTRAS; do
        _has "$t" && continue
        any_missing=1

        # Get hint string
        local hint_var="DOTTOOLS_HINT_${t}"
        # sh-compatible indirect expansion
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

# ── dotphase: show which features are active in current shell ─────────────
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
