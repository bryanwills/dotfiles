## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.config/zsh/oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 13

# AI / service tokens (read from ~/.keys, never hardcoded)
export OPENAI_API_KEY="$(<~/.keys/.openai_api_key)"
# export ANTHROPIC_API_KEY="$(<~/.keys/.openclaw_api_key)"
export GITHUB_PERSONAL_ACCESS_TOKEN="$(<~/.keys/.github_bryanwills_token)"
export SUPABASE_ACCESS_TOKEN="$(<~/.keys/.supabase-mcp-server)"
export NOTION_TOKEN="$(<~/.keys/.notion_integration_key)"
export OPENCLAW_API_KEY="$(<~/.keys/.openclaw_api_key)"

source /opt/homebrew/share/zsh-system-clipboard/zsh-system-clipboard.zsh
export EDITOR="nvim"

# History
HISTSIZE=500000
HIST_STAMPS="mm/dd/yyyy"
HISTFILE=~"/.zsh_history"
HISTORY_IGNORE="(ls|ll|clear|cd *|cd ~|..|cd|pwd|exit|sudo reboot|history|cd -| cd..)"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history
setopt inc_append_history_time
setopt hist_reduce_blanks
setopt hist_no_store

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Up and down arrow key support for most terminal emulators.
bindkey "^[OA" history-search-backward
bindkey "^[OB" history-search-forward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

fpath+="$ZSH/custom/plugins/zsh-completions/src"
ZSH_DISABLE_COMPFIX="true" # skip slow compaudit security check on startup
source $ZSH/oh-my-zsh.sh
# Note: oh-my-zsh.sh already runs compinit; no need to call it again.

# Add FZF_DEFAULT_OPTS for fzf-tab before the fzf shell integration
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Load fzf shell integration
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Override fzf key bindings to avoid Ghostty conflicts
# Use Option+F for file search and Option+D for directory search
bindkey -M emacs '\ef' fzf-file-widget # Option+F for files
bindkey -M vicmd '\ef' fzf-file-widget
bindkey -M viins '\ef' fzf-file-widget
bindkey -M emacs '\ed' fzf-cd-widget # Option+D for directories
bindkey -M vicmd '\ed' fzf-cd-widget
bindkey -M viins '\ed' fzf-cd-widget

# Alias configurations

alias ls="eza --group-directories-first --color=always --icons --header --time-style long-iso"
alias ll="eza --all --long --group --group-directories-first --icons --header --time-style long-iso --color=always"
alias la="eza --all --long --group-directories-first --icons --header --time-style long-iso --color=always"
alias tree="eza --tree --icons --color=always"
alias gc="git clone"
alias gcm="git commit -m"
alias py="python3"
alias cat="bat"
alias bs="brew search"
alias bi="brew install"
alias gcz="cz commit"
#alias updatedb="launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
alias updatedb="/usr/libexec/locate.updatedb"
alias img="imgcat"
alias sf="spf"
alias sshl="ssh -i ~/.ssh/littlecreek bryanwi09@bryanwills.dev"
alias zsh_backup_dir="~/zsh-backup/"
#alias npm="pnpm"
alias dl="docker logs --tail=100"
alias dc="docker compose"
alias sz="source ~/.config/zsh/.zshrc"
alias reload="source ~/.config/zsh/.zshrc"
alias ez="nvim ~/.config/zsh/.zshrc"
alias n="nvim"
alias nv="nvim"
alias ec="nvim ~/claude_desktop_config.json"
alias journal='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/bryan-journal'

# Aliases: tmux
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias td='tmux kill-session -t'

# Override standard git commands with automatic setup
git() {
  if [[ "$1" == "init" ]]; then
    echo "🚀 Initializing repository with automatic setup..."
    command git "$@"
    command git config --local commit.template ~/.config/commitizen/.czrc

    # Copy commitizen configs if they don't exist
    if [ ! -f ".czrc" ]; then
      /bin/cp ~/.config/commitizen/.czrc ./.czrc 2>/dev/null
      echo "📝 Created .czrc"
    fi

    if [ ! -f "pyproject.toml" ]; then
      /bin/cp ~/.config/commitizen/pyproject.toml ./pyproject.toml 2>/dev/null && echo "📋 Created pyproject.toml" || echo "📋 pyproject.toml not found in global config"
    fi

    echo "✅ Repository initialized with commitizen template"
    echo "💡 Use 'cz commit' for conventional commits"
    echo "💡 Use 'git commit' for regular commits"

  elif [[ "$1" == "clone" ]]; then
    echo "🚀 Cloning repository with automatic setup..."
    command git "$@"

    # Get the repository name from the URL (second argument)
    repo_name=$(basename "$2" .git)
    cd "$repo_name"

    # Set up commitizen template
    command git config --local commit.template ~/.config/commitizen/.czrc

    # Copy commitizen configs if they don't exist
    if [ ! -f ".czrc" ]; then
      /bin/cp ~/.config/commitizen/.czrc ./.czrc 2>/dev/null
      echo "📝 Created .czrc"
    fi

    if [ ! -f "pyproject.toml" ]; then
      /bin/cp ~/.config/commitizen/pyproject.toml ./pyproject.toml 2>/dev/null && echo "📋 Created pyproject.toml" || echo "📋 pyproject.toml not found in global config"
    fi

    echo "✅ Repository cloned with commitizen template"
    echo "💡 Use 'cz commit' for conventional commits"
    echo "💡 Use 'git commit' for regular commits"

  else
    # For all other git commands, just run them normally
    command git "$@"
  fi
}

# Auto-setup function for existing repositories
git-setup-auto() {
  echo "🔧 Setting up existing repository with development tools..."
  bash ~/.config/scripts/setup-new-repo.sh
}

# Ensure cp/mv are the plain commands (clear any inherited aliases/functions)
unalias cp mv 2>/dev/null
unset -f cp mv 2>/dev/null

# ---------------------------------------------------------------------------
# PATH (consolidated & de-duplicated)
# ---------------------------------------------------------------------------
# Homebrew (also set in .zprofile via `brew shellenv`; kept here for safety)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/Cellar/w3m/0.5.3_8/bin/w3m:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/bin:/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# User-local tooling
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/code/flutter/bin:$PATH"
export PATH="$HOME/.codeium/windsurf/bin:$PATH" # Windsurf
export PATH="$HOME/go/bin:$PATH"

# Java / Android
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# humanlog
export HUMANLOG_INSTALL="$HOME/.humanlog"
export PATH="$HUMANLOG_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# ---------------------------------------------------------------------------
# Tooling initialization
# ---------------------------------------------------------------------------
# Powerlevel10k prompt config (run `p10k configure` or edit ~/.config/zsh/.p10k.zsh)
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# GitHub Copilot CLI plugin
source ~/.config/zsh/oh-my-zsh/custom/plugins/zsh-github-copilot/zsh-github-copilot.plugin.zsh

# Local env shims (uv / cargo)
. "$HOME/.local/bin/env"

# mise manages node, ruby, and other runtimes (replaces nvm + rbenv)
eval "$(mise activate zsh)"

# zoxide (smarter cd)
source ~/.config/zoxide/init.zsh
