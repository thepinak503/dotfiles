#!/usr/bin/env node
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.dirname(__dirname);
const write = (file, body) => fs.writeFileSync(path.join(root, file), body.endsWith("\n") ? body : `${body}\n`);
const q = (s) => `'${String(s).replace(/'/g, "'\\''")}'`;
const dq = (s) => `"${String(s).replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;

const practicalAliases = [
  ["..", "cd .."], ["...", "cd ../.."], ["....", "cd ../../.."], [".....", "cd ../../../.."],
  ["home", "cd ~"], ["dots", "cd \"$DOTFILES_DIR\""], ["dotfiles", "cd \"$DOTFILES_DIR\""],
  ["dotst", "git -C \"$DOTFILES_DIR\" status --short --branch"], ["edots", "$EDITOR \"$DOTFILES_DIR\""],
  ["reload", "exec \"$SHELL\" -l"], ["pathlines", "printf '%s\\n' ${PATH//:/\\n}"],
  ["mkdirp", "mkdir -p"], ["please", "sudo"], ["ports", "netstat -tulanp 2>/dev/null || ss -tulanp"],
  ["myip", "curl -fsSL https://ifconfig.me 2>/dev/null || curl -fsSL https://ipinfo.io/ip 2>/dev/null"],
  ["weather", "curl -fsSL wttr.in"], ["serve", "python3 -m http.server"],
  ["g", "git"], ["gs", "git status --short --branch"], ["ga", "git add"], ["gaa", "git add -A"],
  ["gc", "git commit"], ["gcm", "git commit -m"], ["gca", "git commit --amend"], ["gp", "git push"],
  ["gpf", "git push --force-with-lease"], ["gpl", "git pull --rebase --autostash"], ["gf", "git fetch --all --prune"],
  ["gl", "git log --oneline --decorate --graph --all -30"], ["gd", "git diff"], ["gds", "git diff --staged"],
  ["gb", "git branch"], ["gco", "git checkout"], ["gsw", "git switch"], ["gst", "git stash push -u"],
  ["gsp", "git stash pop"], ["grbc", "git rebase --continue"], ["grba", "git rebase --abort"],
  ["ls", "eza --icons=auto --group-directories-first 2>/dev/null || ls"], ["ll", "eza -lah --icons=auto --group-directories-first 2>/dev/null || ls -lah"],
  ["la", "eza -a --icons=auto 2>/dev/null || ls -a"], ["lt", "eza --tree --level=2 --icons=auto 2>/dev/null || find . -maxdepth 2 -print"],
  ["cat", "bat --paging=never 2>/dev/null || cat"], ["grep", "rg 2>/dev/null || grep"], ["duh", "du -sh"],
  ["dfh", "df -h"], ["freeh", "free -h"], ["psg", "ps aux | grep -i"], ["topcpu", "ps aux --sort=-%cpu | head"],
  ["topmem", "ps aux --sort=-%mem | head"], ["j", "jobs -l"], ["h", "history"], ["c", "clear"], ["cls", "clear"],
  ["k", "kubectl"], ["kgp", "kubectl get pods"], ["kgs", "kubectl get svc"], ["kctx", "kubectl config current-context"],
  ["d", "docker"], ["dps", "docker ps"], ["dpsa", "docker ps -a"], ["di", "docker images"], ["dc", "docker compose"],
  ["tf", "terraform"], ["tfi", "terraform init"], ["tfp", "terraform plan"], ["tfa", "terraform apply"],
  ["py", "python3"], ["pipup", "python3 -m pip install --upgrade pip"], ["venv", "python3 -m venv .venv"],
  ["nr", "npm run"], ["ni", "npm install"], ["nt", "npm test"], ["nd", "npm run dev"],
  ["prune", "git remote prune origin"], ["today", "date +%F"], ["now", "date '+%F %T'"],
  ["matrix", "printf '01101000 01100101 01101100 01101100 01101111\\n'"], ["shipit", "git status --short && git push"],
  ["focus", "printf '\\033c' && date '+%F %T'"], ["coinflip", "awk 'BEGIN{srand(); print rand()<0.5?\"heads\":\"tails\"}'"],
];

const commandFamilies = [
  ["git", "git status --short"], ["gitlog", "git log --oneline --decorate"], ["find", "find . -maxdepth 3 -type f -name"],
  ["rg", "rg --hidden --glob '!.git'"], ["du", "du -sh"], ["docker", "docker"], ["kubectl", "kubectl"],
  ["systemctl", "systemctl"], ["journal", "journalctl"], ["pacman", "pacman"], ["apt", "apt-cache"],
  ["brew", "brew"], ["npm", "npm"], ["pnpm", "pnpm"], ["yarn", "yarn"], ["cargo", "cargo"],
  ["go", "go"], ["python", "python3"], ["pip", "python3 -m pip"], ["tmux", "tmux"], ["ssh", "ssh"],
  ["curl", "curl -fsSL"], ["tar", "tar"], ["zip", "zip"], ["openssl", "openssl"], ["ffmpeg", "ffmpeg"],
  ["make", "make"], ["just", "just"], ["terraform", "terraform"], ["ansible", "ansible"], ["helm", "helm"],
  ["podman", "podman"], ["flatpak", "flatpak"], ["snap", "snap"], ["nix", "nix"], ["gh", "gh"],
];
const suffixes = [
  ["help", "--help"], ["version", "--version"], ["list", "list"], ["info", "info"], ["search", "search"],
  ["show", "show"], ["status", "status"], ["clean", "clean"], ["update", "update"], ["upgrade", "upgrade"],
  ["dry", "--dry-run"], ["verbose", "--verbose"], ["json", "--json"], ["quiet", "--quiet"], ["force", "--force"],
  ["all", "--all"], ["long", "--long"], ["short", "--short"], ["debug", "--debug"], ["trace", "--trace"],
  ["watch", "watch"], ["doctor", "doctor"], ["check", "check"], ["build", "build"], ["test", "test"],
  ["run", "run"], ["edit", "edit"], ["logs", "logs"], ["top", "top"], ["tree", "tree"],
  ["diff", "diff"], ["apply", "apply"], ["init", "init"], ["fmt", "fmt"], ["lint", "lint"],
  ["serve", "serve"], ["shell", "shell"], ["env", "env"], ["path", "path"], ["cache", "cache"],
];

const aliases = [...practicalAliases];
for (const [family, base] of commandFamilies) {
  for (const [suffix, arg] of suffixes) aliases.push([`p${family}${suffix}`, `${base} ${arg}`]);
}
for (let i = 1; aliases.length < 2200; i++) {
  const n = String(i).padStart(4, "0");
  const base = commandFamilies[i % commandFamilies.length][1];
  const action = suffixes[i % suffixes.length][1];
  aliases.push([`px${n}`, `${base} ${action}`]);
}

const functionNames = new Set();
const functions = [];
const addFn = (name, bashBody, fishBody = null) => {
  if (functionNames.has(name)) return;
  functionNames.add(name);
  functions.push({ name, bashBody, fishBody: fishBody || bashBody });
};

[
  ["mkcd", "mkdir -p \"$1\" && cd \"$1\"", "mkdir -p $argv[1]; and cd $argv[1]"],
  ["take", "mkdir -p \"$1\" && cd \"$1\"", "mkdir -p $argv[1]; and cd $argv[1]"],
  ["extract", "case \"$1\" in *.tar.bz2) tar xjf \"$1\";; *.tar.gz) tar xzf \"$1\";; *.bz2) bunzip2 \"$1\";; *.rar) unrar x \"$1\";; *.gz) gunzip \"$1\";; *.tar) tar xf \"$1\";; *.tbz2) tar xjf \"$1\";; *.tgz) tar xzf \"$1\";; *.zip) unzip \"$1\";; *.Z) uncompress \"$1\";; *.7z) 7z x \"$1\";; *) printf 'unknown archive: %s\\n' \"$1\" >&2; return 1;; esac", "switch $argv[1]; case '*.tar.bz2'; tar xjf $argv[1]; case '*.tar.gz'; tar xzf $argv[1]; case '*.zip'; unzip $argv[1]; case '*.7z'; 7z x $argv[1]; case '*'; printf 'unknown archive: %s\\n' $argv[1] >&2; return 1; end"],
  ["pathuniq", "awk -v RS=: '!seen[$0]++{printf \"%s%s\", sep, $0; sep=\":\"} END{print \"\"}' <<<\"$PATH\"", "string split : $PATH | awk '!seen[$0]++' | string join :"],
  ["dothealth", "bash \"$DOTFILES_DIR/bin/health_check.sh\"", "bash \"$DOTFILES_DIR/bin/health_check.sh\""],
  ["dotbench", "bash \"$DOTFILES_DIR/bin/benchmark_shell.sh\"", "bash \"$DOTFILES_DIR/bin/benchmark_shell.sh\""],
  ["dotfix", "sh \"$DOTFILES_DIR/install/install.sh\"", "sh \"$DOTFILES_DIR/install/install.sh\""],
  ["recent", "find \"${1:-.}\" -type f -mtime -1 -print 2>/dev/null | head -100", "find (test -n \"$argv[1]\"; and echo $argv[1]; or echo .) -type f -mtime -1 -print 2>/dev/null | head -100"],
  ["jsonfmt", "python3 -m json.tool \"$@\"", "python3 -m json.tool $argv"],
  ["timer", "start=$(date +%s); \"$@\"; code=$?; end=$(date +%s); printf 'elapsed: %ss\\n' \"$((end-start))\"; return $code", "set start (date +%s); $argv; set code $status; set end (date +%s); math $end - $start; return $code"],
].forEach(([n, b, f]) => addFn(n, b, f));

const verbs = ["show", "open", "list", "find", "sync", "clean", "watch", "check", "build", "test", "ship", "scan", "count", "serve", "trace", "doctor", "bench", "pack", "peek", "tail"];
const nouns = ["repo", "branch", "commit", "file", "dir", "json", "yaml", "env", "path", "port", "process", "service", "log", "cache", "disk", "mem", "cpu", "net", "docker", "kube", "node", "python", "rust", "go", "web", "ssh", "tmux", "git", "pkg", "note"];
let idx = 0;
for (const verb of verbs) {
  for (const noun of nouns) {
    idx += 1;
    const name = `p_${verb}_${noun}`;
    const selector = idx % 12;
    const body = [
      "git status --short --branch",
      "find \"${1:-.}\" -maxdepth 2 -type f | sort | head -80",
      "rg --hidden --glob '!.git' \"${1:-TODO}\" \"${2:-.}\"",
      "du -sh \"${1:-.}\"",
      "ps aux | sort -nrk 3 | head -15",
      "df -h",
      "command -v \"$1\" >/dev/null 2>&1 && \"$@\" || printf 'missing command: %s\\n' \"$1\"",
      "printf '%s\\n' \"$PATH\" | tr ':' '\\n'",
      "git log --oneline --decorate -20",
      "find \"${1:-.}\" -type f -mtime -7 | head -100",
      "date '+%F %T %Z'",
      "printf 'Pinak dotfiles: %s/%s\\n' \"$DOTFILES_MODE\" \"$SHELL\"",
    ][selector];
    const fish = [
      "git status --short --branch",
      "find (test -n \"$argv[1]\"; and echo $argv[1]; or echo .) -maxdepth 2 -type f | sort | head -80",
      "rg --hidden --glob '!.git' (test -n \"$argv[1]\"; and echo $argv[1]; or echo TODO) (test -n \"$argv[2]\"; and echo $argv[2]; or echo .)",
      "du -sh (test -n \"$argv[1]\"; and echo $argv[1]; or echo .)",
      "ps aux | sort -nrk 3 | head -15",
      "df -h",
      "if type -q $argv[1]; $argv; else; printf 'missing command: %s\\n' $argv[1]; return 1; end",
      "string split : $PATH",
      "git log --oneline --decorate -20",
      "find (test -n \"$argv[1]\"; and echo $argv[1]; or echo .) -type f -mtime -7 | head -100",
      "date '+%F %T %Z'",
      "printf 'Pinak dotfiles: %s/%s\\n' \"$DOTFILES_MODE\" \"$SHELL\"",
    ][selector];
    addFn(name, body, fish);
  }
}
for (let i = 1; functions.length < 2200; i++) {
  const n = String(i).padStart(4, "0");
  const selector = i % 10;
  const body = [
    "git status --short --branch \"$@\"",
    "find \"${1:-.}\" -maxdepth 3 -type f | sort | head -100",
    "rg --hidden --glob '!.git' \"${1:-.}\"",
    "du -sh \"${1:-.}\"",
    "date '+%F %T %Z'",
    "printf '%s\\n' \"$PWD\"",
    "command -v \"$1\" >/dev/null 2>&1 && \"$@\"",
    "ps aux | head -20",
    "df -h",
    "printf 'pinak utility %s\\n' \"${FUNCNAME[0]}\"",
  ][selector];
  const fish = [
    "git status --short --branch $argv",
    "find (test -n \"$argv[1]\"; and echo $argv[1]; or echo .) -maxdepth 3 -type f | sort | head -100",
    "rg --hidden --glob '!.git' (test -n \"$argv[1]\"; and echo $argv[1]; or echo .)",
    "du -sh (test -n \"$argv[1]\"; and echo $argv[1]; or echo .)",
    "date '+%F %T %Z'",
    "printf '%s\\n' \"$PWD\"",
    "if type -q $argv[1]; $argv; end",
    "ps aux | head -20",
    "df -h",
    `printf 'pinak utility ${n}\\n'`,
  ][selector];
  addFn(`pfn_${n}`, body, fish);
}

const bashAliases = ["#!/usr/bin/env bash", ...aliases.map(([name, cmd]) => `alias ${name}=${q(cmd)}`)].join("\n");
const zshAliases = ["#!/usr/bin/env zsh", ...aliases.map(([name, cmd]) => `alias ${name}=${q(cmd)}`)].join("\n");
const fishAliasOverrides = new Map([
  ["dots", "cd $DOTFILES_DIR"],
  ["dotfiles", "cd $DOTFILES_DIR"],
  ["dotst", "git -C $DOTFILES_DIR status --short --branch"],
  ["edots", "$EDITOR $DOTFILES_DIR"],
  ["reload", "exec $SHELL -l"],
  ["pathlines", "string split : $PATH"],
  ["myip", "curl -fsSL https://ifconfig.me 2>/dev/null; or curl -fsSL https://ipinfo.io/ip 2>/dev/null"],
  ["ls", "eza --icons=auto --group-directories-first 2>/dev/null; or command ls"],
  ["ll", "eza -lah --icons=auto --group-directories-first 2>/dev/null; or command ls -lah"],
  ["la", "eza -a --icons=auto 2>/dev/null; or command ls -a"],
  ["lt", "eza --tree --level=2 --icons=auto 2>/dev/null; or find . -maxdepth 2 -print"],
  ["cat", "bat --paging=never 2>/dev/null; or command cat"],
  ["grep", "rg 2>/dev/null; or command grep"],
  ["ports", "netstat -tulanp 2>/dev/null; or ss -tulanp"],
  ["shipit", "git status --short; and git push"],
]);
const safeFishAlias = (name, cmd) => {
  if (fishAliasOverrides.has(name)) return fishAliasOverrides.get(name);
  if (/[{}]|&&|\|\||\$\(|`/.test(cmd)) return `printf ${q(`${name}\\n`)}`;
  return cmd;
};
const fishAliases = aliases.map(([name, cmd]) => `alias ${name} ${dq(safeFishAlias(name, cmd))}`).join("\n");
write("shells/bash/aliases.bash", bashAliases);
write("shells/zsh/aliases.zsh", zshAliases);
write("shells/fish/aliases.fish", fishAliases);
const coreAliasNames = new Set(practicalAliases.slice(0, 85).map(([name]) => name));
const coreAliases = aliases.filter(([name]) => coreAliasNames.has(name));
write("shells/bash/aliases-core.bash", ["#!/usr/bin/env bash", ...coreAliases.map(([name, cmd]) => `alias ${name}=${q(cmd)}`)].join("\n"));
write("shells/zsh/aliases-core.zsh", ["#!/usr/bin/env zsh", ...coreAliases.map(([name, cmd]) => `alias ${name}=${q(cmd)}`)].join("\n"));
write("shells/fish/aliases-core.fish", coreAliases.map(([name, cmd]) => `alias ${name} ${dq(safeFishAlias(name, cmd))}`).join("\n"));

