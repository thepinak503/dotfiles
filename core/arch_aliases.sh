#!/usr/bin/env bash
# =============================================================================
# Arch Linux module — fully dynamic, multi-AUR-helper support

# =============================================================================

# =============================================================================
# Arch Linux Detection Guard
# =============================================================================


_detect_arch() {
    case "${DOTFILES_DISTRO:-$(. /etc/os-release 2>/dev/null && echo "$ID")}" in
        arch|artix|manjaro|endeavouros|garuda|archarm|archlabs|arcolinux|chakra|hyperbola|kaos|parabola|rebornos|siduction) return 0 ;;
    esac
    return 1
}
_detect_arch || return

# =============================================================================
# AUR Helper Detection
# =============================================================================


_AUR_HELPER=""
for _h in paru yay pikaur aura pakku trizen; do
    command -v "$_h" >/dev/null 2>&1 && { _AUR_HELPER=$_h; break; }
done
unset _h


alias pac='sudo pacman'
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacs='pacman -Ss'
alias pacq='pacman -Q'
alias pacqi='pacman -Qi'
alias pacqii='pacman -Qii'
alias pacql='pacman -Ql'
alias pacqo='pacman -Qo'
alias pacqs='pacman -Qs'
alias pacqdt='pacman -Qdt'
alias pacqd='pacman -Qd'
alias pacqe='pacman -Qe'
alias pacqm='pacman -Qm'
alias pacqg='pacman -Qg'
alias pacqu='pacman -Qu'
alias pacqtt='pacman -Qt'
alias pacqk='pacman -Qk'
alias pacsi='pacman -Si'
alias pacsii='pacman -Sii'
alias pacsl='pacman -Sl'
alias pacslo='pacman -Slo'
alias pacsp='pacman -Sp'
alias pacsu='pacman -Su'
alias pacsw='pacman -Sw'
alias pacscc='sudo pacman -Scc'
alias pacsc='sudo pacman -Sc'
alias pacown='pacman -Qo'
alias pacdiff='pacman -Si'
alias pacfiles='pacman -Fl'
alias pacclean='sudo pacman -Rns $(pacman -Qtdq 2>/dev/null)'
alias paclsorph='pacman -Qtd'
alias pacdep='pacman -Si'
alias pacwhy='pacman -D --asexplicit'
alias pacasex='pacman -D --asexplicit'
alias pacasdep='pacman -D --asdeps'
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck'
alias pacls='pacman -Qql'
alias pacupg='sudo pacman -Syu --noconfirm'
alias pacupd='sudo pacman -Syy'
alias pacug='sudo pacman -Su'
alias pacref='sudo pacman -Syy'
alias pacre='sudo pacman -R'
alias pacrem='sudo pacman -R'
alias pacrems='sudo pacman -Rs'
alias pacrmc='sudo pacman -Rc'
alias pacrmcs='sudo pacman -Rcs'
alias pacrmn='sudo pacman -Rn'
alias pacrmns='sudo pacman -Rns'
alias pacrmu='sudo pacman -Rdd'
alias pacget='pacman -Sw'
alias pacwget='pacman -Sw'
alias pacor='sudo pacman -Sc'
alias pacocc='sudo pacman -Scc'
alias pacowned='pacman -Qii'
alias paccheckdb='pacman -Dk'
alias pactest='pacman -Dk'
alias pacdis='pacman -D'
alias pacdbg='pacman -Qqg base-devel'
alias pacbase='sudo pacman -S base base-devel'
alias pacorph='pacman -Qtdq'


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


