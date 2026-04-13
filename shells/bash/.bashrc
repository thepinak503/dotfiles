#!/usr/bin/env bash
[[ $- != *i* ]] && return
_BS_FILE="${BASH_SOURCE[0]}"
while [ -L "$_BS_FILE" ]; do
    _BS_DIR="$(cd -P "$(dirname "$_BS_FILE")" >/dev/null 2>&1 && pwd)"
    _BS_FILE="$(readlink "$_BS_FILE")"
    [[ $_BS_FILE != /* ]] && _BS_FILE="$_BS_DIR/$_BS_FILE"
done
DOTFILES_DIR="$(cd -P "$(dirname "$_BS_FILE")/../.." >/dev/null 2>&1 && pwd)"
if [[ ! -d "$DOTFILES_DIR/shells" ]]; then
    if [[ -d "$HOME/git/dotfiles" ]]; then
        DOTFILES_DIR="$HOME/git/dotfiles"
    fi
fi
export DOTFILES_DIR
unset _BS_FILE _BS_DIR
export DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null
if [[ -z "$DOTFILES_MODE" ]]; then
    if [[ -f "$DOTFILES_STATE_DIR/mode" ]]; then
        export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
    else
        export DOTFILES_MODE="supreme"
    fi
fi
export DOTFILES_VERSION="11.0.0"
_src() { [[ -f "$1" && -r "$1" ]] && source "$1" 2>/dev/null; }
_src "$DOTFILES_DIR/core/system-detect.sh"
_src "$DOTFILES_DIR/core/tools.sh"
_src "$DOTFILES_DIR/core/battery.sh"
_src "$DOTFILES_DIR/shells/bash/exports.bash"
_src "$DOTFILES_DIR/shells/bash/functions.bash"
_src "$DOTFILES_DIR/shells/bash/aliases.bash"
_load_mode() {
    local d="$DOTFILES_DIR/shells/bash/modes"
    case "$DOTFILES_MODE" in
        minimal)
            _src "$d/minimal.bash" ;;
        standard)
            _src "$d/minimal.bash"
            _src "$d/standard.bash" ;;
        supreme)
            _src "$d/minimal.bash"
            _src "$d/standard.bash"
            _src "$d/supreme.bash" ;;
        ultra-nerd)
            _src "$d/minimal.bash"
            _src "$d/standard.bash"
            _src "$d/supreme.bash"
            _src "$d/ultra-nerd.bash" ;;
        *)
            _src "$d/minimal.bash"
            _src "$d/standard.bash"
            _src "$d/supreme.bash" ;;
    esac
}
_load_mode
unset -f _load_mode

if [[ -f "$DOTFILES_DIR/bin/dotupdate_bg.sh" && "$DOTFILES_MODE" != "minimal" ]]; then
    (bash "$DOTFILES_DIR/bin/dotupdate_bg.sh" &)
    if [[ -f "$DOTFILES_STATE_DIR/update_ready" ]]; then
        echo -e "\n${YELLOW}⚡ Dotfiles updates are available! Run 'dotupdate' to apply.${NC}"
    fi
fi
if [[ -f /usr/bin/fastfetch ]]; then
    fastfetch
fi
if [[ -f /usr/share/doc/find-the-command/ftc.bash ]]; then
    source /usr/share/doc/find-the-command/ftc.bash noprompt quiet
fi
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
if command -v starship &>/dev/null; then
    if [[ "$DOTFILES_OS" == "Darwin" ]]; then
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    fi
    eval "$(starship init bash)"
fi