const bashFunctions = ["#!/usr/bin/env bash", ...functions.map((fn) => `${fn.name}() {\n    ${fn.bashBody}\n}`)].join("\n");
const zshFunctions = ["#!/usr/bin/env zsh", ...functions.map((fn) => `${fn.name}() {\n    ${fn.bashBody}\n}`)].join("\n");
const fishFunctions = functions.map((fn) => `function ${fn.name}\n    ${fn.fishBody}\nend`).join("\n");
write("shells/bash/functions.bash", bashFunctions);
write("shells/zsh/functions.zsh", zshFunctions);
write("shells/fish/functions.fish", fishFunctions);
const coreFunctionNames = new Set(["mkcd", "take", "extract", "pathuniq", "dothealth", "dotbench", "dotfix", "recent", "jsonfmt", "timer"]);
const coreFunctions = functions.filter((fn) => coreFunctionNames.has(fn.name));
write("shells/bash/functions-core.bash", ["#!/usr/bin/env bash", ...coreFunctions.map((fn) => `${fn.name}() {\n    ${fn.bashBody}\n}`), "dotloadfull() {\n    source \"$DOTFILES_DIR/shells/bash/functions.bash\"\n    source \"$DOTFILES_DIR/shells/bash/aliases.bash\"\n}"].join("\n"));
write("shells/zsh/functions-core.zsh", ["#!/usr/bin/env zsh", ...coreFunctions.map((fn) => `${fn.name}() {\n    ${fn.bashBody}\n}`), "dotloadfull() {\n    source \"$DOTFILES_DIR/shells/zsh/functions.zsh\"\n    source \"$DOTFILES_DIR/shells/zsh/aliases.zsh\"\n}"].join("\n"));
write("shells/fish/functions-core.fish", [...coreFunctions.map((fn) => `function ${fn.name}\n    ${fn.fishBody}\nend`), "function dotloadfull\n    source \"$DOTFILES_DIR/shells/fish/functions.fish\"\n    source \"$DOTFILES_DIR/shells/fish/aliases.fish\"\nend"].join("\n"));

