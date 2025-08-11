#!/bin/bash

# Linux Dotfiles Installation Script
# This script installs dotfiles on a Debian-based Linux system
# Optimized for headless servers and remote development

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        error "This script should not be run as root. Please run as a regular user."
        exit 1
    fi
}

# Function to get current username
get_username() {
    local current_user
    current_user=$(whoami)

    if [[ -z "$current_user" ]]; then
        error "Could not determine current username"
        exit 1
    fi

    echo "$current_user"
}

# Function to check and install dependencies
check_dependencies() {
    log "Checking system dependencies..."

    local missing_packages=()
    local missing_commands=()

    # Check for essential packages
    if ! command_exists git; then
        missing_packages+=("git")
    fi

    if ! command_exists curl; then
        missing_packages+=("curl")
    fi

    if ! command_exists wget; then
        missing_packages+=("wget")
    fi

    if ! command_exists zsh; then
        missing_packages+=("zsh")
    fi

    if ! command_exists tmux; then
        missing_packages+=("tmux")
    fi

    if ! command_exists nvim; then
        missing_packages+=("neovim")
    fi

    if ! command_exists btop; then
        missing_packages+=("btop")
    fi

    # Check for Homebrew (Linux)
    if ! command_exists brew; then
        if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
            warn "Homebrew found at /home/linuxbrew/.linuxbrew/bin/brew but not in PATH"
            info "Adding Homebrew to PATH for this session..."
            export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
        else
            warn "Homebrew not found. Some tools may need manual installation."
        fi
    fi

    # Install missing packages if any
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        log "Installing missing packages: ${missing_packages[*]}"

        if command_exists apt; then
            sudo apt update
            sudo apt install -y "${missing_packages[@]}"
        elif command_exists apt-get; then
            sudo apt-get update
            sudo apt-get install -y "${missing_packages[@]}"
        else
            error "No supported package manager found (apt/apt-get)"
            error "Please install the following packages manually: ${missing_packages[*]}"
            exit 1
        fi
    fi

    log "All system dependencies are satisfied"
}

# Function to backup existing dotfiles
backup_dotfiles() {
    local username="$1"
    local backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d_%H%M%S)"

    log "Creating backup of existing dotfiles in: $backup_dir"
    mkdir -p "$backup_dir"

    # List of dotfiles to backup
    local dotfiles_to_backup=(
        ".zshrc"
        ".bashrc"
        ".bash_profile"
        ".profile"
        ".tmux.conf"
        ".config/nvim"
        ".config/tmux"
        ".config/zsh"
        ".config/btop"
        ".config/git"
        ".config/ranger"
        ".config/nnn"
        ".config/bat"
        ".config/eza"
        ".config/nano"
        ".config/neofetch"
        ".config/htop"
        ".config/bpytop"
        ".config/cargo"
        ".config/curl"
        ".config/gnupg"
        ".config/mise"
        ".config/rclone"
        ".config/ueberzugpp"
        ".config/superfile"
        ".config/yazi"
        ".config/lazygit"
        ".config/envman"
        ".config/humanlog"
        ".config/naabu"
        ".config/nano"
        ".config/neofetch"
        ".config/posting"
        ".config/opencode"
        ".config/uv"
        ".config/gh"
        ".config/gcloud"
        ".config/crossnote"
        ".config/spf"
        ".config/contour"
        ".config/flutter"
        ".config/simple-update-notifier"
        ".config/xbuild"
        ".config/wireshark"
        ".config/powershell"
        ".config/fish"
        ".config/zed"
        ".config/cursor"
        ".config/claude"
        ".config/pnpm"
        ".config/npm"
        ".config/postgres"
        ".config/chrome"
        ".config/browseruse"
        ".config/configstore"
        ".gitconfig"
        ".gitignore_global"
        ".gitignore"
        ".nanorc"
        ".curlrc"
        ".gpg-agent.conf"
        ".gpg.conf"
        ".scdaemon.conf"
        ".npmrc"
        ".pnpmrc"
        ".uvrc"
        ".mise.toml"
        ".zoxide"
        ".envman"
        ".humanlog"
        ".naabu"
        ".posting"
        ".opencode"
        ".spf"
        ".contour"
        ".flutter"
        ".simple-update-notifier"
        ".xbuild"
        ".wireshark"
        ".powershell"
        ".fish"
        ".zed"
        ".cursor"
        ".claude"
        ".pnpm"
        ".npm"
        ".postgres"
        ".chrome"
        ".browseruse"
        ".configstore"
    )

    for dotfile in "${dotfiles_to_backup[@]}"; do
        if [[ -e "$HOME/$dotfile" ]]; then
            local backup_path="$backup_dir/$(dirname "$dotfile")"
            mkdir -p "$backup_path"
            cp -r "$HOME/$dotfile" "$backup_path/"
            log "Backed up: $dotfile"
        fi
    done

    log "Backup completed: $backup_dir"
    echo "$backup_dir" > "$HOME/.dotfiles-backup-location"
}

