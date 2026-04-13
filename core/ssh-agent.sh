#!/usr/bin/env sh
# =============================================================================
# lib/ssh-agent.sh — SSH agent singleton (bash + zsh)
# Starts one agent per user session; reuses across terminals.
# =============================================================================

_SSH_ENV="$HOME/.ssh/agent.env"

_ssh_agent_start() {
    ssh-agent | sed 's/^echo/#echo/' > "$_SSH_ENV"
    chmod 600 "$_SSH_ENV"
    # shellcheck disable=SC1090
    . "$_SSH_ENV" > /dev/null
    ssh-add 2>/dev/null
}

ssh_agent_ensure() {
    if [ -f "$_SSH_ENV" ]; then
        # shellcheck disable=SC1090
        . "$_SSH_ENV" > /dev/null
        # Test if agent is still alive
        if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
            _ssh_agent_start
        fi
    else
        _ssh_agent_start
    fi
}

# Only run in interactive shells and if ssh-agent is available
if command -v ssh-agent >/dev/null 2>&1; then
    case "$-" in *i*) ssh_agent_ensure ;; esac
fi

unset -f _ssh_agent_start 2>/dev/null || true