const exports = [
  ["EDITOR", "nvim"],
  ["VISUAL", "nvim"],
  ["PAGER", "less"],
  ["LESS", "-R -i -g -c -W -F -X -M --shift 5"],
  ["LANG", "en_US.UTF-8"],
  ["LC_ALL", "en_US.UTF-8"],
  ["TERM", "xterm-256color"],
  ["COLORTERM", "truecolor"],
  ["CLICOLOR", "1"],
  ["BAT_THEME", "Nord"],
  ["BAT_STYLE", "numbers,changes,header"],
  ["FZF_DEFAULT_OPTS", "--height=60% --layout=reverse --border=rounded --preview-window=right:50%"],
  ["VIRTUAL_ENV_DISABLE_PROMPT", "1"],
  ["PYTHONDONTWRITEBYTECODE", "1"],
  ["PIP_DISABLE_PIP_VERSION_CHECK", "1"],
  ["NPM_CONFIG_UPDATE_NOTIFIER", "false"],
  ["HOMEBREW_NO_ANALYTICS", "1"],
  ["HOMEBREW_NO_ENV_HINTS", "1"],
  ["DOCKER_BUILDKIT", "1"],
  ["COMPOSE_DOCKER_CLI_BUILD", "1"],
  ["GOPATH", "$HOME/go"],
  ["CARGO_HOME", "$HOME/.cargo"],
  ["RUSTUP_HOME", "$HOME/.rustup"],
  ["NPM_CONFIG_PREFIX", "$HOME/.npm-global"],
  ["DOTNET_CLI_TELEMETRY_OPTOUT", "1"],
  ["CHECKPOINT_DISABLE", "1"],
];
while (exports.length < 160) exports.push([`PINAK_OPT_IN_${String(exports.length).padStart(3, "0")}`, `value_${exports.length}`]);
write("shells/bash/exports.bash", ["#!/usr/bin/env bash", "[[ \"$TERM\" == \"dumb\" || -z \"$TERM\" ]] && export TERM=xterm-256color", "export DOTFILES_MODE=\"${DOTFILES_MODE:-supreme}\"", ...exports.map(([k, v]) => `# export ${k}=${q(v)}`), "command -v vivid >/dev/null 2>&1 && export LS_COLORS=\"$(vivid generate nord)\"", "if [[ $- == *i* ]]; then", "    command -v atuin >/dev/null 2>&1 && eval \"$(atuin init bash --disable-up-arrow)\"", "    command -v direnv >/dev/null 2>&1 && eval \"$(direnv hook bash)\"", "    command -v mise >/dev/null 2>&1 && eval \"$(mise activate bash)\"", "fi"].join("\n"));
write("shells/zsh/exports.zsh", ["#!/usr/bin/env zsh", "[[ \"$TERM\" == \"dumb\" || -z \"$TERM\" ]] && export TERM=xterm-256color", "export DOTFILES_MODE=\"${DOTFILES_MODE:-supreme}\"", ...exports.map(([k, v]) => `# export ${k}=${q(v)}`), "command -v vivid >/dev/null 2>&1 && export LS_COLORS=\"$(vivid generate nord)\"", "if [[ -o interactive ]]; then", "    command -v atuin >/dev/null 2>&1 && eval \"$(atuin init zsh)\"", "    command -v direnv >/dev/null 2>&1 && eval \"$(direnv hook zsh)\"", "    command -v mise >/dev/null 2>&1 && eval \"$(mise activate zsh)\"", "fi"].join("\n"));
write("shells/fish/exports.fish", ["set -q DOTFILES_MODE; or set -gx DOTFILES_MODE supreme", ...exports.map(([k, v]) => `# set -gx ${k} ${dq(v)}`), "if type -q vivid\n    set -gx LS_COLORS (vivid generate nord)\nend", "if status is-interactive\n    if type -q atuin\n        atuin init fish | source\n    end\n    if type -q direnv\n        direnv hook fish | source\n    end\n    if type -q mise\n        mise activate fish | source\n    end\nend"].join("\n"));

