#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
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
if bash -c "source $DOTFILES_DIR/shells/bash/exports.bash && source $DOTFILES_DIR/shells/bash/aliases.bash" 2>/dev/null; then
    echo "✓ Bash sourcing: OK"
else
    echo "❌ Bash sourcing: FAILED (Runtime error)"
    EXIT_CODE=1
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    echo -e "\n\033[1;32mALL TESTS PASSED. SAFE TO COMMIT.\033[0m"
else
    echo -e "\n\033[1;31mTESTS FAILED. DO NOT COMMIT.\033[0m"
fi
exit $EXIT_CODE
