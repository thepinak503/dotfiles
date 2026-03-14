# Dotfiles v4.0.0

## Installation

```bash
curl -fsSL https://is.gd/install_dotfiles | sh
```

With dependencies:
```bash
curl -fsSL https://is.gd/install_dotfiles | sh -s -- --install-deps
```

## Shells

| Shell | Config |
|-------|--------|
| Bash | `.bashrc` |
| Zsh | `.zshrc` |
| Fish | `config.fish` |

## Modes

```bash
export DOTFILES_MODE=basic       # Minimal
export DOTFILES_MODE=advanced   # Default
export DOTFILES_MODE=ultra-nerd # Max productivity
```

## Features

- ✅ Modern CLI (eza, bat, starship, zoxide, fzf)
- ✅ Fastfetch on all shells
- ✅ Auto-update system
- ✅ No errors

## Commands

```bash
install-shells    # Install modern tools
dotfiles-update   # Update dotfiles
dotfiles-status   # Check git status
```

## Structure

```
.bash/     # Bash configs
.zsh/      # Zsh configs
.fish/     # Fish configs
scripts/   # Helper scripts
config/    # App configs
```

---

**Version:** 4.0.0 ✅
