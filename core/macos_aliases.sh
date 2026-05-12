#!/usr/bin/env bash
# =============================================================================
# macOS - Homebrew, MacPorts, MAS & macOS-specific aliases
# Only loads on macOS
# =============================================================================

if [ "$DOTFILES_DISTRO" = "macos" ]; then

# ---- Homebrew aliases ----
alias brewup='brew update && brew upgrade'
alias brewin='brew install'
alias brewrm='brew uninstall'
alias brews='brew search'
alias brewq='brew list'
alias brewli='brew leaves'
alias brewdeps='brew deps'
alias brewc='brew cleanup'
alias brewinfo='brew info'
alias brewdo='brew doctor'
alias brewpin='brew pin'
alias brewunpin='brew unpin'
alias brewupg='brew upgrade'
alias brewlink='brew link'
alias brewunlink='brew unlink'
alias brewout='brew outdated'
alias brewo='brew outdated'
alias brewcl='brew cleanup'
alias brewcln='brew cleanup --prune=all'
alias brewdesc='brew desc'
alias brewcat='brew cat'
alias brewlog='brew log'
alias brewtap='brew tap'
alias brewtapinfo='brew tap-info'
alias brewuntap='brew untap'
alias brewuses='brew uses'
alias brewrdeps='brew uses --installed'
alias brewmissing='brew missing'
alias brewsrvc='brew services'
alias brewsrvcl='brew services list'
alias brewsrvr='brew services restart'
alias brewsrvstart='brew services start'
alias brewsrvstop='brew services stop'
alias brewsrvrun='brew services run'
alias brewcask='brew install --cask'
alias brewci='brew install --cask'
alias brewcasl='brew list --cask'
alias brewcasinfo='brew info --cask'
alias brewcasrm='brew uninstall --cask'
alias brewcasup='brew upgrade --cask'
alias brewcasout='brew outdated --cask'
alias brewbundle='brew bundle'
alias brewbundl='brew bundle'
alias brewbundd='brew bundle dump'
alias brewbundc='brew bundle cleanup'
alias brewbundi='brew bundle install'
alias brewbundch='brew bundle check'
alias brewconfig='brew config'
alias brewenve='eval "$(brew shellenv)"'

# ---- Homebrew functions ----
brewinstall() { brew install "$@"; }
brewremove() { brew uninstall "$@"; }
brewupdate() { brew update; }
brewupgrade() { brew upgrade; }
function brewclean() { brew cleanup; }
brewsearch() { brew search "$@"; }
function brewinfo() { brew info "$@"; }
function brewcask() { brew install --cask "$@"; }

# ---- Mac App Store (mas) ----
command -v mas >/dev/null 2>&1 && {
    alias mas='mas'
    alias masin='mas install'
    alias masup='mas upgrade'
    alias masout='mas outdated'
    alias masl='mas list'
    alias mass='mas search'
    alias masinfo='mas info'
    alias masluck='mas lucky'
    alias masopen='mas open'
    alias masreset='mas reset'
}

# ---- MacPorts ----
command -v port >/dev/null 2>&1 && {
    alias port='port'
    alias portin='sudo port install'
    alias portrm='sudo port uninstall'
    alias portup='sudo port selfupdate && sudo port upgrade'
    alias ports='port search'
    alias portq='port installed'
    alias portinfo='port info'
    alias portl='port list'
    alias portvar='port variants'
    alias portdep='port deps'
    alias portact='port active'
    alias portinact='port inactive'
    alias portout='port outdated'
    alias portcl='sudo port clean --all'
    alias portlocks='sudo port reclaim'
}

# ---- macOS-specific CLI tools ----
alias pbcopy='pbcopy'
alias pbpaste='pbpaste'
alias pbc='pbcopy'
alias pbp='pbpaste'
alias mdfind='mdfind'
alias mdls='mdls'
alias mdutil='mdutil'
alias open='open'
alias o='open'
alias o.='open .'
alias ql='qlmanage -p'
alias screencapture='screencapture'
alias afplay='afplay'
alias say='say'
alias diskut='diskutil'
alias diskutl='diskutil list'
alias diskutif='diskutil info'
alias diskutmount='diskutil mount'
alias diskutumount='diskutil unmount'
alias diskuteject='diskutil eject'
alias diskutr='diskutil rename'
alias diskutud='sudo diskutil unmountDisk'
alias diskutv='diskutil verifyVolume'
alias diskutrv='diskutil repairVolume'
alias diskutvp='diskutil verifyPermissions'
alias diskutrp='diskutil repairPermissions'
alias diskutap='diskutil apfs'
alias diskutapfl='diskutil apfs list'
alias diskutapfc='diskutil apfs create'
alias diskutapfd='diskutil apfs delete'
alias diskutapfs='diskutil apfs resize'
alias diskutapfv='diskutil apfs lock'
alias diskutapfu='diskutil apfs unlock'

