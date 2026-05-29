#!/usr/bin/env bash
# =============================================================================
# dotlogcat — Centralized Error Trace & Logcat for Dotfiles
# =============================================================================
# Aggregates errors from all dotfiles components into a unified, colorized,
# filterable stream — like Android logcat, but for your dotfiles.
#
# Usage:
#   dots logcat                  # Show last 50 errors (default)
#   dots logcat -n 100           # Show last 100 entries
#   dots logcat -f               # Follow mode (tail logs in real time)
#   dots logcat --component hypr # Filter by component
#   dots logcat --severity ERROR # Filter by severity
#   dots logcat --summary        # Error count by component
#   dots logcat --watch          # Refresh every 5s
#   dots logcat --since "2026-05-28"  # Since date
#   dots logcat --all            # Show all available logs
#
# Components: shell, hyprland, waybar, swaync, services, theme, tools,
#             network, update, dotfiles, system, rofi, wlogout, kitty
# Severities: ERROR, WARN, INFO, OK
# =============================================================================

set -euo pipefail

# ── Paths ──────────────────────────────────────────────────────────────────────
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
LOG_DIR="$DOTFILES_STATE_DIR/logs"
ERROR_LOG="$DOTFILES_STATE_DIR/errors.log"
AUTOUPDATE_LOG="$DOTFILES_STATE_DIR/autoupdate.log"
CORE_LOG="${DOTFILES_LOG_FILE:-/var/tmp/dotfiles.log}"
DOCTOR_LOG="$LOG_DIR/doctor.log"
DOTS_LOG="$LOG_DIR/dots.log"

# ── Colors ─────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ── Defaults ────────────────────────────────────────────────────────────────────
DEFAULT_LINES=50
FOLLOW=false
SUMMARY=false
WATCH=false
ALL=false
SHOW_COMPONENT=""
SHOW_SEVERITY=""
SINCE=""
JSON=false

# ── Help ────────────────────────────────────────────────────────────────────────
usage() {
    cat <<EOF
${CYAN}${BOLD}dotlogcat${NC} — Unified Dotfiles Error Trace

${BOLD}Usage:${NC}
  dots logcat [options]

${BOLD}Options:${NC}
  -n, --lines N       Show last N entries (default: $DEFAULT_LINES)
  -f, --follow        Follow mode (like tail -f across all logs)
  -s, --summary       Error count summary by component
  -w, --watch         Watch mode (refresh every 5s)
  -a, --all           Show all available entries (no line limit)
  -c, --component C   Filter by component (shell, hyprland, waybar, etc.)
  -S, --severity S    Filter by severity (ERROR, WARN, INFO, OK)
  --since DATE        Show entries since date/time
  --json              Machine-readable JSON output
  -h, --help          Show this help

${BOLD}Components:${NC}
  shell      — Shell startup errors, syntax errors (zsh/bash/fish)
  hyprland   — Hyprland config, keybinds, scripts
  waybar     — Waybar bar configs and modules
  swaync     — Notification daemon
  wlogout    — Logout/lock screen
  rofi       — Application launcher
  kitty      — Terminal emulator
  services   — Background daemons (hypridle, swaync, etc.)
  theme      — Theme switching system
  tools      — Missing or broken tools
  network    — Network connectivity
  update     — Dotfiles update process
  dotfiles   — General dotfiles operations
  system     — System info, GPU, kernel
  install    — Installation process
  doctor     — Health check results

${BOLD}Examples:${NC}
  dots logcat                          # Last 50 errors
  dots logcat -f                       # Real-time monitoring
  dots logcat -c hyprland              # Hyprland errors only
  dots logcat -S ERROR                 # Only errors
  dots logcat --summary                # Error counts by component
  dots logcat --since "2026-05-01"     # Since May 1st
  dots logcat -c shell -S ERROR -f     # Watch shell errors
EOF
}

