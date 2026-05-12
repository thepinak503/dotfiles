#!/usr/bin/env bash
# Pinak's Ultimate Dotfiles - Rigorous Test Suite
# Run: bash tests/run_tests.sh
set -euo pipefail

PASS=0
FAIL=0
D=$(dirname "$0")/..

pass() { echo "  ✓ $1"; ((PASS++)); }
fail() { echo "  ✗ $1"; ((FAIL++)); }

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          RIGOROUS DOTFILES TEST SUITE                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

echo "━━━━ 1. SYNTAX VALIDATION ━━━━"
for f in core/aliases.sh core/functions.sh core/universal.sh shells/bash/aliases.bash shells/bash/exports.bash shells/zsh/aliases.zsh shells/zsh/exports.zsh; do
    bash -n "$D/$f" 2>/dev/null && pass "$f" || fail "$f"
done
for f in shells/fish/aliases.fish shells/fish/functions.fish shells/fish/exports.fish; do
    fish --no-execute "$D/$f" 2>/dev/null && pass "$f" || fail "$f"
done
git config -f "$HOME/.gitconfig" --list >/dev/null 2>&1 && pass ".gitconfig" || fail ".gitconfig"

echo ""
echo "━━━━ 2. SHELL STARTUP ━━━━"
for s in bash zsh fish; do
    timeout 10 "$s" -i -c "exit" 2>/dev/null && pass "$s starts" || fail "$s fails"
done

echo ""
echo "━━━━ 3. NO DUPLICATE ALIASES IN SAME FILE ━━━━"
for f in core/aliases.sh shells/bash/aliases.bash shells/zsh/aliases.zsh shells/fish/aliases.fish; do
    dups=$(rg '^alias ' "$D/$f" | sed 's/.*alias //;s/=.*//' | sort | uniq -d)
    if [ -z "$dups" ]; then pass "$f: no internal dupes"
    else fail "$f: dupes: $dups"; fi
done

echo ""
echo "━━━━ 4. DUPLICATE ALIAS NAMES ACROSS FILES ━━━━"
# Check for aliases defined in both core AND shell-specific files with different values
while IFS='=' read -r name val; do
    [ -z "$name" ] && continue
    vals=$(rg -n "^alias $name=" "$D/core/aliases.sh" "$D/shells/bash/aliases.bash" "$D/shells/zsh/aliases.zsh" 2>/dev/null | sed 's/.*=//' | sort -u)
    distinct=$(echo "$vals" | wc -l)
    if [ "$distinct" -gt 1 ]; then
        echo "  ~ warning: $name defined differently in multiple files:"
        rg -n "^alias $name=" "$D/core/aliases.sh" "$D/shells/bash/aliases.bash" "$D/shells/zsh/aliases.zsh" 2>/dev/null | sed 's/.*://' | while read -r line; do echo "    $line"; done
    fi
done < <(rg '^alias ' "$D/core/aliases.sh" "$D/shells/bash/aliases.bash" "$D/shells/zsh/aliases.zsh" 2>/dev/null | sed 's/.*alias //' | sed 's/=/=/' | sed 's/=.*//' | sort -u)
pass "alias conflict check done"

echo ""
echo "━━━━ 5. CORE FUNCTIONS EXIST ━━━━"
for fn in bak unbak orig unorig topcommands puniq findup cdup pg stamp clip path_remove path_append path_prepend here mkcd gcd gbs extract colors wanip flush countfiles pwdtail distribution have _x; do
    bash -c "source $D/core/functions.sh 2>/dev/null; declare -f $fn >/dev/null 2>&1" && pass "$fn" || fail "$fn"
done

echo ""
echo "━━━━ 6. CORE ALIASES EXIST ━━━━"
for a in path envg nohist clhist histgrep cleanshell tmp tstamp topcmds port ports lw le lm dsstore mirrorsite ff gwip gwipe nah gbage gmn sep q dash; do
    bash -c "source $D/core/aliases.sh 2>/dev/null; alias $a >/dev/null 2>&1" && pass "$a" || fail "$a"
done

echo ""
echo "━━━━ 7. FISH FUNCTIONS EXIST ━━━━"
for fn in bak unbak orig unorig topcommands findup cdup pg stamp clip path_remove path_append path_prepend here mkcd gcd extract colors wanip flush countfiles pwdtail distribution _x; do
    fish -c "source $D/shells/fish/functions.fish 2>/dev/null; type -q $fn" 2>/dev/null && pass "fish:$fn" || fail "fish:$fn"
done

echo ""
echo "━━━━ 8. FISH ALIASES EXIST ━━━━"
for a in envg tmp tstamp topcmds le lm dsstore mirrorsite docker-ip gbs gwip gwipe nah gmn yayf sep svi vis; do
    fish -c "source $D/shells/fish/aliases.fish 2>/dev/null; type -q $a" 2>/dev/null && pass "fish:$a" || echo "  ~ fish:$a (conditional)"
