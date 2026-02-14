# Nushell Environment Configuration
# This file is sourced by Nushell

# =============================================================================
# FASTFETCH - System info on startup
# =============================================================================
if (which fastfetch | is-not-empty) {
    ^fastfetch
}

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# PATH additions
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    "~/.local/bin"
    "~/.cargo/bin"
    "~/.dotnet/tools"
    "~/.npm-global/bin"
    "~/.poetry/bin"
    "~/go/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
])

# FZF configuration
$env.FZF_DEFAULT_OPTS = "
  --height=60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --bind='pgdn:preview-page-down,pgup:preview-page-up'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0'
  --color='pointer:#c586c0,marker:#ce9178,spinner:#569cd6,header:#4ec9b0'
"

# BAT configuration
$env.BAT_THEME = "TwoDark"
$env.BAT_STYLE = "numbers,changes,header"

# Docker
$env.DOCKER_BUILDKIT = "1"
$env.COMPOSE_DOCKER_CLI_BUILD = "1"

# Python
$env.PYTHONDONTWRITEBYTECODE = "1"

# Node
$env.NPM_CONFIG_PREFIX = "~/.npm-global"
$env.NVM_DIR = "~/.nvm"

# Rust
$env.CARGO_HOME = "~/.cargo"
$env.RUSTUP_HOME = "~/.rustup"

# Go
$env.GOPATH = "~/go"

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

# Load local environment if it exists
if ($"~/.config/nushell/env.local.nu" | path exists) {
    source ~/.config/nushell/env.local.nu
}