# ── Parse severity from a log line ─────────────────────────────────────────────
detect_severity() {
    local line="$1"
    local upper
    upper=$(echo "$line" | tr '[:lower:]' '[:upper:]')
    case "$upper" in
        *'[ERROR]'*|*'FAILED'*|*'FAIL'*|*'✗'*|*'ERROR'*|*'SYNTAX ERROR'*|*'CRITICAL'*)
            echo "ERROR" ;;
        *'[WARN]'*|*'WARNING'*|*'⚠'*|*'MISSING'*|*'DEDUCTION'*|*'BROKEN'*)
            echo "WARN" ;;
        *'[INFO]'*|*'INFO'*|*'OK'*|*'PASSED'*|*'PASS'*|*'✓'*|*'PASS'*)
            echo "OK" ;;
        *)
            echo "INFO" ;;
    esac
}

# ── Detect component from a log line ───────────────────────────────────────────
detect_component() {
    local line="$1"
    local upper
    upper=$(echo "$line" | tr '[:lower:]' '[:upper:]')

    # Dotfiles general
    if echo "$upper" | grep -qE 'DOTFILES|DOTS\b|\.DOT|CONFIG'; then
        echo "Dotfiles"; return
    fi

    # Shell
    if echo "$upper" | grep -qE '\b(SHELL|BASH|ZSH|FISH|STARTUP|\.ZSHRC|\.BASHRC|\.PROFILE|SYNTAX|ALIAS|FUNCTION)\b'; then
        echo "Shell"; return
    fi

    # Hyprland
    if echo "$upper" | grep -qE '\b(HYPRLAND|HYPRCTL|HYPRPAPER|HYPRIDLE|HYPRLOCK|LUA CONFIG|HOTPLUG|MONITOR)\b'; then
        echo "Hyprland"; return
    fi

    # Waybar
    if echo "$upper" | grep -qE '\b(WAYBAR|STYLE\.CSS|CONFIG\.JSONC|CUSTOM-COMMANDS|QUICK-COMMANDS)\b'; then
        echo "Waybar"; return
    fi

    # SwayNC
    if echo "$upper" | grep -qE '\b(SWAYNC|NOTIFICATION|NOTIF)\b'; then
        echo "SwayNC"; return
    fi

    # Wlogout
    if echo "$upper" | grep -qE '\b(WLOGOUT|LOGOUT|LOCK SCREEN)\b'; then
        echo "Wlogout"; return
    fi

    # Rofi
    if echo "$upper" | grep -qE '\b(ROFI|LAUNCHER|DRUN|RASI)\b'; then
        echo "Rofi"; return
    fi

    # Kitty
    if echo "$upper" | grep -qE '\b(KITTY|TERMINAL|NORD\.CONF)\b'; then
        echo "Kitty"; return
    fi

    # Theme
    if echo "$upper" | grep -qE '\b(THEME|THEME\.SH|DARK|LIGHT|NORD)\b'; then
        echo "Theme"; return
    fi

    # Tools
    if echo "$upper" | grep -qE '\b(TOOL|MISSING.*\b(NEOFETCH|FASTFETCH|STARSHIP|EZA|BAT|FD|RG|FZF|ZOXIDE|CURL|GIT)\b|INSTALLED|COMMAND NOT FOUND)\b'; then
        echo "Tools"; return
    fi

    # Network
    if echo "$upper" | grep -qE '\b(NETWORK|NET\b|WIFI|ETHERNET|DNS|PING|SPEED|NMCLI|IP\b)\b'; then
        echo "Network"; return
    fi

    # Update
    if echo "$upper" | grep -qE '\b(UPDATE|PULL|SNAPSHOT|ROLLBACK|BACKUP|AUTOUPDATE)\b'; then
        echo "Update"; return
    fi

    # Services
    if echo "$upper" | grep -qE '\b(SERVICE|DAEMON|SWAYOSD|POLKIT|NM-APPLET|BLUEMAN|WALLPAPER)\b'; then
        echo "Services"; return
    fi

    # Install
    if echo "$upper" | grep -qE '\b(INSTALL|INSTALLER|BOOTSTRAP|FONTS)\b'; then
        echo "Install"; return
    fi

    # Doctor
    if echo "$upper" | grep -qE '\b(DOCTOR|HEALTH|DIAGNOSTIC|SCORE|GRADE)\b'; then
        echo "Doctor"; return
    fi

    # Tests
    if echo "$upper" | grep -qE '\b(TEST|TEST_REPO|RUN_TESTS|BLOAT|INTEGRITY)\b'; then
        echo "Tests"; return
    fi

    echo "Dotfiles"
}

