<#
.SYNOPSIS
    PowerShell Aliases and Functions
#>

# =============================================================================
# NAVIGATION
# =============================================================================

Set-Alias -Name .. -Value Go-Up
Set-Alias -Name ... -Value Go-Up2
Set-Alias -Name home -Value Go-Home
function Go-Up { Set-Location .. }
function Go-Up2 { Set-Location ..\.. }
function Go-Home { Set-Location ~ }

# =============================================================================
# LISTING
# =============================================================================

# Use Get-ChildItem with better defaults
function List-All {
    param([string]$Path = ".")
    Get-ChildItem -Path $Path -Force | Format-Table -AutoSize
}

function List-Detailed {
    param([string]$Path = ".")
    Get-ChildItem -Path $Path -Force | Format-List
}

Set-Alias -Name ls -Value Get-ChildItem
Set-Alias -Name l -Value List-All
Set-Alias -Name ll -Value List-Detailed
Set-Alias -Name la -Value List-All

# =============================================================================
# FILE OPERATIONS
# =============================================================================

function Make-Directory {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force
    Set-Location $Path
}

Set-Alias -Name mkdir -Value Make-Directory
Set-Alias -Name cp -Value Copy-Item
Set-Alias -Name mv -Value Move-Item
Set-Alias -Name rm -Value Remove-Item
Set-Alias -Name cat -Value Get-Content

# =============================================================================
# EDITORS
# =============================================================================

Set-Alias -Name v -Value $env:EDITOR
Set-Alias -Name vi -Value $env:EDITOR
Set-Alias -Name vim -Value $env:EDITOR
Set-Alias -Name c -Value Clear-Host
Set-Alias -Name cls -Value Clear-Host
Set-Alias -Name q -Value Exit

# =============================================================================
# SYSTEM
# =============================================================================

function Show-SystemInfo {
    Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, TotalPhysicalMemory, CsProcessors
}

function Show-IpAddress {
    Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" -and $_.IPAddress -ne "127.0.0.1" } | Select-Object InterfaceAlias, IPAddress
}

Set-Alias -Name df -Value Get-Volume
Set-Alias -Name ps -Value Get-Process
Set-Alias -Name top -Value Get-Process

# =============================================================================
# GIT
# =============================================================================

function Git-Status { git status $args }
function Git-Add { git add $args }
function Git-Commit { git commit $args }
function Git-Push { git push $args }
function Git-Pull { git pull $args }
function Git-Log { git log --oneline --graph --decorate $args }
function Git-Checkout { git checkout $args }
function Git-Branch { git branch $args }

Set-Alias -Name g -Value git
Set-Alias -Name gs -Value Git-Status
Set-Alias -Name ga -Value Git-Add
Set-Alias -Name gc -Value Git-Commit
Set-Alias -Name gp -Value Git-Push
Set-Alias -Name gpl -Value Git-Pull
Set-Alias -Name gl -Value Git-Log
Set-Alias -Name gco -Value Git-Checkout
Set-Alias -Name gb -Value Git-Branch

# =============================================================================
# DOCKER
# =============================================================================

function Docker-Containers { docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" }
function Docker-AllContainers { docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" }
function Docker-Images { docker images }
function Docker-Logs { param([string]$Container) docker logs -f $Container }

Set-Alias -Name d -Value docker
Set-Alias -Name dc -Value docker-compose
Set-Alias -Name dps -Value Docker-Containers
Set-Alias -Name dpa -Value Docker-AllContainers
Set-Alias -Name di -Value Docker-Images
Set-Alias -Name dl -Value Docker-Logs

# =============================================================================
# KUBERNETES
# =============================================================================

function Kubectl-Get { kubectl get $args }
function Kubectl-Describe { kubectl describe $args }
function Kubectl-Logs { kubectl logs -f $args }

Set-Alias -Name k -Value kubectl
Set-Alias -Name kg -Value Kubectl-Get
Set-Alias -Name kd -Value Kubectl-Describe
Set-Alias -Name kl -Value Kubectl-Logs

# =============================================================================
# UTILITY
# =============================================================================

function Reload-Profile {
    . $PROFILE
}

Set-Alias -Name reload -Value Reload-Profile
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item
Set-Alias -Name grep -Value Select-String
