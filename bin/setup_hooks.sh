#!/usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/local/share/.dotfiles}"
HOOK_FILE="$DOTFILES_DIR/.git/hooks/pre-commit"
echo "Setting up pre-commit hook..."
cat > "$HOOK_FILE" <<EOF
#!/usr/bin/env bash
git add history.md llm_state.md
EOF
chmod +x "$HOOK_FILE"
echo "✓ Pre-commit hook active. Sync is now automated on 'git commit'."
