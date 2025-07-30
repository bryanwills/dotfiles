# dotfiles

My Personal dotfiles on my Macbook Pro M2 Max machine.

## macOS Customization Scripts

This repository includes several scripts for managing macOS system preferences and customizations:

### Scripts Overview

All scripts are located in the `scripts/` directory:

- **`scripts/macos-customizations.sh`** - Template script with common macOS customizations
- **`scripts/macos-defaults.conf`** - Documentation of available macOS defaults settings
- **`scripts/extract-current-defaults.sh`** - Extracts current macOS settings to a readable format
- **`scripts/convert-to-defaults-write.sh`** - Converts current settings to `defaults write` commands
- **`scripts/my-current-defaults.sh`** - Your current macOS customizations as `defaults write` commands
- **`scripts/install.sh`** - Installation script for new users (checks dependencies, customizes usernames, and creates symlinks)
- **`scripts/uninstall.sh`** - Uninstallation script to remove dotfiles and restore backups
- **`scripts/dependencies.sh`** - Dependency checker that verifies required applications and tools
- **`scripts/clean-ds-store.sh`** - Clean up .DS_Store files and prevent their creation

### Usage

#### Install Dotfiles (for new users)
```bash
./scripts/install.sh
```

#### Uninstall Dotfiles
```bash
./scripts/uninstall.sh
```

#### Apply Current Settings
```bash
./scripts/my-current-defaults.sh
```

#### Extract Current Settings
```bash
./scripts/extract-current-defaults.sh
```

#### Convert Settings to Commands
```bash
./scripts/convert-to-defaults-write.sh
```

#### Clean .DS_Store Files
```bash
./scripts/clean-ds-store.sh
```

### Current Customizations

The following settings are currently applied:

- **Screenshot Settings:**
  - Screenshots save to `/Users/bryanwills/screenshots`
  - PNG format
  - Thumbnail preview duration: 1 second

- **Dock Settings:**
  - Auto-hide enabled
  - No delay when hiding
  - Fast animation
  - Tile size: 49 pixels
  - Magnification enabled

- **Global Settings:**
  - Show all file extensions
  - Don't save documents to iCloud by default

- **.DS_Store Prevention:**
  - Prevent .DS_Store creation on network drives
  - Prevent .DS_Store creation on USB drives
  - Prevent .DS_Store creation on local drives (aggressive prevention)

### Installation Process

The install script will:

1. **Check dependencies** - Verify Homebrew and required applications are installed
2. **Install missing applications** - Automatically install missing tools via Homebrew
3. **Prompt for username customization** - Replace 'bryanwills' with your username
4. **Create backups** - All original files are backed up before modification
5. **Update file paths** - Replace hardcoded paths with your home directory
6. **Create symlinks** - Link dotfiles to their proper locations
7. **Apply macOS customizations** - Run the macOS settings script
8. **Install plugins** - Set up Neovim, Tmux, and Zsh plugins
9. **Install additional tools** - Install Rust tools, Node.js packages, and configure Git
10. **Generate summary files** - Create detailed logs and guides for user reference

### Adding New Customizations

1. Edit `scripts/macos-customizations.sh` to add new settings
2. Run the script to apply changes
3. Use `scripts/extract-current-defaults.sh` to capture the new settings
4. Update `scripts/my-current-defaults.sh` with the new commands

### Logging and Summary Files

Both install and uninstall scripts create comprehensive logs and summary files:

**Install Script Output:**
- `install_YYYYMMDD_HHMMSS.log` - Complete installation log with all terminal output
- `installation_summary.txt` - Summary of what was installed and next steps
- `missing_apps_summary.txt` - List of applications that were automatically installed
- `manual_install_guide.txt` - Guide for applications that need manual installation

**Uninstall Script Output:**
- `uninstall_YYYYMMDD_HHMMSS.log` - Complete uninstallation log with all terminal output
- `uninstall_summary.txt` - Summary of what was removed and what needs manual cleanup

**Benefits:**
- **Troubleshooting** - Full logs help diagnose any issues
- **Transparency** - Users know exactly what was installed/removed
- **Manual guidance** - Clear instructions for applications that need manual setup
- **Audit trail** - Complete record of all changes made

### Notes

- Some changes require restarting applications (Dock, Finder, etc.)
- Use `killall Dock` to restart the Dock
- Use `killall Finder` to restart Finder
- Some settings may require a system restart to take full effect
- Check the generated summary files for detailed information about the installation/uninstallation process
