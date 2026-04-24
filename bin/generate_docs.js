#!/usr/bin/env node
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const root = path.dirname(path.dirname(__filename));
const docs = path.join(root, "docs");
const read = (p) => fs.readFileSync(path.join(root, p), "utf8");
const count = (p, re) => (read(p).match(re) || []).length;
const stat = {
  bashAliases: count("shells/bash/aliases.bash", /^alias /gm),
  zshAliases: count("shells/zsh/aliases.zsh", /^alias /gm),
  fishAliases: count("shells/fish/aliases.fish", /^alias /gm),
  bashFunctions: count("shells/bash/functions.bash", /^[A-Za-z0-9_]+[A-Za-z0-9_]*\(\) \{/gm),
  zshFunctions: count("shells/zsh/functions.zsh", /^[A-Za-z0-9_]+[A-Za-z0-9_]*\(\) \{/gm),
  fishFunctions: count("shells/fish/functions.fish", /^function /gm),
  starshipLines: read("apps/starship-linux.toml").split("\n").length,
};

const nav = [
  ["index.html", "Main Page"],
  ["install.html", "Installation"],
  ["architecture.html", "Architecture"],
  ["bash.html", "Bash"],
  ["zsh.html", "Zsh"],
  ["fish.html", "Fish"],
  ["starship.html", "Starship"],
  ["fastfetch.html", "Fastfetch"],
  ["performance.html", "Performance"],
  ["features.html", "Feature Matrix"],
  ["reference.html", "Reference"],
  ["diagnostics.html", "Diagnostics"],
  ["faq.html", "FAQ"],
];

const page = (file, title, body) => {
  const links = nav.map(([href, label]) => `<a href="${href}" class="${href === file ? "active" : ""}">${label}</a>`).join("");
  fs.writeFileSync(path.join(docs, file), `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title} - Pinak's Dotfiles</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<aside>
<div class="brand">Pinak's Dotfiles</div>
<nav>${links}</nav>
<div class="meta">v12.1.0<br>Arch-style manual</div>
</aside>
<main>
<header class="top"><span>Manual</span><h1>${title}</h1></header>
${body}
</main>
</body>
</html>
`);
};

const code = (s) => `<pre><code>${s.replace(/&/g, "&amp;").replace(/</g, "&lt;")}</code></pre>`;
const table = (rows) => `<table><tbody>${rows.map((r) => `<tr><th>${r[0]}</th><td>${r[1]}</td></tr>`).join("")}</tbody></table>`;
const section = (title, body) => `<section><h2>${title}</h2>${body}</section>`;
const list = (items) => `<ul>${items.map((x) => `<li>${x}</li>`).join("")}</ul>`;

page("index.html", "Main Page", `
${section("Overview", `<p>Pinak's Dotfiles is a modular shell and terminal environment for Arch Linux, Arch-based systems, other Linux distributions, and macOS. It keeps the repository at <code>~/.dotfiles</code>, links files into their runtime locations, and supports Bash, Zsh, and Fish from one coherent layout.</p>`)}
<div class="grid">
<div class="box"><strong>${stat.bashAliases}</strong><span>Bash aliases</span></div>
<div class="box"><strong>${stat.zshAliases}</strong><span>Zsh aliases</span></div>
<div class="box"><strong>${stat.fishAliases}</strong><span>Fish aliases</span></div>
<div class="box"><strong>${stat.starshipLines}</strong><span>Starship lines</span></div>
</div>
${section("Quick Start", code(`curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | sh
exec "$SHELL" -l`))}
${section("Default Behavior", list([
  "Fast startup path loads core aliases and functions only.",
  "Full 2200-item libraries remain available through <code>dotloadfull</code> or <code>DOTFILES_LOAD_FULL=1</code>.",
  "Fastfetch runs at startup by default and can be disabled with <code>DOTFILES_FASTFETCH_ON_STARTUP=0</code>.",
  "Starship uses a compact Nord prompt with clear Git, directory, runtime, battery, and time segments."
]))}`);

page("install.html", "Installation", `
${section("Supported Systems", table([
  ["Primary target", "Arch Linux, EndeavourOS, Manjaro, Garuda, CachyOS, and related pacman systems"],
  ["Secondary targets", "Debian/Ubuntu, Fedora, openSUSE, Alpine, Void, generic Linux"],
  ["macOS", "Supported through Homebrew and the macOS Starship profile"]
]))}
${section("Bootstrap", code(`curl -fsSL https://raw.githubusercontent.com/thepinak503/dotfiles/main/install.sh | sh`))}
${section("Manual Install", code(`git clone https://github.com/thepinak503/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh install.sh`))}
${section("Linked Paths", table([
  ["Bash", "<code>~/.bashrc</code>"],
  ["Zsh", "<code>~/.zshrc</code>, <code>~/.zprofile</code>"],
  ["Fish", "<code>~/.config/fish/config.fish</code>"],
  ["Starship", "<code>~/.config/starship.toml</code>"],
  ["Fastfetch", "<code>~/.config/fastfetch/config.jsonc</code>"],
  ["Git", "<code>~/.gitconfig</code>"]
]))}`);

page("architecture.html", "Architecture", `
${section("Repository Layout", table([
  ["<code>shells/</code>", "Bash, Zsh, Fish entry points, core libraries, full catalogs, and modes"],
  ["<code>core/</code>", "Shared detection, tool, battery, SSH, and logging helpers"],
  ["<code>apps/</code>", "External application configs for Starship, Fastfetch, Git, Tmux, Lazygit, Atuin, and Brew"],
  ["<code>bin/</code>", "Generators, diagnostics, benchmarks, update helpers, and docs tooling"],
  ["<code>install/</code>", "Installer and uninstaller"]
]))}
${section("Generated Assets", `<p><code>bin/generate_assets.js</code> owns the large synchronized shell catalogs and prompt configs. Edit the generator first, then regenerate.</p>${code("node bin/generate_assets.js")}`)}
${section("Modes", table([
  ["minimal", "SSH-safe and low noise"],
  ["standard", "Balanced daily interactive shell"],
  ["supreme", "Default feature set"],
  ["ultra-nerd", "Maximum opt-in surface area"]
]))}`);

page("bash.html", "Bash", `
${section("Startup Path", list([
  "Resolves <code>DOTFILES_DIR</code> from the symlink target.",
  "Loads shared system detection and tool helpers.",
  "Loads <code>exports.bash</code> and core aliases/functions by default.",
  "Initializes Starship if available.",
  "Skips Fastfetch and updater unless explicitly enabled."
]))}
${section("Full Library", code(`dotloadfull
DOTFILES_LOAD_FULL=1 exec bash`))}
${section("Validation", code(`bash -n shells/bash/.bashrc
bash -c ". shells/bash/aliases-core.bash; . shells/bash/functions-core.bash; type mkcd"`))}`);

page("zsh.html", "Zsh", `
${section("Startup Path", list([
  "Uses native Zsh path resolution and completion setup.",
  "Loads syntax and autosuggestion plugins when installed.",
  "Uses core generated libraries by default.",
  "Keeps full generated catalogs available through <code>dotloadfull</code>."
]))}
${section("Completion", `<p>The configuration uses <code>compinit -C</code> when possible to avoid unnecessary completion cache rebuilds.</p>`)}
${section("Validation", code(`zsh -n shells/zsh/.zshrc
zsh -c ". shells/zsh/aliases-core.zsh; . shells/zsh/functions-core.zsh; whence -w mkcd"`))}`);

page("fish.html", "Fish", `
${section("Startup Path", list([
  "Keeps the greeting disabled.",
  "Loads core generated aliases/functions by default.",
  "Avoids creating thousands of Fish alias functions unless the full library is requested.",
  "Initializes Starship and Zoxide when installed."
]))}
${section("Full Library", code(`dotloadfull
set -gx DOTFILES_LOAD_FULL 1
exec fish`))}
${section("Validation", code(`fish --no-execute shells/fish/config.fish
fish -c "source shells/fish/functions-core.fish; functions -q mkcd"`))}`);

page("starship.html", "Starship", `
${section("Prompt Design", `<p>The prompt is a compact Nord layout: OS and user, host, directory, right-side duration/jobs/battery/time, second-line Git and language context, then a clean prompt character.</p>`)}
${section("Performance", list([
  "No always-on custom shell commands in the default format.",
  "Git metrics are disabled because they are expensive in large repositories.",
  "Command timeout and scan timeout are bounded.",
  "Date and time include seconds using <code>%F %T</code>."
]))}
${section("Render Test", code(`STARSHIP_CACHE=/tmp/starship-cache STARSHIP_CONFIG=apps/starship-linux.toml starship prompt`))}`);

page("fastfetch.html", "Fastfetch", `
${section("Config", `<p>Fastfetch is configured for a clean system summary with battery health when a battery is detected. It runs on shell startup by default. Set <code>DOTFILES_FASTFETCH_ON_STARTUP=0</code> to disable it for faster terminal tabs.</p>`)}
${section("Manual Run", code(`fastfetch --config ~/.config/fastfetch/config.jsonc`))}
${section("Battery Health", `<p>The helper reads Linux power supply data and exits quietly on desktops or systems without a battery.</p>`)}`);

page("performance.html", "Performance", `
${section("Startup Policy", table([
  ["Default", "Core aliases/functions only"],
  ["Full catalog", "<code>dotloadfull</code> or <code>DOTFILES_LOAD_FULL=1</code>"],
  ["Fastfetch", "enabled by default; disable with <code>DOTFILES_FASTFETCH_ON_STARTUP=0</code>"],
  ["Updater", "<code>DOTFILES_AUTO_UPDATE=1</code>"],
  ["Starship", "Compact prompt without always-on custom command modules"]
]))}
${section("Benchmark", code(`for i in 1 2 3; do zsh -c 'zmodload zsh/datetime; s=$EPOCHREALTIME; zsh -i -c exit >/dev/null 2>&1; e=$EPOCHREALTIME; printf "zsh %.3f\\n" $(( e - s ))'; done`))}
${section("Tuning", list([
  "Keep <code>DOTFILES_LOAD_FULL</code> unset for daily shells.",
  "Run <code>dotloadfull</code> only in sessions where the large generated catalog is useful.",
  "Set <code>DOTFILES_FASTFETCH_ON_STARTUP=0</code> on machines where terminal tab creation speed matters more than the startup summary.",
  "Use <code>minimal</code> mode on remote hosts."
]))}`);

page("features.html", "Feature Matrix", `
${section("Shell Surface", table([
  ["Core startup", "Small daily-use alias/function layer for fast new terminals"],
  ["Full generated layer", "2200 aliases and 2200 functions per shell available on demand"],
  ["Cross-shell parity", "Bash, Zsh, and Fish are generated from the same source catalog"],
  ["Mode system", "Minimal, standard, supreme, and ultra-nerd layers"]
]))}
${section("Terminal Tools", table([
  ["Starship", "Nord prompt, compact segments, seconds in clock, bounded scanning"],
  ["Fastfetch", "Manual or opt-in startup system summary with battery health"],
  ["Zoxide", "Loaded when installed"],
  ["Atuin, Direnv, Mise", "Interactive hooks guarded to avoid non-interactive failures"]
]))}
${section("Maintenance", table([
  ["Generators", "<code>generate_assets.js</code> and <code>generate_docs.js</code>"],
  ["Tests", "<code>test_repo.sh</code> and <code>test_all.sh --fast</code>"],
  ["Repair", "<code>dotfix</code> relinks and validates configs"],
  ["Full library", "<code>dotloadfull</code> loads the large catalogs in the current session"]
]))}`);

page("reference.html", "Reference", `
${section("Counts", table([
  ["Bash aliases", String(stat.bashAliases)],
  ["Zsh aliases", String(stat.zshAliases)],
  ["Fish aliases", String(stat.fishAliases)],
  ["Bash functions", String(stat.bashFunctions)],
  ["Zsh functions", String(stat.zshFunctions)],
  ["Fish functions", String(stat.fishFunctions)]
]))}
${section("Core Commands", table([
  ["<code>mkcd DIR</code>", "Create a directory and enter it"],
  ["<code>take DIR</code>", "Alias-style helper for creating and entering a directory"],
  ["<code>extract FILE</code>", "Extract common archive formats"],
  ["<code>dothealth</code>", "Run the health checker"],
  ["<code>dotbench</code>", "Run shell startup benchmarks"],
  ["<code>dotfix</code>", "Re-run the installer and relink configs"],
  ["<code>dotloadfull</code>", "Load the full generated alias/function library in the current shell"]
]))}`);

page("diagnostics.html", "Diagnostics", `
${section("Test Suite", code(`bash bin/test_repo.sh
bash bin/test_all.sh --fast
git diff --check`))}
${section("Installer Checks", `<p>The installer validates shell behavior through <code>bash -c</code>, <code>zsh -c</code>, and <code>fish -c</code> when those shells are installed.</p>`)}
${section("Common Files", table([
  ["Errors", "<code>$DOTFILES_STATE_DIR/errors.log</code>"],
  ["Mode", "<code>$DOTFILES_STATE_DIR/mode</code>"],
  ["Install date", "<code>$DOTFILES_STATE_DIR/install_date</code>"]
]))}`);

page("faq.html", "FAQ", `
${section("Can This Be Best-In-Class?", `<p>For a personal dotfiles repository, yes: it is modular, generated where large catalogs would otherwise drift, validated across shells, and optimized for fast default startup. It is not universally best for every user because terminals, fonts, policies, and package managers differ.</p>`)}
${section("Why Does Bash Sometimes Miss Starship?", `<p>Bash only reads <code>~/.bashrc</code> for interactive non-login shells. Login shells may read <code>~/.bash_profile</code>, <code>~/.bash_login</code>, or <code>~/.profile</code>. Source <code>~/.bashrc</code> from the login file and ensure <code>starship</code> is installed on <code>PATH</code>.</p>`)}
${section("Are All Commands Distro-Agnostic?", `<p>No large shell catalog is perfectly distro-agnostic. The default startup path is conservative, but package-manager commands, Linux-only paths, Docker/Kubernetes helpers, and GNU/BSD differences can still require local adjustment.</p>`)}`);

fs.writeFileSync(path.join(docs, "style.css"), `:root{--bg:#f6f7f9;--panel:#fff;--text:#20242c;--muted:#5d6675;--line:#d8dee9;--blue:#33658a;--blue2:#2f5575;--code:#eef2f6;--warn:#8a5a00;--green:#3a6b35}*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--text);font:15px/1.6 system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;display:flex}aside{width:270px;background:#eaedf2;border-right:1px solid var(--line);min-height:100vh;position:fixed;padding:22px 18px}.brand{font-size:22px;font-weight:700;color:var(--blue2);margin-bottom:18px}nav{display:flex;flex-direction:column;gap:2px}nav a{color:#263241;text-decoration:none;padding:7px 9px;border-radius:3px}nav a:hover,nav a.active{background:#d8dee9;color:#111820}.meta{color:var(--muted);font-size:12px;margin-top:24px;border-top:1px solid var(--line);padding-top:14px}main{margin-left:270px;max-width:1120px;padding:34px 44px 80px;width:100%}.top{border-bottom:1px solid var(--line);margin-bottom:24px}.top span{font-size:12px;text-transform:uppercase;color:var(--muted);letter-spacing:.08em}.top h1{font-size:34px;margin:4px 0 18px;color:#111820}section{background:var(--panel);border:1px solid var(--line);padding:22px;margin:0 0 18px;border-radius:4px}h2{font-size:22px;margin:0 0 12px;color:var(--blue2)}p{margin:0 0 12px}code{background:var(--code);padding:1px 5px;border-radius:3px;font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace}pre{background:#1f2937;color:#e5e7eb;border-radius:4px;padding:16px;overflow:auto}pre code{background:transparent;color:inherit;padding:0}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:12px;margin:16px 0}.box{background:#eef2f6;border:1px solid var(--line);padding:16px;border-radius:4px}.box strong{display:block;font-size:28px;color:var(--blue)}.box span{color:var(--muted)}table{width:100%;border-collapse:collapse;margin-top:8px}th,td{border:1px solid var(--line);padding:10px;text-align:left;vertical-align:top}th{width:220px;background:#f0f3f7}ul{margin:0;padding-left:22px}@media(max-width:800px){body{display:block}aside{position:static;width:auto;min-height:0}main{margin:0;padding:22px}}`);
