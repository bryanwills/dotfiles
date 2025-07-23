## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$ZDOTDIR/oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13



# AI ENV Variables
OPENAI_API_KEY="~/.keys/.openai_api_key"
ANTHROPIC_API_KEY="~/.keys/.opencode_claude_api_key"
export EDITOR="cursor"

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

plugins=(
zsh-syntax-highlighting
zsh-autosuggestions
git
fzf-tab
)
# Set FZF defaults
export FZF_DEFAULT_OPTS="--layout=reverse --border=bold --border=rounded --margin=3% --color=dark"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Alias configurations

alias ls="eza"
alias ll="eza --all --long --group --group-directories-first --icons --header --time-style long-iso"
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
alias npm="pnpm"

export PATH="/opt/homebrew/Cellar/w3m/0.5.3_8/bin/w3m:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/Users/bryanwills/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
# Original config
#[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
export PATH="/opt/homebrew/opt/bin/go:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/bryanwills/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/bryanwills/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/bryanwills/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/bryanwills/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/Users/bryanwills/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#zsh fzf
source <(fzf --zsh)

# .NET Core
export PATH="$PATH:/Users/$USER/.dotnet/tools"

# Python3 using Homebrew
#export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# Add human log environment
export HUMANLOG_INSTALL="/Users/bryanwills/.humanlog"
export PATH="$HUMANLOG_INSTALL/bin:$PATH"

# store more information (timestamp)
setopt extended_history

# shares history across multiple zsh sessions
setopt share_history
# append to history
setopt append_history

# expire duplicates first
setopt hist_expire_dups_first

# do not store duplications, keep newest
setopt hist_ignore_all_dups

#ignore duplicates when searching
setopt hist_find_no_dups

# removes blank lines from history
setopt hist_reduce_blanks

source ~/.env.openai
export API_KEY="~/.env.openai:$API_KEY"
export OPENAI_API_KEY={{OPEN_API_KEY}}
source ~/.zsh-copilot/zsh-copilot.plugin.zsh


export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

. "$HOME/.local/bin/env"
eval "$(mise activate zsh)"

# Added by Windsurf
export PATH="/Users/bryanwills/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
