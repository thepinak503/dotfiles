#!/bin/bash
# =============================================================================
# PRE-PUSH SECURITY CHECK
# =============================================================================
# Run this script before pushing to ensure no credentials are exposed
# Usage: ./scripts/pre-push-check.sh
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}              PRE-PUSH SECURITY VERIFICATION${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

errors=0
warnings=0

# =============================================================================
# CHECK 1: SSH Keys
# =============================================================================
echo "🔑 Checking for SSH private keys..."
ssh_keys=$(git diff --cached --name-only 2>/dev/null | grep -E "id_(rsa|ed25519|dsa|ecdsa)$" | grep -v ".pub" || true)
if [[ -n "$ssh_keys" ]]; then
    echo -e "${RED}✗ FAIL: SSH private keys detected:${NC}"
    echo "$ssh_keys" | sed 's/^/  /'
    errors=$((errors + 1))
else
    echo -e "${GREEN}✓ PASS${NC}: No SSH private keys found"
fi

# =============================================================================
# CHECK 2: Certificate Files
# =============================================================================
echo ""
echo "📜 Checking for certificate files..."
certs=$(git diff --cached --name-only 2>/dev/null | grep -E "\.(pem|key)$" | grep -v ".pub" || true)
if [[ -n "$certs" ]]; then
    echo -e "${YELLOW}⚠ WARNING: Certificate files detected:${NC}"
    echo "$certs" | sed 's/^/  /'
    echo -e "${YELLOW}  Ensure these don't contain private keys!${NC}"
    warnings=$((warnings + 1))
else
    echo -e "${GREEN}✓ PASS${NC}: No certificate files found"
fi

# =============================================================================
# CHECK 3: Environment Files
# =============================================================================
echo ""
echo "🌍 Checking for environment files..."
env_files=$(git diff --cached --name-only 2>/dev/null | grep -E "^\.env|\.envrc$" || true)
if [[ -n "$env_files" ]]; then
    echo -e "${RED}✗ FAIL: Environment files detected:${NC}"
    echo "$env_files" | sed 's/^/  /'
    echo -e "${RED}  These files often contain secrets!${NC}"
    errors=$((errors + 1))
else
    echo -e "${GREEN}✓ PASS${NC}: No environment files found"
fi

# =============================================================================
# CHECK 4: Hardcoded Secrets
# =============================================================================
echo ""
echo "🔒 Checking for hardcoded secrets..."

# High-confidence patterns
secret_patterns=(
    "sk-[a-zA-Z0-9]{20,}"                              # OpenAI/Anthropic keys
    "ghp_[a-zA-Z0-9]{36}"                              # GitHub tokens
    "gho_[a-zA-Z0-9]{36}"                              # GitHub OAuth
    "AKIA[0-9A-Z]{16}"                                 # AWS Access Key
    "[0-9a-zA-Z/+]{40}="                               # Base64 secrets
    "BEGIN (RSA|OPENSSH|DSA|EC) PRIVATE KEY"           # Private keys
)

found_secrets=0
for pattern in "${secret_patterns[@]}"; do
    matches=$(git diff --cached -G "$pattern" --name-only 2>/dev/null || true)
    if [[ -n "$matches" ]]; then
        echo -e "${RED}✗ FAIL: Potential hardcoded secrets in:${NC}"
        echo "$matches" | sed 's/^/  /'
        found_secrets=1
        errors=$((errors + 1))
        break
    fi
done

if [[ $found_secrets -eq 0 ]]; then
    echo -e "${GREEN}✓ PASS${NC}: No hardcoded secrets detected"
fi

# =============================================================================
# CHECK 5: Suspicious Variable Assignments
# =============================================================================
echo ""
echo "📝 Checking for suspicious patterns..."

# Check for patterns that look like credentials (but might be false positives)
suspicious=$(git diff --cached 2>/dev/null | grep -E "^[\+].*(api_key|apikey|password|secret|token)\s*=\s*[\"'][^\"']{8,}[\"']" | grep -v "op://\|bw get\|pass show\|# " || true)

if [[ -n "$suspicious" ]]; then
    echo -e "${YELLOW}⚠ WARNING: Suspicious patterns found:${NC}"
    echo "$suspicious" | head -5 | sed 's/^/  /'
    echo -e "${YELLOW}  Review these manually to ensure they're not real credentials${NC}"
    warnings=$((warnings + 1))
else
    echo -e "${GREEN}✓ PASS${NC}: No suspicious patterns found"
fi

# =============================================================================
# CHECK 6: Large Binary Files
# =============================================================================
echo ""
echo "📦 Checking for large files..."
large_files=$(git diff --cached --numstat 2>/dev/null | awk '$1 > 1000 || $2 > 1000 {print $3}' | head -5 || true)
if [[ -n "$large_files" ]]; then
    echo -e "${YELLOW}⚠ WARNING: Large files detected:${NC}"
    echo "$large_files" | sed 's/^/  /'
    echo -e "${YELLOW}  Consider using Git LFS for files > 1MB${NC}"
    warnings=$((warnings + 1))
else
    echo -e "${GREEN}✓ PASS${NC}: No large files found"
fi

# =============================================================================
# CHECK 7: New Untracked Files
# =============================================================================
echo ""
echo "📄 Checking for new untracked files..."
untracked=$(git ls-files --others --exclude-standard 2>/dev/null | head -10 || true)
if [[ -n "$untracked" ]]; then
    echo -e "${BLUE}ℹ INFO: Untracked files present:${NC}"
    echo "$untracked" | sed 's/^/  /'
    echo -e "${BLUE}  These won't be pushed unless you 'git add' them${NC}"
fi

# =============================================================================
# SUMMARY
# =============================================================================
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}                         SUMMARY${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

if [[ $errors -eq 0 && $warnings -eq 0 ]]; then
    echo -e "${GREEN}🎉 ALL CHECKS PASSED!${NC}"
    echo -e "${GREEN}Your repository is safe to push.${NC}"
    echo ""
    echo "Run: git push origin main"
    exit 0
elif [[ $errors -eq 0 ]]; then
    echo -e "${YELLOW}⚠ WARNINGS FOUND: $warnings${NC}"
    echo -e "${YELLOW}Review the warnings above before pushing.${NC}"
    echo ""
    echo "To proceed anyway: git push origin main"
    echo "To review changes:  git diff --cached"
    exit 0
else
    echo -e "${RED}🚨 ERRORS FOUND: $errors${NC}"
    [[ $warnings -gt 0 ]] && echo -e "${YELLOW}⚠ WARNINGS: $warnings${NC}"
    echo ""
    echo -e "${RED}DO NOT PUSH until these issues are resolved!${NC}"
    echo ""
    echo "To bypass (not recommended): git push --no-verify"
    exit 1
fi
