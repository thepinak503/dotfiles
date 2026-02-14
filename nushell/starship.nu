# Starship prompt initialization for Nushell
# This module exports starship prompt configuration

# Generate and load starship init
export def --env init-starship [] {
    let init_script = (starship init nu | complete | get stdout)
    $init_script | save --force /tmp/starship-init.nu
    source /tmp/starship-init.nu
}

# Initialize on module load
init-starship
