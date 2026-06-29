## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------------------------------------------------------
# Platform detection (this file is shared across macOS and Linux/VPS)
# ---------------------------------------------------------------------------
case "$OSTYPE" in
darwin*) ZSH_OS="mac" ;;
linux*) ZSH_OS="linux" ;;
*) ZSH_OS="unknown" ;;
esac

# Locate Homebrew (Apple Silicon, Intel, or Linuxbrew)
BREW_PREFIX=""
for _b in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew "$HOME/.linuxbrew"; do
  if [[ -x "$_b/bin/brew" ]]; then
    BREW_PREFIX="$_b"
    break
  fi
done
unset _b

export ZSH="$HOME/.config/zsh/oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto # update automatically without asking
zstyle ':omz:update' frequency 13

# AI / service tokens (read from ~/.keys if present; never hardcoded)
_load_key() { [[ -f "$2" ]] && export "$1"="$(<"$2")"; }
_load_key OPENAI_API_KEY ~/.keys/.openai_api_key
_load_key GITHUB_PERSONAL_ACCESS_TOKEN ~/.keys/.github_bryanwills_token
_load_key SUPABASE_ACCESS_TOKEN ~/.keys/.supabase-mcp-server
_load_key NOTION_TOKEN ~/.keys/.notion_integration_key
_load_key OPENCLAW_API_KEY ~/.keys/.openclaw_api_key
_load_key KAGGLE_API_TOKEN ~/.keys/.kaggle_api_token
unset -f _load_key

# System clipboard integration (installed via brew; macOS uses pbcopy backend)
if [[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-system-clipboard/zsh-system-clipboard.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-system-clipboard/zsh-system-clipboard.zsh"
fi
export EDITOR="nvim"

#source /Users/bryanwills/.config/zsh/oh-my-zsh/plugins/zsh-opencode-plugin

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
  you-should-use
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
# Keep the completion dump out of the (git-tracked) config dir -> XDG cache
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"
[[ -d "${ZSH_COMPDUMP:h}" ]] || mkdir -p "${ZSH_COMPDUMP:h}"
source $ZSH/oh-my-zsh.sh
# Note: oh-my-zsh.sh already runs compinit; no need to call it again.

# Add FZF_DEFAULT_OPTS for fzf-tab before the fzf shell integration
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"

# fzf shell integration (cross-platform; fzf >= 0.48 ships `fzf --zsh`)
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh 2>/dev/null)
fi

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
alias img="imgcat" # macOS/iTerm only; harmless if absent
alias sf="spf"
alias sshl="ssh -i ~/.ssh/littlecreek bryanwi09@bryanwills.dev"
alias zsh_backup_dir="~/zsh-backup/"
#alias npm="pnpm"
alias dl="docker logs --tail=100"
alias dc="docker compose"
alias ds="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"
alias sz="source ~/.config/zsh/.zshrc"
alias reload="source ~/.config/zsh/.zshrc"
alias ez="nvim ~/.config/zsh/.zshrc"
alias n="nvim"
alias nv="nvim"
alias ec="nvim ~/claude_desktop_config.json"
alias journal='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/bryan-journal'

# macOS-only aliases
if [[ "$ZSH_OS" == "mac" ]]; then
  alias updatedb="/usr/libexec/locate.updatedb"
fi

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
# PATH (platform-aware, existence-guarded so the same file works everywhere)
# ---------------------------------------------------------------------------
# Prepend $1 to PATH only if it exists and isn't already present.
_prepend_path() {
  [[ -d "$1" ]] || return
  case ":$PATH:" in
  *":$1:"*) ;;
  *) PATH="$1:$PATH" ;;
  esac
}

export PATH="/Users/bryanwills/.devcontainers/bin:$PATH"
export PATH="/Users/bryanwills/.venv-vllm-metal/bin:$PATH"

