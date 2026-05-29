#!/usr/bin/env bash
# ============================================================================
# Power Profile Cycle — cycles between power-saver / balanced / performance
# ============================================================================
# Gracefully exits if powerprofilesctl is not available.
# ============================================================================

set -euo pipefail

if ! command -v powerprofilesctl &>/dev/null; then
    exit 0
fi

current=$(timeout 5 powerprofilesctl get 2>/dev/null || echo "balanced")
case "$current" in
  power-saver) powerprofilesctl set balanced ;;
  balanced)    powerprofilesctl set performance ;;
  performance) powerprofilesctl set power-saver ;;
  *)           powerprofilesctl set balanced ;;
esac
