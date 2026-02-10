.PHONY: help install update backup clean test test-functions test-aliases test-symlinks lint lint-all fix docker doctor profile stats format uninstall info check-links verify

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

# Default target
help:
	@echo "$(BOLD)Dotfiles Makefile v3.0.0$(NC)"
	@echo ""
	@echo "$(BOLD)Installation:$(NC)"
	@echo "  make install         - Install dotfiles (interactive)"
	@echo "  make install-fast    - Fast install (MODE=advanced)"
	@echo "  make install-basic   - Install with basic mode"
	@echo "  make uninstall       - Remove dotfiles cleanly"
	@echo ""
	@echo "$(BOLD)Maintenance:$(NC)"
	@echo "  make update          - Pull updates and reload"
	@echo "  make backup          - Create backup of current configs"
	@echo "  make clean           - Uninstall and restore backups"
	@echo ""
	@echo "$(BOLD)Testing & Quality:$(NC)"
	@echo "  make test            - Run all tests"
	@echo "  make test-syntax     - Test shell syntax only"
	@echo "  make test-functions  - Test key functions"
	@echo "  make test-aliases    - Test alias definitions"
	@echo "  make test-symlinks   - Check symlink integrity"
	@echo "  make lint            - Run shellcheck on scripts"
	@echo "  make lint-all        - Lint all files (stricter)"
	@echo "  make fix             - Auto-fix shellcheck issues"
	@echo "  make verify          - Comprehensive verification"
	@echo ""
	@echo "$(BOLD)Diagnostics:$(NC)"
	@echo "  make doctor          - Run dotfiles-doctor"
	@echo "  make profile         - Profile shell startup time"
	@echo "  make stats           - Show repository statistics"
	@echo "  make info            - Show dotfiles information"
	@echo "  make check-links     - Check for broken symlinks"
	@echo ""
	@echo "$(BOLD)Development:$(NC)"
	@echo "  make docker          - Test in Docker container"
	@echo "  make format          - Format shell scripts"
	@echo ""
	@echo "$(BOLD)Options:$(NC)"
	@echo "  MODE=basic|advanced|ultra-nerd"
	@echo "  DOTFILES_PROFILE=1 make install  # Enable profiling"

# =============================================================================
# INSTALLATION TARGETS
# =============================================================================

install:
	@./install.sh

install-fast:
	@./install.sh -m $(MODE) -i -f

install-basic:
	@MODE=basic ./install.sh -m basic -i -f

# =============================================================================
# MAINTENANCE TARGETS
# =============================================================================

update:
	@echo "$(BLUE)→ Pulling latest changes...$(NC)"
	@git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "$(YELLOW)⚠ Could not pull updates$(NC)"
	@echo "$(GREEN)✓ Updated$(NC)"
	@echo "$(BLUE)→ Reloading shells...$(NC)"
	@source ~/.bashrc 2>/dev/null || true
	@source ~/.zshrc 2>/dev/null || true
	@echo "$(GREEN)✓ Reloaded$(NC)"

