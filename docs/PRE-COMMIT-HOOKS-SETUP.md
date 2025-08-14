# Pre-commit Hooks Setup Guide

This document describes the dual pre-commit hook system implemented in this repository to ensure code quality and security.

## 🏗️ **System Architecture**

### **Primary System: Pre-commit Framework**
- **Location**: `.pre-commit-config.yaml` in repository root
- **Purpose**: Comprehensive code quality checks, formatting, and secret scanning
- **When it runs**: Automatically on every commit when available

### **Backup System: Basic Git Hooks**
- **Location**: `$HOME/.config/git-templates/hooks/`
- **Purpose**: Fallback protection when pre-commit framework isn't available
- **When it runs**: Automatically on every commit in new repositories

## 🔧 **Pre-commit Framework (Primary)**

### **Features:**
- ✅ **GitGuardian Secret Scanning** - Detects secrets and sensitive data
- ✅ **Code Formatting** - Trailing whitespace, end of file fixes
- ✅ **File Validation** - YAML, JSON, merge conflict checks
- ✅ **Commitizen Integration** - Enforces conventional commit format
- ✅ **Markdown Linting** - Ensures markdown quality (manual mode)
- ✅ **Shell Script Linting** - ShellCheck validation (manual mode)

### **Installation:**
```bash
# Install pre-commit framework
brew install pre-commit

# Install hooks in repository
pre-commit install

# Run manually on all files
pre-commit run --all-files
```

### **Configuration:**
The framework is configured via `.pre-commit-config.yaml` in the repository root.

## 🛡️ **Backup Git Hooks (Secondary)**

### **Features:**
- 🔒 **GitGuardian Secret Scanning** - Same protection as primary system
- 📏 **File Size Checks** - Prevents large files (>10MB)
- 🔍 **Sensitive File Pattern Detection** - Warns about potentially sensitive files
- 📝 **Commit Message Validation** - Enforces conventional commit format
- 🔄 **Post-merge Guidance** - Provides tips after merge operations

### **Installation:**
```bash
# Global template directory is automatically configured
git config --global init.templateDir ~/.config/git-templates

# For existing repositories, manually copy hooks:
cp ~/.config/git-templates/hooks/pre-commit .git/hooks/
cp ~/.config/git-templates/hooks/commit-msg .git/hooks/
cp ~/.config/git-templates/hooks/post-merge .git/hooks/
chmod +x .git/hooks/*
```

### **Hook Details:**

#### **pre-commit Hook:**
- Secret scanning with GitGuardian
- File size validation (10MB limit)
- Sensitive file pattern detection
- Interactive prompts for warnings

#### **commit-msg Hook:**
- Conventional commit format enforcement
- Commit message length validation
- Examples and guidance for proper format

#### **post-merge Hook:**
- Development branch guidance
- Merge conflict detection
- Best practice recommendations

## 🚀 **Usage Workflow**

### **Normal Operation (Pre-commit Framework Active):**
1. Make changes to files
2. Stage changes: `git add .`
3. Commit: `git commit -m "feat: your message"`
4. Pre-commit framework automatically runs all checks
5. If checks pass, commit succeeds
6. If checks fail, issues are fixed automatically or manually

### **Fallback Operation (Backup Hooks Only):**
1. Make changes to files
2. Stage changes: `git add .`
3. Commit: `git commit -m "feat: your message"`
4. Backup hooks run basic security checks
5. Interactive prompts for any warnings
6. Commit proceeds after user confirmation

## 🔍 **Troubleshooting**

### **Pre-commit Framework Issues:**
```bash
# Validate configuration
pre-commit validate-config

# Run specific hooks
pre-commit run ggshield
pre-commit run trailing-whitespace

# Skip hooks (emergency only)
git commit --no-verify
```

### **Backup Hook Issues:**
```bash
# Check hook permissions
ls -la .git/hooks/pre-commit

# Test hook manually
.git/hooks/pre-commit

# Skip hooks (emergency only)
git commit --no-verify
```

### **GitGuardian Issues:**
```bash
# Check installation
ggshield --version

# Install if missing
brew install gitguardian/tap/ggshield

# Test scanning
ggshield secret scan pre-commit
```

## 📋 **Best Practices**

### **Commit Messages:**
Use conventional commit format:
```
type(scope): description

feat: add new feature
fix(auth): resolve login issue
docs: update README
style: format code
refactor: restructure code
test: add unit tests
chore: maintenance tasks
```

### **File Management:**
- Keep files under 10MB (use Git LFS for large files)
- Avoid committing sensitive files (keys, credentials, .env)
- Use `.gitignore` for application data and logs

### **Branch Management:**
- Use feature branches: `dev/feature-name`
- Keep branches up to date with main
- Rebase before merging for clean history

## 🔧 **Customization**

### **Adding New Hooks:**
1. Edit `.pre-commit-config.yaml` for framework hooks
2. Edit `~/.config/git-templates/hooks/` for backup hooks
3. Test thoroughly before committing

### **Modifying Existing Hooks:**
1. Update the appropriate hook file
2. Make executable: `chmod +x hook-name`
3. Test in a safe environment

## 📚 **Additional Resources**

- [Pre-commit Framework Documentation](https://pre-commit.com/)
- [GitGuardian Documentation](https://docs.gitguardian.com/)
- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [Git Hooks Documentation](https://git-scm.com/docs/githooks)

## 🆘 **Support**

If you encounter issues:
1. Check this documentation first
2. Review the hook output for specific errors
3. Test hooks manually to isolate issues
4. Check file permissions and paths
5. Verify GitGuardian installation and configuration
