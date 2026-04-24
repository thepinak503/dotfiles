#!/usr/bin/env fish
# =============================================================================
# SUPREME MODE - Full-featured configuration (Fish)
# Enhanced with battery warning and modern tools from Pinak's Dotfiles
# =============================================================================

# Only load if mode is supreme or ultra-nerd
if not test "$DOTFILES_MODE" = "supreme" -o "$DOTFILES_MODE" = "ultra-nerd"
    return 0
end

# -----------------------------------------------------------------------------
# BATTERY FUNCTIONS (from Pinak's Dotfiles)
# -----------------------------------------------------------------------------

function __get_battery_percent
    if test -d /sys/class/power_supply/BAT0
        cat /sys/class/power_supply/BAT0/capacity 2>/dev/null
    else if type -q pmset
        pmset -g batt 2>/dev/null | string match -r '[0-9]+%' | head -1 | string replace '%' ''
    else
        echo ""
    end
end

function __is_charging
    if test -f /sys/class/power_supply/BAT0/status
        string match -q "Charging" /sys/class/power_supply/BAT0/status
    else if type -q pmset
        pmset -g batt 2>/dev/null | string match -q "charging"
    else
        return 1
    end
end

function __is_laptop
    if test -d /sys/class/power_supply/BAT0
        return 0
    else if type -q pmset
        pmset -g batt 2>/dev/null | string match -q "InternalBattery"
        return 0
    end
    return 1
end

function __battery_warning
    set -l percent (__get_battery_percent)
    if test -z "$percent"
        return
    end
    if __is_charging
        return
    end
    if test "$percent" -le 10
        echo "🔴 CRITICAL: Battery at "$percent"%! Plug in charger NOW!"
    else if test "$percent" -le 30
        echo "🟡 Battery low: "$percent"%"
    end
end

# Show battery warning on shell start
if __is_laptop
    __battery_warning
end

# -----------------------------------------------------------------------------
# DOCKER (additional)
# -----------------------------------------------------------------------------
if type -q docker
    abbr -a d 'docker'
    abbr -a dc 'docker-compose'
    abbr -a dps 'docker ps'
    abbr -a dpsa 'docker ps -a'
    abbr -a di 'docker images'
    abbr -a dex 'docker exec -it'
    abbr -a dlog 'docker logs -f'
    abbr -a dstop 'docker stop (docker ps -q)'
    abbr -a drm 'docker rm (docker ps -aq)'
    abbr -a dprune 'docker system prune -af'
    abbr -a dclean 'docker system prune -af --volumes'
end

# -----------------------------------------------------------------------------
# KUBERNETES
# -----------------------------------------------------------------------------
if type -q kubectl
    abbr -a k 'kubectl'
    abbr -a kg 'kubectl get'
    abbr -a kd 'kubectl describe'
    abbr -a kl 'kubectl logs'
    abbr -a ka 'kubectl apply -f'
    abbr -a kdel 'kubectl delete'
end

# -----------------------------------------------------------------------------
# TMUX
# -----------------------------------------------------------------------------
if type -q tmux
    abbr -a t 'tmux'
    abbr -a ta 'tmux attach'
    abbr -a tl 'tmux list-sessions'
end

# -----------------------------------------------------------------------------
# FZF
# -----------------------------------------------------------------------------
if type -q fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end

# -----------------------------------------------------------------------------
# NETWORK & SYSTEM
# -----------------------------------------------------------------------------
abbr -a ports 'netstat -tulanp'
abbr -a ipl 'ip -br link'
abbr -a ipa 'ip -br addr'
abbr -a cpuinfo 'lscpu'
abbr -a meminfo 'free -h && cat /proc/meminfo'

# -----------------------------------------------------------------------------
# GIT (additional)
# -----------------------------------------------------------------------------
abbr -a gaa 'git add --all'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gst 'git stash'
abbr -a gstd 'git stash drop'

# -----------------------------------------------------------------------------
# TOOLS
# -----------------------------------------------------------------------------
abbr -a now 'date "+%T"'
abbr -a nowdate 'date "+%d-%m-%Y"'
abbr -a path 'echo $PATH | tr ":" "\\n" | nl'

# -----------------------------------------------------------------------------
# DOCKER (additional)
# -----------------------------------------------------------------------------
abbr -a dprune 'docker system prune -af'

# -----------------------------------------------------------------------------
# MODERN TOOLS ABBREVIATIONS
# -----------------------------------------------------------------------------
if type -q yazi
    abbr -a y 'yazi'
end

if type -q lazygit
    abbr -a lg 'lazygit'
end

if type -q bat
    abbr -a cat 'bat --style=auto --wrap=never'
end

if type -q rg
    abbr -a grep 'rg --smart-case --hidden'
end

if type -q fd
    abbr -a find 'fd -H'
end

# -----------------------------------------------------------------------------
# DOTFILES SYNC
# -----------------------------------------------------------------------------
function dot_sync
    set -l repo_root "$DOTFILES_DIR"
    if not test -d "$repo_root/.git"
        echo "Dotfiles repo not found."
        return 1
    end
    echo "Syncing dotfiles in $repo_root..."
    git -C "$repo_root" fetch --all --prune
    git -C "$repo_root" pull --rebase --autostash; or git -C "$repo_root" pull --ff-only
end
abbr -a dsync 'dot_sync'