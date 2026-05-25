#!/usr/bin/env bash
# =============================================================================
# Bloat Tolerance Test Suite
# =============================================================================
# This test verifies that the dotfiles can tolerate large amounts of
# well-structured content (comment headers, guarded sections, etc.) without
# causing syntax errors. It synthesizes bloated versions of key files and
# validates them syntactically, without modifying the actual dotfiles.
#
# Usage:
#   bash tests/test_bloat_tolerance.sh            # run all tests
#   bash tests/test_bloat_tolerance.sh --cleanup   # remove temp files
#
# Return code: 0 = all passed, 1 = one or more failures

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR=""
PASS=0
FAIL=0

# Shell syntax checkers
check_bash() { bash -n "$1" 2>&1; }
check_zsh()  { zsh -n "$1" 2>&1; }
check_fish() { fish -n "$1" 2>&1 || [[ $? -eq 0 ]]; }

# Test result helpers
pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); echo "  ✗ $1"; echo "    output: $2"; }

setup() {
    TMPDIR="$(mktemp -d)"
    echo "→ Created temp directory: $TMPDIR"
}

cleanup() {
    if [[ -n "$TMPDIR" && -d "$TMPDIR" ]]; then
        rm -rf "$TMPDIR"
        echo "→ Cleaned up: $TMPDIR"
    fi
}

# =============================================================================
# Section 1: Bash bloat test
# =============================================================================
# Synthesize a bash file with 50 heavily-commented sections (simulating
# max expanded aliases/exports). Each section wraps its content in
# `command -v` guards so no tool absence causes errors.

test_bash_bloat() {
    local f="$TMPDIR/bash_bloat_test.bash"
    cat > "$f" << 'BASH_HEADER'
#!/usr/bin/env bash
# Bloat tolerance test – bash

_x() { if command -v "${1%% *}" >/dev/null 2>&1; then "$@"; else return 127; fi; }

BASH_HEADER

    # Generate 50 bloat sections
    for i in $(seq 1 50); do
        cat >> "$f" << BLOATSECTION
# =============================================================================
# BLOAT_SECTION_${i} - expanded tool aliases
# =============================================================================
# Guard: each alias block is wrapped in command -v so missing tools never
# cause errors, even with thousands of lines of bloat.

if command -v tool_${i}a >/dev/null 2>&1; then
    alias t${i}a='tool_${i}a'
    alias t${i}al='tool_${i}a --list'
    alias t${i}ar='tool_${i}a --run'
    alias t${i}ab='tool_${i}a --build'
    alias t${i}at='tool_${i}a --test'
    alias t${i}ad='tool_${i}a --deploy'
fi

if command -v tool_${i}b >/dev/null 2>&1; then
    alias t${i}b='tool_${i}b'
    alias t${i}bl='tool_${i}b --list'
    alias t${i}br='tool_${i}b --run'
    alias t${i}bb='tool_${i}b --build'
fi

if command -v tool_${i}c >/dev/null 2>&1; then
    alias t${i}c='tool_${i}c'
    alias t${i}cl='tool_${i}c --list'
    alias t${i}cr='tool_${i}c --run'
fi

# -----------------------------------------------------------------------------
# Section $i - safe no-ops
# -----------------------------------------------------------------------------
alias dummy${i}a='echo "section_${i}_a" 2>/dev/null || true'
alias dummy${i}b='echo "section_${i}_b" 2>/dev/null || true'
alias dummy${i}c='echo "section_${i}_c" 2>/dev/null || true'
alias dummy${i}d='echo "section_${i}_d" 2>/dev/null || true'
alias dummy${i}e='echo "section_${i}_e" 2>/dev/null || true'

BLOATSECTION
    done

    # Validate syntax
    local out; out=$(check_bash "$f" 2>&1) || true
    if bash -n "$f" 2>/dev/null; then
        pass "bash bloat (${i} sections)"
    else
        fail "bash bloat" "$out"
    fi
}

# =============================================================================
# Section 2: Zsh bloat test
# =============================================================================

