#!/bin/bash
# Setup script for new repositories
# Run this script in any new repository to set up development tools

set -e

echo "🚀 Setting up new repository with development tools..."

# Get repository path
repo_path=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
echo "📁 Repository: $repo_path"

# Copy commitizen configuration
if [ -f "$HOME/.config/commitizen/.czrc" ]; then
    echo "📝 Setting up commitizen configuration..."
    cp "$HOME/.config/commitizen/.czrc" "$repo_path/.czrc"
    echo "   ✅ Created .czrc"
else
    echo "   ⚠️  Global commitizen config not found"
fi

# Create pyproject.toml if it doesn't exist
if [ ! -f "$repo_path/pyproject.toml" ]; then
    echo "📋 Creating pyproject.toml..."
    cat > "$repo_path/pyproject.toml" << 'PYEOF'
[tool.commitizen]
name = "cz_conventional_commits"
version = "1.0.0"
tag_format = "v$version"

[tool.commitizen.questions]
type = [
    "feat",
    "fix",
    "docs",
    "style",
    "refactor",
    "test",
    "chore",
    "perf",
    "ci",
    "build",
    "revert"
]
scope = "What is the scope of this change (e.g. component or file name)? (optional)"
subject = "Write a short, imperative description of the change:"
body = "Provide a longer description of the change: (optional)"
breaking = "Are there any breaking changes? (y/N)"
breaking_change = "Describe the breaking changes:"
issues = "Does this change affect any open issues? (y/N)"

[tool.commitizen.style]
commit_format = "{type}({scope}): {subject}"
example = "feat(auth): add user authentication system"
emoji = false
max_line_length = 72
PYEOF
    echo "   ✅ Created pyproject.toml"
fi

# Check if pre-commit is available and offer to set it up
if command -v pre-commit &> /dev/null; then
    echo "🔧 Pre-commit framework detected!"
    echo "   💡 To set up pre-commit hooks, run: pre-commit install"
    echo "   💡 To run pre-commit on all files: pre-commit run --all-files"
else
    echo "⚠️  Pre-commit framework not found"
    echo "   💡 Install with: brew install pre-commit"
fi

# Create a basic .gitignore if it doesn't exist
if [ ! -f "$repo_path/.gitignore" ]; then
    echo "🚫 Creating basic .gitignore..."
    cat > "$repo_path/.gitignore" << 'GITEOF'
# Dependencies
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
.venv/

# Build outputs
dist/
build/
*.egg-info/

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Environment files
.env
.env.local
.env.*.local

# Temporary files
*.tmp
*.temp
GITEOF
    echo "   ✅ Created .gitignore"
fi

# Copy global git hooks if they exist
if [ -d "$HOME/.config/git-templates/hooks" ]; then
    echo "🔗 Setting up backup git hooks..."
    cp "$HOME/.config/git-templates/hooks/"* "$repo_path/.git/hooks/" 2>/dev/null || echo "   ⚠️  Could not copy hooks (repository may not be initialized)"
fi

echo ""
echo "🎉 Repository setup complete!"
echo "   💡 Use 'cz commit' for conventional commits"
echo "   💡 Use 'git commit' for regular commits"
echo "   💡 Consider setting up pre-commit hooks for code quality"
echo "   💡 Run this script again if you need to update configuration"
echo ""
exit 0