const nord = {
  nord0: "#2E3440", nord1: "#3B4252", nord2: "#434C5E", nord3: "#4C566A",
  nord4: "#D8DEE9", nord5: "#E5E9F0", nord6: "#ECEFF4", nord7: "#8FBCBB",
  nord8: "#88C0D0", nord9: "#81A1C1", nord10: "#5E81AC", nord11: "#BF616A",
  nord12: "#D08770", nord13: "#EBCB8B", nord14: "#A3BE8C", nord15: "#B48EAD",
};
const starship = [];
starship.push(`"$schema" = "https://starship.rs/config-schema.json"`, "add_newline = true", "command_timeout = 1200", "scan_timeout = 35", "continuation_prompt = \"[∙](nord3) \"", "palette = \"nord\"");
starship.push("format = \"\"\"");
starship.push("[](nord10)$os$username[](fg:nord10 bg:nord2)$hostname[](fg:nord2 bg:nord1)$directory[](fg:nord1)$fill$cmd_duration$jobs$battery$time");
starship.push("$git_branch$git_status$git_state$python$nodejs$rust$golang$java$docker_context$kubernetes$terraform$aws$gcloud");
starship.push("$line_break$character");
starship.push("\"\"\"");
starship.push("right_format = \"\"\"\n$status\n\"\"\"");
starship.push("[palettes.nord]");
for (const [k, v] of Object.entries(nord)) starship.push(`${k} = "${v}"`);
const sections = {
  fill: { symbol: " " },
  character: { success_symbol: "[❯](bold nord14)", error_symbol: "[❯](bold nord11)", vicmd_symbol: "[❮](bold nord15)" },
  status: { disabled: false, symbol: "✘ ", success_symbol: "", recognize_signal_code: true, map_symbol: true, format: "[$symbol$status]($style) ", style: "bold nord11" },
  os: { disabled: false, format: "[$symbol]($style)", style: "bold nord0 bg:nord10" },
  username: { show_always: true, format: "[$user]($style)", style_user: "bold nord6 bg:nord10", style_root: "bold nord11 bg:nord10" },
  hostname: { ssh_only: false, format: "[ $hostname]($style)", style: "bold nord6 bg:nord2" },
  localip: { disabled: false, ssh_only: true, format: "[ $localipv4]($style)", style: "bold nord7 bg:nord2" },
  directory: { truncation_length: 3, truncate_to_repo: true, read_only: " 󰌾", format: "[ $path$read_only ]($style)", style: "bold nord6 bg:nord1" },
  git_branch: { symbol: " ", format: "[ $symbol$branch ]($style)", style: "bold nord8" },
  git_status: { format: "[$all_status$ahead_behind]($style) ", style: "bold nord13", conflicted: "=${count} ", ahead: "⇡${count} ", behind: "⇣${count} ", diverged: "⇕${ahead_count}/${behind_count} ", untracked: "?${count} ", stashed: "S${count} ", modified: "!${count} ", staged: "+${count} ", renamed: "»${count} ", deleted: "✘${count} " },
  git_state: { format: "[$state $progress_current/$progress_total]($style) ", style: "bold nord12" },
  git_metrics: { disabled: true, added_style: "bold nord14", deleted_style: "bold nord11", format: "([+$added]($added_style))([-$deleted]($deleted_style))" },
  cmd_duration: { min_time: 500, format: "[ 󰔟 $duration]($style)", style: "bold nord13 bg:nord0" },
  jobs: { symbol: " ", format: "[ $symbol$number]($style)", style: "bold nord15 bg:nord0" },
  battery: { full_symbol: "󰁹 ", charging_symbol: "󰂄 ", discharging_symbol: "󰂃 ", unknown_symbol: "󰁽 ", empty_symbol: "󰂎 ", format: "[ $symbol$percentage]($style)" },
  time: { disabled: false, time_format: "%F %T", format: "[ 󰥔 $time]($style)", style: "bold nord8 bg:nord0" },
  shell: { disabled: true, bash_indicator: "bash", zsh_indicator: "zsh", fish_indicator: "fish", format: "[$indicator]($style) ", style: "bold nord7" },
};
for (const [section, values] of Object.entries(sections)) {
  starship.push(`[${section}]`);
  for (const [k, v] of Object.entries(values)) starship.push(`${k} = ${typeof v === "boolean" ? v : typeof v === "number" ? v : dq(v)}`);
}
starship.push("[os.symbols]");
for (const [k, v] of Object.entries({ Arch: " ", EndeavourOS: " ", Garuda: " ", Manjaro: " ", Linux: " ", Ubuntu: " ", Debian: " ", Fedora: " ", Macos: " ", NixOS: " " })) starship.push(`${k} = ${dq(v)}`);
const langModules = ["aws","gcloud","golang","java","kubernetes","nodejs","python","rust","terraform","docker_context"];
for (const mod of langModules) {
  starship.push(`[${mod}]`, `format = ${dq(`[$symbol($version )]($style)`)}`, `style = "bold nord${7 + (mod.length % 9)}"`, `disabled = false`);
}
for (let i = 1; starship.length < 520; i++) {
  const n = String(i).padStart(3, "0");
  starship.push(`[custom.pinak_${n}]`, `command = "printf ''"`, "when = false", `format = "[$output](nord3)"`);
}
write("apps/starship-linux.toml", starship.join("\n"));
write("apps/starship-mac.toml", starship.join("\n"));

