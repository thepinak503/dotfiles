#!/usr/bin/env bash
# =============================================================================

# Loads on any Fedora-derived distro
# =============================================================================

if [ "$DOTFILES_DISTRO" = "fedora" ] || [ "$DOTFILES_DISTRO" = "centos" ] || [ "$DOTFILES_DISTRO" = "rhel" ] || [ "$DOTFILES_DISTRO" = "rocky" ] || [ "$DOTFILES_DISTRO" = "alma" ] || [ "$DOTFILES_DISTRO" = "nobara" ]; then


alias dnfup='sudo dnf upgrade'
alias dnfu='sudo dnf upgrade'
alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfq='dnf list'
alias dnfiinfo='dnf info'
alias dnflist='dnf list available'
alias dnfinstalled='dnf list installed'
alias dnfclean='sudo dnf clean all'
alias dnfmark='dnf mark'
alias dnfhistory='dnf history'
alias dnfrequires='dnf repoquery --requires'
alias dnfprovides='dnf provides'
alias dnfri='sudo dnf reinstall'
alias dnfd='sudo dnf downgrade'
alias dnfdl='sudo dnf download'
alias dnfmake='sudo dnf makecache'
alias dnfmc='sudo dnf makecache'
alias dnfupd='dnf check-update'
alias dnfchk='dnf check-update'
alias dnfse='dnf search'


alias dnfg='dnf group list'
alias dnfgv='dnf group list -v'
alias dnfgi='sudo dnf group install'
alias dnfgr='sudo dnf group remove'
alias dnfgu='sudo dnf group upgrade'
alias dnfgup='sudo dnf group upgrade'
alias dnfgf='dnf group info'


alias dnfm='dnf module list'
alias dnfml='dnf module list'
alias dnfmi='sudo dnf module install'
alias dnfmr='sudo dnf module remove'
alias dnfme='sudo dnf module enable'
alias dnfmd='sudo dnf module disable'
alias dnfmu='sudo dnf module update'
alias dnfmup='sudo dnf module upgrade'
alias dnfmc='sudo dnf module reset'
alias dnfminfo='dnf module info'


alias dnfrepo='dnf repolist'
alias dnfrepos='dnf repolist'
alias dnfrepoa='dnf repolist --all'
alias dnfrepoe='dnf repolist --enabled'
alias dnfrpod='dnf repolist --disabled'
alias dnfrepoup='sudo dnf update --refresh'
alias dnfcc='sudo dnf clean all'
alias dnfccdb='sudo dnf clean dbcache'
alias dnfccmeta='sudo dnf clean metadata'
alias dnfccpkg='sudo dnf clean packages'
alias dnfccexp='sudo dnf clean expire-cache'
alias dnfconfig='dnf config-manager'
alias dnfrepoadd='sudo dnf config-manager --add-repo'
alias dfnenable='sudo dnf config-manager --set-enabled'
alias dnfdisable='sudo dnf config-manager --set-disabled'


alias dnfhi='dnf history list'
alias dnfhiu='dnf history undo'
alias dnfhir='dnf history rollback'
alias dnfhis='dnf history info'
alias dnfhistore='dnf history store'
alias dnfhistl='dnf history list'


command -v dnf-plugin-system-upgrade >/dev/null 2>&1 && {
    alias dnfupgdl='sudo dnf system-upgrade download'
    alias dnfupgreb='sudo dnf system-upgrade reboot'
    alias dnfupgcl='sudo dnf system-upgrade clean'
    alias dnfupgver='sudo dnf system-upgrade download --releasever'
}


alias dnfseconly='sudo dnf upgrade --security'
alias dnfsecinfo='dnf updateinfo --list --security'
alias dnfsecadvisory='dnf updateinfo --advisory'


alias dnfau='sudo dnf autoremove'
alias dnfauto='sudo dnf autoremove'
alias dnflsorph='dnf list extras'
alias dnfleaves='dnf list extras'


alias dnfsync='sudo dnf distro-sync'
alias dnfswap='sudo dnf swap'


dnfinstall() { sudo dnf install "$@"; }
dnfremove() { sudo dnf remove "$@"; }
dnfupdate() { sudo dnf upgrade; }
dnfsearch() { dnf search "$@" | less; }
dnfinfo() { dnf info "$@"; }
dnfupgrade() { sudo dnf upgrade; }
dnfclean() { sudo dnf clean all; }
dnfgroup() { sudo dnf group "$@"; }