# ── Colorize severity tag ──────────────────────────────────────────────────────
severity_color() {
    local sev="$1"
    case "$sev" in
        ERROR) echo -e "${RED}${BOLD}ERROR${NC}" ;;
        WARN)  echo -e "${YELLOW}${BOLD}WARN ${NC}" ;;
        INFO)  echo -e "${BLUE}${BOLD}INFO ${NC}" ;;
        OK)    echo -e "${GREEN}${BOLD}OK   ${NC}" ;;
        *)     echo -e "${DIM}${sev}${NC}" ;;
    esac
}

# ── Colorize component tag ─────────────────────────────────────────────────────
component_color() {
    local comp="$1"
    case "$comp" in
        Shell)     echo -e "${PURPLE}${BOLD}Shell    ${NC}" ;;
        Hyprland)  echo -e "${CYAN}${BOLD}Hyprland ${NC}" ;;
        Waybar)    echo -e "${GREEN}${BOLD}Waybar   ${NC}" ;;
        SwayNC)    echo -e "${YELLOW}${BOLD}SwayNC   ${NC}" ;;
        Services)  echo -e "${BLUE}${BOLD}Services ${NC}" ;;
        Theme)     echo -e "${PURPLE}${BOLD}Theme    ${NC}" ;;
        Tools)     echo -e "${RED}${BOLD}Tools    ${NC}" ;;
        Network)   echo -e "${CYAN}${BOLD}Network  ${NC}" ;;
        Update)    echo -e "${GREEN}${BOLD}Update   ${NC}" ;;
        Wlogout)   echo -e "${YELLOW}${BOLD}Wlogout  ${NC}" ;;
        Rofi)      echo -e "${BLUE}${BOLD}Rofi     ${NC}" ;;
        Kitty)     echo -e "${PURPLE}${BOLD}Kitty    ${NC}" ;;
        Dotfiles)  echo -e "${DIM}${BOLD}Dotfiles ${NC}" ;;
        Doctor)    echo -e "${GREEN}${BOLD}Doctor   ${NC}" ;;
        Tests)     echo -e "${CYAN}${BOLD}Tests    ${NC}" ;;
        Install)   echo -e "${YELLOW}${BOLD}Install  ${NC}" ;;
        System)    echo -e "${RED}${BOLD}System   ${NC}" ;;
        *)         printf "%-9s" "$comp" ;;
    esac
}

# ── Extract a clean timestamp from a log line ──────────────────────────────────
extract_timestamp() {
    local line="$1"
    # Try common timestamp patterns
    # [2026-05-28 12:34:56]
    local ts
    ts=$(echo "$line" | grep -oP '\[\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}\]' | head -1)
    if [ -n "$ts" ]; then
        echo "$ts"
        return
    fi
    # 2026-05-28 12:34:56
    ts=$(echo "$line" | grep -oP '\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}' | head -1)
    if [ -n "$ts" ]; then
        echo "[$ts]"
        return
    fi
    # === DOTS DOCTOR 2026-05-28 12:34:56 ===
    ts=$(echo "$line" | grep -oP '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}' | head -1)
    if [ -n "$ts" ]; then
        echo "[$ts]"
        return
    fi
    echo ""
}

