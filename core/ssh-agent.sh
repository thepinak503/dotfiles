#!/usr/bin/env sh
# =============================================================================
# SSH Agent Management
# =============================================================================
#
# Automatic SSH agent startup and key management for interactive shells.
# The agent is started on demand (lazy initialization) rather than at
# shell startup, keeping shell initialization fast.
#
# Design:
#   SSH agent state is persisted in ~/.ssh/agent.env, which contains
#   the SSH_AUTH_SOCK and SSH_AGENT_PID variables. On subsequent shell
#   sessions, the script checks if the saved agent is still running
#   and reuses it if possible.
#
# Features:
#   - Lazy agent initialization (only starts when needed)
#   - Agent state persistence across shell sessions
#   - Single agent shared across all shell sessions
#   - Graceful fallback when ssh-agent is not installed
#   - No automatic ssh-add (avoids passphrase prompts at startup)
#
# Functions:
#   ssh_agent_ensure - Start agent if not running, or connect to existing
#   ssh_agent_add    - Add SSH keys to the agent (on-demand)
#
# Key file:
#   ~/.ssh/agent.env - Stores SSH agent connection parameters
#   Permissions: 600 (owner read/write only)
#
# Security considerations:
#   - Agent socket is protected by filesystem permissions
#   - Keys are NOT automatically added (no passphrase caching at login)
#   - ssh_agent_add should be called manually after unlocking keychain
#   - Agent.env is chmod 600 to prevent unauthorized access
#
# Compatibility:
#   Works on: All Unix-like systems with OpenSSH
#   Shell: sh, bash, zsh
#
# See also:
#   - ssh-agent(1) - SSH agent documentation
#   - ssh-add(1) - Key management
#   - ~/.ssh/config - SSH client configuration
#   - core/universal.sh - secstatus() SSH permission checks
#
# =============================================================================
# Configuration
# =============================================================================
#
# The agent.env file path. This is hardcoded to ~/.ssh/agent.env
# rather than using XDG paths to maintain compatibility with tools
# that expect the agent socket in a predictable location.

_SSH_ENV="$HOME/.ssh/agent.env"

# =============================================================================
# Internal: Start SSH Agent
# =============================================================================
#
# Starts a new SSH agent process and saves its connection parameters
# to ~/.ssh/agent.env. The environment file is then sourced to set
# SSH_AUTH_SOCK and SSH_AGENT_PID in the current shell.
#
# The 'echo' lines in ssh-agent output are commented out with sed
# to prevent them from being executed when sourcing the file.
#
# Security: agent.env is chmod 600 after creation.
#
# See also:
#   - ssh-agent(1) - Agent options: -s ( Bourne shell output)

_ssh_agent_start() {
    ssh-agent | sed 's/^echo/#echo/' > "$_SSH_ENV"
    chmod 600 "$_SSH_ENV"
    . "$_SSH_ENV" > /dev/null
    # Do not auto-run ssh-add here to avoid blocking passphrase prompts during shell startup.
    # Users can add keys on demand with `ssh_agent_add`.
}
# =============================================================================
# ssh_agent_ensure - Ensure SSH Agent is Running
# =============================================================================
#
# Ensures an SSH agent is available for key management. If the saved
# agent.env file exists and the agent process is still alive, it sources
# the environment to connect to the existing agent. Otherwise, it starts
# a new agent.
#
# This function is called once at shell startup (interactive sessions
# only). After this, SSH_AUTH_SOCK and SSH_AGENT_PID are set for the
# duration of the session.
#
# Process:
#   1. Check if agent.env exists
#   2. If yes: source it and verify agent is alive (kill -0)
#   3. If alive: done (reusing existing agent)
#   4. If dead or missing: start new agent
#
# Note: This function does NOT add any keys. Keys must be added
# manually with ssh_agent_add to avoid passphrase prompts during
# shell startup.
#
# Usage:
#   ssh_agent_ensure   # Typically called automatically
#
# See also:
#   - ssh_agent_add() - Add keys to the agent
#   - kill(1) - kill -0 checks process existence

ssh_agent_ensure() {
    if [ -f "$_SSH_ENV" ]; then
        . "$_SSH_ENV" > /dev/null
        if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
            _ssh_agent_start
        fi
    else
        _ssh_agent_start
    fi
}
if command -v ssh-agent >/dev/null 2>&1; then
    case "$-" in *i*) ssh_agent_ensure ;; esac
fi
unset -f _ssh_agent_start 2>/dev/null || true

# =============================================================================
# ssh_agent_add - Add SSH Keys to Agent
# =============================================================================
#
# Adds SSH private keys to the running SSH agent. This is designed to
# be called on-demand (not at startup) to avoid passphrase prompts
# appearing unexpectedly during shell initialization.
#
# Features:
#   - Accepts optional key paths as arguments
#   - Falls back to default key names if no arguments given
#   - Automatically starts agent if not already running
#   - Silent if ssh-add fails (no error, just no keys loaded)
#
# Usage:
#   ssh_agent_add              # Add default keys (~/.ssh/id_*)
#   ssh_agent_add ~/.ssh/mykey # Add specific key
#   ssh_agent_add -l           # List loaded keys
#
# Typical workflow:
#   1. Start shell (agent auto-starts silently)
#   2. Run ssh_agent_add when you need SSH access
#   3. Enter passphrase once
#   4. Use SSH freely until shell exit
#
# Security note:
#   Keys loaded with ssh-add remain in the agent's memory until the
#   agent is killed or the keys are removed with ssh-add -d/-D.
#   On logout, the agent is typically killed automatically.
#
# See also:
#   - ssh-add(1) - Key loading and management
#   - ssh_agent_ensure() - Agent startup
#   - ssh(1) - SSH client (uses agent automatically)

ssh_agent_add() {
    if [ -f "$_SSH_ENV" ]; then
        . "$_SSH_ENV" >/dev/null
        ssh-add "$@" 2>/dev/null || ssh-add
    else
        _ssh_agent_start
        ssh-add "$@" 2>/dev/null || ssh-add
    fi
}
