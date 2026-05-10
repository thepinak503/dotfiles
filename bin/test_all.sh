#!/usr/bin/env bash
#
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'
PASS=0; FAIL=0; SKIP=0; WARN=0
pass() { printf "  ${GREEN}✓${NC} %s\n" "$1"; PASS=$(( PASS + 1 )); }
fail() { printf "  ${RED}✗${NC} %s\n" "$1"; FAIL=$(( FAIL + 1 )); }
skip() { printf "  ${YELLOW}○${NC} %s\n" "$1 (skipped — $2 not found)"; SKIP=$(( SKIP + 1 )); }
warn() { printf "  ${YELLOW}⚠${NC} %s\n" "$1"; WARN=$(( WARN + 1 )); }
section() { printf "\n${BOLD}${CYAN}▶ %s${NC}\n" "$1"; }
DO_BASH=true; DO_ZSH=true; DO_FISH=true; DO_SLOW=true
for arg in "$@"; do
    case "$arg" in
        --bash)  DO_ZSH=false;  DO_FISH=false ;;
        --zsh)   DO_BASH=false; DO_FISH=false ;;
        --fish)  DO_BASH=false; DO_ZSH=false  ;;
        --fast)  DO_SLOW=false ;;
        --help|-h)
            echo "Usage: $0 [--bash|--zsh|--fish|--fast]"
            exit 0 ;;
    esac
done
printf "\n${BOLD}${CYAN}"
printf "╔══════════════════════════════════════════════════╗\n"
printf "║         DOTFILES TEST SUITE                     ║\n"
printf "╚══════════════════════════════════════════════════╝${NC}\n"
printf "  Root: %s\n" "$ROOT"
if [[ "$DO_BASH" == true ]]; then
    section "Bash syntax (bash -n)"
    BASH_FILES=(
        "shells/bash/.bashrc"
        "core/system-detect.sh"
        "core/battery.sh"
        "core/logging.sh"
        "core/ssh-agent.sh"
        "core/tools.sh"
        "shells/bash/aliases.bash"
        "shells/bash/functions.bash"
        "shells/bash/03-dynamic_aliases.bash"
        "shells/bash/04-pkg_aliases.bash"
        "shells/bash/modes/minimal.bash"
        "shells/bash/modes/standard.bash"
        "shells/bash/modes/supreme.bash"
        "shells/bash/modes/ultra-nerd.bash"
        "install/install.sh"
        "install/uninstall.sh"
        "bin/inventory_check.sh"
    )
    for f in "${BASH_FILES[@]}"; do
        if [[ ! -f "$f" ]]; then
            warn "MISSING: $f"
            continue
        fi
        err="$(bash -n "$f" 2>&1)"
        if [[ -n "$err" ]]; then
            fail "bash -n $f"
            printf "     %s\n" "$err"
        else
            pass "bash -n $f"
        fi
    done
    section "Bash: core/ files must be sh-compatible (no bashisms)"
    SH_FILES=(core/system-detect.sh core/battery.sh core/ssh-agent.sh)
    for f in "${SH_FILES[@]}"; do
        [[ -f "$f" ]] || { warn "MISSING: $f"; continue; }
        if grep -Pn '\[\[|\((' "$f" 2>/dev/null | grep -v '^\s*#' | grep -q .; then
            warn "$f contains bash-specific syntax (may not be POSIX sh)"
        else
            pass "$f looks POSIX-compatible"
        fi
    done
fi
if [[ "$DO_ZSH" == true ]]; then
    section "Zsh syntax (zsh -n)"
    if ! command -v zsh &>/dev/null; then
        skip "all zsh files" "zsh"
    else
        ZSH_FILES=(
            "shells/zsh/.zshrc"
            "shells/zsh/aliases.zsh"
            "shells/zsh/functions.zsh"
            "shells/zsh/01-keybindings.zsh"
            "shells/zsh/02-plugins.zsh"
            "shells/zsh/03-dynamic_aliases.zsh"
            "shells/zsh/05-pkg_aliases.zsh"
            "shells/zsh/modes/minimal.zsh"
            "shells/zsh/modes/standard.zsh"
            "shells/zsh/modes/supreme.zsh"
            "shells/zsh/modes/ultra-nerd.zsh"
        )
        for f in "${ZSH_FILES[@]}"; do
            if [[ ! -f "$f" ]]; then
                warn "MISSING: $f"
                continue
            fi
            err="$(zsh -n "$f" 2>&1)"
            if [[ -n "$err" ]]; then
                fail "zsh -n $f"
                printf "     %s\n" "$err"
            else
                pass "zsh -n $f"
            fi
        done
    fi
