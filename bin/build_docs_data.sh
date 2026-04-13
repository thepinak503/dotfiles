#!/usr/bin/env bash
# =============================================================================
# doc-builder.sh — Generates JSON data for the Pinak's Dotfiles portal
# =============================================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_FILE="$DOTFILES_DIR/docs/data.js"

echo "Building documentation data..."

# Count aliases and functions
BASH_ALIASES=$(grep -c "^alias " "$DOTFILES_DIR/shells/bash/aliases.bash")
BASH_FUNCTIONS=$(grep -c "(){" "$DOTFILES_DIR/shells/bash/functions.bash")
ZSH_ALIASES=$(grep -c "^alias " "$DOTFILES_DIR/shells/zsh/aliases.zsh")
FISH_ABBRS=$(grep -c "^abbr " "$DOTFILES_DIR/shells/fish/aliases.fish")

cat <<EOF > "$DATA_FILE"
const DOTFILES_DATA = {
    version: "11.0.0",
    lastUpdated: "$(date)",
    stats: {
        bash: { aliases: $BASH_ALIASES, functions: $BASH_FUNCTIONS },
        zsh: { aliases: $ZSH_ALIASES, functions: 0 },
        fish: { abbreviations: $FISH_ABBRS, functions: 0 }
    },
    features: [
        { title: "Polyglot Support", desc: "100% parity across Bash, Zsh, and Fish." },
        { title: "Starship Prompt", desc: "Supreme Powerline Pill design with ultra-telemetry." },
        { title: "Self-Healing", desc: "Automated error logging and background update checks." },
        { title: "Distro Agnostic", desc: "Optimized for Arch (Garuda), Debian, Fedora, and macOS." }
    ]
};
EOF

echo "Done: $DATA_FILE"
