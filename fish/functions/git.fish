# Fish git function configuration
# Migrated from Zsh configuration

function git
    if test "$argv[1]" = "init"
        echo "🚀 Initializing repository with automatic setup..."
        command git $argv
        command git config --local commit.template ~/.config/commitizen/.czrc

        # Copy commitizen configs if they don't exist
        if not test -f ".czrc"
            /bin/cp ~/.config/commitizen/.czrc ./.czrc 2>/dev/null
            echo "📝 Created .czrc"
        end

        if not test -f "pyproject.toml"
            /bin/cp ~/.config/commitizen/pyproject.toml ./pyproject.toml 2>/dev/null; and echo "📋 Created pyproject.toml"; or echo "📋 pyproject.toml not found in global config"
        end

        echo "✅ Repository initialized with commitizen template"
        echo "💡 Use 'cz commit' for conventional commits"
        echo "💡 Use 'git commit' for regular commits"

    else if test "$argv[1]" = "clone"
        echo "🚀 Cloning repository with automatic setup..."
        command git $argv

        # Get the repository name from the URL (second argument)
        set repo_name (basename "$argv[2]" .git)
        cd "$repo_name"

        # Set up commitizen template
        command git config --local commit.template ~/.config/commitizen/.czrc

        # Copy commitizen configs if they don't exist
        if not test -f ".czrc"
            /bin/cp ~/.config/commitizen/.czrc ./.czrc 2>/dev/null
            echo "📝 Created .czrc"
        end

        if not test -f "pyproject.toml"
            /bin/cp ~/.config/commitizen/pyproject.toml ./pyproject.toml 2>/dev/null; and echo "📋 Created pyproject.toml"; or echo "📋 pyproject.toml not found in global config"
        end

        echo "✅ Repository cloned with commitizen template"
        echo "💡 Use 'cz commit' for conventional commits"
        echo "💡 Use 'git commit' for regular commits"

    else
        # For all other git commands, just run them normally
        command git $argv
    end
end
