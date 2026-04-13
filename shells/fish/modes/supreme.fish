#!/usr/bin/env fish
if not test "$DOTFILES_MODE" = "advanced" -o "$DOTFILES_MODE" = "ultra-nerd"
    return 0
end
if type -q docker
    abbr -a d 'docker'
    abbr -a dc 'docker-compose'
    abbr -a dps 'docker ps'
    abbr -a dpsa 'docker ps -a'
    abbr -a di 'docker images'
    abbr -a dex 'docker exec -it'
    abbr -a dlog 'docker logs -f'
    abbr -a dstop 'docker stop (docker ps -aq)'
    abbr -a drm 'docker rm (docker ps -aq)'
end
if type -q kubectl
    abbr -a k 'kubectl'
    abbr -a kg 'kubectl get'
    abbr -a kd 'kubectl describe'
    abbr -a kl 'kubectl logs'
    abbr -a ka 'kubectl apply -f'
    abbr -a kdel 'kubectl delete'
end
if type -q tmux
    abbr -a t 'tmux'
    abbr -a ta 'tmux attach'
    abbr -a tl 'tmux list-sessions'
end
if type -q fzf
    set -gx FZF_DEFAULT_OPTS "--height=60% --layout=reverse --border"
end
abbr -a ports 'netstat -tulanp'
abbr -a ipl 'ip -br link'
abbr -a ipa 'ip -br addr'
abbr -a cpuinfo 'lscpu'
abbr -a meminfo 'free -h && cat /proc/meminfo'
abbr -a gaa 'git add --all'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gst 'git stash'
abbr -a gstd 'git stash drop'
abbr -a dprune 'docker system prune -af'
abbr -a now 'date "+%T"'
abbr -a nowdate 'date "+%d-%m-%Y"'
abbr -a path 'echo $PATH | tr ":" "\\n" | nl'
