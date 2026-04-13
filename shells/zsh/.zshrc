#!/usr/bin/env zsh
# =============================================================================
# ~/.zshrc — Zsh entry point (thin loader)
# Same load order as .bashrc for consistency.
# =============================================================================

# =============================================================================
# 1. DOTFILES ENVIRONMENT
# =============================================================================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
if [[ ! -d "$DOTFILES_DIR/shells" ]]; then
    if [[ -d "$HOME/git/dotfiles" ]]; then
        DOTFILES_DIR="$HOME/git/dotfiles"
    fi
fi
export DOTFILES_DIR

export DOTFILES_STATE_DIR="${DOTFILES_STATE_DIR:-$HOME/.local/share/dotfiles}"
[[ -d "$DOTFILES_STATE_DIR" ]] || mkdir -p "$DOTFILES_STATE_DIR" 2>/dev/null

if [[ -z "$DOTFILES_MODE" ]]; then
    if [[ -f "$DOTFILES_STATE_DIR/mode" ]]; then
        export DOTFILES_MODE="$(<"$DOTFILES_STATE_DIR/mode")"
    else
        export DOTFILES_MODE="advanced"
    fi
fi

export DOTFILES_VERSION="3.0.0"

# =============================================================================
# 2. SAFE SOURCE HELPER
# =============================================================================

_src() { [[ -f "$1" && -r "$1" ]] && source "$1" 2>/dev/null; }

# =============================================================================
# 3. LIBRARIES
# =============================================================================

_src "$DOTFILES_DIR/core/system-detect.sh"
_src "$DOTFILES_DIR/core/tools.sh"
_src "$DOTFILES_DIR/core/battery.sh"
_src "$DOTFILES_DIR/core/ssh-agent.sh"

# =============================================================================
# 4. CORE SETTINGS
# =============================================================================

_src "$DOTFILES_DIR/shells/zsh/exports.zsh"

# XDG
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Editor
if command -v nvim &>/dev/null; then
    export EDITOR="nvim" VISUAL="nvim" MANPAGER="nvim +Man!"
elif command -v vim &>/dev/null; then
    export EDITOR="vim"  VISUAL="vim"
else
    export EDITOR="nano" VISUAL="nano"
fi
export PAGER="less"
export LESS="-R -i -g -c -W -F -X -M --shift 5"

# Locale & terminal
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export TERM="${TERM:-xterm-256color}"
export COLORTERM="truecolor"
export CLICOLOR=1

# Silence noise
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NPM_CONFIG_UPDATE_NOTIFIER=false
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export PYTHONDONTWRITEBYTECODE=1

# Developer env vars
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
export GOPATH="${GOPATH:-$HOME/go}"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# bat / fzf / ripgrep
export BAT_THEME="TwoDark"
export BAT_STYLE="numbers,changes,header"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_DEFAULT_OPTS="
  --height=60% --layout=reverse --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up,ctrl-u:half-page-up,ctrl-d:half-page-down'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#4fc1ff,info:#ce9178,prompt:#4ec9b0,pointer:#ff6188'
"
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# Coloured man pages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_ue=$'\e[0m'

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_EXPIRE_DUPS_FIRST \
       SHARE_HISTORY EXTENDED_HISTORY APPEND_HISTORY HIST_FIND_NO_DUPS

# Zsh options
setopt AUTO_CD CORRECT NOMATCH AUTO_PUSHD PUSHD_IGNORE_DUPS CD_SILENT 2>/dev/null || true
unsetopt BEEP 2>/dev/null || true

# Word style (bash-like Ctrl-W)
autoload -U select-word-style && select-word-style bash

