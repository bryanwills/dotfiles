# Fish PATH configuration
# Migrated from Zsh configuration

# Add various binary paths to PATH
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

# Android SDK paths
if test -d $ANDROID_HOME
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
end

# pnpm path
if test -d $PNPM_HOME
    fish_add_path $PNPM_HOME
end

# Homebrew path (should already be in PATH, but just in case)
fish_add_path /opt/homebrew/bin
