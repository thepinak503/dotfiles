#!/usr/bin/env bash
# =============================================================================

# Loads on any Debian-derived distro
# =============================================================================

if [ "$DOTFILES_DISTRO" = "debian" ] || [ "$DOTFILES_DISTRO" = "ubuntu" ] || [ "$DOTFILES_DISTRO" = "linuxmint" ] || [ "$DOTFILES_DISTRO" = "pop" ] || [ "$DOTFILES_DISTRO" = "zorin" ] || [ "$DOTFILES_DISTRO" = "neon" ] || [ "$DOTFILES_DISTRO" = "mx" ] || [ "$DOTFILES_DISTRO" = "elementary" ]; then


alias aptg='sudo apt-get'
alias aptgi='sudo apt-get install'
alias aptgr='sudo apt-get remove'
alias aptgp='sudo apt-get purge'
alias aptgu='sudo apt-get update'
alias aptgup='sudo apt-get upgrade'
alias aptgupg='sudo apt-get dist-upgrade'
alias aptgfull='sudo apt-get full-upgrade'
alias aptgd='sudo apt-get download'
alias aptgsrc='sudo apt-get source'
alias aptgbd='sudo apt-get build-dep'
alias aptgcheck='sudo apt-get check'
alias aptga='sudo apt-get autoremove'
alias aptgac='sudo apt-get autoclean'
alias aptgc='sudo apt-get clean'
alias aptgf='sudo apt-get install -f'
alias aptgfix='sudo apt-get --fix-broken install'
alias aptgdr='sudo apt-get --dry-run install'
alias aptgsim='sudo apt-get --simulate'
alias aptgre='sudo apt-get install --reinstall'
alias aptgnu='sudo apt-get install --no-upgrade'
alias aptgou='sudo apt-get install --only-upgrade'
alias aptgdu='sudo apt-get dist-upgrade --dry-run'
alias aptgsh='sudo apt-get -s install'


alias aptup='sudo apt update && sudo apt upgrade'
alias aptin='sudo apt install'
alias aptr='sudo apt remove'
alias aptp='sudo apt purge'
alias apts='apt search'
alias aptq='dpkg -l'
alias aptshow='apt show'
alias aptfiles='dpkg -L'
alias aptown='dpkg -S'
alias aptclean='sudo apt autoremove && sudo apt autoclean'
alias aptfix='sudo apt install -f'
alias aptdl='apt download'
alias aptlist='apt list'
alias aptli='apt list --installed'
alias aptlu='apt list --upgradable'
alias aptla='apt list --all-versions'
alias aptpolicy='apt policy'
alias aptfu='sudo apt full-upgrade'
alias aptau='sudo apt autoremove'
alias aptac='sudo apt autoclean'
alias aptcc='sudo apt clean'
alias aptdr='sudo apt --dry-run'
alias aptch='apt changelog'


alias acs='apt-cache search'
alias acsh='apt-cache show'
alias acsp='apt-cache showpkg'
alias acsrc='apt-cache showsrc'
alias acst='apt-cache stats'
alias acdep='apt-cache depends'
alias acrdep='apt-cache rdepends'
alias acpn='apt-cache pkgnames'
alias acpol='apt-cache policy'
alias acdump='apt-cache dump'
alias acdumav='apt-cache dumpavail'
alias acun='apt-cache unmet'


alias amh='sudo apt-mark hold'
alias amuh='sudo apt-mark unhold'
alias amsh='apt-mark showhold'
alias ama='sudo apt-mark auto'
alias amm='sudo apt-mark manual'
alias amsa='apt-mark showauto'
alias assm='apt-mark showmanual'


alias aedit='sudo apt edit-sources'
alias asat='apt satisfies'