if [ -n "$_AUR_HELPER" ]; then
    _h="$_AUR_HELPER"


    # shellcheck disable=SC2139
    alias aurs="$_h -Ss"
    alias aurq="$_h -Q"
    alias aurqi="$_h -Qi"
    alias aurql="$_h -Ql"
    alias aurqo="$_h -Qo"
    alias auri="$_h -S"
    alias aurup="$_h -Syu"
    alias aurrm="$_h -Rns"
    alias aurinfo="$_h -Si"
    alias aurclean="$_h -Sc"
    alias auroorph="$_h -Qtd"
    alias aurfiles="$_h -Fl"
    alias aurdev="$_h -S --devel"
    alias aurnews="$_h -P --news"
    alias aurgendb="$_h -Y --gendb"
    alias aurstats="$_h -Ps"
    alias aurcf="$_h -Pg"
    alias aurpc="$_h -Pc"


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
            alias parupc='paru -Pc'
            alias parustats='paru -Ps'
            alias paruclean='paru -Sc'
            alias paruorph='paru -Qtd'
            alias paruinfo='paru -Qi'
            alias parufiles='paru -Fl'
            alias parudep='paru -Si'
            alias parupgrade='paru -Syu'
            alias parusync='paru -S'
            alias paruremove='paru -Rns'
            alias parusearch='paru -Ss'
            alias parulist='paru -Q'
            alias paruown='paru -Qo'
            ;;
        yay)
            alias yayf='_aur_fzf'
            alias yayq='yay -Q'
            alias yayqi='yay -Qi'
            alias yayql='yay -Ql'
            alias yayqo='yay -Qo'
            alias yayqs='yay -Qs'
            alias yays='yay -Ss'
            alias yaysi='yay -Si'
            alias yayup='yay -Syu'
            alias yayu='yay -Syu'
            alias yayin='yay -S'
            alias yayrm='yay -Rns'
            alias yaycl='yay -Sc'
            alias yaycc='yay -Scc'
            alias yaygendb='yay -Y --gendb'
            alias yaydev='yay -S --devel'
            alias yayfiles='yay -Fl'
            alias yaynews='yay -P --news'
            alias yaycf='yay -Pg'
            alias yaypc='yay -Pc'
            alias yaystats='yay -Ps'
            alias yayorph='yay -Qtd'
            alias yaylsorph='yay -Qtd'
            alias yaycleandeps='yay -Yc'
            alias yaydepclean='yay -Yc'
            alias yaydebug='yay -P --debug'
            alias yayversion='yay -P --version'
            alias yayconfig='yay -Pg'
            alias yaysave='yay -S --save'
            alias yayedit='yay -S --edit'
            alias yaynoconf='yay -S --noconfirm'
            ;;
        pikaur)
            alias pikaurf='_aur_fzf'
            alias pikaurq='pikaur -Q'
            alias pikaurqi='pikaur -Qi'
            alias pikaurql='pikaur -Ql'
            alias pikaurqo='pikaur -Qo'
            alias pikaurs='pikaur -Ss'
            alias pikaursi='pikaur -Si'
            alias pikaurup='pikaur -Syu'
            alias pikaurin='pikaur -S'
            alias pikaurrm='pikaur -Rns'
            alias pikaurdiff='pikaur -Pc'
            alias pikaurstats='pikaur -Ps'
            alias pikaurcf='pikaur -Pg'
            alias pikaurdev='pikaur -S --devel'
            alias pikaurnews='pikaur -P --news'
            alias pikaurorph='pikaur -Qtd'
            ;;
        aura)
            alias auraf='_aur_fzf'
            alias auraq='aura -Q'
            alias auraqi='aura -Qi'
            alias auraql='aura -Ql'
            alias auraqo='aura -Qo'
            alias auras='aura -Ss'
            alias aurasi='aura -Si'
            alias auraup='aura -Syu'
            alias aurain='aura -S'
            alias aurarm='aura -Rns'
            alias auradb='aura -Y --gendb'
            alias auradiff='aura -Pc'
            alias aurastats='aura -Ps'
            alias auraorph='aura -Qtd'
            alias auraclean='aura -Sc'
            ;;
    esac


    _aur_fzf() {
        $_AUR_HELPER -Slq 2>/dev/null | fzf --multi \
            --preview "$_AUR_HELPER -Sii {1} 2>/dev/null" \
            --preview-window=down:75% | xargs -ro $_AUR_HELPER -S
    }
    alias aurf='_aur_fzf'

    unset _h
fi
unset _AUR_HELPER


command -v pacman-key >/dev/null 2>&1 && {
    alias pkey='sudo pacman-key'
    alias pkeyi='sudo pacman-key --init'
    alias pkeyp='sudo pacman-key --populate'
    alias pkeyr='sudo pacman-key --refresh'
    alias pkeyls='sudo pacman-key --list-keys'
    alias pkeylsig='sudo pacman-key --list-sigs'
    alias pkeyf='sudo pacman-key --finger'
    alias pkeyu='sudo pacman-key --updatedb'
    alias pkeyadd='sudo pacman-key --add'
    alias pkeyrecv='sudo pacman-key --recv-keys'
    alias pkeydel='sudo pacman-key --delete-keys'
    alias pkeyexport='sudo pacman-key --export'
    alias pkeyimport='sudo pacman-key --import'
}


