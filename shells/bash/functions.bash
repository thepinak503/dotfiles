# =============================================================================
# Bash Functions - Fixed with function keyword to avoid alias conflicts
# =============================================================================

function cd { if [ -n "$1" ]; then builtin cd "$1" && ls; else builtin cd ~ && ls; fi; }
function mkcd { mkdir -p "$1" && cd "$1"; }
function take { mkdir -p "$1" && cd "$1"; }

function pathuniq { echo "$PATH" | tr ':' '\n' | sort -u; }

function detect_pkg_manager {
    command -v yay >/dev/null && echo "yay" && return
    command -v pacman >/dev/null && echo "pacman" && return
    command -v apt >/dev/null && echo "apt" && return
    command -v dnf >/dev/null && echo "dnf" && return
    command -v brew >/dev/null && echo "brew" && return
    echo "none"
}

function detect_distro {
    [ -f /etc/os-release ] && . /etc/os-release && echo "$ID" && return
    [ -f /etc/arch-release ] && echo "arch" && return
    [ -f /etc/debian_version ] && echo "debian" && return
    echo "unknown"
}

function update { case "$(detect_pkg_manager)" in yay|pacman) sudo pacman -Syu ;; apt) sudo apt update && sudo apt upgrade ;; dnf) sudo dnf upgrade ;; brew) brew update && brew upgrade ;; esac; }
function install { case "$(detect_pkg_manager)" in yay|pacman) sudo pacman -S "$@" ;; apt) sudo apt install "$@" ;; dnf) sudo dnf install "$@" ;; brew) brew install "$@" ;; esac; }
function searchpkg { case "$(detect_pkg_manager)" in yay|pacman) pacman -Ss "$@" ;; apt) apt search "$@" ;; dnf) dnf search "$@" ;; brew) brew search "$@" ;; esac; }

function ff { find . -type f -name "*$1*"; }
function ffd { find . -type d -name "*$1*"; }
function frep { grep -r "$1" . --include="*$2*"; }

function du1 { du -h --max-depth=1; }
function dus { du -h --apparent-size; }
function dut { du -sh "$@"; }
function duorder { du -h | sort -rh | head -n "${1:-10}"; }

function psa { ps aux; }
function psg { ps aux | grep "$1"; }
function pf { pgrep -f "$1"; }
function pkill9 { pkill -9 "$1"; }

function topcpu { ps aux --sort=-%cpu | head -n "${1:-10}"; }
function topmem { ps aux --sort=-%mem | head -n "${1:-10}"; }

function myip { curl -s https://api.ipify.org; }
function localip { ip addr show | grep "inet " | awk '{print $2}' | cut -d/ -f1; }
function port { lsof -i :"$1"; }
function portkill { lsof -ti :"$1" | xargs kill -9; }

function free { free -h; }
function df { df -h; }
function dt { df -h | grep -v loop; }

function extract {
    for archive in "$@"; do
        [ -f "$archive" ] || { echo "File not found: $archive"; continue; }
        case "$archive" in
            *.tar.bz2) tar xvjf "$archive" ;;
            *.tar.gz) tar xvzf "$archive" ;;
            *.tar.xz) tar xvJf "$archive" ;;
            *.bz2) bunzip2 "$archive" ;;
            *.rar) unrar x "$archive" ;;
            *.gz) gunzip "$archive" ;;
            *.tar) tar xvf "$archive" ;;
            *.tbz2) tar xvjf "$archive" ;;
            *.tgz) tar xvzf "$archive" ;;
            *.zip) unzip "$archive" ;;
            *.Z) uncompress "$archive" ;;
            *.7z) 7z x "$archive" ;;
            *) echo "Unknown: $archive" ;;
        esac
    done
}

function tarx { tar -xf "$1"; }
function tarc { tar -czf "$2" "$1"; }

function zipf { zip -r "$1.zip" "$1"; }
function unzipf { unzip "$1"; }

function grepo { grep -r "$1" .; }

function myps { ps aux | grep "$1"; }

function v { nvim "$@"; }
function vi { nvim "$@"; }

function la { ls -a "$@"; }
function ll { ls -lah "$@"; }
function lt { tree -L 2; }

function t { tmux "$@"; }
function ta { tmux attach; }

function ping4 { ping -c 4 "$1"; }
function curl4 { curl -fsSL "$1"; }
function wget4 { wget -c "$1"; }

function kill9 { kill -9 "$1"; }
function pstop { pkill -STOP "$1"; }
function cont { kill -CONT "$1"; }