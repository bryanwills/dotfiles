# dotfiles

My Personal dotfiles for macOS, featuring a highly customized development environment with Neovim, Tmux, Zsh, Fish shell, and Cursor IDE.

## 🚀 Features

### **Terminal & Shell**
- **Zsh** with **Oh My Zsh** and **powerlevel10k** theme
- **Fish** with **Oh My Fish** and **Tide v6** theme (Powerlevel10k equivalent)
- **Tmux** with clean Dracula theme and enhanced keybindings
- **Kitty** terminal emulator configuration
- **Btop** system monitoring with custom themes

### **IDE & Editor**
- **Cursor IDE** configuration with sound disabled and optimized settings
- **Neovim (NVIM)** with Lazy.nvim plugin manager
- **LSP** support with auto-completion and diagnostics
- **Tree-sitter** for syntax highlighting
- **Telescope** for fuzzy finding
- **Linting** with nvim-lint
- **Formatting** with conform.nvim
- **Git integration** with gitsigns and lazygit
- **Markdown support** with preserved ASCII diagrams

### **Tmux Configuration**
- **Clean status bar** with essential info only (hostname, path, date)
- **Dracula color theme** with subtle separators
- **Enhanced keybindings** for pane/window/session management
- **Multiple cheat sheet options**:
  - Quick reference (`prefix + ?`)
  - Popup style (`prefix + C-?`) - disappears on Escape
  - Floating window (`prefix + C-h`) - persistent reference
- **TPM plugins**: tmux-yank, tmux-open, tmux-copycat, tmux-resurrect, tmux-continuum
- **Shell integration** for proper powerlevel10k prompt

### **Development Tools**
- **Git** configuration with aliases and hooks
- **LazyGit** for Git operations
- **Rust** toolchain setup
- **Node.js** and **pnpm** configuration
- **Python** environment management

## 📁 Repository Structure

```
.config/
├── nvim/                    # Neovim configuration
│   ├── lua/bryan/          # Custom Neovim modules
│   │   ├── core/           # Core settings and options
│   │   ├── plugins/        # Plugin configurations
│   │   └── templates/      # File templates
│   ├── after/              # Filetype-specific settings
│   └── init.lua            # Neovim entry point
├── cursor/                  # Cursor IDE configuration
│   ├── config.json         # Main Cursor settings
│   ├── argv.jsonc          # Cursor launch arguments
│   └── mcp.json.template   # MCP configuration template
├── fish/                    # Fish shell configuration
│   ├── config.fish         # Main Fish configuration
│   ├── conf.d/             # Fish configuration snippets
│   ├── functions/          # Custom Fish functions
│   └── themes/             # Fish theme configurations
├── tmux/                   # Tmux configuration
│   ├── tmux.conf          # Main tmux config
│   └── plugins/           # TPM plugins (managed by TPM)
├── zsh/                    # Zsh configuration
│   ├── .zshrc             # Main zsh config
│   └── oh-my-zsh/         # Oh My Zsh installation
├── kitty/                  # Kitty terminal config
├── btop/                   # Btop system monitor config
├── scripts/                # macOS customization scripts
└── README.md               # This file
```

## 🛠️ Installation

### **Prerequisites**
- macOS (tested on M2 Max)
- Homebrew installed
- Git installed

### **Quick Install**
```bash
# Clone the repository
git clone https://github.com/bryanwills/dotfiles.git ~/.config

# Run the installation script
cd ~/.config
./scripts/install.sh
```

### **Manual Installation**
```bash
# Clone to your preferred location
git clone https://github.com/bryanwills/dotfiles.git

# Create symlinks (adjust paths as needed)
ln -s ~/path/to/dotfiles/nvim ~/.config/nvim
ln -s ~/path/to/dotfiles/tmux ~/.config/tmux
ln -s ~/path/to/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/path/to/dotfiles/kitty ~/.config/kitty
ln -s ~/path/to/dotfiles/btop ~/.config/btop
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

### **Fish Shell Setup**
1. **Install Fish shell**:
   ```bash
   brew install fish
   ```

2. **Install Oh My Fish**:
   ```bash
   curl -L https://get.oh-my.fish | fish
   ```

3. **Install Tide theme**:
   ```bash
   omf install tide@v6
   ```

4. **Set Fish as default shell** (optional):
   ```bash
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```

### **Cursor IDE Setup**
1. **Configuration location**: `~/.config/cursor/`
2. **Sound settings**: All audio cues and notifications are disabled by default
3. **Launch arguments**: Optimized for performance and stability
4. **MCP integration**: Template provided for Model Context Protocol setup

## 📚 macOS Customization Scripts

### **Available Scripts**
- **`scripts/install.sh`** - Complete installation script
- **`scripts/uninstall.sh`** - Uninstallation and cleanup
- **`scripts/macos-customizations.sh`** - macOS system preferences
- **`scripts/dependencies.sh`** - Dependency checker
- **`scripts/clean-ds-store.sh`** - Clean up .DS_Store files

### **macOS Customizations Applied**
- Screenshot settings (PNG format, custom save location)
- Dock preferences (auto-hide, fast animations)
- File system settings (show extensions, iCloud preferences)
- .DS_Store prevention on network and USB drives

## 🔄 Maintenance

### **Updating Plugins**
- **Tmux**: `prefix + I` to install/update plugins
- **Neovim**: Plugins update automatically via Lazy.nvim
- **Zsh**: `omz update` to update Oh My Zsh
- **Fish**: `omf update` to update Oh My Fish

### **Reloading Configurations**
- **Tmux**: `prefix + r`
- **Neovim**: Restart or `:Lazy sync`
- **Zsh**: `source ~/.zshrc`
- **Fish**: `source ~/.config/fish/config.fish`
- **Cursor**: Restart application for config changes

### **Backup and Restore**
- **Install script** creates backups automatically
- **Uninstall script** restores original configurations
- **Git history** tracks all configuration changes

## 🎨 Themes and Appearance

### **Color Schemes**
- **Dracula** theme for tmux
- **Custom** Neovim color scheme
- **powerlevel10k** for Zsh prompt
- **Tide v6** for Fish shell (Powerlevel10k equivalent)
- **Dark mode** optimized for development

### **Fonts**
- **JetBrains Mono** recommended for Neovim
- **SF Mono** for macOS terminal
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

## 🤝 Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Neovim** community for the excellent editor
- **Tmux** developers and plugin authors
- **Oh My Zsh** and **powerlevel10k** teams
- **Homebrew** maintainers for package management

---

**Note**: These dotfiles are configured for macOS and may need adjustments for other operating systems.
