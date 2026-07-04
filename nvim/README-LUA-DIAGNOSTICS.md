# Neovim Lua Diagnostics Setup

## Overview

This directory contains configuration to suppress false positive "Undefined global `vim`" warnings in Neovim Lua configuration files.

## Files

### Configuration Files

- `.luarc.json` - Standard Lua language server configuration
- `.luarc` - Alternative configuration file (some IDEs prefer this)

### Templates

- `lua/bryan/templates/plugin-template.lua` - Template for new plugin configurations
- `lua/bryan/templates/core-template.lua` - Template for core configuration files

## Key Settings

### Diagnostic Suppression

```json
"Lua.diagnostics.disable": [
  "undefined-global"
]
```

### Global Variables

```json
"Lua.diagnostics.globals": [
  "vim",
  "require"
]
```

## Usage

### For New Plugin Files

1. Copy `lua/bryan/templates/plugin-template.lua`
2. Replace `"plugin-name/plugin-repo"` with your plugin
3. Add your configuration in the `config` function

### For New Core Files

1. Copy `lua/bryan/templates/core-template.lua`
2. Add your configuration after the diagnostic comment

## Why This Setup

- **False Positives**: The `vim` global is only available in Neovim's runtime environment
- **IDE Compatibility**: Different IDEs may use different configuration files
- **Future-Proof**: Templates ensure new files automatically include suppression

## Troubleshooting

If you see "Undefined global `vim`" warnings:

1. Ensure the file starts with `---@diagnostic disable: undefined-global`
2. Check that `.luarc.json` or `.luarc` exists in the nvim directory
3. Restart your IDE to reload the language server
4. Try reloading the window (VS Code: Cmd+Shift+P → "Developer: Reload Window")

## Best Practices

- Always include `---@diagnostic disable: undefined-global` at the top of nvim Lua files
- Use the provided templates for new files
- Keep the configuration files updated if you add new global variables
