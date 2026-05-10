#!/usr/bin/env bash
# =============================================================================
# Arch Linux module — fully dynamic, multi-AUR-helper support
# Only loads on Arch-based distros, only enables aliases for installed tools
# =============================================================================

_detect_arch() {
    case "${DOTFILES_DISTRO:-$(. /etc/os-release 2>/dev/null && echo "$ID")}" in
        arch|artix|manjaro|endeavouros|garuda|archarm|archlabs|arcolinux|chakra|hyperbola|kaos|parabola|rebornos|siduction) return 0 ;;
    esac
    return 1
}
_detect_arch || return

# ---- AUR helper detection ----
# Ordered by preference: paru -> yay -> pikaur -> aura -> pakku -> trizen -> aurutils -> pamac
_AUR_HELPER=""
for _h in paru yay pikaur aura pakku trizen; do
    command -v "$_h" >/dev/null 2>&1 && { _AUR_HELPER=$_h; break; }
done
unset _h

# ---- Pacman aliases (always available on Arch) ----
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacs='pacman -Ss'
alias pacq='pacman -Qq'
alias pacqi='pacman -Qi'
alias pacls='pacman -Qql'
alias pacown='pacman -Qo'
alias pacdiff='pacman -Si'
alias pacfiles='pacman -Fl'
alias pacclean='sudo pacman -Rns $(pacman -Qtdq 2>/dev/null)'
alias paclsorph='pacman -Qtd'
alias pacdep='pacman -Si'
alias pacwhy='pacman -D --asexplicit'

# Pacman functions
pacinfo() { pacman -Si "$@"; }
pacfind() { pacman -Ss "$@" | less; }
pacinstall() { sudo pacman -S "$@"; }
pacremove() { sudo pacman -Rns "$@"; }
pacupdate() { sudo pacman -Syu; }
paccleanfn() { sudo pacman -Sc && sudo pacman -Scc; }
paclsremote() { pacman -Slq | grep "$@"; }
pacver() { pacman -V "$@"; }
pacowns() { pacman -Qo "$@"; }
pacprovides() { pacman -F "$@"; }
paccheck() { pacman -Qkk "$@"; }

# ---- Dynamic AUR helper aliases (works with any installed helper) ----
if [ -n "$_AUR_HELPER" ]; then
    _h="$_AUR_HELPER"

    # Generic AUR commands
    alias aurs="$_h -Ss"
    alias aurq="$_h -Q"
    alias auri="$_h -S"
    alias aurup="$_h -Syu"
    alias aurrm="$_h -Rns"
    alias aurinfo="$_h -Si"
    alias aurclean="$_h -Sc"
    alias auroorph="$_h -Qtd"
    alias aurfiles="$_h -Fl"

    # Helper-specific aliases (only define for the installed one)
    case "$_h" in
        paru)
            alias paruf='_aur_fzf'
            alias paruq='paru -Q'
            alias paruqo='paru -Qo'
            alias paruql='paru -Ql'
            alias parudb='paru -Y --gendb'
            alias parudev='paru -S --devel'
            alias parunews='paru -P --news'
            alias parupcf='paru -Pg'
            ;;
        yay)
            alias yayf='_aur_fzf'
            alias yayq='yay -Q'
            alias yaygendb='yay -Y --gendb'
            alias yaydev='yay -S --devel'
            alias yayfiles='yay -Fl'
            alias yaynews='yay -P --news'
            alias yaycf='yay -Pg'
            ;;
        pikaur)
            alias pikaurf='_aur_fzf'
            alias pikaurq='pikaur -Q'
            alias pikaurdiff='pikaur -Pc'
            ;;
        aura)
            alias auraf='_aur_fzf'
            alias auraq='aura -Q'
            alias auradb='aura -Y --gendb'
            alias auradiff='aura -Pc'
            ;;
    esac

    # Unified fzf AUR package browser (works with any helper)
    _aur_fzf() {
        $_AUR_HELPER -Slq 2>/dev/null | fzf --multi \
            --preview "$_AUR_HELPER -Sii {1} 2>/dev/null" \
            --preview-window=down:75% | xargs -ro $_AUR_HELPER -S
    }
    alias aurf='_aur_fzf'

    unset _h
fi
unset _AUR_HELPER

# ---- pacman-contrib (conditional) ----
if command -v pactree >/dev/null 2>&1; then
    alias pactree='pactree'
    alias pacdepgraph='pactree -c'
    alias pacwhyfn='pactree -r'
    alias pacfilesize='expac -H M -s "%-30n %m"'
fi

# ---- pkgfile (conditional) ----
if command -v pkgfile >/dev/null 2>&1; then
    alias pkgf='pkgfile'
    alias pkgfiles='pkgfile -l'
    alias pkgfsearch='pkgfile -s'
fi

# ---- reflector (conditional) ----
if command -v reflector >/dev/null 2>&1; then
    alias reflect='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
    alias reflectfast='sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
fi

# ---- systemd utilities (conditional) ----
if command -v journalctl >/dev/null 2>&1; then
    alias jlog='journalctl -xe'
    alias jboot='journalctl -b'
    alias jfail='journalctl -p 3 -xb'
    alias jfollow='journalctl -f'
    alias jservice='journalctl -fu'
fi

# ---- mkinitcpio (conditional) ----
if command -v mkinitcpio >/dev/null 2>&1; then
    alias mkinit='sudo mkinitcpio -P'
fi

# ---- Chaotic AUR (conditional) ----
if command -v chaotic-gl >/dev/null 2>&1; then
    alias cgi='chaotic-gl install'
    alias cgr='chaotic-gl remove'
    alias cgs='chaotic-gl search'
fi

# ---- Pacman log and stats ----
pacrecent() { tail -50 /var/log/pacman.log; }
pacupdatelog() { grep -E "\[PACMAN\]" /var/log/pacman.log | grep "starting" | tail -"${1:-5}"; }

# ---- Clean orphaned and cache ----
pacreclaim() {
    sudo pacman -Scc --noconfirm 2>/dev/null
    local _orphans
    _orphans=$(pacman -Qtdq 2>/dev/null)
    [ -n "$_orphans" ] && sudo pacman -Rns $_orphans --noconfirm 2>/dev/null
    true
}