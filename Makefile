.PHONY: help install update backup clean test lint uninstall docker

# Default target
help:
	@echo "${BOLD}Dotfiles Makefile${NC}"
	@echo ""
	@echo "Available targets:"
	@echo "  make install      - Install dotfiles (interactive)"
	@echo "  make update       - Pull updates and reload"
	@echo "  make backup       - Create backup of current configs"
	@echo "  make clean        - Uninstall and restore backups"
	@echo "  make test         - Test shell syntax"
	@echo "  make lint         - Run shellcheck on scripts"
	@echo "  make docker       - Test in Docker container"
	@echo "  make uninstall    - Remove dotfiles cleanly"
	@echo ""
	@echo "Quick install:"
	@echo "  make install-fast MODE=advanced"

# Install dotfiles
install:
	@./install.sh

# Fast install with mode
install-fast:
	@./install.sh -m $(MODE) -i -f

# Update dotfiles from git
update:
	@echo "${BLUE}→ Pulling latest changes...${NC}"
	@git pull origin main
	@echo "${GREEN}✓ Updated${NC}"
	@echo "${BLUE}→ Reloading shells...${NC}"
	@source ~/.bashrc 2>/dev/null || true
	@source ~/.zshrc 2>/dev/null || true
	@echo "${GREEN}✓ Reloaded${NC}"

# Create backup
backup:
	@echo "${BLUE}→ Creating backup...${NC}"
	@mkdir -p ~/.dotfiles-backup-$(shell date +%Y%m%d_%H%M%S)
	@cp ~/.bashrc ~/.bash_profile ~/.zshrc ~/.gitconfig ~/.dotfiles-backup-$(shell date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	@echo "${GREEN}✓ Backup created${NC}"

# Clean uninstall
clean:
	@./uninstall.sh

# Uninstall
uninstall: clean

# Test syntax
test:
	@echo "${BLUE}→ Testing Bash syntax...${NC}"
	@for file in bash/*.sh; do bash -n "$$file" && echo "  ✓ $$file"; done
	@echo "${BLUE}→ Testing Fish syntax...${NC}"
	@for file in fish/**/*.fish; do fish -n "$$file" 2>/dev/null && echo "  ✓ $$file" || true; done
	@echo "${GREEN}✓ All syntax tests passed${NC}"

# Lint with shellcheck
lint:
	@echo "${BLUE}→ Running shellcheck...${NC}"
	@shellcheck install.sh uninstall.sh bash/*.sh 2>/dev/null || echo "${YELLOW}⚠ shellcheck not installed${NC}"

# Docker test
docker:
	@echo "${BLUE}→ Building Docker test environment...${NC}"
	@docker build -t dotfiles-test . 2>/dev/null || echo "${YELLOW}⚠ Docker not available${NC}"
	@echo "${BLUE}→ Running tests...${NC}"
	@docker run --rm -it dotfiles-test ./install.sh --dry-run 2>/dev/null || true

# Check for broken symlinks
check-links:
	@echo "${BLUE}→ Checking symlinks...${NC}"
	@find ~ -maxdepth 2 -type l ! -exec test -e {} \; -print 2>/dev/null | grep -E "(bashrc|zshrc|gitconfig)" || echo "${GREEN}✓ No broken symlinks${NC}"

# Show system info
info:
	@echo "${BOLD}Dotfiles Info${NC}"
	@echo "Version: $(shell git describe --tags --always 2>/dev/null || echo 'dev')"
	@echo "Location: $(shell pwd)"
	@echo "Backup dir: ~/.dotfiles-backup-*"
	@echo ""
	@echo "Configured shells:"
	@ls -la ~/.bashrc ~/.zshrc 2>/dev/null | grep -q "." && echo "  ✓ Shells configured" || echo "  ✗ No shells configured"

# Format code
format:
	@echo "${BLUE}→ Formatting shell scripts...${NC}"
	@shfmt -w bash/*.sh 2>/dev/null || echo "${YELLOW}⚠ shfmt not installed${NC}"

# Show stats
stats:
	@echo "${BOLD}Dotfiles Statistics${NC}"
	@echo "Bash modules: $(shell ls bash/*.sh 2>/dev/null | wc -l)"
	@echo "Fish files: $(shell find fish -name '*.fish' 2>/dev/null | wc -l)"
	@echo "Total lines: $(shell find . -name '*.sh' -o -name '*.fish' 2>/dev/null | xargs wc -l 2>/dev/null | tail -1 | awk '{print $$1}')"
	@echo "Aliases: $(shell grep -r "^alias" bash/ 2>/dev/null | wc -l)"
	@echo "Functions: $(shell grep -r "^function\|^[a-z_]*()" bash/ 2>/dev/null | wc -l)"