# Homebrew
if [[ -n "$BREW_PREFIX" ]]; then
  _prepend_path "$BREW_PREFIX/bin"
  _prepend_path "$BREW_PREFIX/sbin"
  _prepend_path "$BREW_PREFIX/opt/postgresql@16/bin"
  _prepend_path "$BREW_PREFIX/opt/postgresql@17/bin"
  for _p in "$BREW_PREFIX"/opt/php@*/bin(N) "$BREW_PREFIX"/opt/php@*/sbin(N); do _prepend_path "$_p"; done
  _prepend_path "$BREW_PREFIX/opt/imagemagick-full/bin"
  _prepend_path "$BREW_PREFIX/opt/rustup/bin"
  unset _p
fi

# User-local tooling (only added if the dir exists)
_prepend_path "$HOME/.local/bin"
_prepend_path "$HOME/.cargo/bin"
_prepend_path "$HOME/code/flutter/bin"
_prepend_path "$HOME/.codeium/windsurf/bin" # Windsurf (macOS)
_prepend_path "$HOME/go/bin"
_prepend_path "$HOME/.bun/bin"

# Java / Android (macOS dev box)
if [[ "$ZSH_OS" == "mac" ]]; then
  [[ -d "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home" ]] &&
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
  if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    _prepend_path "$ANDROID_HOME/emulator"
    _prepend_path "$ANDROID_HOME/platform-tools"
  fi
fi

# humanlog
if [[ -d "$HOME/.humanlog/bin" ]]; then
  export HUMANLOG_INSTALL="$HOME/.humanlog"
  _prepend_path "$HUMANLOG_INSTALL/bin"
fi

# pnpm (store path differs per OS)
if [[ "$ZSH_OS" == "mac" ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
_prepend_path "$PNPM_HOME"

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

export PATH
unset -f _prepend_path

# ---------------------------------------------------------------------------
# Tooling initialization
# ---------------------------------------------------------------------------
# Powerlevel10k prompt config (run `p10k configure` or edit ~/.config/zsh/.p10k.zsh)
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# GitHub Copilot CLI plugin (if installed)
if [[ -f ~/.config/zsh/oh-my-zsh/custom/plugins/zsh-github-copilot/zsh-github-copilot.plugin.zsh ]]; then
  source ~/.config/zsh/oh-my-zsh/custom/plugins/zsh-github-copilot/zsh-github-copilot.plugin.zsh
fi

# Local env shims (uv / cargo) if present
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# mise manages node, ruby, and other runtimes (replaces nvm + rbenv)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# zoxide (smarter cd)
if [[ -f ~/.config/zoxide/init.zsh ]]; then
  source ~/.config/zoxide/init.zsh
elif command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Obsidian Vault custom configs to work with jrnl tool for notes
# Obsidian vault
export OBSIDIAN_VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/bryan-journal"

# Quick personal capture
jot() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: jot your thought here"
    return 1
  fi

  jrnl personal "$* @inbox"
}

# Sanitized work capture only — no confidential details
wjot() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: wjot sanitized work task here"
    return 1
  fi

  jrnl work "$* @work @inbox"
}

# Append directly to an Obsidian daily inbox note
oi() {
  local inbox="$OBSIDIAN_VAULT/00-Inbox"
  local file="$inbox/$(date +%Y-%m-%d)-inbox.md"

  mkdir -p "$inbox"

  if [[ $# -eq 0 ]]; then
    echo "Usage: oi your thought here"
    return 1
  fi

  {
    echo ""
    echo "- $(date '+%H:%M') — $*"
  } >>"$file"

  echo "Captured to: $file"
}

RDME_AC_ZSH_SETUP_PATH=/Users/bryanwills/Library/Caches/rdme/autocomplete/zsh_setup && test -f $RDME_AC_ZSH_SETUP_PATH && source $RDME_AC_ZSH_SETUP_PATH # rdme autocomplete setup

# Obsidian quick capture functions
source "$HOME/.config/zsh/functions/obsidian-capture.zsh"
