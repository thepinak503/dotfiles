#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"
EXIT_CODE=0
header() {
    echo "----------------------------------------------------------------"
    echo "  CHECKING: $1"
    echo "----------------------------------------------------------------"
}
header "BASH (shells/bash/*.bash)"
while IFS= read -r -d '' file; do
    if ! bash -n "$file"; then
        echo "❌ Syntax error in $file"
        EXIT_CODE=1
    else
        echo "✓ $file"
    fi
done < <(find "$DOTFILES_DIR/shells/bash" -name "*.bash" -type f -print0)
if command -v zsh &>/dev/null; then
    header "ZSH (shells/zsh/*.zsh)"
    while IFS= read -r -d '' file; do
        if ! zsh -n "$file"; then
            echo "❌ Syntax error in $file"
            EXIT_CODE=1
        else
            echo "✓ $file"
        fi
    done < <(find "$DOTFILES_DIR/shells/zsh" -name "*.zsh" -type f -print0)
fi
if command -v fish &>/dev/null; then
    header "FISH (shells/fish/*.fish)"
    while IFS= read -r -d '' file; do
        if ! fish -n "$file"; then
            echo "❌ Syntax error in $file"
            EXIT_CODE=1
        else
            echo "✓ $file"
        fi
    done < <(find "$DOTFILES_DIR/shells/fish" -name "*.fish" -type f -print0)
fi
header "RUNTIME SOURCING (No-op test)"
if bash -c "source $DOTFILES_DIR/shells/bash/exports.bash && source $DOTFILES_DIR/core/aliases.sh && source $DOTFILES_DIR/core/functions.sh" 2>/dev/null; then
    echo "✓ Bash sourcing: OK"
else
    echo "❌ Bash sourcing: FAILED (Runtime error)"
    EXIT_CODE=1
fi
if command -v zsh &>/dev/null; then
    if zsh -c "source $DOTFILES_DIR/shells/zsh/exports.zsh && source $DOTFILES_DIR/core/aliases.sh && source $DOTFILES_DIR/core/functions.sh" 2>/dev/null; then
        echo "✓ Zsh sourcing: OK"
    else
        echo "❌ Zsh sourcing: FAILED (Runtime error)"
        EXIT_CODE=1
    fi
fi
if command -v fish &>/dev/null; then
    if fish -c "source $DOTFILES_DIR/shells/fish/exports.fish; source $DOTFILES_DIR/core/aliases.sh 2>/dev/null; source $DOTFILES_DIR/core/aliases.fish 2>/dev/null" 2>/dev/null; then
        echo "✓ Fish sourcing: OK"
    else
        echo "❌ Fish sourcing: FAILED (Runtime error)"
        EXIT_CODE=1
    fi
fi
header "CROSS-SHELL PARITY (alias + function consistency)"
BASH_SNAPSHOT=$(mktemp)
ZSH_SNAPSHOT=$(mktemp)
FISH_SNAPSHOT=$(mktemp)
cleanup() { rm -f "$BASH_SNAPSHOT" "$ZSH_SNAPSHOT" "$FISH_SNAPSHOT"; }
trap cleanup EXIT
# Source shared core then shell-specific layer — mirroring actual load order
bash -c "source $DOTFILES_DIR/core/aliases.sh 2>/dev/null; source $DOTFILES_DIR/shells/bash/aliases.bash 2>/dev/null; alias; declare -F" | sed "s/=.*//" | sort > "$BASH_SNAPSHOT" 2>/dev/null
if command -v zsh &>/dev/null; then
    zsh -c "source $DOTFILES_DIR/core/aliases.sh 2>/dev/null; source $DOTFILES_DIR/shells/zsh/aliases.zsh 2>/dev/null; alias; typeset -f +" | sed "s/=.*//" | sort > "$ZSH_SNAPSHOT" 2>/dev/null
fi
if command -v fish &>/dev/null; then
    fish -c "source $DOTFILES_DIR/core/aliases.sh 2>/dev/null; source $DOTFILES_DIR/shells/fish/aliases.fish 2>/dev/null; alias" | sed "s/=.*//" | sort > "$FISH_SNAPSHOT" 2>/dev/null
fi
BASH_COUNT=$(wc -l < "$BASH_SNAPSHOT" 2>/dev/null || echo 0)
ZSH_COUNT=$(wc -l < "$ZSH_SNAPSHOT" 2>/dev/null || echo 0)
FISH_COUNT=$(wc -l < "$FISH_SNAPSHOT" 2>/dev/null || echo 0)
echo "  Bash: $BASH_COUNT commands  |  Zsh: $ZSH_COUNT commands  |  Fish: $FISH_COUNT commands"
if command -v zsh &>/dev/null; then
    DIFF=$(diff "$BASH_SNAPSHOT" "$ZSH_SNAPSHOT" 2>/dev/null | grep "^[<>]" | head -20)
    if [ -n "$DIFF" ]; then
        echo "⚠ Bash vs Zsh command differences (showing top 20):"
        echo "$DIFF"
        echo "⚠ Cross-shell command mismatch (bash vs zsh)"
    else
        echo "✓ Bash vs Zsh command parity: OK"
    fi
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    echo -e "\n\033[1;32mALL TESTS PASSED. SAFE TO COMMIT.\033[0m"
else
    echo -e "\n\033[1;31mTESTS FAILED. DO NOT COMMIT.\033[0m"
fi
exit $EXIT_CODE
