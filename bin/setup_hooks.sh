#!/usr/bin/env bash
# =============================================================================
# Git Hooks Setup
# Ensures polyglot shells are synced before every commit.
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/git/dotfiles}"
HOOK_FILE="$DOTFILES_DIR/.git/hooks/pre-commit"

echo "Setting up pre-commit hook..."

cat > "$HOOK_FILE" <<EOF
#!/usr/bin/env bash
echo "Running pre-commit sync..."
python3 bin/sync_shells.py
git add shells/zsh/*.zsh shells/fish/*.fish history.md llm_state.md
EOF

chmod +x "$HOOK_FILE"
echo "✓ Pre-commit hook active. Sync is now automated on 'git commit'."