# ── Format a log line for display ──────────────────────────────────────────────
format_line() {
    local line="$1"
    local sev component timestamp msg

    sev=$(detect_severity "$line")
    component=$(detect_component "$line")
    timestamp=$(extract_timestamp "$line")
    msg="$line"

    # Apply filters
    if [ -n "$SHOW_SEVERITY" ] && [ "$sev" != "$SHOW_SEVERITY" ]; then
        return 1
    fi
    if [ -n "$SHOW_COMPONENT" ]; then
        local comp_lower
        comp_lower=$(echo "$component" | tr '[:upper:]' '[:lower:]')
        local filter_lower
        filter_lower=$(echo "$SHOW_COMPONENT" | tr '[:upper:]' '[:lower:]')
        if [ "$comp_lower" != "$filter_lower" ]; then
            return 1
        fi
    fi

    if [ "$JSON" = true ]; then
        local json_sev json_comp json_msg json_ts
        json_sev=$(echo "$sev" | tr -d '\n')
        json_comp=$(echo "$component" | tr -d '\n')
        json_msg=$(echo "$msg" | sed 's/"/\\"/g' | tr -d '\n')
        json_ts=$(echo "$timestamp" | sed 's/[][]//g' | tr -d '\n')
        echo "{\"timestamp\":\"$json_ts\",\"severity\":\"$json_sev\",\"component\":\"$json_comp\",\"message\":\"$json_msg\"}"
    else
        local sev_colored comp_colored ts_colored
        sev_colored=$(severity_color "$sev")
        comp_colored=$(component_color "$component")
        ts_colored="${DIM}$timestamp${NC}"
        echo -e "$ts_colored $sev_colored $comp_colored $msg"
    fi
    return 0
}

