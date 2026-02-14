# Starship prompt initialization for Nushell
# This file is sourced by config.nu

# Initialize starship
source (starship init nu | complete | get stdout)
