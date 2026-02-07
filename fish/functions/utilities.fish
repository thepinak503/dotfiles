#!/usr/bin/env fish
# =============================================================================
# FISH UTILITY FUNCTIONS
# =============================================================================

# Create directory and enter it
function mkcd
    if test (count $argv) -eq 0
        echo "Usage: mkcd <directory>"
        return 1
    end
    mkdir -p $argv[1]; and cd $argv[1]
end

# Go up N directories
function up
    set -l count 1
    if test (count $argv) -gt 0
        set count $argv[1]
    end
    
    set -l path ""
    for i in (seq $count)
        set path "$path../"
    end
    cd $path
end

# Backup file with timestamp
function bak
    if test (count $argv) -eq 0
        echo "Usage: bak <file>"
        return 1
    end
    
    if not test -e $argv[1]
        echo "Error: '$argv[1]' does not exist"
        return 1
    end
    
    set -l timestamp (date +%Y%m%d_%H%M%S)
    set -l backup "$argv[1].bak.$timestamp"
    
    cp -a $argv[1] $backup
    echo "Backed up: $argv[1] → $backup"
end

# Extract any archive
function extract
    if test (count $argv) -eq 0
        echo "Usage: extract <archive>"
        return 1
    end
    
    if not test -f $argv[1]
        echo "Error: '$argv[1]' is not a file"
        return 1
    end
    
    switch $argv[1]
        case '*.tar.bz2' '*.tbz2'
            tar -xjf $argv[1]
        case '*.tar.gz' '*.tgz'
            tar -xzf $argv[1]
        case '*.tar.xz' '*.txz'
            tar -xJf $argv[1]
        case '*.tar'
            tar -xf $argv[1]
        case '*.bz2'
            bunzip2 $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*.7z'
            7z x $argv[1]
        case '*.Z'
            uncompress $argv[1]
        case '*'
            echo "Unknown archive format: $argv[1]"
            return 1
    end
end

# Fuzzy find and edit
function fe
    set -l files (fzf --multi --select-1 --exit-0 --preview 'bat --style=numbers --color=always --line-range :500 {}' 2>/dev/null)
    if test -n "$files"
        $EDITOR $files
    end
end

# Fuzzy cd
function fcd
    set -l dir (find . -type d -not -path '*/\.*' 2>/dev/null | fzf --preview 'tree -C {} | head -20')
    if test -n "$dir"
        cd $dir
    end
end

# Show internal and external IP
function myip
    echo "Internal IPs:"
    ip -4 addr show 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1" | sed 's/^/  /'
    
    echo "External IP:"
    curl -s -4 https://ifconfig.me 2>/dev/null | sed 's/^/  /'
end

# Quick HTTP server
function serve
    set -l port 8080
    if test (count $argv) -gt 0
        set port $argv[1]
    end
    
    echo "Serving on http://localhost:$port"
    python3 -m http.server $port
end

# Fuzzy kill process
function fkill
    set -l pid (ps aux | sed 1d | fzf --multi --header='[kill process]' | awk '{print $2}')
    if test -n "$pid"
        echo $pid | xargs kill -9
    end
end

# Git add, commit, push
function lazyg
    if test (count $argv) -eq 0
        echo "Usage: lazyg <commit-message>"
        return 1
    end
    
    git add .; and git commit -m "$argv[1]"; and git push
end

# Generate password
function passgen
    set -l length 16
    if test (count $argv) -gt 0
        set length $argv[1]
    end
    
    openssl rand -base64 48 | tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c $length
    echo
end

# Docker cleanup
function docker_clean
    echo "Removing stopped containers..."
    docker container prune -f
    
    echo "Removing unused images..."
    docker image prune -f
    
    echo "Removing unused volumes..."
    docker volume prune -f
    
    echo "Removing unused networks..."
    docker network prune -f
    
    echo "Docker cleanup complete!"
end

# Weather
function weather
    set -l location ""
    if test (count $argv) -gt 0
        set location $argv[1]
    end
    curl -s "wttr.in/$location?format=v2"
end

# QR code generator
function qr
    if test (count $argv) -eq 0
        echo "Usage: qr <text>"
        return 1
    end
    curl -s "qrenco.de/$argv[1]"
end

# Calculate expression
function calc
    if test (count $argv) -eq 0
        echo "Usage: calc <expression>"
        return 1
    end
    
    if command -v bc >/dev/null 2>&1
        echo "scale=4; $argv" | bc -l
    else
        python3 -c "print($argv)" 2>/dev/null
    end
end

# Find text in files
function ftext
    if test (count $argv) -eq 0
        echo "Usage: ftext <pattern> [directory]"
        return 1
    end
    
    set -l pattern $argv[1]
    set -l dir "."
    if test (count $argv) -gt 1
        set dir $argv[2]
    end
    
    if command -v rg >/dev/null 2>&1
        rg -i --color=always $pattern $dir
    else
        grep -ri --color=always $pattern $dir 2>/dev/null
    end
end

# Find file by name
function ff
    if test (count $argv) -eq 0
        echo "Usage: ff <filename> [directory]"
        return 1
    end
    
    set -l name $argv[1]
    set -l dir "."
    if test (count $argv) -gt 1
        set dir $argv[2]
    end
    
    if command -v fd >/dev/null 2>&1
        fd $name $dir
    else
        find $dir -type f -iname "*$name*" 2>/dev/null
    end
end

# Swap two files
function swap
    if test (count $argv) -ne 2
        echo "Usage: swap <file1> <file2>"
        return 1
    end
    
    set -l tmp (mktemp)
    mv $argv[1] $tmp
    mv $argv[2] $argv[1]
    mv $tmp $argv[2]
    echo "Swapped: $argv[1] ↔ $argv[2]"
end

# Copy with progress (using rsync)
function cpv
    rsync -ah --info=progress2 $argv
end