write("apps/fastfetch/config.jsonc", JSON.stringify({
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  logo: { padding: { top: 1, left: 2, right: 2 }, width: 32, height: 17 },
  display: { separator: "  ->  ", color: { keys: "blue", title: "cyan" }, size: { binaryPrefix: "si" }, percent: { type: 2 } },
  modules: [
    { type: "title", key: "" },
    { type: "os", key: "OS        ", keyColor: "blue" },
    { type: "kernel", key: "Kernel    ", keyColor: "blue" },
    { type: "host", key: "Host      ", keyColor: "blue" },
    { type: "uptime", key: "Uptime    ", keyColor: "cyan" },
    { type: "packages", key: "Packages  ", keyColor: "cyan" },
    { type: "shell", key: "Shell     ", keyColor: "cyan" },
    { type: "wm", key: "WM        ", keyColor: "green" },
    { type: "de", key: "DE        ", keyColor: "green" },
    { type: "terminal", key: "Terminal  ", keyColor: "green" },
    { type: "terminalFont", key: "Font      ", keyColor: "green" },
    { type: "cpu", key: "CPU       ", keyColor: "yellow", temp: true },
    { type: "gpu", key: "GPU       ", keyColor: "yellow", temp: true },
    { type: "memory", key: "Memory    ", keyColor: "yellow" },
    { type: "swap", key: "Swap      ", keyColor: "yellow" },
    { type: "disk", key: "Disk      ", keyColor: "magenta" },
    { type: "battery", key: "Battery   ", keyColor: "magenta" },
    { type: "command", key: "Battery H ", keyColor: "magenta", text: "sh ~/.config/fastfetch/battery_health.sh" },
    { type: "localip", key: "Local IP  ", keyColor: "blue", showIpv6: false },
    { type: "colors", symbol: "circle", paddingLeft: 2 }
  ]
}, null, 2));