alias dpi='sudo dpkg -i'
alias dpr='sudo dpkg -r'
alias dpp='sudo dpkg -P'
alias dpl='dpkg -l'
alias dpq='dpkg --list'
alias dpqi='dpkg -l | grep'
alias dpqf='dpkg -L'
alias dpqo='dpkg -S'
alias dpqs='dpkg -s'
alias dpqc='dpkg -c'
alias dpqI='dpkg -I'
alias dpqa='dpkg --audit'
alias dpcfg='sudo dpkg --configure -a'
alias dpfunpack='sudo dpkg --unpack'
alias dpfconfig='sudo dpkg --configure'
alias dpfstatus='dpkg --status'
alias dpfsearch='dpkg --search'
alias dpfprint='dpkg --print-architecture'
alias dpff='dpkg --force-all -i'
alias dpdiv='dpkg --compare-versions'
alias dpclr='sudo dpkg --clear-avail'
alias dpfor='sudo dpkg --force-depends -i'
alias dppurge='sudo dpkg --purge'


alias dpdeb='dpkg-deb'
alias dpdebc='dpkg-deb -c'
alias dpdebi='dpkg-deb -I'
alias dpdebf='dpkg-deb -f'
alias dpdebe='dpkg-deb -e'
alias dpdebx='dpkg-deb -x'
alias dpdebX='dpkg-deb -X'
alias dpdebv='dpkg-deb --vextract'


alias dpqry='dpkg-query'
alias dpqryW='dpkg-query -W'
alias dpqryf='dpkg-query -f'
alias dpqryl='dpkg-query -L'
alias dpqrys='dpkg-query -S'
alias dpqryp='dpkg-query -p'


alias dprec='sudo dpkg-reconfigure'
alias dpreca='sudo dpkg-reconfigure -a'
alias dprecp='sudo dpkg-reconfigure --priority'
alias dprecf='sudo dpkg-reconfigure --frontend'


alias aptkey='sudo apt-key'
alias aptkeya='sudo apt-key adv'
alias aptkeyl='sudo apt-key list'
alias aptkeyf='sudo apt-key finger'
alias aptkeyd='sudo apt-key del'
alias aptkeyadd='sudo apt-key add'


command -v add-apt-repository >/dev/null 2>&1 && {
    alias aptrepo='sudo add-apt-repository'
    alias aptrepoy='sudo add-apt-repository -y'
    alias aptreporm='sudo add-apt-repository --remove'
    alias aptrepoup='sudo add-apt-repository --update'
    alias aptrepols='sudo add-apt-repository --list'
}


alias srclist='ls /etc/apt/sources.list.d/'
alias srcshow='cat /etc/apt/sources.list'
alias srcbackup='sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak'
alias srcrestore='sudo cp /etc/apt/sources.list.bak /etc/apt/sources.list'
alias supd='sudo apt-get update 2>&1 | grep -E "(Hit|Ign|Err|Get)"'
alias supdlist='sudo apt-get update 2>&1 | grep -v "^Hit:"'


command -v snap >/dev/null 2>&1 && {
    alias sn='snap'
    alias sni='sudo snap install'
    alias snr='sudo snap remove'
    alias snrm='sudo snap remove'
    alias sns='snap search'
    alias snf='snap find'
    alias snl='snap list'
    alias sninfo='snap info'
    alias snup='sudo snap refresh'
    alias snupg='sudo snap refresh --list'
    alias snch='snap changes'
    alias sntasks='snap tasks'
    alias snsvc='snap services'
    alias snstart='sudo snap start'
    alias snstop='sudo snap stop'
    alias snrestart='sudo snap restart'
    alias snlogs='snap logs'
    alias sncon='snap connections'
    alias sndiscon='snap disconnect'
    alias snconnec='snap connect'
    alias snalias='snap aliases'
    alias snunalias='snap unalias'
    alias snprefer='sudo snap prefer'
    alias snrevert='sudo snap revert'
    alias snenable='sudo snap enable'
    alias sndisable='sudo snap disable'
    alias snswitch='sudo snap switch'
    alias snhold='sudo snap hold'
    alias snunhold='sudo snap unhold'
    alias snset='sudo snap set'
    alias sunget='snap get'
    alias snwarn='snap warnings'
    alias snok='snap ok'
    alias snack='snap acknowledge'
    alias snbuy='snap buy'
    alias snknown='snap known'
    alias snmodel='snap model'
    alias snbootstrap='sudo snap bootstrap'
    alias sndownload='snap download'
    alias snpack='snap pack'
    alias snrun='snap run'
    alias snsave='snap save'
    alias sncheck='snap check-snapshot'
    alias snfor='snap forget'
    alias snpurge='snap purge'
}


