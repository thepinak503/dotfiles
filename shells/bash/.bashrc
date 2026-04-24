#!/usr/bin/env bash
[[ $- != *i* ]] && return
shopt -s autocd
# Keybindings
bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"
bind '"\C-f":"zi\n"'
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[H": beginning-of-line'
bind '"\e[F": end-of-line'
bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
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
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null || DOTFILES_STATE_DIR="${TMPDIR:-/tmp}/dotfiles-$USER"
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null
[[ -w "$DOTFILES_STATE_DIR" ]] || export DOTFILES_STATE_DIR="${TMPDIR:-/tmp}/dotfiles-$USER"
mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null
if [[ -z "$DOTFILES_MODE" ]]; then
    if [[ -f "$DOTFILES_STATE_DIR/mode" ]]; then
        export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
    else
        export DOTFILES_MODE="supreme"
    fi
fi
export DOTFILES_VERSION="12.1.0"
_src() { [[ -f "$1" && -r "$1" ]] && source "$1" 2>/dev/null; }
_src "$DOTFILES_DIR/core/system-detect.sh"
_src "$DOTFILES_DIR/core/tools.sh"
_src "$DOTFILES_DIR/core/battery.sh"

if command -v starship &>/dev/null; then
    export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    [[ "$DOTFILES_OS" == "Darwin" ]] && export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    eval "$(starship init bash 2>>"${DOTFILES_STATE_DIR:-/tmp}/errors.log")"
fi

_src "$DOTFILES_DIR/shells/bash/exports.bash"
if [[ "${DOTFILES_LOAD_FULL:-0}" == "1" ]]; then
    _src "$DOTFILES_DIR/shells/bash/functions.bash"
    _src "$DOTFILES_DIR/shells/bash/aliases.bash"
else
    _src "$DOTFILES_DIR/shells/bash/functions-core.bash"
    _src "$DOTFILES_DIR/shells/bash/aliases-core.bash"
fi
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

if [[ "${DOTFILES_AUTO_UPDATE:-0}" == "1" && -f "$DOTFILES_DIR/bin/dotupdate_bg.sh" && "$DOTFILES_MODE" != "minimal" ]]; then
    (bash "$DOTFILES_DIR/bin/dotupdate_bg.sh" &)
    if [[ -f "$DOTFILES_STATE_DIR/update_ready" ]]; then
        echo -e "\n${YELLOW}⚡ Dotfiles updates are available! Run 'dotupdate' to apply.${NC}"
    fi
fi
if [[ "${DOTFILES_FASTFETCH_ON_STARTUP:-1}" == "1" && -f /usr/bin/fastfetch ]]; then
    fastfetch
fi
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
