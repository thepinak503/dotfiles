#!/usr/bin/env bash
# =============================================================================
# DOTFILES DIAGNOSTIC SCRIPT v1.0
# For: Detecting alias/function/syntax conflicts across all 3 shells
# Output: Structured, LLM-friendly error reporting
# =============================================================================

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Colors for human readability (but keep output structured)
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; NC='\033[0m'

# Counters
ERRORS=0
WARNINGS=0
PASSES=0

# Arrays for reporting
declare -a ERROR_LIST=()
declare -a WARN_LIST=()
declare -a PASS_LIST=()

error() {
    echo -e "${RED}✗ ERROR:${NC} $1"
    ERROR_LIST+=("$1")
    ERRORS=$((ERRORS + 1))
}

warn() {
    echo -e "${YELLOW}⚠ WARNING:${NC} $1"
    WARN_LIST+=("$1")
    WARNINGS=$((WARNINGS + 1))
}

pass() {
    echo -e "${GREEN}✓ PASS:${NC} $1"
    PASS_LIST+=("$1")
    PASSES=$((PASSES + 1))
}

section() {
    echo ""
    echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"
}

# =============================================================================
# PHASE 1: Syntax Check All Files
# =============================================================================

section "PHASE 1: SYNTAX VALIDATION"

# Find all shell files
ALL_SH_FILES=()
while IFS= read -r -d '' f; do
    ALL_SH_FILES+=("$f")
done < <(find "$ROOT" -type f \( -name "*.sh" -o -name "*.bash" -o -name "*.zsh" \) -print0 2>/dev/null)

# Bash syntax check for bash-compatible files
for f in "${ALL_SH_FILES[@]}"; do
    # Skip if in .git
    if [[ "$f" == *".git"* ]]; then continue; fi
    
    rel="${f#$ROOT/}"
    
    # Check shebang
    if head -1 "$f" 2>/dev/null | grep -qE '^#!.*bash|^#!.*sh'; then
        bash_err="$(bash -n "$f" 2>&1)"
        if [[ -n "$bash_err" ]]; then
            error "BASH SYNTAX: $rel"
            echo "    $bash_err" | sed 's/^/    /'
        else
            pass "Bash syntax: $rel"
        fi
    fi
done

# Fish syntax check
FISH_FILES=()
while IFS= read -r -d '' f; do
    FISH_FILES+=("$f")
done < <(find "$ROOT" -type f -name "*.fish" -print0 2>/dev/null)

if command -v fish >/dev/null 2>&1; then
    for f in "${FISH_FILES[@]}"; do
        rel="${f#$ROOT/}"
        fish_err="$(fish --no-execute "$f" 2>&1)"
        if [[ -n "$fish_err" ]]; then
            error "FISH SYNTAX: $rel"
            echo "    $fish_err" | sed 's/^/    /'
        else
            pass "Fish syntax: $rel"
        fi
    done
else
    warn "fish not installed, skipping fish syntax checks"
fi

# =============================================================================
# PHASE 2: Check for alias vs function conflicts in the SAME shell
# =============================================================================

section "PHASE 2: ALIAS vs FUNCTION CONFLICTS (Per Shell)"