# ── Collect all log entries from all sources ───────────────────────────────────
collect_entries() {
    local tmp_file
    tmp_file=$(mktemp)

    # Helper: write all formatted lines from a file to the temp collection
    collect_file() {
        local file="$1"
        [ ! -f "$file" ] && return
        [ ! -s "$file" ] && return

        while IFS= read -r line || [ -n "$line" ]; do
            [ -z "$line" ] && continue
            echo "$line" | grep -qE '^={3,}|^-{3,}|^───' && continue

            local ts
            ts=$(extract_timestamp "$line")
            if [ -z "$ts" ]; then
                ts="[0000-00-00 00:00:00]"
            fi
            echo "$ts|$line" >> "$tmp_file"
        done < "$file" 2>/dev/null || true
    }

    collect_file "$ERROR_LOG"
    collect_file "$AUTOUPDATE_LOG"
    collect_file "$DOTS_LOG"
    collect_file "$DOCTOR_LOG"
    collect_file "$CORE_LOG"

    # Collect all .log files in the logs directory
    if [ -d "$LOG_DIR" ]; then
        for f in "$LOG_DIR"/*.log; do
            [ -f "$f" ] || continue
            # Already collected dots.log and doctor.log above
            case "$(basename "$f")" in
                dots.log|doctor.log) continue ;;
            esac
            collect_file "$f"
        done
    fi

    echo "$tmp_file"
}

# ── Summary mode: count errors by component ────────────────────────────────────
show_summary() {
    local tmp_file
    tmp_file=$(collect_entries)

    if [ ! -s "$tmp_file" ]; then
        echo "  ${YELLOW}No log entries found.${NC}"
        rm -f "$tmp_file"
        return
    fi

    declare -A ERROR_COUNTS WARN_COUNTS INFO_COUNTS OK_COUNTS

    while IFS='|' read -r ts line; do
        local sev comp
        sev=$(detect_severity "$line")
        comp=$(detect_component "$line")
        case "$sev" in
            ERROR) ERROR_COUNTS["$comp"]=$(( ${ERROR_COUNTS["$comp"]:-0} + 1 )) ;;
            WARN)  WARN_COUNTS["$comp"]=$(( ${WARN_COUNTS["$comp"]:-0} + 1 )) ;;
            INFO)  INFO_COUNTS["$comp"]=$(( ${INFO_COUNTS["$comp"]:-0} + 1 )) ;;
            OK)    OK_COUNTS["$comp"]=$(( ${OK_COUNTS["$comp"]:-0} + 1 )) ;;
        esac
    done < "$tmp_file"

    echo -e "${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║           ERROR SUMMARY BY COMPONENT                       ║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Collect all components (temporarily bypass unbound check for potentially empty arrays)
    set +u
    local all_comps
    all_comps=$( (
        for k in "${!ERROR_COUNTS[@]}"; do echo "$k"; done
        for k in "${!WARN_COUNTS[@]}"; do echo "$k"; done
        for k in "${!INFO_COUNTS[@]}"; do echo "$k"; done
        for k in "${!OK_COUNTS[@]}"; do echo "$k"; done
    ) | sort -u)
    set -u

    local total_errors=0 total_warns=0
    printf "  ${BOLD}%-12s %6s %6s %6s %6s${NC}\n" "Component" "ERRORS" "WARNS" "INFO" "OK"
    echo "  ─────────────────────────────────────────────"

    while IFS= read -r comp; do
        [ -z "$comp" ] && continue
        local e="${ERROR_COUNTS[$comp]:-0}"
        local w="${WARN_COUNTS[$comp]:-0}"
        local i="${INFO_COUNTS[$comp]:-0}"
        local o="${OK_COUNTS[$comp]:-0}"
        total_errors=$((total_errors + e))
        total_warns=$((total_warns + w))
        printf "  ${BOLD}%-12s${NC} ${RED}%6s${NC} ${YELLOW}%6s${NC} ${BLUE}%6s${NC} ${GREEN}%6s${NC}\n" "$comp" "$e" "$w" "$i" "$o"
    done <<< "$all_comps"

    echo "  ─────────────────────────────────────────────"
    printf "  ${BOLD}%-12s${NC} ${RED}${BOLD}%6s${NC} ${YELLOW}${BOLD}%6s${NC}\n" "TOTAL" "$total_errors" "$total_warns"

    local total_lines
    total_lines=$(wc -l < "$tmp_file" 2>/dev/null || echo "0")
    echo ""
    echo -e "  ${DIM}Total log entries scanned: $total_lines${NC}"

    if [ "$total_errors" -gt 0 ]; then
        echo ""
        echo -e "  ${RED}${BOLD}Top Errors:${NC}"
        local tmp_top
        tmp_top=$(mktemp)
        while IFS='|' read -r ts line; do
            local sev
            sev=$(detect_severity "$line")
            if [ "$sev" = "ERROR" ]; then
                echo "$line" >> "$tmp_top"
            fi
        done < "$tmp_file"
        sort "$tmp_top" | uniq -c | sort -rn | head -5 | while read -r count line; do
            echo -e "    ${RED}✗${NC} ${DIM}[$count×]${NC} $(echo "$line" | head -c 120)"
        done
        rm -f "$tmp_top"
    fi

    rm -f "$tmp_file"
}

# ── Follow mode: tail -f across all log files ──────────────────────────────────
follow_logs() {
    echo -e "${BOLD}${CYAN}  dotlogcat — Following logs... (Ctrl+C to stop)${NC}"
    echo -e "  ${DIM}Watching: errors.log, dots.log, doctor.log, autoupdate.log${NC}"
    echo ""

    local files_to_watch=()
    [ -f "$ERROR_LOG" ] && files_to_watch+=("$ERROR_LOG")
    [ -f "$DOTS_LOG" ] && files_to_watch+=("$DOTS_LOG")
    [ -f "$DOCTOR_LOG" ] && files_to_watch+=("$DOCTOR_LOG")
    [ -f "$AUTOUPDATE_LOG" ] && files_to_watch+=("$AUTOUPDATE_LOG")
    [ -f "$CORE_LOG" ] && files_to_watch+=("$CORE_LOG")

    if [ ${#files_to_watch[@]} -eq 0 ]; then
        echo -e "  ${YELLOW}No log files found to follow.${NC}"
        return
    fi

    # Use process substitution to avoid orphan tail processes on Ctrl+C
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        # Skip tail's file header separators (inserted when watching >1 file)
        [[ "$line" == "==>"* ]] && continue
        format_line "$line" && true
    done < <(tail -f "${files_to_watch[@]}" 2>/dev/null)
}

# ── Watch mode: periodically refresh ───────────────────────────────────────────
watch_logs() {
    local interval="${1:-5}"
    echo -e "${BOLD}${CYAN}  dotlogcat — Watching (every ${interval}s)... (Ctrl+C to stop)${NC}"
    echo ""

    while true; do
        clear 2>/dev/null || true
        echo -e "${BOLD}${CYAN}  ── dotlogcat @ $(date '+%H:%M:%S') ──${NC}"
        echo ""
        show_logs "$DEFAULT_LINES"
        sleep "$interval"
    done
}

# ── Display the collected logs ─────────────────────────────────────────────────
show_logs() {
    local max_lines="${1:-$DEFAULT_LINES}"
    local tmp_file
    tmp_file=$(collect_entries)

    if [ ! -s "$tmp_file" ]; then
        echo -e "  ${YELLOW}No log entries found.${NC}"
        echo -e "  ${DIM}Checked: errors.log, dots.log, doctor.log, autoupdate.log, core log${NC}"
        rm -f "$tmp_file"
        return
    fi

    # Sort by timestamp then apply line limit
    local sorted_file
    sorted_file=$(mktemp)
    sort -t'[' -k2 "$tmp_file" 2>/dev/null | tail -n "$max_lines" > "$sorted_file"

    # Apply additional filters and display
    local displayed=0 skipped=0
    while IFS='|' read -r ts line; do
        # Apply since filter
        if [ -n "$SINCE" ]; then
            local line_date
            line_date=$(echo "$ts" | tr -d '[]' | cut -d' ' -f1 2>/dev/null || echo "0000-00-00")
            if [[ "$line_date" < "$SINCE" ]]; then
                skipped=$((skipped + 1))
                continue
            fi
        fi

        if format_line "$line"; then
            displayed=$((displayed + 1))
        else
            skipped=$((skipped + 1))
        fi
    done < "$sorted_file"

    if [ "$displayed" -eq 0 ]; then
        echo -e "  ${YELLOW}No matching entries found.${NC}"
        if [ "$skipped" -gt 0 ]; then
            echo -e "  ${DIM}($skipped entries filtered out)${NC}"
        fi
    else
        echo ""
        echo -e "  ${DIM}Showing $displayed entries${NC}"
    fi

    rm -f "$tmp_file" "$sorted_file"
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════════════════════

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--lines)
            DEFAULT_LINES="$2"; shift 2 ;;
        -f|--follow)
            FOLLOW=true; shift ;;
        -s|--summary)
            SUMMARY=true; shift ;;
        -w|--watch)
            WATCH=true; shift ;;
        -a|--all)
            ALL=true; shift ;;
        -c|--component)
            SHOW_COMPONENT="$2"; shift 2 ;;
        -S|--severity)
            SHOW_SEVERITY="$2"; shift 2 ;;
        --since)
            SINCE="$2"; shift 2 ;;
        --json)
            JSON=true; shift ;;
        -h|--help)
            usage; exit 0 ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}" >&2
            usage; exit 1 ;;
    esac
done

# ── Mode dispatch ──────────────────────────────────────────────────────────────
if [ "$SUMMARY" = true ]; then
    show_summary
elif [ "$FOLLOW" = true ]; then
    follow_logs
elif [ "$WATCH" = true ]; then
    watch_logs
else
    if [ "$ALL" = true ]; then
        DEFAULT_LINES=999999
    fi
    show_logs "$DEFAULT_LINES"
fi
