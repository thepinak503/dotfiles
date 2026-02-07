<#
.SYNOPSIS
    Dotfiles PowerShell Profile - Universal Windows/PowerShell Configuration
.DESCRIPTION
    The ultimate PowerShell configuration with cross-platform support
    Modes: basic, advanced, ultra-nerd
#>

# =============================================================================
# CONFIGURATION
# =============================================================================

# Set dotfiles mode
$env:DOTFILES_MODE = if ($env:DOTFILES_MODE) { $env:DOTFILES_MODE } else { "advanced" }
$env:DOTFILES_DIR = if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { "$env:USERPROFILE\.dotfiles" }

# =============================================================================
# CORE ENVIRONMENT
# =============================================================================

# Editor preference
if (Get-Command nvim -ErrorAction SilentlyContinue) {
    $env:EDITOR = "nvim"
    $env:VISUAL = "nvim"
} elseif (Get-Command vim -ErrorAction SilentlyContinue) {
    $env:EDITOR = "vim"
    $env:VISUAL = "vim"
} else {
    $env:EDITOR = "notepad"
    $env:VISUAL = "notepad"
}

# Pager
$env:PAGER = "less"
$env:LESS = "-R -i -g -c -W -F -X -M --shift 5"

# Locale
$env:LANG = "en_US.UTF-8"

# Disable annoying prompts
$env:VIRTUAL_ENV_DISABLE_PROMPT = "1"

# =============================================================================
# PATH MANAGEMENT
# =============================================================================

$PathToAdd = @(
    "$env:USERPROFILE\.local\bin"
    "$env:USERPROFILE\.cargo\bin"
    "$env:USERPROFILE\.dotnet\tools"
    "$env:USERPROFILE\.npm-global\bin"
    "$env:USERPROFILE\.poetry\bin"
    "$env:USERPROFILE\go\bin"
    "$env:USERPROFILE\scoop\shims"
    "$env:USERPROFILE\AppData\Local\Microsoft\WindowsApps"
)

foreach ($Path in $PathToAdd) {
    if (Test-Path $Path -PathType Container) {
        if ($env:Path -notlike "*$Path*") {
            $env:Path = "$Path;$env:Path"
        }
    }
}

# =============================================================================
# FZF CONFIGURATION
# =============================================================================

$env:FZF_DEFAULT_OPTS = @"
  --height=60%
  --layout=reverse
  --border=rounded
  --preview-window=right:50%
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --bind='pgdn:preview-page-down,pgup:preview-page-up'
  --color='bg:#1e1e1e,bg+:#3c3c3c,fg:#d4d4d4,fg+:#ffffff'
  --color='hl:#569cd6,hl+:#569cd6,info:#ce9178,prompt:#4ec9b0'
  --color='pointer:#c586c0,marker:#ce9178,spinner:#569cd6,header:#4ec9b0'
"@

# =============================================================================
# LOAD DOTFILES COMPONENTS
# =============================================================================

# Load aliases
$AliasesFile = "$env:DOTFILES_DIR\powershell\Aliases.ps1"
if (Test-Path $AliasesFile) {
    . $AliasesFile
}

# Load functions
$FunctionsFile = "$env:DOTFILES_DIR\powershell\Functions.ps1"
if (Test-Path $FunctionsFile) {
    . $FunctionsFile
}

# Load development tools (if not basic mode)
if ($env:DOTFILES_MODE -ne "basic") {
    $DevFile = "$env:DOTFILES_DIR\powershell\Development.ps1"
    if (Test-Path $DevFile) {
        . $DevFile
    }
}

# =============================================================================
# MODERN TOOL INITIALIZATION
# =============================================================================

# Starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# Zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# FZF
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    # FZF key bindings for PowerShell
    $FzfKeyBindings = "$env:USERPROFILE\scoop\apps\fzf\current\shell\key-bindings.ps1"
    if (Test-Path $FzfKeyBindings) {
        . $FzfKeyBindings
    }
}

# =============================================================================
# CUSTOM PROMPT (if no Starship)
# =============================================================================

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    function prompt {
        $location = Get-Location
        $branch = ""
        
        # Show git branch
        try {
            $branch = git branch --show-current 2>$null
            if ($branch) {
                $branch = " ($branch)"
            }
        } catch {}
        
        # Last command status
        $status = if ($?) { "✓" } else { "✗" }
        
        # Build prompt
        Write-Host "$status " -NoNewline -ForegroundColor (if ($?) { "Green" } else { "Red" })
        Write-Host "$env:USERNAME@$env:COMPUTERNAME " -NoNewline -ForegroundColor Cyan
        Write-Host "$location" -NoNewline -ForegroundColor Yellow
        Write-Host "$branch" -NoNewline -ForegroundColor Magenta
        Write-Host "`n> " -NoNewline
        return " "
    }
}

# =============================================================================
# WELCOME MESSAGE
# =============================================================================

switch ($env:DOTFILES_MODE) {
    "ultra-nerd" { Write-Host "✓ Dotfiles loaded in ULTRA-NERD mode (PowerShell)" -ForegroundColor Green }
    "basic" { Write-Host "✓ Dotfiles loaded in BASIC mode (PowerShell)" -ForegroundColor Blue }
    default { Write-Host "✓ Dotfiles loaded in ADVANCED mode (PowerShell)" -ForegroundColor DarkYellow }
}

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

$LocalProfile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.local.ps1"
if (Test-Path $LocalProfile) {
    . $LocalProfile
}