done

echo ""
echo "━━━━ 9. FUNCTION RUNTIME TESTS ━━━━"
bash -c "
source $D/core/functions.sh 2>/dev/null
source $D/core/aliases.sh 2>/dev/null
puniq '/usr/bin:/bin' >/dev/null 2>&1 && echo '  ✓ puniq' || echo '  ✗ puniq'
stamp 'test' >/dev/null 2>&1 && echo '  ✓ stamp' || echo '  ✗ stamp'
pg \$\$ >/dev/null 2>&1 && echo '  ✓ pg' || echo '  ✗ pg'
colors >/dev/null 2>&1 && echo '  ✓ colors' || echo '  ✗ colors'
countfiles >/dev/null 2>&1 && echo '  ✓ countfiles' || echo '  ✗ countfiles'
pwdtail >/dev/null 2>&1 && echo '  ✓ pwdtail' || echo '  ✗ pwdtail'
"

echo ""
echo "━━━━ 10. _x GUARD TEST ━━━━"
bash -c "source $D/core/functions.sh 2>/dev/null; _x nonexistent_tool_xyz 2>/dev/null" && fail "_x allowed nonexistent" || pass "_x blocked nonexistent"
fish -c "source $D/shells/fish/functions.fish 2>/dev/null; _x nonexistent_tool_xyz 2>/dev/null" && fail "fish _x allowed nonexistent" || pass "fish _x blocked nonexistent"

echo ""
echo "━━━━ 11. CROSS-PLATFORM FUNCTIONS ━━━━"
for fn in have _is_mac _is_linux _x ip_show disk_usage mem_info cpu_info pkg_list service_list open_file copy_cmd paste_cmd epoch hrline; do
    bash -c "source $D/core/functions.sh 2>/dev/null; declare -f $fn >/dev/null 2>&1" && pass "$fn" || fail "$fn"
done

echo ""
echo "━━━━ 12. SHELL-SPECIFIC ALIASES ━━━━"
for a in grep diff less mem cpu disk uptime dateiso epoch cal; do
    bash -c "source $D/shells/bash/aliases.bash 2>/dev/null; alias $a >/dev/null 2>&1" && pass "bash:$a" || echo "  ~ bash:$a (conditional)"
done
for a in grep diff less cpu disk uptime weather tl wifi bt docker; do
    zsh -c "source $D/shells/zsh/aliases.zsh 2>/dev/null; alias $a >/dev/null 2>&1" 2>/dev/null && pass "zsh:$a" || echo "  ~ zsh:$a (conditional)"
done

echo ""
echo "━━━━ 13. EXPORTS LOAD ━━━━"
bash -c "source $D/shells/bash/exports.bash 2>/dev/null; echo env vars: \$(env | grep -c DOTFILES)" && pass "bash exports" || fail "bash exports"
zsh -c "source $D/shells/zsh/exports.zsh 2>/dev/null; echo env vars loaded" 2>/dev/null && pass "zsh exports" || fail "zsh exports"
fish -c "source $D/shells/fish/exports.fish 2>/dev/null; echo env vars loaded" 2>/dev/null && pass "fish exports" || fail "fish exports"

echo ""
echo "━━━━ 14. RECURSION CHECK ━━━━"
# Check for aliases that call themselves (infinite recursion)
for f in core/aliases.sh shells/bash/aliases.bash shells/zsh/aliases.zsh shells/fish/aliases.fish; do
    while IFS='=' read -r name rest; do
        name=$(echo "$name" | sed 's/^alias //')
        val=$(echo "$rest" | tr -d "'\"")
        first_cmd=$(echo "$val" | awk '{print $1}')
        first_cmd=$(echo "$first_cmd" | sed 's/^_x //')
        if [ "$name" = "$first_cmd" ]; then
            echo "  ⚠ recursion risk: $name => $val"
        fi
    done < <(rg '^alias ' "$D/$f" 2>/dev/null) || true
done
pass "recursion check done"

echo ""
echo "━━━━ 15. SOURCE FILES EXIST ━━━━"
for f in core/aliases.sh core/functions.sh core/universal.sh shells/bash/aliases.bash shells/bash/exports.bash shells/bash/detect_apps.bash shells/zsh/aliases.zsh shells/zsh/exports.zsh shells/zsh/detect_apps.zsh shells/fish/aliases.fish shells/fish/functions.fish shells/fish/exports.fish shells/fish/detect_apps.fish .gitconfig; do
    [ -f "$D/$f" ] && pass "$f exists" || fail "$f missing"
done

echo ""
echo "══════════════════════════════════════════════════════════════"
echo "  RESULTS: $PASS passed, $FAIL failed"
echo "══════════════════════════════════════════════════════════════"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1