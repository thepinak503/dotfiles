#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/local/share/.dotfiles}"
WORK_DIR=$(mktemp -d -t dotfiles-fonts-XXXXXX)
FONT_NAME="MesloLGS Nerd Font Mono"
FONT_RELEASE_ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
# Additional fonts to install
CASCADIA_CODE_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"
CASCADIA_MONO_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip"

cleanup() {
  rm -rf "$WORK_DIR"
}
trap cleanup EXIT

echo "Installing fonts: ${FONT_NAME}"

# Ensure downloader tools
if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required to download fonts. Please install curl and retry." >&2
  exit 1
fi
if ! command -v unzip >/dev/null 2>&1; then
  echo "Error: unzip is required to extract fonts. Please install unzip and retry." >&2
  exit 1
fi

OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
  # macOS: install to user fonts dir unless running as root
  if [ "$EUID" -eq 0 ]; then
    DEST_DIR="/Library/Fonts"
  else
    DEST_DIR="$HOME/Library/Fonts"
  fi
else
  # Linux and others: prefer user fonts dir when not root
  if [ "$EUID" -eq 0 ]; then
    DEST_DIR="/usr/share/fonts/truetype/dotfiles"
  else
    DEST_DIR="$HOME/.local/share/fonts"
  fi
fi

mkdir -p "$WORK_DIR" "$DEST_DIR"

ZIP_FILE="$WORK_DIR/meslo.zip"

echo "Downloading $FONT_NAME..."
if ! curl -L -sSf -o "$ZIP_FILE" "$FONT_RELEASE_ZIP_URL"; then
  echo "Failed to download fonts from $FONT_RELEASE_ZIP_URL" >&2
  exit 1
fi

echo "Extracting..."
unzip -q "$ZIP_FILE" -d "$WORK_DIR/extracted"

echo "Copying ttf files to $DEST_DIR..."
find "$WORK_DIR/extracted" -type f -iname "*.ttf" -exec cp -v {} "$DEST_DIR/" \; || true

# Download and install Cascadia Code
echo "Downloading Cascadia Code..."
if curl -L -sSf -o "$WORK_DIR/CascadiaCode.zip" "$CASCADIA_CODE_URL"; then
  unzip -q "$WORK_DIR/CascadiaCode.zip" -d "$WORK_DIR/extracted_cascadia_code" || true
  find "$WORK_DIR/extracted_cascadia_code" -type f -iname "*.ttf" -exec cp -v {} "$DEST_DIR/" \; || true
else
  echo "Warning: failed to download Cascadia Code; continuing with other fonts." >&2
fi

# Download and install Cascadia Mono
echo "Downloading Cascadia Mono..."
if curl -L -sSf -o "$WORK_DIR/CascadiaMono.zip" "$CASCADIA_MONO_URL"; then
  unzip -q "$WORK_DIR/CascadiaMono.zip" -d "$WORK_DIR/extracted_cascadia_mono" || true
  find "$WORK_DIR/extracted_cascadia_mono" -type f -iname "*.ttf" -exec cp -v {} "$DEST_DIR/" \; || true
else
  echo "Warning: failed to download Cascadia Mono; continuing." >&2
fi

if [ "$OS" != "Darwin" ]; then
  if command -v fc-cache >/dev/null 2>&1; then
    echo "Updating font cache..."
    fc-cache -fv >/dev/null 2>&1 || true
  else
    echo "Note: fc-cache not found; you may need to run it to refresh fonts." >&2
  fi
else
  echo "On macOS, fonts copied to $DEST_DIR (refresh happens automatically)."
fi

echo "Fonts installed to $DEST_DIR"
exit 0
