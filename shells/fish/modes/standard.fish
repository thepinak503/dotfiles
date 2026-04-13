#!/usr/bin/env fish
abbr -a ports 'netstat -tulanp 2>/dev/null; or ss -tuln'
abbr -a ipl 'ip -br link'
abbr -a ipa 'ip -br addr'
abbr -a now 'date +"%T"'
abbr -a nowdate 'date +"%d-%m-%Y"'
abbr -a path 'echo $PATH | tr ":" "\n" | nl'
abbr -a gaa 'git add --all'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gst 'git stash'
set -g fish_greeting ""
if type -q zoxide
    zoxide init fish | source
end