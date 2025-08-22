# Fish theme configuration
# Mirrors Powerlevel10k settings from Zsh

# Gitstatus theme configuration (similar to Powerlevel10k)
set -g theme_nerd_fonts yes
set -g theme_color_scheme dark

# Git information display (matching your Powerlevel10k settings)
set -g theme_display_git_default_branch yes
set -g theme_display_git_untracked yes
set -g theme_display_git_dirty yes
set -g theme_display_git_stashed yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_behind_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_last_commits yes
set -g theme_git_worktree_support yes

# Prompt customization (Powerlevel10k style)
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes

# Colors (dark theme like Dracula/Monokai)
set -g theme_color_user 00ff87
set -g theme_color_host 5f87ff
set -g theme_color_path 5f87d7
set -g theme_color_git_dirty ff5f5f
set -g theme_color_git_staged 5fff5f
set -g theme_color_git_untracked 5f5fff

# Git status symbols (Powerlevel10k style)
set -g theme_git_dirty_symbol "●"
set -g theme_git_staged_symbol "●"
set -g theme_git_untracked_symbol "●"
set -g theme_git_stashed_symbol "●"
set -g theme_git_ahead_symbol "↑"
set -g theme_git_behind_symbol "↓"

# Prompt layout (similar to Powerlevel10k)
set -g theme_prompt_prefix ""
set -g theme_prompt_suffix ""
set -g theme_prompt_separator " "

# Time format (matching your Zsh history stamps)
set -g theme_date_format "+%Y-%m-%d %H:%M:%S"

# Git status format (verbose like Powerlevel10k)
set -g theme_git_default_branch yes
set -g theme_git_worktree_support yes
set -g theme_git_show_upstream yes