check_bash_zsh_conflicts() {
    local shell_name="$1"
    local shell_cmd="$2"
    local alias_files="$3"
    local func_files="$4"
    
    echo ""
    echo "Checking: $shell_name"
    
    # Get all alias definitions
    local -A aliases=()
    for f in $alias_files; do
        if [[ ! -f "$f" ]]; then continue; fi
        while IFS= read -r line; do
            if [[ "$line" =~ ^alias[[:space:]]+([a-zA-Z0-9_-]+)= ]]; then
                name="${BASH_REMATCH[1]}"
                aliases["$name"]=1
            fi
        done < "$f"
    done
    
    # Get all function definitions
    local -A functions=()
    for f in $func_files; do
        if [[ ! -f "$f" ]]; then continue; fi
        while IFS= read -r line; do
            # function foo() or foo()
            if [[ "$line" =~ ^function[[:space:]]+([a-zA-Z0-9_-]+)[[:space:]]*\(\) ]]; then
                name="${BASH_REMATCH[1]}"
                functions["$name"]=1
            elif [[ "$line" =~ ^([a-zA-Z0-9_-]+)[[:space:]]*\(\)[[:space:]]*\{ ]]; then
                name="${BASH_REMATCH[1]}"
                functions["$name"]=1
            elif [[ "$line" =~ ^([a-zA-Z0-9_-]+)[[:space:]]*\(\)[[:space:]]*$ ]]; then
                name="${BASH_REMATCH[1]}"
                functions["$name"]=1
            fi
        done < "$f"
    done
    
    # Find conflicts
    local conflicts=0
    for a in "${!aliases[@]}"; do
        if [[ -n "${functions[$a]:-}" ]]; then
            error "CONFLICT [$shell_name]: '$a' is both ALIAS and FUNCTION"
            conflicts=$((conflicts + 1))
        fi
    done
    
    if [[ $conflicts -eq 0 ]]; then
        pass "$shell_name: No alias/function conflicts"
    fi
    
    echo "  $shell_name Stats: ${#aliases[@]} aliases, ${#functions[@]} functions"
}

# Check BASH files
check_bash_zsh_conflicts "BASH" "bash" \
    "$ROOT/core/aliases.sh $ROOT/core/universal.sh $ROOT/core/arch_aliases.sh $ROOT/core/debian_aliases.sh $ROOT/core/fedora_aliases.sh $ROOT/core/macos_aliases.sh $ROOT/shells/bash/aliases.bash" \
    "$ROOT/core/functions.sh $ROOT/core/tools.sh $ROOT/shells/bash/functions.bash"

# Check ZSH files
check_bash_zsh_conflicts "ZSH" "zsh" \
    "$ROOT/core/aliases.sh $ROOT/core/universal.sh $ROOT/core/arch_aliases.sh $ROOT/core/debian_aliases.sh $ROOT/core/fedora_aliases.sh $ROOT/core/macos_aliases.sh $ROOT/shells/zsh/aliases.zsh" \
    "$ROOT/core/functions.sh $ROOT/core/tools.sh"

# Check FISH (different syntax)
echo ""
echo "Checking: FISH"

fish_alias_count=0
fish_func_count=0
declare -A fish_aliases=()
declare -A fish_funcs=()

for f in $ROOT/shells/fish/aliases.fish $ROOT/shells/fish/functions.fish; do
    if [[ ! -f "$f" ]]; then continue; fi
    rel="${f#$ROOT/}"
    
    while IFS= read -r line; do
        # Fish alias: alias foo 'bar' or alias foo=bar
        if [[ "$line" =~ ^alias[[:space:]]+([a-zA-Z0-9_-]+)[[:space:]] ]]; then
            name="${BASH_REMATCH[1]}"
            fish_aliases["$name"]=1
        # Fish function: function foo
        elif [[ "$line" =~ ^function[[:space:]]+([a-zA-Z0-9_-]+) ]]; then
            name="${BASH_REMATCH[1]}"
            # skip common prefixes like __fish_
            if [[ ! "$name" =~ ^__ ]]; then
                fish_funcs["$name"]=1
            fi
        fi
    done < "$f"
done

# Check fish conflicts
fish_conflicts=0
for a in "${!fish_aliases[@]}"; do
    if [[ -n "${fish_funcs[$a]:-}" ]]; then
        error "CONFLICT [FISH]: '$a' is both ALIAS and FUNCTION"
        fish_conflicts=$((fish_conflicts + 1))
    fi
done

if [[ $fish_conflicts -eq 0 ]]; then
    pass "FISH: No alias/function conflicts"
fi
echo "  FISH Stats: ${#fish_aliases[@]} aliases, ${#fish_funcs[@]} functions"

# =============================================================================
# PHASE 3: Actual Shell Loading Test (Live Test)
# =============================================================================

section "PHASE 3: LIVE SHELL LOAD TEST"

test_shell_load() {
    local shell_name="$1"
    
    echo ""
    echo "Testing $shell_name RC load..."
    
    if ! command -v "$shell_name" >/dev/null 2>&1; then
        warn "$shell_name not installed, skipping load test"
        return
    fi
    
    # Create a minimal test script
    local test_out=$(mktemp /tmp/dottest.XXXXXX)
    local test_err=$(mktemp /tmp/dotterr.XXXXXX)
    
    case "$shell_name" in
        bash)
            # Test bash
            DOTFILES_DIR="$ROOT" HOME="$HOME" "$shell_name" -i -c "exit 0" >"$test_out" 2>"$test_err"
            ;;
        zsh)
            DOTFILES_DIR="$ROOT" HOME="$HOME" "$shell_name" -i -c "exit 0" >"$test_out" 2>"$test_err"
            ;;
        fish)
            DOTFILES_DIR="$ROOT" HOME="$HOME" "$shell_name" -i -c "exit 0" >"$test_out" 2>"$test_err"
            ;;
    esac
    
    local rc=$?
    
    # Filter out expected errors (terminal/tty issues)
    local filtered_err=$(grep -v \
        -e 'cannot set terminal process group' \
        -e 'Inappropriate ioctl for device' \
        -e '^stty: .*standard input' \
        -e 'tput: No value for $TERM' \
        -e 'find-the-command:' \
        -e 'no job control in this shell' \
        -e '^exit$' \
        "$test_err")
    
    if [[ $rc -ne 0 ]]; then
        error "$shell_name exited with code $rc"
    fi
    
    if [[ -n "$filtered_err" ]]; then
        error "$shell_name load produced errors:"
        echo "$filtered_err" | sed 's/^/    /'
    else
        pass "$shell_name loads cleanly"
    fi
    
    rm -f "$test_out" "$test_err"
}

