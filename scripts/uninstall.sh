#!/bin/bash

# Uninstall script for Bryan's dotfiles
# This script will remove symlinks and restore original files

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

# Setup logging
LOG_FILE="uninstall_$(date +%Y%m%d_%H%M%S).log"
exec 1> >(tee -a "$LOG_FILE")
exec 2> >(tee -a "$LOG_FILE" >&2)

print_status "Uninstallation log: $LOG_FILE"

# Get current user
CURRENT_USER=$(whoami)
print_status "Current user: $CURRENT_USER"

# Confirm before proceeding
echo ""
print_warning "This will remove all dotfiles symlinks and restore original files."
print_warning "Make sure you have backups of any important configurations."
read -p "Continue with uninstallation? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Uninstallation cancelled."
    exit 1
fi

print_header "Starting Uninstallation"

# Initialize tracking arrays
REMOVED_SYMLINKS=()
RESTORED_FILES=()
FAILED_REMOVALS=()
MANUAL_CLEANUP=()

# Function to safely remove symlink and restore backup
remove_symlink_and_restore() {
    local target="$1"
    local backup_pattern="$2"

    if [[ -L "$target" ]]; then
        print_status "Removing symlink: $target"
        if rm "$target"; then
            REMOVED_SYMLINKS+=("$target")
            print_status "Successfully removed symlink: $target"
        else
            FAILED_REMOVALS+=("$target (symlink)")
            print_error "Failed to remove symlink: $target"
        fi

        # Look for backup file
        if [[ -f "${target}.backup"* ]]; then
            local backup_file=$(ls -t "${target}.backup"* | head -1)
            print_status "Restoring backup: $backup_file -> $target"
            if mv "$backup_file" "$target"; then
                RESTORED_FILES+=("$target")
                print_status "Successfully restored: $target"
            else
                FAILED_REMOVALS+=("$target (restore)")
                print_error "Failed to restore: $target"
            fi
        else
            print_warning "No backup found for: $target"
            MANUAL_CLEANUP+=("$target (no backup)")
        fi
    elif [[ -f "$target" ]]; then
        print_warning "File exists at $target but is not a symlink. Skipping..."
        MANUAL_CLEANUP+=("$target (not symlink)")
    else
        print_status "No file found at $target"
    fi
}

# Remove Neovim configuration
print_status "Removing Neovim configuration..."
remove_symlink_and_restore "$HOME/.config/nvim"

# Remove other configurations
print_status "Removing other configurations..."

# Git
remove_symlink_and_restore "$HOME/.gitconfig"

# Zsh
remove_symlink_and_restore "$HOME/.zshrc"

# Tmux
remove_symlink_and_restore "$HOME/.tmux.conf"

# Kitty
remove_symlink_and_restore "$HOME/.config/kitty/kitty.conf"

# Ghostty
remove_symlink_and_restore "$HOME/.config/ghostty/config"

# Sketchybar
remove_symlink_and_restore "$HOME/.config/sketchybar/sketchybarrc"

# Remove empty directories
print_status "Cleaning up empty directories..."
EMPTY_DIRS=$(find "$HOME/.config" -type d -empty 2>/dev/null || true)
if [[ -n "$EMPTY_DIRS" ]]; then
    echo "$EMPTY_DIRS" | while read -r dir; do
        if rmdir "$dir" 2>/dev/null; then
            print_status "Removed empty directory: $dir"
        fi
    done
fi