# ---- Network (macOS-specific) ----
alias netstat='netstat'
alias nstop='sudo lsof -iTCP -sTCP:LISTEN -P'
alias nstoppid='sudo lsof -iTCP -sTCP:LISTEN -P -p'
alias netext='sudo lsof -i'
alias dnsflush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias dnsclear='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias arp='arp -a'
alias ifconfig='ifconfig'
alias route='netstat -r'
alias networksetup='networksetup'
alias nw='networksetup'
alias nwlist='networksetup -listallnetworkservices'
alias nwhw='networksetup -listallhardwareports'
alias nwget='networksetup -getinfo'
alias nwset='sudo networksetup -setnetworkserviceenabled'
alias nwdns='networksetup -getdnsservers'
alias nwsetdns='networksetup -setdnsservers'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s'
alias airporti='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I'
alias airportscan='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s'
alias airportl='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --prefs'
alias wifion='networksetup -setairportpower en0 on'
alias wifioff='networksetup -setairportpower en0 off'
alias wifiname='networksetup -getairportnetwork en0'

# ---- macOS System management ----
alias sysprefs='open -a System\ Preferences'
alias sysinfo='system_profiler SPHardwareDataType'
alias sysmem='system_profiler SPMemoryDataType'
alias sysstorage='system_profiler SPStorageDataType'
alias syspower='system_profiler SPPowerDataType'
alias sysusb='system_profiler SPUSBDataType'
alias sysbluetooth='system_profiler SPBluetoothDataType'
alias sysnet='system_profiler SPNetworkDataType'
alias sysdisplays='system_profiler SPDisplaysDataType'
alias sysprints='system_profiler SPPrintersDataType'
alias sysapps='system_profiler SPApplicationsDataType'
alias sysstartup='system_profiler SPStartupItemDataType'
alias syslogs='system_profiler SPSoftwareDataType'
alias sysfonts='system_profiler SPFontsDataType'
alias sysaudio='system_profiler SPAudioDataType'
alias syscamera='system_profiler SPCameraDataType'
alias sysbatt='system_profiler SPPowerDataType | grep -E "Condition|Cycle|Charge|Health"'

# ---- Launchctl (macOS init) ----
alias lctl='launchctl'
alias lctll='launchctl list'
alias lctlload='launchctl load'
alias lctlunload='launchctl unload'
alias lctlk='launchctl kickstart'
alias lctlkick='launchctl kickstart -k'
alias lctlboot='launchctl bootstrap'
alias lctlbootout='launchctl bootout'
alias lctlenv='launchctl setenv'
alias lctlunenv='launchctl unsetenv'
alias lctlgetenv='launchctl getenv'
alias lctlstart='launchctl start'
alias lctlstop='launchctl stop'
alias lctlinst='launchctl submit'
alias lctlrm='launchctl remove'
alias lctlprint='launchctl print'
alias lctlerr='launchctl error'

# ---- PlistBuddy ----
command -v /usr/libexec/PlistBuddy >/dev/null 2>&1 && {
    alias plist='/usr/libexec/PlistBuddy'
    alias plistp='/usr/libexec/PlistBuddy -c Print'
    alias plistadd='/usr/libexec/PlistBuddy -c Add'
    alias plistset='/usr/libexec/PlistBuddy -c Set'
    alias plistrm='/usr/libexec/PlistBuddy -c Delete'
    alias plistc='plutil -convert xml1'
    alias plistcb='plutil -convert binary1'
    alias plistj='plutil -convert json'
    alias plistchk='plutil -lint'
}

# ---- Defaults (macOS settings) ----
alias def='defaults'
alias defr='defaults read'
alias defw='defaults write'
alias defd='defaults delete'
alias deff='defaults find'
alias deft='defaults read -g'
alias defhost='defaults -currentHost'
alias defv='defaults -domain'

# ---- macOS FDer ----
alias fdsoft='ulimit -S -n'
alias fdhard='ulimit -H -n'
alias fdmax='ulimit -n 1024'

# ---- SW_VER ----
alias swv='sw_vers'
alias swvpd='sw_vers -productName'
alias swvpv='sw_vers -productVersion'
alias swvpb='sw_vers -buildVersion'

fi