# Function to create symlinks for Linux-compatible dotfiles
create_symlinks() {
    local username="$1"
    local dotfiles_dir="$2"

    log "Creating symlinks for Linux-compatible dotfiles..."

    # Create necessary directories
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"

    # Linux-compatible dotfiles (exclude macOS-specific ones)
    local linux_dotfiles=(
        # Core configurations
        "nvim"              # Neovim configuration
        "tmux"              # Tmux configuration
        "zsh"               # Zsh configuration
        "git"               # Git configuration
        "btop"              # System monitoring
        "htop"              # Alternative system monitor
        "bpytop"            # Python-based system monitor
        "ranger"            # File manager
        "nnn"               # Terminal file manager
        "bat"               # Better cat
        "eza"               # Better ls
        "nano"              # Text editor
        "neofetch"          # System info
        "curl"              # HTTP client
        "gnupg"             # GPG configuration
        "cargo"             # Rust package manager
        "mise"              # Tool version manager
        "rclone"            # Cloud storage
        "ueberzugpp"        # Image preview
        "superfile"         # File manager
        "yazi"              # Modern file manager
        "lazygit"           # Git TUI
        "envman"            # Environment manager
        "humanlog"          # Human-readable logs
        "naabu"             # Port scanner
        "posting"           # Posting tools
        "opencode"          # Open source tools
        "uv"                # Python package manager
        "gh"                # GitHub CLI
        "gcloud"            # Google Cloud CLI
        "crossnote"         # Note taking
        "spf"               # Shell prompt framework
        "contour"           # Terminal emulator
        "flutter"           # Flutter SDK
        "simple-update-notifier" # Update notifications
        "xbuild"            # Build tools
        "wireshark"         # Network analyzer
        "powershell"         # PowerShell
        "fish"               # Fish shell
        "zed"                # Code editor
        "cursor"             # Cursor editor
        "claude"             # Claude AI
        "pnpm"               # Package manager
        "npm"                # Node package manager
        "postgres"           # PostgreSQL
        "chrome"             # Chrome flags
        "browseruse"         # Browser usage
        "configstore"        # Config storage
    )

    # Create symlinks for each compatible dotfile
    for dotfile in "${linux_dotfiles[@]}"; do
        local source="$dotfiles_dir/$dotfile"
        local target="$HOME/.config/$dotfile"

        if [[ -d "$source" ]] || [[ -f "$source" ]]; then
            # Remove existing symlink or file
            if [[ -L "$target" ]]; then
                rm "$target"
            elif [[ -e "$target" ]]; then
                warn "Removing existing $target (was backed up)"
                rm -rf "$target"
            fi

            # Create symlink
            ln -sf "$source" "$target"
            log "Created symlink: $target -> $source"
        else
            warn "Source not found: $source"
        fi
    done

    # Handle special cases (files in home directory)
    local home_dotfiles=(
        ".gitconfig"
        ".gitignore_global"
        ".nanorc"
        ".curlrc"
        ".gpg-agent.conf"
        ".gpg.conf"
        ".scdaemon.conf"
        ".npmrc"
        ".pnpmrc"
        ".uvrc"
        ".mise.toml"
    )

    for dotfile in "${home_dotfiles[@]}"; do
        local source="$dotfiles_dir/$dotfile"
        local target="$HOME/$dotfile"

        if [[ -f "$source" ]]; then
            # Remove existing symlink or file
            if [[ -L "$target" ]]; then
                rm "$target"
            elif [[ -e "$target" ]]; then
                warn "Removing existing $target (was backed up)"
                rm "$target"
            fi

            # Create symlink
            ln -sf "$source" "$target"
            log "Created symlink: $target -> $source"
        fi
    done

    # Handle special directories
    if [[ -d "$dotfiles_dir/.zoxide" ]]; then
        ln -sf "$dotfiles_dir/.zoxide" "$HOME/.zoxide"
        log "Created symlink: $HOME/.zoxide -> $dotfiles_dir/.zoxide"
    fi

    log "All symlinks created successfully"
}

