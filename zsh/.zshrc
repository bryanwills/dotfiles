## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.config/zsh/oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

# AI ENV Variables
OPENAI_API_KEY="~/.keys/.openai_api_key"
ANTHROPIC_API_KEY="~/.keys/.opencode_claude_api_key"
export EDITOR="nvim"

export ZSH_COMPDUMP="~/.zcompdump"

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
source $ZSH/oh-my-zsh.sh

# Ensure completion system is properly initialized
autoload -U compinit
compinit

# Add FZF_DEFAULT_OPTS for fzf-tab before the fzf shell integration
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Load fzf shell integration
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Override fzf key bindings to avoid Ghostty conflicts
# Use Option+F for file search and Option+D for directory search
bindkey -M emacs '\ef' fzf-file-widget      # Option+F for files
bindkey -M vicmd '\ef' fzf-file-widget
bindkey -M viins '\ef' fzf-file-widget
bindkey -M emacs '\ed' fzf-cd-widget        # Option+D for directories
bindkey -M vicmd '\ed' fzf-cd-widget
bindkey -M viins '\ed' fzf-cd-widget

# Alias configurations

alias ls="eza --group-directories-first --color=always --icons --header --time-style long-iso"
alias ll="eza --all --long --group --group-directories-first --icons --header --time-style long-iso --color=always"
alias la="l -l --time-style="+%Y-%m-%d %H:%M""
alias tree="l --tree"
alias gc="git clone"
alias gcm="git commit -m"
alias py="/usr/local/bin/python3"
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
alias nv="nvim"

# Safe copy alias using rsync (like cp -R)
#alias cp='rsync -a --info=progress2 --no-xattrs'

# Safe move alias using rsync + delete source (like mv)
#alias mv='rsync -a --info=progress2 --remove-source-files --no-xattrs'


# Aliases: tmux
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias td='tmux kill-session -t'

# Aliases: safety (temporarily disabled to fix fzf-tab)
# alias cp='cp --interactive'
# alias mv='mv --interactive'
# Remove any existing mv aliases to prevent conflicts
unalias mv 2>/dev/null

export PATH="/opt/homebrew/Cellar/w3m/0.5.3_8/bin/w3m:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/Users/bryanwills/.local/bin:$PATH"
export PATH="/Users/bryanwills/.cargo/bin:$PATH"
export PATH="/Users/bryanwills/code/flutter/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# Original config
#[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
export PATH="/opt/homebrew/opt/bin/go:$PATH"

eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/Users/bryanwills/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Python3 using Homebrew
#export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# Add human log environment
export HUMANLOG_INSTALL="/Users/bryanwills/.humanlog"
export PATH="$HUMANLOG_INSTALL/bin:$PATH"

#
source ~/.keys/.env.openai
export API_KEY="~/.keys/.env.openai:$API_KEY"
export OPENAI_API_KEY={{OPEN_API_KEY}}
source ~/.config/zsh/oh-my-zsh/custom/plugins/zsh-github-copilot/zsh-github-copilot.plugin.zsh


export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"
eval "$(mise activate zsh)"

# Added by Windsurf
export PATH="/Users/bryanwills/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"

# Init zoxide
#eval "$(zoxide init zsh)"
source ~/.config/zoxide/init.zsh

# Unalias first to avoid conflict
unalias cp 2>/dev/null
unalias mv 2>/dev/null

# Remove any mv function definitions that might be causing issues
unset -f mv 2>/dev/null

# Safe copy function using rsync (temporarily disabled for debugging)
# cp() {
#   if [[ "$#" -lt 2 ]]; then
#     echo "Usage: cp source... destination"
#     return 1
#   fi
#   local dest="${@: -1}"       # last argument
#   local sources=("${@:1:$#-1}") # all but last
#
#   rsync -a --no-xattrs --info=progress2 "${sources[@]}" "$dest"
# }

# Safe move function using rsync (temporarily disabled for debugging)
# mv() {
#   if [[ "$#" -ne 2 ]]; then
#     echo "Usage: mv source destination"
#     return 1
#   fi
#
#   local src="$1"
#   local dst="$2"
#
#   if [[ -d "$src" ]]; then
#     rsync -a --no-xattrs --remove-source-files --info=progress2 "$src/" "$dst/"
#     rm -rf "$src"
#   else
#     rsync -a --no-xattrs --remove-source-files --info=progress2 "$src" "$dst"
#     rm -f "$src"
#   fi
# }
