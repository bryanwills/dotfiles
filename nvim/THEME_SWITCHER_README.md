# Neovim Theme Switcher

This configuration provides a comprehensive theme switcher with 11 pre-configured dark themes and easy management tools.

## 🎨 Pre-loaded Dark Themes

1. **catppuccin-frappe** - Warm, cozy dark theme (default)
2. **dracula** - Classic dark theme with vibrant colors
3. **gruvbox** - Earthy, warm dark theme
4. **nord** - Cool blue-gray dark theme
5. **onedark** - Atom editor style dark theme
6. **nightfox** - Fox-inspired dark themes
7. **kanagawa** - Japanese-inspired dark theme
8. **oxocarbon** - Modern, clean dark theme
9. **moonfly** - Dark blue theme
10. **vscode** - VS Code dark theme
11. **one_monokai** - One Monokai dark theme

**Note**: tokyonight theme has been temporarily disabled due to loading issues.

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

## 🚨 Known Issues & Error Documentation

### ⚠️ Current Known Issues (Pinned for Later Fix)

The theme switcher is functional but has some error messages that need to be addressed in future updates.

#### Issue 1: "Plugin [theme_name] not found" Error
**Error Message:**
```
Plugin dracula/vim not found
Theme: dracula (2/11)
Press ENTER or type command to continue
```

**What Happens:**
- Theme switching works but shows error messages
- User must press ENTER to continue
- Theme actually loads successfully despite the error

**Root Cause:**
- Plugin loading detection has timing issues
- Some themes are loaded as `lazy = true` and not immediately available
- Error handling shows messages before themes are fully loaded

**Workaround:**
- Press ENTER when you see the error message
- Theme will work correctly after the error
- Not critical for daily use

#### Issue 2: "Press ENTER or type command to continue" Messages
**Error Message:**
```
Press ENTER or type command to continue
```

**What Happens:**
- Appears during theme switching
- Interrupts the user experience
- Requires manual intervention to continue

**Root Cause:**
- Error handling in theme availability checks
- Some themes trigger error messages that pause execution
- Silent command handling not fully implemented

**Workaround:**
- Press ENTER to continue
- Theme switching will complete successfully

#### Issue 3: Theme Loading Race Conditions
**Error Message:**
```
Theme [theme_name] not available, falling back to catppuccin-frappe
```

**What Happens:**
- Theme switcher tries to load themes before they're ready
- Falls back to default theme
- Can cause theme switching to appear broken

**Root Cause:**
- Lazy-loaded themes need time to initialize
- Plugin loading and theme application timing mismatch
- Error handling falls back too quickly

**Workaround:**
- Wait a moment between theme switches
- Restart Neovim if themes seem stuck
- Use `:ThemeDebug` to check theme status

### 🔧 Technical Details for Future Fixes

#### Files Involved:
- `nvim/lua/bryan/plugins/theme.lua` - Main theme switcher logic
- `nvim/lazy-lock.json` - Plugin dependency definitions

#### Key Functions to Investigate:
1. **`ensure_theme_loaded()`** - Plugin loading logic
2. **`is_theme_available()`** - Theme availability checking
3. **`switch_theme()`** - Main theme switching function

#### Areas for Improvement:
1. **Better plugin loading detection** - Check if plugins are truly ready
2. **Improved error handling** - Prevent "Press ENTER" messages
3. **Theme availability validation** - More reliable theme detection
4. **Silent operation** - Eliminate user interruptions

#### Debugging Commands:
- **`:ThemeDebug`** - Shows plugin loading status
- **`:ThemeTestTokyo`** - Tests specific theme loading (if tokyonight is re-enabled)
- **`:Lazy`** - Shows plugin manager status

### 🎯 Future Fix Priorities

#### High Priority:
1. **Eliminate "Press ENTER" messages** - Critical for user experience
2. **Fix plugin detection** - Prevent "Plugin not found" errors
3. **Improve error handling** - Graceful fallbacks without interruptions

#### Medium Priority:
1. **Re-enable tokyonight theme** - Once loading issues are resolved
2. **Optimize theme loading** - Reduce race conditions
3. **Better user feedback** - Clear status messages without errors

#### Low Priority:
1. **Add more themes** - Expand the collection
2. **Theme customization** - User-configurable options
3. **Performance optimization** - Faster theme switching

### 📝 Error Log for Developers

When investigating these issues, look for:
- **Plugin loading timing** in `ensure_theme_loaded()`
- **Error message generation** in theme switching functions
- **Silent command handling** in `vim.cmd()` calls
- **Plugin availability checks** in `lazy.get_plugin()`

#### Common Error Patterns:
1. **"Plugin [name] not found"** → Plugin loading issue
2. **"Press ENTER" messages** → Error handling problem
3. **Theme fallbacks** → Availability detection issue
4. **Race conditions** → Timing problems in plugin loading

---

**Status**: Theme switcher is functional but needs error handling improvements. All themes work correctly despite error messages. Consider this a "working prototype" that needs polish.