test_zsh_bloat() {
    local f="$TMPDIR/zsh_bloat_test.zsh"
    cat > "$f" << 'ZSH_HEADER'
#!/usr/bin/env zsh
# Bloat tolerance test – zsh

_x() { if command -v "${1%% *}" >/dev/null 2>&1; then "$@"; else return 127; fi; }

ZSH_HEADER

    for i in $(seq 1 50); do
        cat >> "$f" << SECTION
# =============================================================================
# ZSH BLOAT_SECTION_${i}
# =============================================================================
# Guard: each block is conditionally executed on tool availability.

if command -v tool_${i}x >/dev/null 2>&1; then
    alias tx${i}a='tool_${i}x'
    alias tx${i}b='tool_${i}x --flag'
    alias tx${i}c='tool_${i}x --verbose'
fi

(( \${+commands[tool_${i}y]} )) && {
    alias ty${i}a='tool_${i}y'
    alias ty${i}b='tool_${i}y --list'
    alias ty${i}c='tool_${i}y --all'
}

alias zbloat${i}a='echo "zbloat_${i}_a" 2>/dev/null || true'
alias zbloat${i}b='echo "zbloat_${i}_b" 2>/dev/null || true'

SECTION
    done

    if zsh -n "$f" 2>/dev/null; then
        pass "zsh bloat (${i} sections)"
    else
        local out; out=$(check_zsh "$f" 2>&1) || true
        fail "zsh bloat" "$out"
    fi
}

# =============================================================================
# Section 3: Fish bloat test
# =============================================================================

test_fish_bloat() {
    local f="$TMPDIR/fish_bloat_test.fish"
    cat > "$f" << 'FISH_HEADER'
#!/usr/bin/env fish
# Bloat tolerance test – fish

FISH_HEADER

    for i in $(seq 1 50); do
        cat >> "$f" << FISHSECTION
# =============================================================================
# FISH BLOAT_SECTION_${i}
# =============================================================================
# Guard: type -q checks prevent errors when tools aren't installed.

if type -q tool_${i}p
    alias tp${i}a="tool_${i}p"
    alias tp${i}b="tool_${i}p --flag"
    alias tp${i}c="tool_${i}p --version"
end

if type -q tool_${i}q
    alias tq${i}a="tool_${i}q"
    alias tq${i}b="tool_${i}q --verbose"
    alias tq${i}c="tool_${i}q --list"
end

# Safe no-ops - always defined, always harmless
alias fishbloat_${i}_a="true"
alias fishbloat_${i}_b="true"
alias fishbloat_${i}_c="true"

FISHSECTION
    done

    if fish -n "$f" 2>/dev/null; then
        pass "fish bloat (50 sections)"
    else
        local out; out=$(check_fish "$f" 2>&1) || true
        fail "fish bloat" "$out"
    fi
}

# =============================================================================
# Section 4: Real dotfiles reference check
# =============================================================================
# Verify that the actual dotfiles parse cleanly with their current content.

test_real_files() {
    local errors=0

    echo "--- Bash files ---"
    for f in "$ROOT"/shells/bash/*.bash "$ROOT"/shells/bash/.bashrc "$ROOT"/core/*.sh "$ROOT"/bin/*.sh "$ROOT"/install/*.sh "$ROOT"/install.sh; do
        [[ -f "$f" ]] || continue
        bash -n "$f" 2>/dev/null && continue
        echo "  FAIL: $f"
        errors=$((errors + 1))
    done

    echo "--- Zsh files ---"
    for f in "$ROOT"/shells/zsh/*.zsh "$ROOT"/shells/zsh/.zshrc "$ROOT"/shells/zsh/.zprofile; do
        [[ -f "$f" ]] || continue
        zsh -n "$f" 2>/dev/null && continue
        echo "  FAIL: $f"
        errors=$((errors + 1))
    done

    echo "--- Fish files ---"
    for f in "$ROOT"/shells/fish/*.fish; do
        [[ -f "$f" ]] || continue
        fish -n "$f" 2>/dev/null && continue
        echo "  FAIL: $f"
        errors=$((errors + 1))
    done

    echo "--- Hypr scripts (bash syntax) ---"
    for f in "$ROOT"/hypr/scripts/*; do
        [[ -f "$f" ]] || continue
        head -1 "$f" | grep -qE 'sh|bash' 2>/dev/null || continue
        bash -n "$f" 2>/dev/null && continue
        echo "  FAIL: $f"
        errors=$((errors + 1))
    done

    if [[ $errors -eq 0 ]]; then
        pass "real dotfiles — all syntax checks pass"
    else
        fail "real dotfiles — $errors files have syntax errors" "see above"
    fi
}

# =============================================================================
# Run all tests
# =============================================================================

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║        BLOAT TOLERANCE TEST SUITE                       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

setup
trap cleanup EXIT

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  SYNTHETIC BLOAT TESTS (50 sections each)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

test_bash_bloat
test_zsh_bloat
test_fish_bloat

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  REAL DOTFILES VALIDATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

test_real_files

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  RESULTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Passed: $PASS    Failed: $FAIL"
echo ""

if [[ $FAIL -gt 0 ]]; then
    echo "  ❌ Some tests failed."
    exit 1
else
    echo "  ✅ All tests passed — bloat-tolerant!"
    exit 0
fi
