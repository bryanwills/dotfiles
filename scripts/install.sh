#!/bin/bash

# Install script for Bryan's dotfiles
# This script will install all dotfiles and customize them for the current user

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Source the dependencies script
if [[ -f "scripts/dependencies.sh" ]]; then
    source scripts/dependencies.sh
else
    print_error "Dependencies script not found. Please ensure scripts/dependencies.sh exists."
    exit 1
fi

# Get current user
CURRENT_USER=$(whoami)
print_status "Current user: $CURRENT_USER"

# Check dependencies first
print_header "Checking Dependencies"
main

# Ask user to confirm after dependency check
echo ""
print_warning "Please review the dependency check above."
read -p "Continue with installation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Installation cancelled."
    exit 1
fi

# Prompt for username customization
echo ""
print_header "Username Configuration"
echo "The dotfiles contain references to 'bryanwills' that need to be customized for your system."
echo "For Neovim configuration, a custom folder structure is used."
echo ""

# Get username for Neovim
read -p "Enter username for Neovim configuration (default: $CURRENT_USER): " NVIM_USERNAME
NVIM_USERNAME=${NVIM_USERNAME:-$CURRENT_USER}
print_status "Neovim username set to: $NVIM_USERNAME"

# Get general username replacement
read -p "Enter username for general file replacements (default: $CURRENT_USER): " GENERAL_USERNAME
GENERAL_USERNAME=${GENERAL_USERNAME:-$CURRENT_USER}
print_status "General username set to: $GENERAL_USERNAME"

# Confirm before proceeding
echo ""
print_warning "This will modify files in the current directory. Make sure you're in the dotfiles directory."
read -p "Continue with installation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Installation cancelled."
    exit 1
fi

print_header "Starting Installation"

# Setup logging
LOG_FILE="install_$(date +%Y%m%d_%H%M%S).log"
exec 1> >(tee -a "$LOG_FILE")
exec 2> >(tee -a "$LOG_FILE" >&2)

print_status "Installation log: $LOG_FILE"

# Create backup of original files
print_status "Creating backup of original files..."
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and replace in a file
backup_and_replace() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "$BACKUP_DIR/"
        # Replace bryanwills with the new username
        sed -i.bak "s/bryanwills/$GENERAL_USERNAME/g" "$file"
        rm -f "$file.bak"
        print_status "Updated: $file"
    fi
}

# Function to backup and replace in a file with specific username
backup_and_replace_specific() {
    local file="$1"
    local old_username="$2"
    local new_username="$3"
    if [[ -f "$file" ]]; then
        cp "$file" "$BACKUP_DIR/"
        # Replace specific username with the new username
        sed -i.bak "s/$old_username/$new_username/g" "$file"
        rm -f "$file.bak"
        print_status "Updated: $file"
    fi
}

