# Fish aliases configuration
# Migrated from Zsh configuration

# File listing aliases
alias ls="eza --group-directories-first --color=always --icons --header --time-style long-iso"
alias ll="eza --all --long --group --group-directories-first --icons --header --time-style long-iso --color=always"
alias la="eza -l --time-style=\"+%Y-%m-%d %H:%M\""
alias tree="eza --tree"

# Git aliases
alias gc="git clone"
alias gcm="git commit -m"
alias gcz="cz commit"

# Development aliases
alias py="/usr/local/bin/python3"
alias cat="bat"
alias bs="brew search"
alias bi="brew install"
alias nv="nvim"

# System aliases
alias updatedb="/usr/libexec/locate.updatedb"
alias img="imgcat"
alias sf="spf"

# SSH aliases
alias sshl="ssh -i ~/.ssh/littlecreek bryanwi09@bryanwills.dev"

# Docker aliases
alias dl="docker logs --tail=100"
alias dc="docker compose"

# Tmux aliases
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias td='tmux kill-session -t'

# Zsh compatibility aliases (for when you want to reload Zsh config)
alias sz="source ~/.config/zsh/.zshrc"
alias reload="source ~/.config/zsh/.zshrc"
alias ez="nvim ~/.config/zsh/.zshrc"

# Backup aliases
alias zsh_backup_dir="~/zsh-backup/"
