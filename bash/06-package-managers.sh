#!/usr/bin/env bash
# =============================================================================
# 06-PACKAGE-MANAGERS.SH - Universal Package Manager Aliases
# Applies to ALL modes
# =============================================================================

# Only load if distro detection has run
[[ -z "$DISTRO_FAMILY" ]] && return

# =============================================================================
# GENERIC PACKAGE MANAGER ALIASES
# =============================================================================

# Universal package operations
alias pkg-install='$PKG_INSTALL'
alias pkg-remove='$PKG_REMOVE'
alias pkg-update='$PKG_UPDATE'
alias pkg-search='$PKG_SEARCH'
alias pkg-list='$PKG_QUERY'
alias pkg-clean='$PKG_CLEAN'

# Shorter versions
alias pin='pkg-install'
alias prm='pkg-remove'
alias pup='pkg-update'
alias pse='pkg-search'
alias pls='pkg-list'
alias pcl='pkg-clean'

# =============================================================================
# DISTRO-SPECIFIC ALIASES
# =============================================================================

case "$DISTRO_FAMILY" in
    "arch")
        # Pacman shortcuts
        alias pacs='sudo pacman -S'
        alias pacr='sudo pacman -Rs'
        alias pacu='sudo pacman -Syu'
        alias pacq='pacman -Q'
        alias pacqi='pacman -Qi'
        alias pacqo='pacman -Qo'
        alias pacqs='pacman -Qs'
        alias pacsy='sudo pacman -Sy'
        alias pacss='pacman -Ss'
        alias pacsi='pacman -Si'
        alias pacsc='sudo pacman -Sc'
        alias pacsg='pacman -Sg'
        alias pacsl='pacman -Sl'
        alias pacsw='pacman -Sw'
        alias pacuun='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphan packages"'
        alias paclo='pacman -Qdt'
        alias pacc='sudo pacman -Scc'
        alias paclf='pacman -Ql'
        alias pacexpl='pacman -D --asexp'
        alias pacimpl='pacman -D --asdep'
        alias pacro='pacman -Qtdq'
        
        # Log
        alias paclog='cat /var/log/pacman.log | tail -n 100'
        alias pacrecent='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | tail -20'
        
        # AUR helpers
        if [[ -n "$AUR_HELPER" ]]; then
            alias aurs="$AUR_SEARCH"
            alias auri="$AUR_INSTALL"
            alias auru="$AUR_UPDATE"
            alias aurq="$AUR_HELPER -Q"
            alias aurqi="$AUR_HELPER -Qi"
            alias aurreview="$AUR_HELPER -S --review"
            alias aurclean="$AUR_HELPER -Sc"
            
            if [[ "$AUR_HELPER" == "paru" ]]; then
                alias paruskip='paru -S --skipreview'
                alias paruua='paru -Sua'
                alias paruqo='paru -Qo'
            elif [[ "$AUR_HELPER" == "yay" ]]; then
                alias yayq='yay -Q'
                alias yayqi='yay -Qi'
                alias yayclean='yay -Sc'
            fi
        fi
        
        # Mirrors
        if command -v reflector &>/dev/null; then
            alias mirror-update='sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'
            alias mirror-fast='sudo reflector --fastest 20 --latest 50 --number 20 --save /etc/pacman.d/mirrorlist'
        fi
        
        # Unlock pacman database
        alias fixpacman='sudo rm /var/lib/pacman/db.lck'
        
        # Pacman orphan cleanup
        alias pacro-remove='sudo pacman -Rns $(pacman -Qtdq)'
        ;;
        
    "debian")
        # APT shortcuts
        alias apti='sudo apt install'
        alias aptr='sudo apt remove'
        alias aptp='sudo apt purge'
        alias aptu='sudo apt update && sudo apt upgrade'
        alias aptud='sudo apt update'
        alias aptug='sudo apt upgrade'
        alias aptf='sudo apt full-upgrade'
        alias aptdist='sudo apt dist-upgrade'
        alias apts='apt search'
        alias aptsh='apt show'
        alias aptli='apt list --installed'
        alias aptlu='apt list --upgradable'
        alias aptc='sudo apt autoremove'
        alias aptcc='sudo apt clean'
        alias aptar='sudo apt autoremove'
        alias aptpolicy='apt-cache policy'
        alias aptdep='apt-cache depends'
        alias aptrev='apt-cache rdepends'
        alias aptfiles='dpkg -L'
        alias aptwhich='dpkg -S'
        
        # Fix broken packages
        alias aptfix='sudo apt --fix-broken install'
        alias aptfinstall='sudo apt -f install'
        
        # Update and cleanup
        alias aptup='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt clean'
        
        # Snap shortcuts
        if command -v snap &>/dev/null; then
            alias sinstall='sudo snap install'
            alias sremove='sudo snap remove'
            alias sfind='snap find'
            alias slist='snap list'
            alias sinfo='snap info'
        fi
        
        # Flatpak shortcuts
        if command -v flatpak &>/dev/null; then
            alias finstall='flatpak install'
            alias fremove='flatpak uninstall'
            alias fupdate='flatpak update'
            alias flist='flatpak list'
            alias fsearch='flatpak search'
        fi
        ;;
        
    "rhel")
        # DNF/YUM shortcuts
        alias dnfi='sudo dnf install'
        alias dnfr='sudo dnf remove'
        alias dnfu='sudo dnf upgrade'
        alias dnfud='sudo dnf update'
        alias dnfs='dnf search'
        alias dnfinfo='dnf info'
        alias dnfl='dnf list installed'
        alias dnfc='sudo dnf autoremove'
        alias dnfcc='sudo dnf clean all'
        alias dnfgroup='dnf group'
        alias dnfcg='sudo dnf groupinstall'
        alias dnfcr='sudo dnf groupremove'
        alias dnfgl='dnf grouplist'
        alias dnfprov='dnf provides'
        alias dnfhist='dnf history'
        alias dnfdep='dnf repoquery --requires'
        alias dnfwhat='dnf repoquery --whatrequires'
        
        # COPR
        alias coprenable='sudo dnf copr enable'
        alias coprdisable='sudo dnf copr disable'
        
        # Update and cleanup
        alias dnfup='sudo dnf upgrade --refresh && sudo dnf autoremove'
        
        # RPM shortcuts
        alias rpmq='rpm -qa | grep'
        alias rpminfo='rpm -qi'
        alias rpmfiles='rpm -ql'
        alias rpmwhich='rpm -qf'
        
        # Amazon Linux specific
        if [[ "$DISTRO_ID" == "amzn" ]]; then
            # Amazon Linux uses yum/dnf but has some specific features
            alias amazon-update='sudo yum update -y'
            alias amazon-upgrade='sudo yum upgrade -y'
            alias al-install='sudo yum install -y'
            alias al-remove='sudo yum remove -y'
            alias al-search='yum search'
            alias al-info='yum info'
            alias al-list='yum list installed'
            alias al-clean='sudo yum clean all'
            
            # Amazon Linux extras
            if command -v amazon-linux-extras &>/dev/null; then
                alias al-extras='amazon-linux-extras'
                alias al-list-extras='amazon-linux-extras list'
                alias al-enable='amazon-linux-extras enable'
                alias al-disable='amazon-linux-extras disable'
                alias al-install-extras='amazon-linux-extras install'
            fi
            
            # AWS CLI specific
            alias aws-update='sudo yum update -y aws-cli'
            alias aws-install='sudo yum install -y aws-cli'
        fi
        ;;
        
    "suse")
        # Zypper shortcuts
        alias zin='sudo zypper install'
        alias zrm='sudo zypper remove'
        alias zup='sudo zypper update'
        alias zdup='sudo zypper dup'
        alias zse='zypper search'
        alias zinfo='zypper info'
        alias zli='zypper packages --installed-only'
        alias zlu='zypper list-updates'
        alias zpatch='sudo zypper patch'
        alias zclean='sudo zypper clean'
        alias zrefresh='sudo zypper refresh'
        alias zrefup='sudo zypper refresh && sudo zypper update'
        alias zdist='sudo zypper dist-upgrade'
        alias zps='sudo zypper ps -s'
        alias zal='sudo zypper addlock'
        alias zrl='sudo zypper removelock'
        alias zll='zypper locks'
        
        # Services
        alias zsi='sudo zypper si'
        alias zsr='sudo zypper sr'
        ;;
        
    "alpine")
        # APK shortcuts
        alias apki='sudo apk add'
        alias apkr='sudo apk del'
        alias apku='sudo apk upgrade'
        alias apkup='sudo apk update && sudo apk upgrade'
        alias apkud='sudo apk update'
        alias apkse='apk search'
        alias apkinfo='apk info'
        alias apkli='apk list --installed'
        alias apkcache='sudo apk cache clean'
        alias apkfix='sudo apk fix'
        ;;
        
    "gentoo")
        # Portage shortcuts
        alias eme='sudo emerge'
        alias emeu='sudo emerge --update --deep --newuse @world'
        alias emes='emerge --search'
        alias emep='emerge --pretend'
        alias emef='sudo emerge --fetchonly'
        alias emec='sudo emerge --depclean'
        alias emesync='sudo emerge --sync'
        alias emew='sudo emerge -avuDN @world'
        alias eme1='sudo emerge -1'
        alias emeinfo='emerge --info'
        alias emelog='cat /var/log/emerge.log | tail -n 50'
        alias emeq='qlist -I'
        alias qcheck='qcheck'
        alias qfile='qfile'
        alias quse='quse'
        ;;
        
    "void")
        # XBPS shortcuts
        alias xin='sudo xbps-install -S'
        alias xrm='sudo xbps-remove -R'
        alias xup='sudo xbps-install -Su'
        alias xse='xbps-query -Rs'
        alias xinfo='xbps-query -R'
        alias xli='xbps-query -l'
        alias xfiles='xbps-query -f'
        alias xwhich='xbps-query -o'
        alias xclean='sudo xbps-remove -Oo'
        alias xorphan='sudo xbps-remove -Oo'
        ;;
        
    "nix")
        # Nix shortcuts
        alias nixi='nix-env -iA'
        alias nixr='nix-env -e'
        alias nixu='nix-env -u'
        alias nixup='nix-channel --update && nix-env -u'
        alias nixse='nix search'
        alias nixq='nix-env -q'
        alias nixqc='nix-env -qc'
        alias nixgc='nix-collect-garbage'
        alias nixgd='nix-collect-garbage -d'
        alias nixshell='nix-shell'
        alias nixenv='nix-env'
        ;;
        
    "macos")
        # Homebrew shortcuts
        alias brewu='brew update && brew upgrade'
        alias brewi='brew install'
        alias brewr='brew uninstall'
        alias brews='brew search'
        alias brewinfo='brew info'
        alias brewl='brew list'
        alias brewc='brew cleanup'
        alias brewd='brew doctor'
        alias brewo='brew outdated'
        alias brewh='brew home'
        alias brewnew='brew update && brew outdated'
        
        # Cask
        alias caski='brew install --cask'
        alias caskr='brew uninstall --cask'
        alias casks='brew search --casks'
        alias caskl='brew list --cask'
        ;;
esac

# =============================================================================
# FLATPAK (Universal)
# =============================================================================

if command -v flatpak &>/dev/null; then
    alias fp='flatpak'
    alias fpi='flatpak install'
    alias fpr='flatpak uninstall'
    alias fpu='flatpak update'
    alias fps='flatpak search'
    alias fplist='flatpak list'
    alias fpinfo='flatpak info'
    alias fprun='flatpak run'
    alias fpclean='flatpak uninstall --unused'
fi

# =============================================================================
# SNAP (Universal)
# =============================================================================

if command -v snap &>/dev/null; then
    alias snapu='sudo snap refresh'
    alias snapup='sudo snap refresh'
    alias snapli='snap list'
    alias snaps='snap find'
    alias snapinfo='snap info'
    alias snaprm='sudo snap remove'
fi

# =============================================================================
# NIX (Universal - can be installed on any distro)
# =============================================================================

if command -v nix-env &>/dev/null && [[ "$DISTRO_FAMILY" != "nix" ]]; then
    alias nixi='nix-env -iA nixpkgs'
    alias nixr='nix-env -e'
    alias nixu='nix-env -u'
    alias nixse='nix search nixpkgs'
    alias nixq='nix-env -q'
fi