# Restore macOS settings to defaults (optional)
echo ""
print_warning "Do you want to reset macOS settings to defaults?"
print_warning "This will reset screenshot, dock, and other customizations."
read -p "Reset macOS settings? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Resetting macOS settings..."

    # Track reset settings
    RESET_SETTINGS=()

    # Reset screenshot settings
    if defaults delete com.apple.screencapture show-thumbnail 2>/dev/null; then
        RESET_SETTINGS+=("screenshot show-thumbnail")
    fi
    if defaults delete com.apple.screencapture thumbnail-duration 2>/dev/null; then
        RESET_SETTINGS+=("screenshot thumbnail-duration")
    fi
    if defaults delete com.apple.screencapture location 2>/dev/null; then
        RESET_SETTINGS+=("screenshot location")
    fi
    if defaults delete com.apple.screencapture type 2>/dev/null; then
        RESET_SETTINGS+=("screenshot type")
    fi

    # Reset dock settings
    if defaults delete com.apple.dock autohide 2>/dev/null; then
        RESET_SETTINGS+=("dock autohide")
    fi
    if defaults delete com.apple.dock autohide-delay 2>/dev/null; then
        RESET_SETTINGS+=("dock autohide-delay")
    fi
    if defaults delete com.apple.dock autohide-time-modifier 2>/dev/null; then
        RESET_SETTINGS+=("dock autohide-time-modifier")
    fi
    if defaults delete com.apple.dock tilesize 2>/dev/null; then
        RESET_SETTINGS+=("dock tilesize")
    fi
    if defaults delete com.apple.dock magnification 2>/dev/null; then
        RESET_SETTINGS+=("dock magnification")
    fi

    # Reset global settings
    if defaults delete NSGlobalDomain AppleShowAllExtensions 2>/dev/null; then
        RESET_SETTINGS+=("global AppleShowAllExtensions")
    fi
    if defaults delete NSGlobalDomain NSDocumentSaveNewDocumentsToCloud 2>/dev/null; then
        RESET_SETTINGS+=("global NSDocumentSaveNewDocumentsToCloud")
    fi

    if [[ ${#RESET_SETTINGS[@]} -gt 0 ]]; then
        print_status "Reset ${#RESET_SETTINGS[@]} macOS settings:"
        for setting in "${RESET_SETTINGS[@]}"; do
            print_status "  - $setting"
        done
    else
        print_status "No custom macOS settings found to reset."
    fi

    print_warning "You may need to restart applications for changes to take effect"
fi

# Create uninstallation summary
print_header "Creating Uninstallation Summary"

echo "Uninstallation Summary" > "uninstall_summary.txt"
echo "Generated: $(date)" >> "uninstall_summary.txt"
echo "" >> "uninstall_summary.txt"

echo "Successfully removed symlinks:" >> "uninstall_summary.txt"
if [[ ${#REMOVED_SYMLINKS[@]} -gt 0 ]]; then
    for symlink in "${REMOVED_SYMLINKS[@]}"; do
        echo "  - $symlink" >> "uninstall_summary.txt"
    done
else
    echo "  - None" >> "uninstall_summary.txt"
fi
echo "" >> "uninstall_summary.txt"

echo "Successfully restored files:" >> "uninstall_summary.txt"
if [[ ${#RESTORED_FILES[@]} -gt 0 ]]; then
    for file in "${RESTORED_FILES[@]}"; do
        echo "  - $file" >> "uninstall_summary.txt"
    done
else
    echo "  - None" >> "uninstall_summary.txt"
fi
echo "" >> "uninstall_summary.txt"

echo "Failed operations:" >> "uninstall_summary.txt"
if [[ ${#FAILED_REMOVALS[@]} -gt 0 ]]; then
    for failure in "${FAILED_REMOVALS[@]}"; do
        echo "  - $failure" >> "uninstall_summary.txt"
    done
else
    echo "  - None" >> "uninstall_summary.txt"
fi
echo "" >> "uninstall_summary.txt"

echo "Manual cleanup required:" >> "uninstall_summary.txt"
if [[ ${#MANUAL_CLEANUP[@]} -gt 0 ]]; then
    for item in "${MANUAL_CLEANUP[@]}"; do
        echo "  - $item" >> "uninstall_summary.txt"
    done
else
    echo "  - None" >> "uninstall_summary.txt"
fi
echo "" >> "uninstall_summary.txt"

if [[ $REPLY =~ ^[Yy]$ ]] && [[ ${#RESET_SETTINGS[@]} -gt 0 ]]; then
    echo "Reset macOS settings:" >> "uninstall_summary.txt"
    for setting in "${RESET_SETTINGS[@]}"; do
        echo "  - $setting" >> "uninstall_summary.txt"
    done
    echo "" >> "uninstall_summary.txt"
fi

echo "Files created:" >> "uninstall_summary.txt"
echo "  - $LOG_FILE (Full uninstallation log)" >> "uninstall_summary.txt"
echo "  - uninstall_summary.txt (This summary)" >> "uninstall_summary.txt"
echo "" >> "uninstall_summary.txt"

echo "Next steps:" >> "uninstall_summary.txt"
echo "  1. Review the log file if you encounter any issues" >> "uninstall_summary.txt"
echo "  2. Manually clean up any items listed above" >> "uninstall_summary.txt"
echo "  3. Restart your terminal and applications" >> "uninstall_summary.txt"
echo "  4. If you want to reinstall, run the install script again" >> "uninstall_summary.txt"

print_status "Created uninstall_summary.txt"

print_header "Uninstallation Complete!"
print_status "All dotfiles have been removed successfully!"
print_status "Full log: $LOG_FILE"
echo ""
print_warning "You may need to restart your terminal and applications for changes to take effect."
print_warning "If you want to reinstall, run the install script again."
echo ""
print_status "Check the generated summary files for details!"
print_status "Uninstallation completed!"
