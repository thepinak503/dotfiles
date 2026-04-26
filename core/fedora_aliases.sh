#!/usr/bin/env bash
# =============================================================================
# Fedora/RHEL/CentOS - DNF aliases
# Only loads on Fedora-based distros
# =============================================================================

[ "$DOTFILES_DISTRO" = "fedora" ] || [ "$DOTFILES_DISTRO" = "centos" ] || [ "$DOTFILES_DISTRO" = "rhel" ] || [ "$DOTFILES_DISTRO" = "rocky" ] || [ "$DOTFILES_DISTRO" = "alma" ] && {

# DNF aliases
alias dnfup='sudo dnf upgrade'
alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfq='dnf list'
alias dnfiinfo='dnf info'
alias dnflist='dnf list available'
alias dnfinstalled='dnf list installed'
alias dnfclean='sudo dnf clean all'
alias dnfmark='dnf mark'
alias dnfhistory='dnf history'
alias dnfrequires='dnf repoquery --requires'
alias dnfprovides='dnf provides'

# DNF functions
dnfinstall() { sudo dnf install "$@"; }
dnfremove() { sudo dnf remove "$@"; }
dnfupdate() { sudo dnf upgrade; }
dnfsearch() { dnf search "$@" | less; }
dnfinfo() { dnf info "$@"; }
dnfupgrade() { sudo dnf upgrade; }
dnfclean() { sudo dnf clean all; }
dnfgroup() { sudo dnf group "$@"; }

# Cockpit (if installed)
command -v cockpit >/dev/null 2>&1 && {
    alias cockpit='cockpit'
}

echo "[dotfiles] Fedora aliases loaded"
}