# PATH
_path_prepend() { [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && export PATH="$1${PATH:+:$PATH}"; }
_path_append()  { [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && export PATH="${PATH:+$PATH:}$1"; }

_path_prepend "$HOME/.local/bin"
_path_prepend "$CARGO_HOME/bin"
_path_prepend "$HOME/.pyenv/bin"
_path_append  "$GOPATH/bin"
_path_append  "$NPM_CONFIG_PREFIX/bin"
_path_append  "$HOME/.poetry/bin"
_path_append  "$HOME/.dotnet/tools"
[[ -d /snap/bin ]] && _path_append "/snap/bin"
[[ -d /var/core/flatpak/exports/bin ]] && _path_append "/var/core/flatpak/exports/bin"

# Homebrew
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null
elif [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
fi

unset -f _path_prepend _path_append

# =============================================================================
# 5. COMPLETION + PLUGINS
# =============================================================================

# Completion — init once per day (speed hack)
autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{cyan}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches%f'

# Plugins (syntax highlight + auto-suggestions — no oh-my-zsh required)
for _plugin in \
    zsh-syntax-highlighting \
    zsh-autosuggestions; do
    for _dir in \
        "$HOME/shells/zsh/${_plugin}" \
        "/usr/share/zsh/plugins/${_plugin}" \
        "/usr/share/${_plugin}" \
        "$ZSH/custom/plugins/${_plugin}"; do
        _src "${_dir}/${_plugin}.zsh" && break
    done
done
unset _plugin _dir

# Key bindings
_src "$DOTFILES_DIR/shells/zsh/01-keybindings.zsh"

# Oh-My-Zsh (optional — only if installed, uses it for extras only)
if [[ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" && "${USE_OMZ:-0}" == "1" ]]; then
    _src "$DOTFILES_DIR/shells/zsh/02-plugins.zsh"
fi

# =============================================================================
# 6. MODULES
# =============================================================================

_src "$DOTFILES_DIR/shells/zsh/aliases.zsh"
_src "$DOTFILES_DIR/shells/zsh/functions.zsh"
_src "$DOTFILES_DIR/shells/zsh/03-dynamic_aliases.zsh"
_src "$DOTFILES_DIR/shells/zsh/05-pkg_aliases.zsh"

# =============================================================================
# 7. MODE CONFIGURATION
# =============================================================================

_load_mode() {
    local d="$DOTFILES_DIR/shells/zsh/modes"
    case "$DOTFILES_MODE" in
        minimal)
            _src "$d/minimal.zsh" ;;
        standard)
            _src "$d/minimal.zsh"
            _src "$d/standard.zsh" ;;
        supreme)
            _src "$d/minimal.zsh"
            _src "$d/standard.zsh"
            _src "$d/supreme.zsh" ;;
        ultra-nerd)
            _src "$d/minimal.zsh"
            _src "$d/standard.zsh"
            _src "$d/supreme.zsh"
            _src "$d/ultra-nerd.zsh" ;;
        *)
            # Fallback to supreme if unknown
            _src "$d/minimal.zsh"
            _src "$d/standard.zsh"
            _src "$d/supreme.zsh" ;;
    esac

}
_load_mode
unset -f _load_mode

# =============================================================================
# 8. CHANGE MODE FUNCTION
# =============================================================================

chmode() {
    case "${1:-}" in
        minimal|standard|supreme|ultra-nerd)
            export DOTFILES_MODE="$1"
            echo "$1" > "$DOTFILES_STATE_DIR/mode" 2>/dev/null
            echo "✓ Mode → $1  (restart shell or run: exec zsh)"
            ;;
        "")
            printf 'Current mode: %s\n' "$DOTFILES_MODE"
            printf 'Modes: minimal | standard | supreme | ultra-nerd\n'
            printf '  minimal     — minimal, SSH-safe\n'
            printf '  standard    — balanced\n'
            printf '  supreme     — full-featured (default)\n'
            printf '  ultra-nerd  — maximum productivity\n'
            ;;
        *) echo "Unknown mode: $1" >&2; return 1 ;;
    esac
}
alias cm='chmode'

# =============================================================================
# 9. PROMPT (starship) + SMART cd (zoxide)
# =============================================================================

if command -v starship &>/dev/null; then
    if [[ "$DOTFILES_OS" == "Darwin" ]]; then
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-mac.toml"
    else
        export STARSHIP_CONFIG="$DOTFILES_DIR/apps/starship-linux.toml"
    fi
    eval "$(starship init zsh)" 2>/dev/null
fi

command -v zoxide &>/dev/null && eval "$(zoxide init zsh)" 2>/dev/null

# 9.1 BACKGROUND UPDATE CHECK (Weekly logic)
if [[ -f "$DOTFILES_DIR/bin/dotupdate_bg.sh" && "$DOTFILES_MODE" != "minimal" ]]; then
    (bash "$DOTFILES_DIR/bin/dotupdate_bg.sh" &)
    if [[ -f "$DOTFILES_STATE_DIR/update_ready" ]]; then
        echo "\n%F{yellow}⚡ Dotfiles updates are available! Run 'dotupdate' to apply.%f"
    fi
fi

# FZF key-bindings
for _fzf_bind in \
    /usr/share/fzf/key-bindings.zsh \
    /usr/share/doc/fzf/examples/key-bindings.zsh \
    "$HOME/.fzf.zsh"; do
    _src "$_fzf_bind" && break
done
unset _fzf_bind

# =============================================================================
# 10. BATTERY WARNING + FASTFETCH + LOGGING
# =============================================================================

command -v battery_warn &>/dev/null && battery_warn
command -v fastfetch    &>/dev/null && fastfetch 2>/dev/null
_src "$DOTFILES_DIR/core/logging.sh"

# =============================================================================
# 11. LOCAL OVERRIDE & EXTENSIONS
# =============================================================================

if [[ -f /usr/share/doc/find-the-command/ftc.zsh ]]; then
    source /usr/share/doc/find-the-command/ftc.zsh noprompt quiet
fi

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

unset -f _src
true

