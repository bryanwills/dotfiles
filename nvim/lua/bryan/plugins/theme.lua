---@diagnostic disable: undefined-global

return {
  -- Default theme (catppuccin-frappe)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])

      -- Theme switcher configuration
      local themes = {
        "catppuccin-frappe",    -- Current default (warm dark)
        -- "tokyonight",           -- Beautiful blue/purple dark (temporarily disabled)
        "dracula",              -- Classic dark theme
        "gruvbox",              -- Earthy, warm dark
        "nord",                 -- Cool blue-gray dark
        "onedark",              -- Atom editor style dark
        "nightfox",             -- Fox-inspired dark themes
        "kanagawa",             -- Japanese-inspired dark
        "oxocarbon",            -- Modern dark theme
        "moonfly",              -- Dark blue theme
        "vscode",               -- VS Code dark theme
        "one_monokai",          -- One Monokai dark theme
      }

      local current_theme = 1

      -- Function to check if a theme is truly available
      local function is_theme_available(theme_name)
        if theme_name == "catppuccin-frappe" then
          return true
        end

        -- Simple check: try to apply the theme and see if it works
        local success = pcall(function()
          vim.cmd("silent! colorscheme " .. theme_name)
        end)

        return success
      end

      -- Function to ensure theme is loaded
      local function ensure_theme_loaded(theme_name)
        -- Check if theme is already loaded
        if theme_name == "catppuccin-frappe" then
          return true
        end

        -- Try to load the theme plugin using the correct plugin names
        local success = pcall(require, "lazy")
        if success then
          local lazy = require("lazy")

          -- Map theme names to actual plugin names
          local plugin_map = {
            -- ["tokyonight"] = "tokyonight.nvim",  -- Temporarily disabled
            ["dracula"] = "dracula/vim",
            ["gruvbox"] = "gruvbox.nvim",
            ["nord"] = "nord.nvim",
            ["onedark"] = "onedark.vim",
            ["nightfox"] = "nightfox.nvim",
            ["kanagawa"] = "kanagawa.nvim",
            ["oxocarbon"] = "oxocarbon.nvim",
            ["moonfly"] = "vim-moonfly-colors",
            ["vscode"] = "vscode.nvim",
            ["one_monokai"] = "one_monokai.nvim",
          }

          local plugin_name = plugin_map[theme_name]
          if plugin_name then
            -- Check if plugin is already loaded first
            local plugin_loaded = pcall(function()
              return lazy.get_plugin(plugin_name)
            end)

            if not plugin_loaded then
              -- Try to load the plugin silently
              success = pcall(function()
                lazy.load({ plugins = { plugin_name } })
              end)

              -- Wait a bit for the plugin to load
              if success then
                vim.wait(200, function() return false end, 20)
              end
            else
              success = true
            end
          end
        end

        return success
      end

      -- Function to switch to next theme
      local function switch_theme()
        current_theme = current_theme % #themes + 1
        local theme_name = themes[current_theme]

        print("Switching to theme: " .. theme_name)

        -- Try to load the theme first
        local load_success = ensure_theme_loaded(theme_name)

        -- Try to apply the theme directly
        local success = pcall(function()
          vim.cmd("silent! colorscheme " .. theme_name)
        end)

        if success then
          print("Theme: " .. theme_name .. " (" .. current_theme .. "/" .. #themes .. ")")
        else
          print("Theme " .. theme_name .. " not available, falling back to catppuccin-frappe")
          vim.cmd("silent! colorscheme catppuccin-frappe")
          current_theme = 1
        end
      end

      -- Function to switch to previous theme
      local function switch_theme_prev()
        current_theme = current_theme - 1
        if current_theme < 1 then
          current_theme = #themes
        end

        local theme_name = themes[current_theme]

        -- Try to load the theme first
        local load_success = ensure_theme_loaded(theme_name)

        -- Try to apply the theme directly
        local success = pcall(function()
          vim.cmd("silent! colorscheme " .. theme_name)
        end)

        if success then
          print("Theme: " .. theme_name .. " (" .. current_theme .. "/" .. #themes .. ")")
        else
          print("Theme " .. theme_name .. " not available, falling back to catppuccin-frappe")
          vim.cmd("silent! colorscheme catppuccin-frappe")
          current_theme = 1
        end
      end

      -- Function to set specific theme by name
      local function set_theme(theme_name)
        for i, theme in ipairs(themes) do
          if theme == theme_name then
            current_theme = i

            -- Try to load the theme first
            local load_success = ensure_theme_loaded(theme_name)

            -- Try to apply the theme directly
            local success = pcall(function()
              vim.cmd("silent! colorscheme " .. theme_name)
            end)

            if success then
              print("Theme set to: " .. theme_name)
            else
              print("Theme " .. theme_name .. " not available")
            end
            return
          end
        end
        print("Theme " .. theme_name .. " not found in theme list")
      end

      -- Function to list all available themes
      local function list_themes()
        print("Available themes:")
        for i, theme in ipairs(themes) do
          local marker = (i == current_theme) and " → " or "   "
          local status = is_theme_available(theme) and "✓" or "✗"
          print(marker .. i .. ". " .. theme .. " " .. status)
        end
      end

      -- Function to add a new theme to the list
      local function add_theme(theme_name)
        -- Check if theme already exists
        for _, theme in ipairs(themes) do
          if theme == theme_name then
            print("Theme " .. theme_name .. " already exists in the list")
            return
          end
        end

        -- Add new theme
        table.insert(themes, theme_name)
        print("Theme " .. theme_name .. " added to the list")
        print("Total themes: " .. #themes)
      end

      -- Function to remove a theme from the list
      local function remove_theme(theme_name)
        for i, theme in ipairs(themes) do
          if theme == theme_name then
            table.remove(themes, i)
            print("Theme " .. theme_name .. " removed from the list")

            -- Adjust current theme if needed
            if current_theme > #themes then
              current_theme = 1
            end

            print("Total themes: " .. #themes)
            return
          end
        end
        print("Theme " .. theme_name .. " not found in the list")
      end

      -- Function to install missing themes
      local function install_missing_themes()
        print("Installing missing themes...")
        local lazy = require("lazy")

        -- Map theme names to actual plugin names
        local plugin_map = {
          -- ["tokyonight"] = "tokyonight.nvim",  -- Temporarily disabled
          ["dracula"] = "dracula/vim",
          ["gruvbox"] = "gruvbox.nvim",
          ["nord"] = "nord.nvim",
          ["onedark"] = "onedark.vim",
          ["nightfox"] = "nightfox.nvim",
          ["kanagawa"] = "kanagawa.nvim",
          ["oxocarbon"] = "oxocarbon.nvim",
          ["moonfly"] = "vim-moonfly-colors",
          ["vscode"] = "vscode.nvim",
          ["one_monokai"] = "one_monokai.nvim",
        }

        for _, theme_name in ipairs(themes) do
          if theme_name ~= "catppuccin-frappe" then
            local plugin_name = plugin_map[theme_name]
            if plugin_name then
              print("Installing " .. theme_name .. " (" .. plugin_name .. ")...")
              pcall(function()
                lazy.install({ plugins = { plugin_name } })
              end)
            else
              print("Warning: No plugin mapping found for " .. theme_name)
            end
          end
        end

        print("Theme installation complete! Restart Neovim or run :Lazy sync")
      end

      -- Set up keybindings for theme switching
      vim.keymap.set("n", "<leader>tt", switch_theme, { desc = "Next theme" })
      vim.keymap.set("n", "<leader>tT", switch_theme_prev, { desc = "Previous theme" })
      vim.keymap.set("n", "<leader>tl", list_themes, { desc = "List themes" })

      -- Commands for theme management
      vim.api.nvim_create_user_command("ThemeNext", switch_theme, {})
      vim.api.nvim_create_user_command("ThemePrev", switch_theme_prev, {})
      vim.api.nvim_create_user_command("ThemeList", list_themes, {})
      vim.api.nvim_create_user_command("ThemeSet", function(args)
        set_theme(args.args)
      end, { nargs = 1, complete = function()
        return themes
      end })
      vim.api.nvim_create_user_command("ThemeAdd", function(args)
        add_theme(args.args)
      end, { nargs = 1 })
      vim.api.nvim_create_user_command("ThemeRemove", function(args)
        remove_theme(args.args)
      end, { nargs = 1, complete = function()
        return themes
      end })
      vim.api.nvim_create_user_command("ThemeInstall", install_missing_themes, {})

      -- Debug command to check theme availability
      vim.api.nvim_create_user_command("ThemeDebug", function()
        print("=== THEME DEBUG INFO ===")
        print("Available themes in list:")
        for i, theme in ipairs(themes) do
          local marker = (i == current_theme) and " → " or "   "
          local status = is_theme_available(theme) and "✓" or "✗"
          print(marker .. i .. ". " .. theme .. " " .. status)
        end

        print("\nCurrent theme: " .. themes[current_theme])
        print("Total themes: " .. #themes)

        print("\nLazy plugin status:")
        local lazy_success = pcall(require, "lazy")
        if lazy_success then
          local lazy = require("lazy")
          print("  ✓ Lazy loaded successfully")

          -- Check plugin status for each theme
          print("\nPlugin status:")
          local plugin_map = {
            ["dracula"] = "dracula/vim",
            ["gruvbox"] = "gruvbox.nvim",
            ["nord"] = "nord.nvim",
            ["onedark"] = "onedark.vim",
            ["nightfox"] = "nightfox.nvim",
            ["kanagawa"] = "kanagawa.nvim",
            ["oxocarbon"] = "oxocarbon.nvim",
            ["moonfly"] = "vim-moonfly-colors",
            ["vscode"] = "vscode.nvim",
            ["one_monokai"] = "one_monokai.nvim",
          }

          for theme_name, plugin_name in pairs(plugin_map) do
            local plugin_loaded = pcall(function()
              return lazy.get_plugin(plugin_name)
            end)
            local status = plugin_loaded and "✓" or "✗"
            print("  " .. status .. " " .. theme_name .. " → " .. plugin_name)
          end
        else
          print("  ✗ Failed to load Lazy")
        end
      end, {})

      -- Test command to manually load tokyonight
      vim.api.nvim_create_user_command("ThemeTestTokyo", function()
        print("=== TESTING TOKYONIGHT LOADING ===")

        -- Try to load the plugin first
        local lazy_success = pcall(require, "lazy")
        if lazy_success then
          local lazy = require("lazy")
          print("1. Lazy loaded successfully")

          -- Try to load tokyonight plugin
          local load_success = pcall(function()
            lazy.load({ plugins = { "tokyonight.nvim" } })
          end)
          print("2. Plugin load attempt: " .. tostring(load_success))

          -- Wait a bit
          vim.wait(200, function() return false end, 20)
          print("3. Waited for plugin to load")

          -- Try to apply the theme
          local theme_success = pcall(vim.cmd, "colorscheme tokyonight")
          print("4. Theme application: " .. tostring(theme_success))

          if not theme_success then
            print("5. Error: " .. tostring(vim.api.nvim_get_vvar("errmsg")))
          end
        else
          print("Failed to load Lazy")
        end
      end, {})

      -- Silent startup - no messages unless there's an error
      -- print("Theme switcher loaded! Use <leader>tt to switch themes")
      -- print("Run :ThemeInstall to install all missing themes")
    end,
  },

  -- Additional popular dark themes
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "night", -- night, storm, day, moon
  --       transparent = false,
  --       terminal_colors = true,
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = true },
  --         functions = {},
  --         variables = {},
  --         sidebars = "dark",
  --         floats = "dark",
  --       },
  --       sidebars = { "qf", "help", "terminal", "NvimTree", "toggleterm", "lazy" },
  --       day_brightness = 0.3,
  --       hide_inactive_statusline = false,
  --       dim_inactive = false,
  --       lualine_bold = false,
  --       on_colors = function(colors)
  --         colors.hint = colors.orange1
  --         colors.error = colors.red1
  --       end,
  --       on_highlights = function(hl, c)
  --         local prompt = "#2d3149"
  --         hl.TelescopeNormal = {
  --           bg = c.bg_dark,
  --           ctermbg = c.bg_dark,
  --         }
  --         hl.TelescopeBorder = {
  --           bg = c.bg_dark,
  --           ctermbg = c.bg_dark,
  --         }
  --         hl.TelescopeSelectionCaret = {
  --           bg = c.bg_dark,
  --           ctermbg = c.bg_dark,
  --         }
  --       end,
  --     })
  --   end,
  -- },

  {
    "dracula/vim",
    lazy = true,
    config = function()
      -- Dracula theme is loaded automatically when the plugin is loaded
      -- No additional configuration needed
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard", -- soft, medium, hard
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end,
  },

  {
    "shaunsingh/nord.nvim",
    lazy = true,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },

  {
    "joshdick/onedark.vim",
    lazy = true,
    config = function()
      vim.g.onedark_style = "dark"
      vim.g.onedark_italic_comment = 1
      vim.g.onedark_italic_strings = 1
      vim.g.onedark_italic_keywords = 1
      vim.g.onedark_italic_functions = 1
      vim.g.onedark_italic_variables = 1
      vim.g.onedark_contrast_background = "hard"
      vim.g.onedark_hide_endofbuffer = 1
      vim.g.onedark_terminal_italics = 1
      vim.g.onedark_terminal_colors = 1
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          terminal_colors = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        -- Simplified overrides to prevent the "invalid key: text" error
        overrides = function(colors)
          return colors
        end,
        theme = "wave",
        background = {
          dark = "wave",
          light = "lotus",
        },
      })
    end,
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    config = function()
      vim.opt.background = "dark"
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    lazy = true,
    config = function()
      vim.g.moonflyTransparent = false
      vim.g.moonflyItalics = true
      vim.g.moonflyTerminalColors = true
      vim.g.moonflyWinSeparator = 2
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    config = function()
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = false,
        color_overrides = {},
        group_overrides = {},
      })
    end,
  },

  -- One Monokai theme
  {
    "bryanwills/one_monokai.nvim",
    lazy = true,
    config = function()
      -- One Monokai is a dark theme, no additional configuration needed
      vim.opt.background = "dark"
    end,
  },
}