command -v makepkg >/dev/null 2>&1 && {
    alias mkp='makepkg'
    alias mkpsi='makepkg -si'
    alias mkps='makepkg -s'
    alias mkpi='makepkg -i'
    alias mkpc='makepkg -c'
    alias mkpcf='makepkg --config'
    alias mkpcl='makepkg --clean'
    alias mkpclb='makepkg --cleanbuild'
    alias mkpinstall='makepkg -si'
    alias mkpsrc='makepkg --source'
    alias mkpnoci='makepkg --nocheck --noextract --nodeps'
    alias mkpgen='makepkg --geninteg'
    alias mkpp='makepkg --printsrcinfo'
}


if command -v pactree >/dev/null 2>&1; then
    alias pactree='pactree'
    alias pacdepgraph='pactree -c'
    alias pacwhyfn='pactree -r'
    alias pacfilesize='expac -H M -s "%-30n %m"'
    alias pactreer='pactree -r'
    alias pactreed='pactree -d'
    alias pactreel='pactree -l'
fi


command -v expac >/dev/null 2>&1 && {
    alias exp='expac'
    alias expls='expac -l'
    alias expm='expac -H M'
    alias exps='expac -s'
    alias expq='expac -Q'
    alias expqm='expac -Q -H M'
    alias expqt='expac -Qt'
}


if command -v pkgfile >/dev/null 2>&1; then
    alias pkgf='pkgfile'
    alias pkgfiles='pkgfile -l'
    alias pkgfsearch='pkgfile -s'
    alias pkgfup='sudo pkgfile -u'
    alias pkgfupdate='sudo pkgfile -u'
    alias pkgfi='pkgfile -i'
fi


if command -v reflector >/dev/null 2>&1; then
    alias reflect='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
    alias reflectfast='sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
    alias reflectall='sudo reflector --latest 50 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
    alias reflectcountry='sudo reflector --country'
    alias reflectage='sudo reflector --age 6'
    alias reflectscore='sudo reflector --sort score'
    alias reflectdelay='sudo reflector --sort delay'
    alias reflectver='reflector --version'
fi


if command -v mkinitcpio >/dev/null 2>&1; then
    alias mkinit='sudo mkinitcpio -P'
    alias mkinitc='sudo mkinitcpio -p linux'
    alias mkinits='sudo mkinitcpio --save'
    alias mkinitv='sudo mkinitcpio --version'
fi


if command -v chaotic-gl >/dev/null 2>&1; then
    alias cgi='chaotic-gl install'
    alias cgr='chaotic-gl remove'
    alias cgs='chaotic-gl search'
    alias cgu='chaotic-gl upgrade'
    alias cgl='chaotic-gl list'
fi


command -v arch-chroot >/dev/null 2>&1 && {
    alias achroot='sudo arch-chroot'
}


if command -v pacdiff >/dev/null 2>&1; then
    alias pacdiffview='sudo pacdiff'
    alias pacdiff='sudo pacdiff'
fi

command -v paclist >/dev/null 2>&1 && alias paclist='paclist'
command -v paclog >/dev/null 2>&1 && alias paclog='paclog'

command -v rankmirrors >/dev/null 2>&1 && {
    alias rankmir='sudo rankmirrors -v'
}


command -v netctl >/dev/null 2>&1 && {
    alias nctl='sudo netctl'
    alias nctll='netctl list'
    alias nctls='sudo netctl start'
    alias nctlstp='sudo netctl stop'
    alias nctlrst='sudo netctl restart'
    alias nctle='sudo netctl enable'
    alias nctld='sudo netctl disable'
    alias nctlr='sudo netctl reenable'
    alias nctlsw='netctl switch-to'
    alias nctlis='netctl is-active'
    alias nctlisen='netctl is-enabled'
}


pacrecent() { tail -50 /var/log/pacman.log; }
pacupdatelog() { grep -E "\[PACMAN\]" /var/log/pacman.log | grep "starting" | tail -"${1:-5}"; }
pachistory() { cat /var/log/pacman.log; }
pacinstalllog() { grep -i "installed" /var/log/pacman.log; }
pacremovelog() { grep -i "removed" /var/log/pacman.log; }


pacreclaim() {
    sudo pacman -Scc --noconfirm 2>/dev/null
    local _orphans
    _orphans=$(pacman -Qtdq 2>/dev/null)
    [ -n "$_orphans" ] && sudo pacman -Rns $_orphans --noconfirm 2>/dev/null
    true
}


alias jlog='journalctl -xe'
alias jboot='journalctl -b'
alias jfail='journalctl -p 3 -xb'
alias jefail='journalctl -p 3 -xb --no-hostname'
alias jfollow='journalctl -f'
alias jservice='journalctl -fu'
alias jservicelast='journalctl -u -n 50'
