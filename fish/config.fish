# Fish shell configuration
# Migrated from Zsh configuration

# Set Fish as the default shell (but keep Zsh as system default)
# This file only affects Fish when it's explicitly launched

# Environment variables
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx ZSH_COMPDUMP ~/.zcompdump

# History configuration
set -g fish_history_size 500000
set -g fish_history_file ~/.fish_history

# AI ENV Variables (set directly instead of sourcing bash files)
# Note: These are commented out for security - uncomment and set your actual keys if needed
# set -gx OPENAI_API_KEY "your_openai_key_here"
# set -gx ANTHROPIC_API_KEY "your_anthropic_key_here"

# PATH additions
fish_add_path /opt/homebrew/Cellar/w3m/0.5.3_8/bin/w3m
fish_add_path /opt/homebrew/opt/postgresql@16/bin
fish_add_path /opt/homebrew/opt/postgresql@17/bin
fish_add_path /Users/bryanwills/.local/bin
fish_add_path /Users/bryanwills/.cargo/bin
fish_add_path /Users/bryanwills/code/flutter/bin
fish_add_path /opt/homebrew/opt/bin/go
fish_add_path /opt/homebrew/opt/php@8.1/bin
fish_add_path /opt/homebrew/opt/php@8.1/sbin
fish_add_path /Users/bryanwills/.humanlog/bin
fish_add_path /Users/bryanwills/.codeium/windsurf/bin
fish_add_path /opt/homebrew/opt/imagemagick@6/bin

# Java and Android
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -gx ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

# pnpm
set -gx PNPM_HOME "/Users/bryanwills/Library/pnpm"
fish_add_path $PNPM_HOME

# NVM (Node Version Manager) - Fish-compatible alternative
set -gx NVM_DIR "$HOME/.nvm"

# Human log
set -gx HUMANLOG_INSTALL "/Users/bryanwills/.humanlog"

# FZF configuration
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Load Oh My Fish
if test -f $HOME/.local/share/omf/init.fish
    source $HOME/.local/share/omf/init.fish
end

# Initialize Fish-compatible tools
if test -f $HOME/.local/bin/mise
    eval (mise activate fish)
end

if test -f $HOME/.config/zoxide/init.fish
    source $HOME/.config/zoxide/init.fish
end

# Aliases
alias ls="eza --group-directories-first --color=always --icons --header --time-style long-iso"
alias ll="eza --all --long --group --group-directories-first --icons --header --time-style long-iso --color=always"
alias la="eza -l --time-style=\"+%Y-%m-%d %H:%M\""
alias tree="eza --tree"
alias gc="git clone"
alias gcm="git commit -m"
alias py="/usr/local/bin/python3"
alias cat="bat"
alias bs="brew search"
alias bi="brew install"
alias gcz="cz commit"
alias updatedb="/usr/libexec/locate.updatedb"
alias img="imgcat"
alias sf="spf"
alias sshl="ssh -i ~/.ssh/littlecreek bryanwi09@bryanwills.dev"
alias zsh_backup_dir="~/zsh-backup/"
alias dl="docker logs --tail=100"
alias dc="docker compose"
alias sz="source ~/.config/zsh/.zshrc"
alias reload="source ~/.config/zsh/.zshrc"
alias ez="nvim ~/.config/zsh/.zshrc"
alias nv="nvim"

# Git aliases
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias td='tmux kill-session -t'

# Git function (Fish equivalent of your Zsh git function)
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

# Auto-setup function for existing repositories
function git-setup-auto
    echo "🔧 Setting up existing repository with development tools..."
    bash ~/.config/scripts/setup-new-repo.sh
end

# Welcome message
echo "🐟 Welcome to Fish shell!"
echo "💡 Type 'help' for Fish help, 'omf help' for Oh My Fish help"
echo "🔄 Your Zsh configurations have been migrated to Fish"
echo "🎨 Using gitstatus theme (Powerlevel10k equivalent)"
echo "⚠️  Note: Some bash-based tools (NVM, rbenv) need Fish-native alternatives"
