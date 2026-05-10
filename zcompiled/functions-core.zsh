#!/usr/bin/env zsh
mkcd() {
    mkdir -p "$1" && cd "$1"
}
take() {
    mkdir -p "$1" && cd "$1"
}
extract() {
    case "$1" in *.tar.bz2) tar xjf "$1";; *.tar.gz) tar xzf "$1";; *.bz2) bunzip2 "$1";; *.rar) unrar x "$1";; *.gz) gunzip "$1";; *.tar) tar xf "$1";; *.tbz2) tar xjf "$1";; *.tgz) tar xzf "$1";; *.zip) unzip "$1";; *.Z) uncompress "$1";; *.7z) 7z x "$1";; *) printf 'unknown archive: %s\n' "$1" >&2; return 1;; esac
}
pathuniq() {
    awk -v RS=: '!seen[$0]++{printf "%s%s", sep, $0; sep=":"} END{print ""}' <<<"$PATH"
}
dothealth() {
    bash "$DOTFILES_DIR/bin/health_check.sh"
}
dotbench() {
    bash "$DOTFILES_DIR/bin/benchmark_shell.sh"
}
dotfix() {
    sh "$DOTFILES_DIR/install/install.sh"
}
recent() {
    find "${1:-.}" -type f -mtime -1 -print 2>/dev/null | head -100
}
jsonfmt() {
    python3 -m json.tool "$@"
}
timer() {
    start=$(date +%s); "$@"; code=$?; end=$(date +%s); printf 'elapsed: %ss\n' "$((end-start))"; return $code
}
dotloadfull() {
    source "$DOTFILES_DIR/shells/zsh/functions.zsh"
    source "$DOTFILES_DIR/shells/zsh/aliases.zsh"
}
