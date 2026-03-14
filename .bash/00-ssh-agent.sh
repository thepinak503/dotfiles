#!/usr/bin/env bash
# =============================================================================
# 00-SSH-AGENT.SH - SSH Agent Auto-Start and Management
# =============================================================================
# Automatically starts SSH agent if not running and adds common keys
# Only runs in interactive shells with SSH directory present
# =============================================================================

# Only run in interactive shells
[[ $- != *i* ]] && return

# Skip if no SSH directory
[[ ! -d "$HOME/.ssh" ]] && return

# Configuration
SSH_AGENT_ENV="${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles/ssh-agent.env"
SSH_AGENT_KEYS=(
    "$HOME/.ssh/id_ed25519"
    "$HOME/.ssh/id_rsa"
    "$HOME/.ssh/id_ecdsa"
)

# =============================================================================
# SSH AGENT FUNCTIONS
# =============================================================================

# Check if SSH agent is running and valid
_ssh_agent_valid() {
    [[ -z "${SSH_AGENT_PID:-}" ]] && return 1
    
    # Check if process exists
    if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
        return 1
    fi
    
    # Check if we can connect to it
    ssh-add -l >/dev/null 2>&1
    local status=$?
    
    # 0 = keys present, 1 = no keys, 2 = can't connect
    [[ $status -eq 0 ]] || [[ $status -eq 1 ]]
}

# Start new SSH agent
_ssh_agent_start() {
    # Create cache directory
    [[ -d "$(dirname "$SSH_AGENT_ENV")" ]] || mkdir -p "$(dirname "$SSH_AGENT_ENV")"
    
    # Start agent and save environment
    ssh-agent -s > "$SSH_AGENT_ENV"
    chmod 600 "$SSH_AGENT_ENV"
    source "$SSH_AGENT_ENV" >/dev/null
    
    echo "✓ Started SSH agent (PID: $SSH_AGENT_PID)"
}

# Load existing SSH agent environment
_ssh_agent_load() {
    [[ -f "$SSH_AGENT_ENV" ]] || return 1
    source "$SSH_AGENT_ENV" >/dev/null 2>&1
}

# Add SSH keys to agent
_ssh_agent_add_keys() {
    local added=0
    
    for key in "${SSH_AGENT_KEYS[@]}"; do
        # Skip if key doesn't exist
        [[ -f "$key" ]] || continue
        
        # Skip if already added (check fingerprint)
        local fingerprint
        fingerprint=$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')
        
        if ssh-add -l 2>/dev/null | grep -q "$fingerprint"; then
            continue
        fi
        
        # Try to add key (will prompt for passphrase if encrypted)
        if ssh-add "$key" 2>/dev/null; then
            ((added++))
            echo "✓ Added: $(basename "$key")"
        fi
    done
    
    return $((added == 0))
}

# List SSH keys in agent
ssh-list() {
    echo "SSH Agent Keys:"
    ssh-add -l 2>/dev/null || echo "  (no keys loaded)"
}

# Add specific key to agent
ssh-add-key() {
    local key="${1:-$HOME/.ssh/id_ed25519}"
    
    [[ -f "$key" ]] || { echo "Error: Key not found: $key" >&2; return 1; }
    
    # Ensure agent is running
    _ssh_agent_load
    if ! _ssh_agent_valid; then
        _ssh_agent_start
    fi
    
    ssh-add "$key"
}

# Kill SSH agent
ssh-kill() {
    if [[ -n "${SSH_AGENT_PID:-}" ]]; then
        kill "$SSH_AGENT_PID" 2>/dev/null
        rm -f "$SSH_AGENT_ENV"
        unset SSH_AGENT_PID SSH_AUTH_SOCK
        echo "✓ SSH agent stopped"
    else
        echo "No SSH agent running"
    fi
}

# =============================================================================
# MAIN SETUP
# =============================================================================

setup_ssh_agent() {
    # Try to load existing agent
    _ssh_agent_load
    
    # Check if agent is still valid
    if ! _ssh_agent_valid; then
        # Kill any stale agent
        [[ -n "${SSH_AGENT_PID:-}" ]] && kill "$SSH_AGENT_PID" 2>/dev/null
        
        # Start new agent
        _ssh_agent_start
    fi
    
    # Try to add keys (silently - don't block shell startup)
    (_sh_agent_add_keys &) 2>/dev/null
}

# Run setup
setup_ssh_agent

# =============================================================================
# ALIASES
# =============================================================================

alias sla='ssh-list'
alias sla='ssh-add -l'
alias sak='ssh-add-key'
alias sk='ssh-kill'
