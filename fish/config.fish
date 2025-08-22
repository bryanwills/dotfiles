# Fish shell configuration
# Migrated from Zsh configuration

# Set environment variables
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -gx FLUTTER_ROOT $HOME/flutter
set -gx DART_SDK $HOME/flutter/bin/cache/dart-sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools
set -gx PATH $PATH $FLUTTER_ROOT/bin
set -gx PATH $PATH $DART_SDK/bin
set -gx PATH $PATH $HOME/.pub-cache/bin

# Add paths
fish_add_path /opt/homebrew/Cellar/w3m/0.5.3_8/bin/w3m
fish_add_path /Users/bryanwills/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path /bin
fish_add_path /usr/sbin
fish_add_path /sbin

# Load Oh My Fish but bypass problematic key bindings
if test -f $HOME/.local/share/omf/init.fish
    # Temporarily disable key bindings to prevent infinite loops
    set -gx OMF_DISABLE_KEY_BINDINGS 1
    source $HOME/.local/share/omf/init.fish
end

# Load custom configurations
source ~/.config/fish/conf.d/env.fish
source ~/.config/fish/conf.d/paths.fish
source ~/.config/fish/conf.d/aliases.fish
source ~/.config/fish/conf.d/tools.fish

# Custom prompt functions are loaded automatically from ~/.config/fish/functions/

echo "🎨 Using custom Powerlevel10k-equivalent prompt"
echo "⚠️  Note: Some bash-based tools (NVM, rbenv) need Fish-native alternatives"
