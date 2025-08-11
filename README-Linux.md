# Linux Dotfiles

This is the Linux-specific version of the dotfiles repository, optimized for Debian-based Linux systems and headless servers.

## 🚀 What's Included (Linux-Compatible)

### **Core Development Environment**
- **Neovim (NVIM)** - Full configuration with LSP, Tree-sitter, and plugins
- **Tmux** - Enhanced configuration with Dracula theme and cheat sheets
- **Zsh** - Configured with Oh My Zsh and powerlevel10k theme
- **Git** - Comprehensive configuration with aliases and hooks

### **System Monitoring & Management**
- **Btop** - Beautiful system monitoring
- **Htop** - Alternative system monitor
- **Bpytop** - Python-based system monitor
- **Neofetch** - System information display

### **File Management**
- **Ranger** - Terminal file manager
- **Nnn** - Fast terminal file manager
- **Yazi** - Modern file manager
- **Superfile** - File manager
- **Bat** - Better cat with syntax highlighting
- **Eza** - Better ls with colors and icons

### **Development Tools**
- **Cargo** - Rust package manager
- **Mise** - Tool version manager
- **UV** - Fast Python package manager
- **LazyGit** - Git TUI
- **GitHub CLI** - GitHub command line interface

### **Network & Cloud Tools**
- **Curl** - HTTP client
- **Rclone** - Cloud storage sync
- **Wireshark** - Network protocol analyzer
- **Naabu** - Port scanner

### **System Utilities**
- **Nano** - Text editor
- **GnuPG** - Encryption and signing
- **Ueberzugpp** - Image preview in terminal
- **Humanlog** - Human-readable logs

### **Shell & Environment**
- **Envman** - Environment manager
- **Zoxide** - Smart cd command
- **Crossnote** - Note taking
- **SPF** - Shell prompt framework
- **Contour** - Terminal emulator

## 🚫 What's Excluded (macOS-Specific)

The following dotfiles are **NOT included** on Linux as they are macOS-specific:

### **Terminal Emulators**
- Ghostty
- iTerm2
- Kitty

### **macOS Applications**
- Obsidian
- Raycast
- Sketchybar
- Xcode build tools

### **macOS-Specific Tools**
- Flipperdevices.com
- FileZilla
- Joplin Desktop
- PowerShell (macOS version)
- Flutter (macOS config)
- Cursor editor
- Zed editor
- Claude AI

### **macOS Package Managers**
- npm (macOS config)
- pnpm (macOS config)
- PostgreSQL (macOS config)

### **macOS System Files**
- .DS_Store files
- macOS-specific configurations
- macOS-specific browser configs

## 🛠️ Installation

### **Prerequisites**
- Debian-based Linux system (Ubuntu, Debian, etc.)
- Git installed
- Sudo access for package installation
- Homebrew (Linux) recommended (optional)

### **Quick Install**
```bash
# Clone the repository
git clone https://github.com/bryanwills/dotfiles.git ~/.config

# Run the Linux installation script
cd ~/.config
./scripts/install-linux.sh
```

### **Manual Installation**
```bash
# Clone to your preferred location
git clone https://github.com/bryanwills/dotfiles.git

# Create symlinks manually (adjust paths as needed)
ln -s ~/path/to/dotfiles/nvim ~/.config/nvim
ln -s ~/path/to/dotfiles/tmux ~/.config/tmux
ln -s ~/path/to/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/path/to/dotfiles/git ~/.config/git
ln -s ~/path/to/dotfiles/btop ~/.config/btop
# ... add other dotfiles as needed
```

## 🔧 Configuration

### **Tmux Setup**
1. **Install TPM** (if not already installed):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```

2. **Install plugins**:
   - Start tmux
   - Press `prefix + I` (Ctrl+a, then Shift+i)

3. **Reload configuration**:
   - Press `prefix + r` (Ctrl+a, then r)

### **Neovim Setup**
1. **Install dependencies**:
   ```bash
   # Install language servers
   npm install -g typescript typescript-language-server
   npm install -g @tailwindcss/language-server
   npm install -g prettier
   ```

2. **First launch**:
   - Neovim will automatically install plugins on first run
   - Wait for installation to complete

### **Zsh Setup**
1. **Install Oh My Zsh**:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Install powerlevel10k**:
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```

## 🎯 Key Bindings

### **Tmux Keybindings**
- **`prefix + r`** - Reload tmux configuration
- **`prefix + ?`** - Show quick cheat sheet
- **`prefix + C-?`** - Show popup cheat sheet (Escape to close)
- **`prefix + C-h`** - Toggle floating cheat sheet window
- **`prefix + v`** - Vertical split
- **`prefix + s`** - Horizontal split
- **`prefix + h/j/k/l`** - Navigate panes
- **`prefix + c`** - New window
- **`prefix + n/p`** - Next/previous window
- **`prefix + d`** - Detach session

### **Neovim Keybindings**
- **`<leader>e`** - Toggle file explorer
- **`<leader>ff`** - Find files
- **`<leader>fg`** - Live grep
- **`<leader>fb`** - Find buffers
- **`<leader>gd`** - Go to definition
- **`<leader>gr`** - Go to references
- **`<leader>ca`** - Code actions
- **`<leader>rn`** - Rename symbol

## 🔄 Maintenance

### **Updating Plugins**
- **Tmux**: `prefix + I` to install/update plugins
- **Neovim**: Plugins update automatically via Lazy.nvim
- **Zsh**: `omz update` to update Oh My Zsh

### **Reloading Configurations**
- **Tmux**: `prefix + r`
- **Neovim**: Restart or `:Lazy sync`
- **Zsh**: `source ~/.zshrc`

### **Backup and Restore**
- **Install script** creates backups automatically
- **Git history** tracks all configuration changes

## 🎨 Themes and Appearance

### **Color Schemes**
- **Dracula** theme for tmux
- **Custom** Neovim color scheme
- **powerlevel10k** for Zsh prompt
- **Dark mode** optimized for development

### **Fonts**
- **JetBrains Mono** recommended for Neovim
- **System fonts** for Linux terminal
- **Nerd Fonts** for icons and symbols

## 🐛 Troubleshooting

### **Common Issues**
1. **Tmux plugins not working**: Run `prefix + I` to install
2. **Neovim slow startup**: Check plugin installation with `:Lazy`
3. **Zsh prompt issues**: Verify powerlevel10k installation
4. **Permission errors**: Check file ownership and symlinks

### **Getting Help**
- Check the generated log files from install scripts
- Review the cheat sheets (`prefix + ?` in tmux)
- Check Neovim health with `:checkhealth`

## 📝 Notes

- **Username Detection**: The install script automatically detects the current username
- **Homebrew Integration**: Supports Linuxbrew at `/home/linuxbrew/.linuxbrew/bin/brew`
- **Package Management**: Automatically installs missing packages via apt/apt-get
- **Backup**: All existing dotfiles are backed up before installation
- **Shell**: Automatically sets zsh as default shell if available

## 🤝 Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: These dotfiles are specifically configured for Linux systems and exclude macOS-specific configurations.