fi
if [[ "$DO_FISH" == true ]]; then
    section "Fish syntax (fish --no-execute)"
    if ! command -v fish &>/dev/null; then
        skip "all fish files" "fish"
    else
        FISH_FILES=(
            "shells/fish/config.fish"
            "shells/fish/conf.d/modern-tools.fish"
            "shells/fish/conf.d/keybindings.fish"
            "shells/fish/conf.d/greeting.fish"
            "shells/fish/modes/minimal.fish"
            "shells/fish/modes/standard.fish"
            "shells/fish/modes/supreme.fish"
            "shells/fish/modes/ultra-nerd.fish"
        )
        for f in "${FISH_FILES[@]}"; do
            if [[ ! -f "$f" ]]; then
                warn "MISSING: $f"
                continue
            fi
            err="$(fish --no-execute "$f" 2>&1)"
            if [[ -n "$err" ]]; then
                fail "fish --no-execute $f"
                printf "     %s\n" "$err"
            else
                pass "fish --no-execute $f"
            fi
        done
    fi
fi
section "TOML validation (starship configs)"
TOML_FILES=(
    "apps/starship-linux.toml"
    "apps/starship-mac.toml"
)
for f in "${TOML_FILES[@]}"; do
    if [[ ! -f "$f" ]]; then
        warn "MISSING: $f"
        continue
    fi
    if command -v tomlqs &>/dev/null; then
        if tomlqs "$f" &>/dev/null; then
            pass "TOML valid: $f"
        else
            fail "TOML parse failed: $f"
        fi
    else
        skip "TOML validate $f" "tomlqs"
    fi
done
section "JSON validation (fastfetch config)"
JSON_FILES=(
    "apps/fastfetch/config.jsonc"
)
for f in "${JSON_FILES[@]}"; do
    if [[ ! -f "$f" ]]; then
        warn "MISSING: $f"
        continue
    fi
    if command -v jq &>/dev/null; then
        if jq . "$f" &>/dev/null; then
            pass "JSON valid: $f"
        else
            fail "JSON invalid: $f"
        fi
    else
        skip "JSON validate $f" "jq"
    fi
done
section "Repository structure"
REQUIRED_FILES=(
    "shells/bash/.bashrc"
    "shells/zsh/.zshrc"
    "shells/fish/config.fish"
    "core/system-detect.sh"
    "core/battery.sh"
    "core/logging.sh"
    "core/ssh-agent.sh"
    "core/tools.sh"
    "shells/bash/aliases.bash"
    "shells/bash/functions.bash"
    "shells/bash/03-dynamic_aliases.bash"
    "shells/bash/04-pkg_aliases.bash"
    "shells/bash/modes/minimal.bash"
    "shells/bash/modes/standard.bash"
    "shells/bash/modes/supreme.bash"
    "shells/bash/modes/ultra-nerd.bash"
    "shells/zsh/aliases.zsh"
    "shells/zsh/functions.zsh"
    "shells/zsh/01-keybindings.zsh"
    "shells/zsh/02-plugins.zsh"
    "shells/zsh/03-dynamic_aliases.zsh"
    "shells/zsh/05-pkg_aliases.zsh"
    "shells/zsh/modes/minimal.zsh"
    "shells/zsh/modes/standard.zsh"
    "shells/zsh/modes/supreme.zsh"
    "shells/zsh/modes/ultra-nerd.zsh"
    "shells/fish/modes/minimal.fish"
    "shells/fish/modes/standard.fish"
    "shells/fish/modes/supreme.fish"
    "shells/fish/modes/ultra-nerd.fish"
    "apps/starship-linux.toml"
    "apps/starship-mac.toml"
    "apps/fastfetch/config.jsonc"
    "install/install.sh"
    "install/uninstall.sh"
)
for f in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$f" ]]; then
        pass "exists: $f"
    else
        fail "MISSING: $f"
    fi