# Function to customize configurations for Linux
customize_for_linux() {
    local username="$1"

    log "Customizing configurations for Linux environment..."

    # Update tmux configuration for Linux paths
    if [[ -f "$HOME/.config/tmux/tmux.conf" ]]; then
        # Replace macOS-specific paths with Linux paths
        sed -i "s|/opt/homebrew/bin/zsh|/usr/bin/zsh|g" "$HOME/.config/tmux/tmux.conf"
        sed -i "s|~/.config/tmux/plugins|$HOME/.config/tmux/plugins|g" "$HOME/.config/tmux/tmux.conf"
        log "Updated tmux configuration for Linux"
    fi

    # Update zsh configuration for Linux
    if [[ -f "$HOME/.config/zsh/.zshrc" ]]; then
        # Replace macOS-specific paths with Linux paths
        sed -i "s|/opt/homebrew|/home/linuxbrew/.linuxbrew|g" "$HOME/.config/zsh/.zshrc"
        log "Updated zsh configuration for Linux"
    fi

    # Create Linux-specific environment file
    cat > "$HOME/.config/envman/load-linux.sh" << 'EOF'
#!/bin/bash
# Linux-specific environment variables

# Add Linuxbrew to PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# Linux-specific aliases
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias search='apt search'

# Linux-specific functions
linux_info() {
    echo "=== Linux System Information ==="
    echo "Distribution: $(lsb_release -d | cut -f2)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
    echo "Disk: $(df -h / | tail -1 | awk '{print $4}') available"
}

# Load Linux-specific completions if available
if [[ -d /usr/share/bash-completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

if [[ -d /usr/share/zsh/vendor-completions ]]; then
    . /usr/share/zsh/vendor-completions/*
fi
EOF

    chmod +x "$HOME/.config/envman/load-linux.sh"
    log "Created Linux-specific environment file"
}

# Function to install additional tools via Homebrew (Linux)
install_homebrew_tools() {
    if command_exists brew; then
        log "Installing additional tools via Homebrew..."

        local homebrew_packages=(
            "neovim"
            "tmux"
            "zsh"
            "btop"
            "bat"
            "eza"
            "fd"
            "ripgrep"
            "fzf"
            "lazygit"
            "gh"
            "rclone"
            "mise"
            "uv"
        )

        for package in "${homebrew_packages[@]}"; do
            if ! brew list "$package" >/dev/null 2>&1; then
                log "Installing $package via Homebrew..."
                brew install "$package"
            else
                log "$package already installed via Homebrew"
            fi
        done

        log "Homebrew tools installation completed"
    else
        warn "Homebrew not available, skipping additional tool installation"
    fi
}

# Function to setup shell
setup_shell() {
    local username="$1"

    log "Setting up shell configuration..."

    # Make zsh the default shell if available
    if command_exists zsh; then
        if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
            log "Changing default shell to zsh..."
            chsh -s /usr/bin/zsh "$username"
            info "Default shell changed to zsh. Please log out and log back in for changes to take effect."
        else
            log "Zsh is already the default shell"
        fi
    fi

    # Source the new zsh configuration
    if [[ -f "$HOME/.config/zsh/.zshrc" ]]; then
        source "$HOME/.config/zsh/.zshrc"
        log "Zsh configuration loaded"
    fi
}

# Function to create summary
create_summary() {
    local username="$1"
    local backup_dir="$2"

    local summary_file="$HOME/linux-dotfiles-installation-summary.txt"

    cat > "$summary_file" << EOF
Linux Dotfiles Installation Summary
==================================
Date: $(date)
Username: $username
Backup Location: $backup_dir

What was installed:
- Neovim configuration with LSP and plugins
- Tmux configuration with enhanced keybindings
- Zsh configuration with Oh My Zsh
- Git configuration
- System monitoring tools (btop, htop, bpytop)
- File managers (ranger, nnn, yazi, superfile)
- Development tools (cargo, mise, uv)
- Network tools (curl, rclone, wireshark)
- Shell utilities (bat, eza, neofetch)

What was excluded (macOS-specific):
- Ghostty terminal
- iTerm2
- Kitty terminal
- Obsidian
- Raycast
- Sketchybar
- Xcode build tools
- macOS-specific applications

Next steps:
1. Log out and log back in for shell changes to take effect
2. Install Neovim plugins: nvim + :Lazy sync
3. Install Tmux plugins: prefix + I (in tmux)
4. Customize configurations as needed

Backup location: $backup_dir
EOF

    log "Installation summary created: $summary_file"
}

# Main installation function
main() {
    log "Starting Linux dotfiles installation..."

    # Check if not running as root
    check_root

    # Get current username
    local username
    username=$(get_username)
    log "Installing for user: $username"

    # Get dotfiles directory
    local dotfiles_dir
    dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    log "Dotfiles directory: $dotfiles_dir"

    # Check dependencies
    check_dependencies

    # Backup existing dotfiles
    local backup_dir
    backup_dir=$(backup_dotfiles "$username")

    # Create symlinks
    create_symlinks "$username" "$dotfiles_dir"

    # Customize for Linux
    customize_for_linux "$username"

    # Install Homebrew tools
    install_homebrew_tools

    # Setup shell
    setup_shell "$username"

    # Create summary
    create_summary "$username" "$backup_dir"

    log "Linux dotfiles installation completed successfully!"
    log "Please review the installation summary at: $HOME/linux-dotfiles-installation-summary.txt"
    log "Backup of existing files is located at: $backup_dir"

    if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
        warn "Please log out and log back in for shell changes to take effect"
    fi
}

# Run main function
main "$@"