alias rpm='rpm'
alias rpmi='sudo rpm -ivh'
alias rpmu='sudo rpm -Uvh'
alias rpmf='sudo rpm -e'
alias rpmrm='sudo rpm -e'
alias rpmq='rpm -qa'
alias rpmqi='rpm -qi'
alias rpmql='rpm -ql'
alias rpmqc='rpm -qc'
alias rpmqd='rpm -qd'
alias rpmqr='rpm -qR'
alias rpmqo='rpm -qf'
alias rpmqp='rpm -qp'
alias rpmqpl='rpm -qpl'
alias rpmqpi='rpm -qpi'
alias rpmqs='rpm -qs'
alias rpmqwhat='rpm -q --whatprovides'
alias rpmqreq='rpm -q --whatrequires'
alias rpmqrec='rpm -q --whatrecommends'
alias rpmqsup='rpm -q --whatsupplements'
alias rpmqconf='rpm -q --whatconflicts'
alias rpmqobso='rpm -q --whatobsoletes'
alias rpmqv='rpm -q --qf'
alias rpmsig='rpm -K'
alias rpmv='rpm -V'
alias rpmva='rpm -Va'
alias rpmvf='rpm -Vf'
alias rpmdb='sudo rpm --rebuilddb'
alias rpmdbinit='sudo rpm --initdb'
alias rpmimp='sudo rpm --import'
alias rpmerase='sudo rpm -e'
alias rpmverify='rpm -V'
alias rpmvers='rpm --version'
alias rpmchecks='rpm -K --nosignature'


command -v dnf-plugin-versionlock >/dev/null 2>&1 && {
    alias dnflock='dnf versionlock'
    alias dnflockl='dnf versionlock list'
    alias dnflocka='sudo dnf versionlock add'
    alias dnflockd='sudo dnf versionlock delete'
    alias dnflockc='sudo dnf versionlock clear'
}


command -v cockpit >/dev/null 2>&1 && {
    alias cockpit='cockpit'
    alias cockpitup='sudo systemctl start cockpit'
    alias cockpitdown='sudo systemctl stop cockpit'
    alias cockpitstatus='sudo systemctl status cockpit'
    alias cockpitenable='sudo systemctl enable cockpit'
}


command -v firewall-cmd >/dev/null 2>&1 && {
    alias fw='sudo firewall-cmd'
    alias fwl='sudo firewall-cmd --list-all'
    alias fwa='sudo firewall-cmd --add-port'
    alias fwr='sudo firewall-cmd --remove-port'
    alias fwas='sudo firewall-cmd --add-service'
    alias fwrs='sudo firewall-cmd --remove-service'
    alias fwzone='sudo firewall-cmd --get-active-zones'
    alias fwdef='sudo firewall-cmd --get-default-zone'
    alias fwsetdef='sudo firewall-cmd --set-default-zone'
    alias fwperm='sudo firewall-cmd --permanent'
    alias fwreload='sudo firewall-cmd --reload'
    alias fwrich='sudo firewall-cmd --add-rich-rule'
    alias fwlog='sudo firewall-cmd --get-log-denied'
    alias fwlist='sudo firewall-cmd --list-all'
    alias fwports='sudo firewall-cmd --list-ports'
    alias fwsvcs='sudo firewall-cmd --list-services'
    alias fwpanic='sudo firewall-cmd --panic-on'
    alias fwnopanic='sudo firewall-cmd --panic-off'
    alias fwlockdown='sudo firewall-cmd --lockdown-on'
    alias fwnolock='sudo firewall-cmd --lockdown-off'
    alias fwdirect='sudo firewall-cmd --direct --get-all-rules'
}


command -v getenforce >/dev/null 2>&1 && {
    alias selinux='getenforce'
    alias selinuxst='sestatus'
    alias selinuxe='sudo setenforce 1'
    alias selinuxd='sudo setenforce 0'
    alias selinuxbooleans='getsebool -a'
    alias selinuxcon='secon'
    alias selinuxfix='sudo fixfiles onboot'
    alias selinuxrestore='sudo restorecon -Rv'
    alias selinuxaudit='ausearch -m avc'
    alias selinuxlog='sealert -a /var/log/audit/audit.log'
}


command -v abrt-cli >/dev/null 2>&1 && {
    alias abrt='abrt-cli'
    alias abrtls='abrt-cli list'
    alias abrtrm='sudo abrt-cli rm'
    alias abrtreport='abrt-cli report'
    alias abrtinfo='abrt-cli info'
}

fi