command -v debootstrap >/dev/null 2>&1 && {
    alias dbootstrap='sudo debootstrap'
    alias dbs='sudo debootstrap'
    alias dbsstable='sudo debootstrap stable'
    alias dbstesting='sudo debootstrap testing'
    alias dbsunstable='sudo debootstrap unstable'
}


command -v apt-file >/dev/null 2>&1 && {
    alias af='apt-file'
    alias afs='apt-file search'
    alias afl='apt-file list'
    alias afup='sudo apt-file update'
    alias aff='apt-file find'
    alias afshow='apt-file show'
    alias afpkg='apt-file --package-only'
}


command -v debconf-show >/dev/null 2>&1 && {
    alias dcs='sudo debconf-show'
    alias dcget='sudo debconf-get-selections'
    alias dcset='sudo debconf-set-selections'
    alias dcc='sudo debconf-communicate'
}


command -v needrestart >/dev/null 2>&1 && {
    alias nr='sudo needrestart'
    alias nrc='sudo needrestart -c'
    alias nrl='sudo needrestart -l'
}

command -v checkrestart >/dev/null 2>&1 && {
    alias cr='sudo checkrestart'
}

command -v gdebi >/dev/null 2>&1 && {
    alias gdebi='sudo gdebi'
    alias gdebii='sudo gdebi -n'
    alias gdebiq='gdebi -q'
}

command -v deborphan >/dev/null 2>&1 && {
    alias doorphan='deborphan'
    alias doorphana='deborphan -a'
    alias doorphangl='deborphan --guess-default'
    alias doorphankde='deborphan -k'
    alias doorphanlib='deborphan -l'
}

command -v debsums >/dev/null 2>&1 && {
    alias dsums='debsums'
    alias dsumsc='debsums -c'
    alias dsumsa='debsums -a'
    alias dsumse='debsums -e'
    alias dsumss='debsums -s'
    alias dumpsl='sudo debsums -l'
}


command -v update-alternatives >/dev/null 2>&1 && {
    alias alt='sudo update-alternatives'
    alias altc='sudo update-alternatives --config'
    alias altl='update-alternatives --list'
    alias altd='update-alternatives --display'
    alias alti='sudo update-alternatives --install'
    alias altr='sudo update-alternatives --remove'
    alias altra='sudo update-alternatives --remove-all'
    alias altg='update-alternatives --get-selections'
    alias alts='sudo update-alternatives --set'
    alias alta='sudo update-alternatives --auto'
}


command -v lsb_release >/dev/null 2>&1 && {
    alias lsbr='lsb_release -a'
    alias lsd='lsb_release -d'
    alias lsr='lsb_release -r'
    alias lsc='lsb_release -c'
    alias lsi='lsb_release -i'
    alias lss='lsb_release -s'
}


alias osr='cat /etc/os-release'
alias osid='grep ^ID= /etc/os-release'
alias osver='grep ^VERSION_ID= /etc/os-release'
alias oslike='grep ^ID_LIKE= /etc/os-release'


command -v docker >/dev/null 2>&1 && {
    alias dcek='"$(command -v docker)"'
}


alias aptfull='sudo apt update && sudo apt dist-upgrade -y'
alias aptfixall='sudo apt update && sudo apt install -f && sudo dpkg --configure -a && sudo apt autoremove'
alias aptnuke='sudo apt purge ~c'
alias aptrmlock='sudo rm -f /var/lib/apt/lists/lock /var/lib/dpkg/lock /var/cache/apt/archives/lock'
alias aptshowheld='apt-mark showhold'


alias aptlog='cat /var/log/apt/history.log'
alias aptlogterm='cat /var/log/apt/term.log'
alias aptloglast='tail -50 /var/log/apt/history.log'


alias aptindex='sudo apt-cache gencaches'
alias aptmkidx='sudo apt-file update 2>/dev/null; sudo apt-get update'

fi
