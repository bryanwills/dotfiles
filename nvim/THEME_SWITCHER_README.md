# Neovim Theme Switcher

This configuration provides a comprehensive theme switcher with 12 pre-configured dark themes and easy management tools.

## 🎨 Pre-loaded Dark Themes

1. **catppuccin-frappe** - Warm, cozy dark theme (default)
2. **tokyonight** - Beautiful blue/purple dark theme
3. **dracula** - Classic dark theme with vibrant colors
4. **gruvbox** - Earthy, warm dark theme
5. **nord** - Cool blue-gray dark theme
6. **onedark** - Atom editor style dark theme
7. **nightfox** - Fox-inspired dark themes
8. **kanagawa** - Japanese-inspired dark theme
9. **oxocarbon** - Modern, clean dark theme
10. **rose-pine** - Rose-pine dark variant
11. **moonfly** - Dark blue theme
12. **vscode** - VS Code dark theme

## ⌨️ Keybindings

- **`<leader>tt`** - Switch to next theme
- **`<leader>tT`** - Switch to previous theme
- **`<leader>tl`** - List all available themes

## 🖥️ Commands

- **`:ThemeNext`** - Switch to next theme
- **`:ThemePrev`** - Switch to previous theme
- **`:ThemeList`** - List all themes with current selection
- **`:ThemeSet <theme_name>`** - Set specific theme
- **`:ThemeAdd <theme_name>`** - Add new theme to the list
- **`:ThemeRemove <theme_name>`** - Remove theme from the list
- **`:ThemeInstall`** - Install all missing themes automatically

## 🚀 How to Use

### First Time Setup
1. **Restart Neovim** to load the theme switcher
2. **Run `:ThemeInstall`** to install all missing themes
3. **Wait for installation** to complete
4. **Restart Neovim** or run `:Lazy sync` to finalize

### Quick Theme Switching
1. Press `<leader>tt` to cycle through themes
2. Each theme change shows a confirmation message
3. If a theme isn't available, it falls back to catppuccin-frappe

### List Available Themes
- Press `<leader>tl` or run `:ThemeList`
- Current theme is marked with `→`
- Shows theme number and name

### Set Specific Theme
- Run `:ThemeSet tokyonight` to set Tokyo Night theme
- Tab completion shows all available themes

## 🔧 Adding New Themes

### Method 1: Using Commands
```vim
:ThemeAdd <theme_name>
```

### Method 2: Edit the File
1. Open `nvim/lua/bryan/plugins/theme.lua`
2. Add your theme to the `themes` table:
   ```lua
   local themes = {
     "catppuccin-frappe",
     "your_new_theme",  -- Add here
     "tokyonight",
     -- ... other themes
   }
   ```
3. Add the plugin configuration below the themes table
4. Restart Neovim or run `:Lazy sync`

### Method 3: Install via Lazy
1. Add the theme plugin to your configuration
2. Run `:ThemeAdd <theme_name>`
3. The theme will be added to your switcher

## 📦 Installing Missing Themes

### Automatic Installation (Recommended)
```vim
:ThemeInstall
```
This will install all themes in your list automatically.

### Manual Installation
If you get "theme not available" messages, install the missing theme:

```vim
:Lazy install <theme_name>
```

For example:
```vim
:Lazy install tokyonight.nvim
:Lazy install dracula/vim
:Lazy install gruvbox.nvim
```

## 🚨 Troubleshooting "Theme Not Available"

### Common Issue
If you see "Theme tokyonight not available, falling back to catppuccin-frappe":

1. **Run `:ThemeInstall`** to install all themes
2. **Wait for installation** to complete
3. **Restart Neovim** or run `:Lazy sync`
4. **Try switching themes again** with `<leader>tt`

### Why This Happens
- Themes are installed as `lazy = true` (only load when needed)
- The theme switcher runs before themes are loaded
- Some themes need to be installed first

### Alternative Solutions
- **Manual sync**: `:Lazy sync`
- **Check status**: `:Lazy` to see installed plugins
- **Force reload**: Restart Neovim completely

## 🎯 Theme Configuration

Each theme comes with optimized settings for:
- **Transparency**: Disabled by default (better for terminals)
- **Italics**: Enabled where supported
- **Bold**: Enabled where supported
- **Terminal colors**: Optimized for terminal compatibility

## 🔄 Customization

### Modify Theme Settings
Edit the `config` function for any theme in `theme.lua`:

```lua
{
  "folke/tokyonight.nvim",
  lazy = true,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,  -- Change this
      -- ... other options
    })
  end,
}
```

### Add Custom Themes
1. Find a theme you like on GitHub
2. Add it to the themes table
3. Add the plugin configuration
4. Customize the settings as needed

## 🐛 Troubleshooting

### Theme Not Loading
1. Check if the plugin is installed: `:Lazy`
2. Install missing plugins: `:ThemeInstall` (recommended) or `:Lazy install <plugin_name>`
3. Check for errors: `:checkhealth`

### Theme Looks Wrong
1. Ensure your terminal supports true colors
2. Check if your terminal theme conflicts
3. Try a different theme variant

### Keybindings Not Working
1. Ensure the theme switcher loaded (check startup messages)
2. Verify your leader key is set correctly
3. Check for conflicting keybindings

### "Theme Not Available" Error
1. **First**: Run `:ThemeInstall`
2. **Wait**: For installation to complete
3. **Restart**: Neovim or run `:Lazy sync`
4. **Try again**: Use `<leader>tt` to switch themes

## 🌟 Popular Theme Sources

- **GitHub**: Search for "neovim theme" or "vim colorscheme"
- **Neovim Awesome**: https://github.com/rockerBOO/awesome-neovim
- **Vim Awesome**: https://vimawesome.com/

## 📝 Example: Adding a Custom Theme

```lua
-- Add to themes table
local themes = {
  "catppuccin-frappe",
  "my_custom_theme",  -- Add this
  "tokyonight",
  -- ... other themes
}

-- Add plugin configuration
{
  "username/my_custom_theme.nvim",
  lazy = true,
  config = function()
    require("my_custom_theme").setup({
      -- your custom settings
    })
  end,
}
```

## 🎨 Theme Recommendations

### For Coding
- **tokyonight** - Excellent syntax highlighting
- **gruvbox** - Easy on the eyes for long sessions
- **onedark** - Familiar Atom-style colors

### For Terminal
- **catppuccin-frappe** - Great terminal compatibility
- **dracula** - Vibrant and clear
- **nord** - Professional appearance

### For Customization
- **rose-pine** - Highly customizable
- **nightfox** - Multiple variants
- **kanagawa** - Unique aesthetic

---

**Note**: All themes are configured for dark mode only. Light themes are not included by default.

## 🚀 Quick Start Checklist

- [ ] Restart Neovim
- [ ] Run `:ThemeInstall`
- [ ] Wait for installation
- [ ] Restart Neovim or run `:Lazy sync`
- [ ] Try `<leader>tt` to switch themes
- [ ] Use `<leader>tl` to see all themes