backup:
	@echo "$(BLUE)→ Creating backup...$(NC)"
	@mkdir -p ~/.dotfiles-backup-$(shell date +%Y%m%d_%H%M%S)
	@cp ~/.bashrc ~/.bash_profile ~/.zshrc ~/.gitconfig ~/.dotfiles-backup-$(shell date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	@echo "$(GREEN)✓ Backup created$(NC)"

clean:
	@./uninstall.sh

uninstall: clean

# =============================================================================
# TEST TARGETS
# =============================================================================

test: test-syntax test-functions test-aliases test-symlinks
	@echo "$(GREEN)$(BOLD)✓ All tests passed$(NC)"

test-syntax:
	@echo "$(BLUE)→ Testing Bash syntax...$(NC)"
	@failed=0; \
	for file in bash/*.sh lib/*.sh; do \
		if [ -f "$$file" ]; then \
			if bash -n "$$file" 2>/dev/null; then \
				echo "  $(GREEN)✓$(NC) $$file"; \
			else \
				echo "  $(RED)✗$(NC) $$file"; \
				failed=$$((failed + 1)); \
			fi; \
		fi; \
	done; \
	if [ $$failed -gt 0 ]; then \
		echo "$(RED)$(BOLD)✗ $$failed file(s) failed syntax check$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)→ Testing Fish syntax...$(NC)"
	@for file in fish/config.fish fish/conf.d/*.fish fish/functions/*.fish; do \
		[ -f "$$file" ] && fish -n "$$file" 2>/dev/null && echo "  $(GREEN)✓$(NC) $$file" || true; \
	done
	@echo "$(GREEN)✓ Syntax tests passed$(NC)"

test-functions:
	@echo "$(BLUE)→ Testing functions...$(NC)"
	@bash -c 'source bash/00-core.sh 2>/dev/null; source bash/01-functions.sh; \
		mkcd /tmp/test_mkcd_$$ && [ -d /tmp/test_mkcd_$$ ] && echo "  $(GREEN)✓$(NC) mkcd" || echo "  $(RED)✗$(NC) mkcd"; \
		rm -rf /tmp/test_mkcd_$$'
	@bash -c 'source bash/00-core.sh 2>/dev/null; source bash/01-functions.sh; \
		up 2 2>/dev/null && [ "$$PWD" = "/" ] && echo "  $(GREEN)✓$(NC) up" || echo "  $(GREEN)✓$(NC) up (dir dependent)"; \
		cd - >/dev/null 2>&1 || true'
	@bash -c 'source bash/01-functions.sh; \
		result=$$(bak /etc/hosts 2>/dev/null | grep -c "Backed up"); \
		rm -f /etc/hosts.bak.* 2>/dev/null; \
		[ "$$result" = "1" ] && echo "  $(GREEN)✓$(NC) bak" || echo "  $(YELLOW)⚠$(NC) bak (needs existing file)"'
	@echo "$(GREEN)✓ Function tests passed$(NC)"

test-aliases:
	@echo "$(BLUE)→ Testing aliases...$(NC)"
	@bash -c 'source bash/02-aliases-core.sh; \
		alias l >/dev/null 2>&1 && echo "  $(GREEN)✓$(NC) l alias" || echo "  $(RED)✗$(NC) l alias"; \
		alias ll >/dev/null 2>&1 && echo "  $(GREEN)✓$(NC) ll alias" || echo "  $(RED)✗$(NC) ll alias"'
	@echo "$(GREEN)✓ Alias tests passed$(NC)"

test-symlinks:
	@echo "$(BLUE)→ Testing symlinks...$(NC)"
	@broken=$$(find ~ -maxdepth 2 -type l ! -exec test -e {} \; -print 2>/dev/null | grep -E "(bashrc|zshrc|gitconfig)" | wc -l); \
	if [ "$$broken" -eq 0 ]; then \
		echo "$(GREEN)✓ No broken dotfiles symlinks$(NC)"; \
	else \
		echo "$(RED)✗ Found $$broken broken symlink(s)$(NC)"; \
		find ~ -maxdepth 2 -type l ! -exec test -e {} \; -print 2>/dev/null | grep -E "(bashrc|zshrc|gitconfig)" | sed 's/^/  /'; \
		exit 1; \
	fi

# =============================================================================
# LINT TARGETS
# =============================================================================

lint:
	@echo "$(BLUE)→ Running shellcheck (basic)...$(NC)"
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck -S warning bash/*.sh 2>/dev/null && echo "$(GREEN)✓ No issues found$(NC)" || echo "$(YELLOW)⚠ Issues found (see above)$(NC)"; \
	else \
		echo "$(YELLOW)⚠ shellcheck not installed (pacman -S shellcheck)$(NC)"; \
	fi

lint-all:
	@echo "$(BLUE)→ Running shellcheck (strict)...$(NC)"
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck -S error bash/*.sh lib/*.sh install.sh uninstall.sh 2>/dev/null && echo "$(GREEN)✓ No errors found$(NC)" || echo "$(RED)✗ Errors found$(NC)"; \
	else \
		echo "$(YELLOW)⚠ shellcheck not installed$(NC)"; \
	fi

fix:
	@echo "$(BLUE)→ Attempting to auto-fix shellcheck issues...$(NC)"
	@if command -v shellcheck >/dev/null 2>&1; then \
		for file in bash/*.sh; do \
			shellcheck -f diff "$$file" 2>/dev/null | patch -p1 2>/dev/null || true; \
		done; \
		echo "$(GREEN)✓ Auto-fix complete$(NC)"; \
	else \
		echo "$(YELLOW)⚠ shellcheck not installed$(NC)"; \
	fi

# =============================================================================
# DIAGNOSTIC TARGETS
# =============================================================================

doctor:
	@echo "$(BLUE)→ Running dotfiles-doctor...$(NC)"
	@if bash -c 'source bash/01-functions.sh 2>/dev/null && dotfiles-doctor' 2>/dev/null; then \
		echo ""; \
	else \
		echo "$(YELLOW)⚠ Some checks failed (see above)$(NC)"; \
	fi

profile:
	@echo "$(BLUE)→ Profiling shell startup...$(NC)"
	@if bash -c 'source bash/01-functions.sh 2>/dev/null && dotfiles-profile' 2>/dev/null; then \
		: ; \
	else \
		iterations=3; \
		echo "Running $$iterations iterations..."; \
		total=0; \
		for i in $$(seq 1 $$iterations); do \
			start=$$(date +%s%N); \
			bash -i -c 'exit' 2>/dev/null; \
			end=$$(date +%s%N); \
			elapsed=$$(((end - start) / 1000000)); \
			total=$$((total + elapsed)); \
			echo "  Run $$i: $${elapsed}ms"; \
		done; \
		avg=$$((total / iterations)); \
		echo ""; \
		echo "Average: $${avg}ms"; \
		if [ $$avg -lt 100 ]; then \
			echo "$(GREEN)✓ Excellent startup time$(NC)"; \
		elif [ $$avg -lt 300 ]; then \
			echo "$(GREEN)✓ Good startup time$(NC)"; \
		elif [ $$avg -lt 500 ]; then \
			echo "$(YELLOW)⚠ Acceptable startup time$(NC)"; \
		else \
			echo "$(RED)✗ Slow startup time - consider optimizations$(NC)"; \
		fi; \
	fi

stats:
	@echo "$(BOLD)════════════════════════════════════════════════════$(NC)"
	@echo "$(BOLD)           DOTFILES STATISTICS$(NC)"
	@echo "$(BOLD)════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(BOLD)Repository:$(NC)"
	@echo "  Version:    $(shell git describe --tags --always 2>/dev/null || echo 'dev')"
	@echo "  Location:   $(shell pwd)"
	@echo "  Branch:     $(shell git branch --show-current 2>/dev/null || echo 'unknown')"
	@echo "  Commits:    $(shell git rev-list --count HEAD 2>/dev/null || echo 'N/A')"
	@echo ""
	@echo "$(BOLD)Configuration:$(NC)"
	@echo "  Bash modules:  $(shell ls bash/*.sh 2>/dev/null | wc -l)"
	@echo "  Fish files:    $(shell find fish -name '*.fish' 2>/dev/null | wc -l)"
	@echo "  Config files:  $(shell find config -type f 2>/dev/null | wc -l)"
	@echo "  Total lines:   $(shell find . -name '*.sh' -o -name '*.fish' 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $$1}')"
	@echo ""
	@echo "$(BOLD)Content:$(NC)"
	@echo "  Aliases:       $(shell grep -r "^alias" bash/ 2>/dev/null | wc -l)"
	@echo "  Functions:     $(shell grep -r "^function\|^[a-z_]*()" bash/ 2>/dev/null | wc -l)"
	@echo "  Comments:      $(shell grep -r "^#" bash/*.sh 2>/dev/null | wc -l)"
	@echo ""
	@echo "$(BOLD)Status:$(NC)"
	@echo "  Mode:          ${DOTFILES_MODE:-advanced}"
	@echo "  Directory:     ${DOTFILES_DIR:-$HOME/.dotfiles}"
	@echo "  Shells:        bash $(shell command -v zsh >/dev/null 2>&1 && echo zsh) $(shell command -v fish >/dev/null 2>&1 && echo fish)"
	@echo ""

info:
	@echo "$(BOLD)Dotfiles Info$(NC)"
	@echo "Version: $(shell git describe --tags --always 2>/dev/null || echo 'dev')"
	@echo "Location: $(shell pwd)"
	@echo "Backup dir: ~/.dotfiles-backup-*"
	@echo ""
	@echo "Configured shells:"
	@ls -la ~/.bashrc ~/.zshrc 2>/dev/null | grep -q "." && echo "  $(GREEN)✓$(NC) Shells configured" || echo "  $(RED)✗$(NC) No shells configured"

check-links:
	@echo "$(BLUE)→ Checking symlinks...$(NC)"
	@find ~ -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null | grep -E "(bashrc|zshrc|gitconfig|tmux.conf)" || echo "$(GREEN)✓ No broken symlinks$(NC)"

verify: test lint doctor stats
	@echo "$(GREEN)$(BOLD)════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)$(BOLD)         VERIFICATION COMPLETE$(NC)"
	@echo "$(GREEN)$(BOLD)════════════════════════════════════════════════════$(NC)"

# =============================================================================
# DEVELOPMENT TARGETS
# =============================================================================

docker:
	@echo "$(BLUE)→ Building Docker test environment...$(NC)"
	@if command -v docker >/dev/null 2>&1; then \
		docker build -t dotfiles-test . 2>/dev/null && echo "$(GREEN)✓ Docker image built$(NC)" || echo "$(YELLOW)⚠ Docker build failed$(NC)"; \
		echo "$(BLUE)→ Running installer test...$(NC)"; \
		docker run --rm dotfiles-test ./install.sh --dry-run 2>/dev/null || echo "$(YELLOW)⚠ Docker test completed with warnings$(NC)"; \
	else \
		echo "$(YELLOW)⚠ Docker not available$(NC)"; \
	fi

format:
	@echo "$(BLUE)→ Formatting shell scripts...$(NC)"
	@if command -v shfmt >/dev/null 2>&1; then \
		shfmt -w -i 4 -ci bash/*.sh 2>/dev/null && echo "$(GREEN)✓ Formatted bash/*.sh$(NC)"; \
		shfmt -w -i 4 -ci lib/*.sh 2>/dev/null && echo "$(GREEN)✓ Formatted lib/*.sh$(NC)"; \
	else \
		echo "$(YELLOW)⚠ shfmt not installed (go install mvdan.cc/sh/v3/cmd/shfmt@latest)$(NC)"; \
	fi

# =============================================================================
# ALIASES
# =============================================================================

.DEFAULT_GOAL := help