test_shell_load bash
test_shell_load zsh
test_shell_load fish

# =============================================================================
# PHASE 4: Cross-Shell Conflict Detection (Same name defined across shells)
# =============================================================================

section "PHASE 4: CROSS-SHELL NAMING ANALYSIS (Informational)"

# Collect ALL names from ALL shells for visibility
echo ""
echo "Most common names (these should behave consistently across shells):"

# Just report top aliases that exist in BOTH bash and fish as informational
# This is NOT necessarily an error, but good to know

# =============================================================================
# FINAL REPORT
# =============================================================================

section "FINAL SUMMARY"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                     DIAGNOSTIC RESULTS                           ║"
echo "╠════════════════════════════════════════════════════════════════╣"
printf "║  PASS:   %-53s║\n" "$PASSES"
printf "║  WARNING:%-53s║\n" "$WARNINGS"
printf "║  ERROR:  %-53s║\n" "$ERRORS"
echo "╚════════════════════════════════════════════════════════════════╝"

# Structured output for LLM
echo ""
echo "---"
echo "STRUCTURED OUTPUT FOR LLM:"
echo "---"

echo "ERRORS=$ERRORS"
echo "WARNINGS=$WARNINGS"
echo "PASSES=$PASSES"

if [[ ${#ERROR_LIST[@]} -gt 0 ]]; then
    echo ""
    echo "ERROR_LIST:"
    for e in "${ERROR_LIST[@]}"; do
        echo "  - $e"
    done
fi

if [[ ${#WARN_LIST[@]} -gt 0 ]]; then
    echo ""
    echo "WARNING_LIST:"
    for w in "${WARN_LIST[@]}"; do
        echo "  - $w"
    done
fi

# Exit code
echo ""
echo "---"
if [[ $ERRORS -gt 0 ]]; then
    echo "EXIT_CODE=1 (Errors present)"
    exit 1
elif [[ $WARNINGS -gt 0 ]]; then
    echo "EXIT_CODE=0 (Warnings only)"
    exit 0
else
    echo "EXIT_CODE=0 (All checks passed)"
    exit 0
fi
