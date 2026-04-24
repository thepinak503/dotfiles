#!/usr/bin/env bash
DOTFILES_LOG_FILE="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}/errors.log"
BOLD="\033[1m"
GREEN="\033[1;32m"
RED="\033[1;31m"
RESET="\033[0m"
echo -e "${BOLD}Checking Dotfiles Startup Integrity...${RESET}"
echo "Log: $DOTFILES_LOG_FILE"
echo "----------------------------------------"
check_shell() {
    local shell_name="$1"
    local shell_cmd="$2"
    if ! command -v "$shell_cmd" &>/dev/null; then
        echo -e "[ ${RED}SKIP${RESET} ] $shell_name (not installed)"
        return
    fi
    echo -n "Checking $shell_name... "
    local tmp_err; tmp_err=$(mktemp)
    case "$shell_cmd" in
        bash)
            bash -i -c "exit" 2>"$tmp_err"
            ;;
        zsh)
            zsh -i -c "exit" 2>"$tmp_err"
            ;;
        fish)
            fish -i -c "exit" 2>"$tmp_err"
            ;;
    esac
    grep -vE "set: Tried to change the read-only variable|job control" "$tmp_err" > "${tmp_err}.filtered"
    if [ -s "${tmp_err}.filtered" ]; then
        echo -e "${RED}FAILED${RESET}"
        echo -e "${BOLD}Errors found in $shell_name startup:${RESET}"
        cat "${tmp_err}.filtered"
        {
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] STARTUP_ERROR ($shell_name):"
            cat "${tmp_err}.filtered"
        } >> "$DOTFILES_LOG_FILE"
    else
        echo -e "${GREEN}PASSED${RESET}"
    fi
    rm -f "$tmp_err" "${tmp_err}.filtered"
}
check_shell "Bash" "bash"
check_shell "Zsh" "zsh"
check_shell "Fish" "fish"
echo "----------------------------------------"
echo -e "${BOLD}Done.${RESET} Check 'doterrors' for detailed logs."
