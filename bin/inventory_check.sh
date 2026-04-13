#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_BASH="$ROOT/.bash"
BASE_ZSH="$ROOT/.zsh"

echo "Inventory check: counts of aliases and functions"
echo
bash_aliases=$(grep -R --no-messages -E '^alias ' "$BASE_BASH" 2>/dev/null | wc -l || true)
zsh_aliases=$(grep -R --no-messages -E '^alias ' "$BASE_ZSH" 2>/dev/null | wc -l || true)
echo "Bash aliases: $bash_aliases"
echo "Zsh aliases: $zsh_aliases"

bash_funcs=$(grep -R --no-messages -E '^[a-zA-Z_][a-zA-Z0-9_]*\s*\(\)' "$BASE_BASH" 2>/dev/null | wc -l || true)
zsh_funcs=$(grep -R --no-messages -E '^[a-zA-Z_][a-zA-Z0-9_]*\s*\(\)' "$BASE_ZSH" 2>/dev/null | wc -l || true)
echo "Bash functions: $bash_funcs"
echo "Zsh functions: $zsh_funcs"

echo
echo "Basic comparison against baseline (if present)" 
bias_bash=$(test -f "$ROOT/config/inventory.baseline.json" && cat "$ROOT/config/inventory.baseline.json" | wc -c || echo 0)
echo "Baseline bytes: $bias_bash"

echo
echo "Done. Keep this in your docs for auditing future changes." 
