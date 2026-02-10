# Security Guide for Dotfiles Repository

## 🔒 Keeping Your Credentials Safe

This document outlines security best practices for managing and contributing to this dotfiles repository.

---

## ✅ Security Status

**Current Status: SAFE TO PUSH** ✅

Your repository has been checked and:
- ✓ No hardcoded credentials detected
- ✓ No SSH key files tracked
- ✓ No .env files in repository
- ✓ Secrets management uses external password managers
- ✓ Pre-commit hooks configured

---

## 🛡️ What We Protect Against

### 1. **Hardcoded Credentials**
Never commit files containing:
```bash
# ❌ NEVER DO THIS:
export API_KEY="sk-1234567890abcdef"
export PASSWORD="mysecretpassword"
export AWS_ACCESS_KEY="AKIAIOSFODNN7EXAMPLE"
```

### 2. **SSH Private Keys**
Never commit:
- `id_rsa` (SSH private key)
- `id_ed25519` (SSH private key)
- `*.pem` files
- Any file containing `BEGIN PRIVATE KEY`

### 3. **Environment Files**
Never commit:
- `.env`
- `.env.local`
- `.envrc`
- `secrets.json`

---

## ✅ How We Handle Secrets

### Method 1: Password Manager Integration (Recommended)

We use external password managers to load secrets dynamically:

```bash
# ✅ SAFE: Load from 1Password
export GITHUB_TOKEN=$(op read "op://Private/GitHub/token")

# ✅ SAFE: Load from Bitwarden
export API_KEY=$(bw get password "API Key")

# ✅ SAFE: Load from Pass
export TOKEN=$(pass show api/token)
```

**Benefits:**
- Secrets never touch the filesystem
- Encrypted at rest in password manager
- Access controlled by password manager

### Method 2: GPG-Encrypted Files

Store secrets in GPG-encrypted files:

```bash
# Create encrypted secrets file
gpg -c -o ~/.config/dotfiles/secrets.gpg secrets.txt

# Load in shell
eval "$(gpg -d ~/.config/dotfiles/secrets.gpg)"
```

**Benefits:**
- Encrypted with your GPG key
- Can be tracked in git (encrypted)
- No external dependencies

### Method 3: Environment Variables

Set in your shell profile (not in dotfiles repo):

```bash
# ~/.bashrc.local (not tracked in git)
export GITHUB_TOKEN="your-token"
```

**Benefits:**
- Simple
- No external tools needed
- Per-machine customization

---

## 🚨 Pre-Commit Security Checks

We've configured a pre-commit hook that automatically checks for:

1. ✓ SSH private keys
2. ✓ Environment files (.env)
3. ✓ Hardcoded secrets (API keys, passwords)
4. ✓ Large binary files
5. ✓ Syntax errors in scripts

### The hook will:
- **Block commits** containing credentials
- **Warn** about suspicious patterns
- **Allow bypass** only with `--no-verify` (not recommended)

---

## 📋 Before Pushing Checklist

Run this checklist before every push:

```bash
# 1. Check what you're committing
git status

# 2. Review all changes
git diff --cached

# 3. Run security check
./scripts/security-check.sh

# 4. Verify no credentials
grep -r "password\|secret\|token" --include="*.sh" .

# 5. Check for SSH keys
find . -name "id_*" -o -name "*.pem" | grep -v ".pub"

# 6. Push safely
git push
```

---

## 🔍 What Gets Ignored

Our `.gitignore` automatically excludes:

```gitignore
# Credentials
.env
*.key
*.pem
id_*
!id_*.pub  # Public keys are OK
*password*
*secret*

# Local config (user-specific)
*.local
.bashrc.local

# Generated files
.cache/
*.log
```

---

## 🆘 If You Accidentally Commit Credentials

### Step 1: Don't Panic!

### Step 2: Immediately Revoke the Credential
- Change the password
- Revoke the API key
- Regenerate the token

### Step 3: Remove from Git History

```bash
# Remove file from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file" \
  --prune-empty --tag-name-filter cat -- --all

# Or use BFG Repo-Cleaner (faster)
bfg --delete-files path/to/file

# Force push
git push --force
```

### Step 4: Notify Team
If this is a shared repository, notify your team to rotate any shared credentials.

---

## 🎯 Best Practices

### DO ✅
- Use password managers (1Password, Bitwarden, Pass)
- Load secrets dynamically at runtime
- Use `.bashrc.local` for local-only settings
- Enable two-factor authentication
- Use SSH keys with passphrases
- Regularly rotate API keys

### DON'T ❌
- Never commit `.env` files
- Never hardcode passwords in scripts
- Never commit SSH private keys
- Never share credential files
- Never disable pre-commit hooks permanently

---

## 🔐 Security Features in This Repo

### 1. **Secrets Management Module** (`bash/00-secrets.sh`)
- Integrates with 1Password, Bitwarden, Pass
- Loads credentials dynamically
- No hardcoded secrets

### 2. **SSH Agent Module** (`bash/00-ssh-agent.sh`)
- Auto-manages SSH keys
- Loads from `~/.ssh/` (not in repo)
- Secure key handling

### 3. **Pre-Commit Hooks** (`.git/hooks/pre-commit`)
- Blocks credential commits
- Checks syntax
- Validates security

### 4. **Comprehensive .gitignore**
- Excludes all credential files
- Excludes local customizations
- Excludes generated files

---

## 📞 Need Help?

If you're unsure about a file:

```bash
# Check if file contains secrets
cat file | grep -i "password\|secret\|token\|key"

# Check file type
file filename

# Ask for review
git diff --cached | less
```

---

## ✅ Quick Security Test

Run this to verify your setup:

```bash
# 1. Verify no credentials in staged files
git diff --cached | grep -i "password\|secret" && echo "❌ FAIL" || echo "✅ PASS"

# 2. Verify no SSH keys
git status | grep "id_" && echo "❌ FAIL" || echo "✅ PASS"

# 3. Verify .gitignore exists
[[ -f .gitignore ]] && echo "✅ PASS" || echo "❌ FAIL"

# 4. Run pre-commit hook
.git/hooks/pre-commit && echo "✅ PASS" || echo "❌ FAIL"
```

All checks should show ✅ before pushing!

---

## 🎉 You're Secure!

Your repository is configured with multiple layers of protection. Just remember:

1. **Check before you commit**
2. **Use password managers for secrets**
3. **Never disable security checks**
4. **When in doubt, ask!**

Happy (secure) coding! 🚀

---

*Last updated: 2026-02-10*
