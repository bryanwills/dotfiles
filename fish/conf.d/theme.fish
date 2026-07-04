# Fish theme configuration for bobthefish
# Provides a rich, informative prompt similar to Powerlevel10k

# Bobthefish theme configuration
set -g theme_nerd_fonts yes
set -g theme_color_scheme dark

# Git information display (rich like Powerlevel10k)
set -g theme_display_git yes
set -g theme_display_git_untracked yes
set -g theme_display_git_dirty yes
set -g theme_display_git_stashed yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_behind_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_last_commits yes
set -g theme_git_worktree_support yes
set -g theme_git_show_upstream yes

# Prompt customization (Powerlevel10k style)
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_display_ruby yes
set -g theme_display_node yes
set -g theme_display_vagrant yes
set -g theme_display_vi yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes

# Colors (dark theme like Dracula/Monokai)
set -g theme_color_user 00ff87
set -g theme_color_host 5f87ff
set -g theme_color_path 5f87d7
set -g theme_color_git_dirty ff5f5f
set -g theme_color_git_staged 5fff5f
set -g theme_color_git_untracked 5f5fff
set -g theme_color_git_stashed 5f5f5f
set -g theme_color_git_ahead 5fff5f
set -g theme_color_git_behind ff5f5f

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

# Node.js version display
set -g theme_display_node yes
set -g theme_color_node_version 5fff5f

# Ruby version display
set -g theme_display_ruby yes
set -g theme_color_ruby_version 5fff5f

# Battery display
set -g theme_display_battery yes
set -g theme_color_battery_charging 5fff5f
set -g theme_color_battery_discharging ff5f5f
set -g theme_color_battery_full 5fff5f

# Kubernetes context display
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_color_k8s_context 5f87ff
set -g theme_color_k8s_namespace 5f87d7

# Vagrant display
set -g theme_display_vagrant yes
set -g theme_color_vagrant 5f87ff

# VI mode display
set -g theme_display_vi yes
set -g theme_color_vi_normal 5f87ff
set -g theme_color_vi_insert 5fff5f
set -g theme_color_vi_visual ff5f5f

# Command duration display
set -g theme_display_cmd_duration yes
set -g theme_color_cmd_duration 5f87ff

# Hostname display
set -g theme_display_hostname yes
set -g theme_color_hostname 5f87ff

# Username display
set -g theme_display_user yes
set -g theme_color_username 00ff87

# Path display
set -g theme_color_path 5f87d7
set -g theme_color_path_basename 5f87ff

# Date display
set -g theme_display_date yes
set -g theme_color_date 5f5f5f
