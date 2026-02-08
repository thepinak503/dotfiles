#!/bin/bash
# System Monitoring Tools Configuration
# btop, htop, fastfetch, and more

# =============================================================================
# BTOP (MODERN TOP)
# =============================================================================

if command -v btop &>/dev/null; then
    alias top='btop'
    alias btop='btop --utf-force'
fi

# =============================================================================
# HTOP
# =============================================================================

if command -v htop &>/dev/null; then
    alias htop='htop -t'
fi

# =============================================================================
# FASTFETCH / NEOFETCH
# =============================================================================

if command -v fastfetch &>/dev/null; then
    alias ff='fastfetch'
    alias neofetch='fastfetch'
elif command -v neofetch &>/dev/null; then
    alias ff='neofetch'
fi

# =============================================================================
# BASHTOP
# =============================================================================

if command -v bashtop &>/dev/null; then
    alias btop-old='bashtop'
fi

# =============================================================================
# IOTOP
# =============================================================================

if command -v iotop &>/dev/null; then
    alias iotop='sudo iotop'
fi

# =============================================================================
# NETHOGS
# =============================================================================

if command -v nethogs &>/dev/null; then
    alias nethogs='sudo nethogs'
fi

# =============================================================================
# IFTOP
# =============================================================================

if command -v iftop &>/dev/null; then
    alias iftop='sudo iftop'
fi

# =============================================================================
# S-TRACE / STRACE
# =============================================================================

if command -v strace &>/dev/null; then
    alias strace-process='sudo strace -p'
fi

# =============================================================================
# LSOF
# =============================================================================

alias ports='sudo lsof -i -P -n | grep LISTEN'
alias port-usage='sudo lsof -i :'

# =============================================================================
# SYSTEM INFO ALIASES
# =============================================================================

alias meminfo='free -h'
alias cpuinfo='lscpu'
alias diskinfo='df -h'
alias sysinfo='bash $HOME/.dotfiles/scripts/sysinfo.sh'
alias sysupdate='bash $HOME/.dotfiles/scripts/sysupdate.sh'

# =============================================================================
# FUNCTIONS
# =============================================================================

# Show system stats
sysstats() {
    echo "=== System Statistics ==="
    echo ""
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print "  " $1 "%"}'
    echo ""
    echo "Memory Usage:"
    free -h | awk '/^Mem:/ {print "  Used: " $3 " / " $2 " (" $3/$2*100 "%)"}'
    echo ""
    echo "Disk Usage:"
    df -h / | awk 'NR==2 {print "  Used: " $3 " / " $2 " (" $5 ")"}'
    echo ""
    echo "Load Average:"
    uptime | awk -F'load average:' '{print "  "$2}'
    echo ""
    echo "Active Users:"
    who | wc -l | xargs echo "  "
}

# Monitor a process
monitor-process() {
    if [ -z "$1" ]; then
        echo "Usage: monitor-process <process_name_or_pid>"
        return 1
    fi
    
    watch -n 1 "ps aux | grep -E 'PID|$1' | grep -v grep"
}

# Show network connections
netconns() {
    sudo netstat -tuln | grep LISTEN
}

# Show bandwidth usage per process
bandwidth() {
    if command -v nethogs &>/dev/null; then
        sudo nethogs
    else
        echo "nethogs not installed. Install with: sudo pacman -S nethogs"
    fi
}

# Check service status
svc-status() {
    if [ -z "$1" ]; then
        echo "Usage: svc-status <service_name>"
        echo "Example: svc-status sshd"
        return 1
    fi
    
    if command -v systemctl &>/dev/null; then
        systemctl status "$1"
    else
        service "$1" status
    fi
}

# Kill process by name
killbyname() {
    if [ -z "$1" ]; then
        echo "Usage: killbyname <process_name>"
        return 1
    fi
    
    pkill -f "$1"
    echo "Killed processes matching: $1"
}

# Find large files
largefiles() {
    local size="${1:-100M}"
    local path="${2:-.}"
    
    echo "Finding files larger than $size in $path..."
    find "$path" -type f -size +$size -exec ls -lh {} \; 2>/dev/null | awk '{ print $5 ": " $9 }' | sort -n
}

# Show directory size summary
sizes() {
    du -sh */ 2>/dev/null | sort -hr | head -20
}

# Real-time log viewer
logview() {
    local logfile="${1:-/var/log/syslog}"
    if [ -f "$logfile" ]; then
        sudo tail -f "$logfile"
    else
        echo "Log file not found: $logfile"
        return 1
    fi
}

# Temperature monitoring (if available)
temp() {
    if command -v sensors &>/dev/null; then
        sensors
    else
        echo "lm_sensors not installed. Install with: sudo pacman -S lm_sensors"
        echo "Then run: sudo sensors-detect"
    fi
}

# Battery info (for laptops)
battery() {
    if [ -d /sys/class/power_supply/BAT0 ]; then
        cat /sys/class/power_supply/BAT0/uevent | grep -E "(POWER_SUPPLY_STATUS|POWER_SUPPLY_CAPACITY)"
    elif command -v acpi &>/dev/null; then
        acpi -b
    else
        echo "No battery information available"
    fi
}