# Update macOS scripts
print_status "Updating macOS customization scripts..."
for script in scripts/*.sh scripts/*.conf; do
    if [[ -f "$script" ]]; then
        backup_and_replace "$script"
    fi
done

# Update README.md
print_status "Updating README.md..."
backup_and_replace "README.md"

# Update Neovim configuration
print_status "Updating Neovim configuration..."
if [[ -d "nvim" ]]; then
    # Update nvim init.lua
    if [[ -f "nvim/init.lua" ]]; then
        backup_and_replace "nvim/init.lua"
    fi

    # Update .luarc files
    for luarc in nvim/.luarc*; do
        if [[ -f "$luarc" ]]; then
            backup_and_replace "$luarc"
        fi
    done

    # Update README files in nvim
    for readme in nvim/README*.md; do
        if [[ -f "$readme" ]]; then
            backup_and_replace "$readme"
        fi
    done
fi

# Update other configuration files that might contain username references
print_status "Updating other configuration files..."

# Common config files that might contain username references
CONFIG_FILES=(
    "git/config"
    "zsh/.zshrc"
    "tmux/tmux.conf"
    "kitty/kitty.conf"
    "ghostty/config"
    "sketchybar/sketchybarrc"
)

for config_file in "${CONFIG_FILES[@]}"; do
    if [[ -f "$config_file" ]]; then
        backup_and_replace "$config_file"
    fi
done

# Update macOS defaults script with current user's home directory
print_status "Updating macOS defaults script with current user's home directory..."
if [[ -f "scripts/my-current-defaults.sh" ]]; then
    # Replace the hardcoded path with current user's home
    sed -i.bak "s|/Users/bryanwills|$HOME|g" "scripts/my-current-defaults.sh"
    rm -f "scripts/my-current-defaults.sh.bak"
    print_status "Updated screenshot path in my-current-defaults.sh"
fi

# Create symlinks or copy files to appropriate locations
print_header "Installing dotfiles"

# Function to safely create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [[ -L "$target" ]]; then
        print_warning "Symlink already exists at $target, removing..."
        rm "$target"
    elif [[ -f "$target" ]]; then
        print_warning "File already exists at $target, backing up..."
        mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Create symlink
    ln -sf "$(pwd)/$source" "$target"
    print_status "Created symlink: $source -> $target"
}

# Install Neovim configuration
print_status "Installing Neovim configuration..."
if [[ -d "nvim" ]]; then
    create_symlink "nvim" "$HOME/.config/nvim"
fi

# Install other configurations
print_status "Installing other configurations..."

# Git
if [[ -d "git" ]]; then
    create_symlink "git/config" "$HOME/.gitconfig"
fi

# Zsh
if [[ -d "zsh" ]]; then
    create_symlink "zsh/.zshrc" "$HOME/.zshrc"
fi

# Tmux
if [[ -d "tmux" ]]; then
    create_symlink "tmux/tmux.conf" "$HOME/.tmux.conf"
fi

# Kitty
if [[ -d "kitty" ]]; then
    create_symlink "kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
fi

# Ghostty
if [[ -d "ghostty" ]]; then
    create_symlink "ghostty/config" "$HOME/.config/ghostty/config"
fi

# Sketchybar
if [[ -d "sketchybar" ]]; then
    create_symlink "sketchybar/sketchybarrc" "$HOME/.config/sketchybar/sketchybarrc"
fi

# Apply macOS customizations
print_header "Applying macOS Customizations"
print_status "Running macOS customization script..."
if [[ -f "scripts/my-current-defaults.sh" ]]; then
    chmod +x "scripts/my-current-defaults.sh"
    ./scripts/my-current-defaults.sh
    print_status "macOS customizations applied successfully!"
else
    print_warning "macOS customization script not found, skipping..."
fi

# Install Neovim plugins and setup
print_header "Setting up Neovim"
if command_exists nvim; then
    print_status "Installing Neovim plugins..."
    nvim --headless -c "Lazy! sync" -c "qa"
    print_status "Neovim plugins installed successfully!"
else
    print_warning "Neovim not found, skipping plugin installation."
fi

# Install Tmux plugins
print_header "Setting up Tmux"
if command_exists tmux; then
    print_status "Installing Tmux plugins..."
    # Create tmux plugin directory if it doesn't exist
    mkdir -p ~/.tmux/plugins

    # Install tpm (Tmux Plugin Manager)
    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_status "Tmux Plugin Manager installed."
    fi

    # Install tmux plugins
    ~/.tmux/plugins/tpm/bin/install_plugins
    print_status "Tmux plugins installed successfully!"
else
    print_warning "Tmux not found, skipping plugin installation."
fi

# Setup Zsh plugins
print_header "Setting up Zsh"
if command_exists zsh; then
    print_status "Installing Oh My Zsh..."
    if [[ ! -d ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_status "Oh My Zsh installed successfully!"
    else
        print_status "Oh My Zsh already installed."
    fi
else
    print_warning "Zsh not found, skipping Oh My Zsh installation."
fi

# Install additional tools and setup
print_header "Additional Setup"

# Install Node.js packages if npm is available
if command_exists npm; then
    print_status "Installing global Node.js packages..."
    npm install -g typescript @types/node
    print_status "Node.js packages installed."
fi

# Install Rust tools if cargo is available
if command_exists cargo; then
    print_status "Installing Rust tools..."
    cargo install ripgrep fd-find exa bat
    print_status "Rust tools installed."
fi

# Setup Git configuration
if command_exists git; then
    print_status "Setting up Git configuration..."
    # Set default branch name
    git config --global init.defaultBranch main
    print_status "Git configuration updated."
fi

# Create summary files for user reference
print_header "Creating Summary Files"

# Create missing apps summary
if [[ -f "/tmp/missing_apps.txt" ]]; then
    MISSING_APPS=($(cat "/tmp/missing_apps.txt"))
    if [[ ${#MISSING_APPS[@]} -gt 0 ]]; then
        echo "Missing Applications Summary" > "missing_apps_summary.txt"
        echo "Generated: $(date)" >> "missing_apps_summary.txt"
        echo "" >> "missing_apps_summary.txt"
        echo "The following applications were missing and have been installed:" >> "missing_apps_summary.txt"
        for app in "${MISSING_APPS[@]}"; do
            echo "  - $app" >> "missing_apps_summary.txt"
        done
        print_status "Created missing_apps_summary.txt"
    fi
fi

# Create manual install summary
if [[ -f "/tmp/manual_apps.txt" ]]; then
    MANUAL_APPS=($(cat "/tmp/manual_apps.txt"))
    if [[ ${#MANUAL_APPS[@]} -gt 0 ]]; then
        echo "Manual Installation Required" > "manual_install_guide.txt"
        echo "Generated: $(date)" >> "manual_install_guide.txt"
        echo "" >> "manual_install_guide.txt"
        echo "The following applications need to be installed manually:" >> "manual_install_guide.txt"
        echo "" >> "manual_install_guide.txt"
        for app in "${MANUAL_APPS[@]}"; do
            if [[ -n "${MANUAL_APPS[$app]}" ]]; then
                echo "  - $app: ${MANUAL_APPS[$app]}" >> "manual_install_guide.txt"
            fi
        done
        echo "" >> "manual_install_guide.txt"
        echo "Please install these applications manually before using the dotfiles." >> "manual_install_guide.txt"
        print_status "Created manual_install_guide.txt"
    fi
fi

# Create installation summary
echo "Installation Summary" > "installation_summary.txt"
echo "Generated: $(date)" >> "installation_summary.txt"
echo "" >> "installation_summary.txt"
echo "Installation completed successfully!" >> "installation_summary.txt"
echo "" >> "installation_summary.txt"
echo "Files created:" >> "installation_summary.txt"
echo "  - $LOG_FILE (Full installation log)" >> "installation_summary.txt"
echo "  - $BACKUP_DIR (Backup of original files)" >> "installation_summary.txt"
if [[ -f "missing_apps_summary.txt" ]]; then
    echo "  - missing_apps_summary.txt (List of installed applications)" >> "installation_summary.txt"
fi
if [[ -f "manual_install_guide.txt" ]]; then
    echo "  - manual_install_guide.txt (Manual installation guide)" >> "installation_summary.txt"
fi
echo "" >> "installation_summary.txt"
echo "Next steps:" >> "installation_summary.txt"
echo "  1. Review the log file if you encounter any issues" >> "installation_summary.txt"
echo "  2. Install any applications listed in manual_install_guide.txt" >> "installation_summary.txt"
echo "  3. Restart your terminal and applications" >> "installation_summary.txt"
echo "  4. For Neovim, run :Lazy sync to install plugins" >> "installation_summary.txt"

print_status "Created installation_summary.txt"

print_header "Installation Complete!"
print_status "Your dotfiles have been installed successfully!"
print_status "Backup files are stored in: $BACKUP_DIR"
print_status "Full log: $LOG_FILE"
echo ""
print_warning "Some applications may need to be restarted for changes to take effect."
print_warning "For Neovim, you may need to install plugins with :Lazy sync"
echo ""
print_status "Check the generated summary files for next steps!"
print_status "Enjoy your new dotfiles setup!"
