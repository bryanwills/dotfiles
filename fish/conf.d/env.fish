# Fish environment variables configuration
# Migrated from Zsh configuration

# Basic environment
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx ZSH_COMPDUMP ~/.zcompdump

# History configuration
set -g fish_history_size 500000
set -g fish_history_file ~/.fish_history

# AI ENV Variables (these will be sourced from your keys)
# set -gx OPENAI_API_KEY "~/.keys/.openai_api_key"
# set -gx ANTHROPIC_API_KEY "~/.keys/.opencode_claude_api_key"

# Java and Android
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
set -gx ANDROID_HOME $HOME/Library/Android/sdk

# pnpm
set -gx PNPM_HOME "/Users/bryanwills/Library/pnpm"

# NVM (Node Version Manager)
set -gx NVM_DIR "$HOME/.nvm"

# Human log
set -gx HUMANLOG_INSTALL "/Users/bryanwills/.humanlog"

# FZF configuration
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
