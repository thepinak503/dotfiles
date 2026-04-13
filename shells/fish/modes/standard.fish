#!/usr/bin/env fish
# =============================================================================
# MEDIUM MODE - Balanced Fish configuration
# =============================================================================

# Enhanced abbreviations for medium mode
abbr -a ports 'netstat -tulanp 2>/dev/null; or ss -tuln'
abbr -a ipl 'ip -br link'
abbr -a ipa 'ip -br addr'
abbr -a now 'date +"%T"'
abbr -a nowdate 'date +"%d-%m-%Y"'
abbr -a path 'echo $PATH | tr ":" "\n" | nl'

# Git shortcuts
abbr -a gaa 'git add --all'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gst 'git stash'

# Fish options for medium mode
set -g fish_greeting ""
set -g history -10000

# Zoxide
if type -q zoxide
    zoxide init fish | source
end