done
section "Anti-pattern checks"
if [[ -f "shells/bash/functions.bash" ]]; then
    dupes="$(grep -oP '^[a-zA-Z_][a-zA-Z0-9_-]*\(\)' "shells/bash/functions.bash" 2>/dev/null \
        | sort | uniq -d)"
    if [[ -n "$dupes" ]]; then
        fail "Duplicate function definitions in shells/bash/functions.bash: $dupes"
    else
        pass "No duplicate functions in shells/bash/functions.bash"
    fi
fi
if [[ -f "shells/bash/aliases.bash" ]]; then
    dupes="$(grep -oP "^alias \K[a-zA-Z0-9_.-]+" "shells/bash/aliases.bash" 2>/dev/null \
        | sort | uniq -d)"
    if [[ -n "$dupes" ]]; then
        warn "Possibly duplicate aliases in shells/bash/aliases.bash: $(echo "$dupes" | tr '\n' ' ')"
    else
        pass "No duplicate alias names in shells/bash/aliases.bash"
    fi
fi
for f in core/battery.sh core/system-detect.sh core/tools.sh core/logging.sh core/ssh-agent.sh; do
    [[ -f "$f" ]] || continue
    pass "$f present"
done
if [[ -f "shells/bash/04-pkg_aliases.bash" ]]; then
    if grep -q "^chaotic_setup$" "shells/bash/04-pkg_aliases.bash" 2>/dev/null; then
        fail "chaotic_setup auto-executes in shells/bash/04-pkg_aliases.bash"
    else
        pass "chaotic_setup is not auto-executed"
    fi
fi
for f in shells/bash/dyn_aliases.generated.bash shells/zsh/dyn_aliases.generated.zsh; do
    if [[ -f "$f" ]]; then
        warn "$f still exists (should have been removed)"
    fi
done
pass "No stale generated alias files"
section "File permissions"
EXEC_FILES=(install.sh uninstall.sh scripts/test_all.sh scripts/inventory_check.sh)
for f in "${EXEC_FILES[@]}"; do
    [[ -f "$f" ]] || continue
    if [[ -x "$f" ]]; then
        pass "executable: $f"
    else
        warn "not executable: $f  (run: chmod +x $f)"
        chmod +x "$f" && warn "  → fixed automatically"
    fi
done
section "Coverage statistics"
if [[ -f "shells/bash/aliases.bash" ]]; then
    alias_count=$(grep -c "^alias " "shells/bash/aliases.bash" 2>/dev/null || true)
    printf "  Bash aliases    : %d\n" "$alias_count"
fi
if [[ -f "shells/bash/functions.bash" ]]; then
    func_count=$(grep -cP "^[a-zA-Z_][a-zA-Z0-9_-]*\(\)" "shells/bash/functions.bash" 2>/dev/null || true)
    printf "  Bash functions  : %d\n" "$func_count"
fi
if [[ -f "shells/fish/config.fish" ]]; then
    fish_abbr=$(grep -c "^abbr -a" "shells/fish/config.fish" 2>/dev/null || true)
    fish_func=$(grep -c "^function " "shells/fish/config.fish" 2>/dev/null || true)
    printf "  Fish abbrevs    : %d\n" "$fish_abbr"
    printf "  Fish functions  : %d\n" "$fish_func"
fi
printf "\n${BOLD}${CYAN}"
printf "══════════════════════════════════════════════════\n"
printf " RESULTS: ${GREEN}%d passed${CYAN}  ${RED}%d failed${CYAN}  ${YELLOW}%d warned${CYAN}  ${YELLOW}%d skipped${CYAN}\n" \
    "$PASS" "$FAIL" "$WARN" "$SKIP"
printf "══════════════════════════════════════════════════${NC}\n\n"
if [[ "$FAIL" -gt 0 ]]; then
    echo "  ❌ Some tests failed. Fix the issues above."
    exit 1
elif [[ "$WARN" -gt 0 ]]; then
    echo "  ⚠️  All tests passed with warnings."
    exit 0
else
    echo "  ✅ All tests passed!"
    exit 0
fi
