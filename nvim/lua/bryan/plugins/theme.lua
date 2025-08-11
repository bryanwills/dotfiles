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
        "tokyonight",           -- Beautiful blue/purple dark
        "dracula",              -- Classic dark theme
        "gruvbox",              -- Earthy, warm dark
        "nord",                 -- Cool blue-gray dark
        "onedark",              -- Atom editor style dark
        "nightfox",             -- Fox-inspired dark themes
        "kanagawa",             -- Japanese-inspired dark
        "oxocarbon",            -- Modern dark theme
        "rose-pine",            -- Rose-pine dark variant
        "moonfly",              -- Dark blue theme
        "vscode",               -- VS Code dark theme
      }

      local current_theme = 1

      -- Function to switch to next theme
      local function switch_theme()
        current_theme = current_theme % #themes + 1
        local theme_name = themes[current_theme]

        -- Check if theme is available, fallback to catppuccin if not
        local success = pcall(vim.cmd, "colorscheme " .. theme_name)
        if success then
          print("Theme: " .. theme_name .. " (" .. current_theme .. "/" .. #themes .. ")")
        else
          print("Theme " .. theme_name .. " not available, falling back to catppuccin-frappe")
          vim.cmd([[colorscheme catppuccin-frappe]])
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
        local success = pcall(vim.cmd, "colorscheme " .. theme_name)
        if success then
          print("Theme: " .. theme_name .. " (" .. current_theme .. "/" .. #themes .. ")")
        else
          print("Theme " .. theme_name .. " not available, falling back to catppuccin-frappe")
          vim.cmd([[colorscheme catppuccin-frappe]])
          current_theme = 1
        end
      end

      -- Function to set specific theme by name
      local function set_theme(theme_name)
        for i, theme in ipairs(themes) do
          if theme == theme_name then
            current_theme = i
            local success = pcall(vim.cmd, "colorscheme " .. theme_name)
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
          print(marker .. i .. ". " .. theme)
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

      print("Theme switcher loaded! Use <leader>tt to switch themes")
    end,
  },

  -- Additional popular dark themes
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night", -- night, storm, day, moon
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "NvimTree", "toggleterm", "lazy" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        on_colors = function(colors)
          colors.hint = colors.orange1
          colors.error = colors.red1
        end,
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            ctermbg = c.bg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            ctermbg = c.bg_dark,
          }
          hl.TelescopeSelectionCaret = {
            bg = c.bg_dark,
            ctermbg = c.bg_dark,
          }
        end,
      })
    end,
  },

  {
    "dracula/vim",
    lazy = true,
    config = function()
      vim.g.dracula_italic = 1
      vim.g.dracula_bold = 1
      vim.g.dracula_underline = 1
      vim.g.dracula_undercurl = 1
      vim.g.dracula_inverse = 1
      vim.g.dracula_colorterm = 1
      vim.g.dracula_show_end_of_buffer = 1
      vim.g.dracula_transparent_bg = 0
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
        overrides = function(colors)
          local theme = colors.theme
          for _, name in ipairs({ "FloatBorder", "FloatTitle", "RedSign", "TSConstBuiltin", "TSField", "TSProperty", "TSVariable", "TSVariableBuiltin" }) do
            if not theme[name] then
              theme[name] = theme.syn
            end
          end
          return theme
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
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- auto, main, moon, or dawn
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        enable = {
          terminal = true,
          migrations = true,
          bufferline = true,
          gitgutter = false,
          neogit = false,
          hop = false,
          ibl = false,
          indent_blankline = false,
          nvim_tree = false,
          neotree = false,
          symbols_outline = false,
          which_key = false,
          illuminate = false,
          notify = false,
          lsp_trouble = false,
          lspsaga = false,
          cmp = false,
          dap = false,
          dap_ui = false,
          overseer = false,
          gitsigns = false,
          neotest = false,
        },
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",
          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",
          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_stash = "rose",
          git_text = "rose",
          git_untracked = "subtle",
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      })
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
}
