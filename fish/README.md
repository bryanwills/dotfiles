# Fish Shell Configuration

This directory contains the Fish shell configuration migrated from your Zsh setup.

## 🐟 What is Fish?

Fish (Friendly Interactive Shell) is a smart and user-friendly command line shell for Linux, macOS, and the rest of the family. Fish includes features like:

- **Smart suggestions** based on command history
- **Syntax highlighting** for commands
- **Web-based configuration** interface
- **Man page completions** built-in
- **Cross-platform** compatibility

## 📁 File Structure

```
fish/
├── config.fish              # Main configuration file
├── conf.d/                  # Configuration snippets
│   ├── aliases.fish        # Aliases configuration
│   ├── env.fish            # Environment variables
│   ├── omf.fish            # Oh My Fish configuration
│   ├── paths.fish          # PATH configuration
│   └── tools.fish          # Tool initialization
├── functions/               # Custom functions
│   ├── git.fish            # Git wrapper function
│   └── git-setup-auto.fish # Git auto-setup function
└── oh-my-fish/             # Oh My Fish installation
```

## 🚀 How to Use

### 1. **Launch Fish Shell**
```bash
fish
```

### 2. **Make Fish Your Default Shell (Optional)**
```bash
# Add Fish to /etc/shells
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells

# Change default shell
chsh -s /opt/homebrew/bin/fish

# Revert to Zsh if needed
chsh -s /bin/zsh
```

### 3. **Install Oh My Fish Plugins**
```bash
# Install useful plugins
omf install fzf
omf install z
omf install git
omf install nvm
omf install rbenv

# List available themes
omf theme

# Change theme
omf theme agnoster
```

## 🔧 Configuration Features

### **Migrated from Zsh:**
- ✅ All your aliases (ls, ll, git, etc.)
- ✅ Environment variables (JAVA_HOME, ANDROID_HOME, etc.)
- ✅ PATH configurations
- ✅ Git wrapper functions
- ✅ Tool initializations (NVM, rbenv, mise, zoxide)
- ✅ FZF configuration

### **Fish-Specific Features:**
- 🎨 Oh My Fish theme system
- 🚀 Smart command suggestions
- 🌈 Syntax highlighting
- 📚 Built-in help system

## 🔄 Switching Between Shells

- **Zsh**: `zsh` (your default)
- **Fish**: `fish`
- **Bash**: `bash`

## 📚 Useful Fish Commands

```bash
# Fish help
help

# Oh My Fish help
omf help

# List functions
functions

# List aliases
alias

# Edit configuration
fish_config
```

## 🎯 Key Differences from Zsh

1. **Syntax**: Fish uses `set -gx` instead of `export`
2. **Functions**: Fish functions use `function` keyword
3. **Conditionals**: Fish uses `if test` instead of `if [[ ]]`
4. **Arrays**: Fish uses `$argv` instead of `$@`
5. **PATH**: Fish uses `fish_add_path` instead of `export PATH`

## 🚨 Troubleshooting

### **If Fish doesn't start:**
```bash
# Check Fish installation
which fish

# Reinstall Fish
brew reinstall fish

# Check configuration syntax
fish -n
```

### **If Oh My Fish doesn't work:**
```bash
# Reinstall Oh My Fish
rm -rf ~/.local/share/omf
cd fish/oh-my-fish
./bin/install --offline
```

## 🔗 Related Files

- **Zsh config**: `~/.config/zsh/.zshrc`
- **Fish config**: `~/.config/fish/config.fish`
- **System shell**: `/etc/shells`

## 💡 Tips

1. **Keep Zsh as default** - Fish is available when you want it
2. **Use Fish for development** - Better completions and suggestions
3. **Customize themes** - Oh My Fish has many beautiful themes
4. **Learn Fish syntax** - It's simpler than Zsh in many ways

---

**Note**: Your Zsh configuration remains unchanged and fully functional. Fish is an additional option that you can use alongside Zsh.
