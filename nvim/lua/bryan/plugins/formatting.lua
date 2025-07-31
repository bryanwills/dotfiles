---@diagnostic disable: undefined-global
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Web Technologies (ACTIVE - You're using these)
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        markdown = { "prettier" },
        md = { "prettier" },
        mdx = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },

        -- Python (ACTIVE - You're using these)
        python = { "isort", "black" },

        -- Lua (ACTIVE - You're using this)
        lua = { "stylua" },

        -- Go (ACTIVE - You're using this)
        go = { "gofmt" }, -- Removed goimports as it's not installed

        -- Rust (ACTIVE - You're using this)
        rust = { "rustfmt" },

        -- Microsoft Office (HANDLED BY VIM-OFFICE PLUGIN)
        -- These file types are handled by the separate vim-office plugin
        -- docx = { "vim_office" },
        -- doc = { "vim_office" },
        -- xlsx = { "vim_office" },
        -- xls = { "vim_office" },
        -- pptx = { "vim_office" },
        -- ppt = { "vim_office" },
        -- odt = { "vim_office" },
        -- ods = { "vim_office" },
        -- odp = { "vim_office" },
        -- epub = { "vim_office" },

        -- PDF Documents (HANDLED BY VIM-OFFICE PLUGIN)
        -- pdf = { "vim_office" },

        -- ========================================
        -- COMMENTED OUT - Not currently installed/used
        -- ========================================

        -- C/C++ (COMMENTED - Not installed)
        -- c = { "clang_format" },
        -- cpp = { "clang_format" },
        -- cxx = { "clang_format" },
        -- h = { "clang_format" },
        -- hpp = { "clang_format" },

        -- Java (COMMENTED - Not installed)
        -- java = { "google_java_format" },

        -- PHP (COMMENTED - Not installed)
        -- php = { "php_cs_fixer" },

        -- Ruby (COMMENTED - Not installed)
        -- ruby = { "rubocop" },

        -- Shell (COMMENTED - Not installed)
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- SQL (ACTIVE - You installed sqlformat)
        -- sql = { "sqlformat" },

        -- Kotlin (COMMENTED - Not installed)
        -- kt = { "ktlint" },
        -- kts = { "ktlint" },

        -- Scala (COMMENTED - Not installed)
        -- scala = { "scalafmt" },

        -- Dart (COMMENTED - Not installed)
        -- dart = { "dart_format" },

        -- Swift (COMMENTED - Not installed)
        swift = { "swiftformat" },

        -- R (COMMENTED - Not installed)
        -- r = { "styler" },

        -- Julia (COMMENTED - Not installed)
        -- jl = { "julia_format" },

        -- Zig (COMMENTED - Not installed)
        -- zig = { "zig_fmt" },

        -- Nim (COMMENTED - Not installed)
        -- nim = { "nimpretty" },

        -- Crystal (COMMENTED - Not installed)
        -- cr = { "crystal_format" },

        -- Elixir (COMMENTED - Not installed)
        -- ex = { "mix_format" },
        -- exs = { "mix_format" },

        -- Haskell (COMMENTED - Not installed)
        -- hs = { "fourmolu" },
        -- lhs = { "fourmolu" },

        -- OCaml (COMMENTED - Not installed)
        -- ml = { "ocamlformat" },
        -- mli = { "ocamlformat" },

        -- F# (COMMENTED - Not installed)
        -- fs = { "fantomas" },
        -- fsi = { "fantomas" },
        -- fsx = { "fantomas" },

        -- Clojure (COMMENTED - Not installed)
        -- clj = { "cljstyle" },
        -- cljs = { "cljstyle" },
        -- edn = { "cljstyle" },

        -- Erlang (COMMENTED - Not installed)
        -- erl = { "erlfmt" },
        -- hrl = { "erlfmt" },

        -- Prolog (COMMENTED - Not installed)
        -- pl = { "swipl_format" },
        -- pro = { "swipl_format" },

        -- V (COMMENTED - Not installed)
        -- v = { "v_fmt" },

        -- Nix (COMMENTED - Not installed)
        -- nix = { "nixpkgs_fmt" },

        -- Terraform (COMMENTED - Not installed)
        -- tf = { "terraform_fmt" },
        -- hcl = { "terraform_fmt" },

        -- Docker (COMMENTED - Not installed)
        -- dockerfile = { "hadolint" },

        -- Make (COMMENTED - Not installed)
        -- make = { "make_format" },
        -- makefile = { "make_format" },
      },
      -- Configure formatters with word wrap limits
      formatters = {
        -- Prettier (JavaScript, TypeScript, CSS, HTML, JSON, YAML, Markdown, etc.)
        prettier = {
          prepend_args = {
            "--print-width=130",
            "--prose-wrap=always",
            "--prose-wrap-width=130",
          },
        },

        -- Python formatters
        black = {
          prepend_args = {
            "--line-length=130",
          },
        },
        isort = {
          prepend_args = {
            "--line-length=130",
          },
        },

        -- Lua
        stylua = {
          prepend_args = {
            "--column-width=130",
          },
        },

        -- Go
        gofmt = {
          prepend_args = {
            "--max-width=130",
          },
        },

        -- Rust
        rustfmt = {
          prepend_args = {
            "--max-width=130",
          },
        },

        -- SQL
        sqlformat = {
          prepend_args = {
            "--max_line_length=130",
          },
        },

        -- Microsoft Office (HANDLED BY VIM-OFFICE PLUGIN)
        -- vim_office is a separate plugin, not a conform.nvim formatter

        -- ========================================
        -- COMMENTED OUT - Not currently installed/used
        -- ========================================

        -- C/C++ (COMMENTED - Not installed)
        -- clang_format = {
        --   prepend_args = {
        --     "--style={BasedOnStyle: Google, ColumnLimit: 130}",
        --   },
        -- },

        -- Java (COMMENTED - Not installed)
        -- google_java_format = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- PHP (COMMENTED - Not installed)
        -- php_cs_fixer = {
        --   prepend_args = {
        --     "--rules=@PSR2",
        --     "--line-length=130",
        --   },
        -- },

        -- Ruby (COMMENTED - Not installed)
        -- rubocop = {
        --   prepend_args = {
        --     "--autocorrect",
        --     "--max-line-length=130",
        --   },
        -- },

        -- Shell (COMMENTED - Not installed)
        -- shfmt = {
        --   prepend_args = {
        --     "--indent=2",
        --     "--binary-next-line",
        --     "--case-indent",
        --     "--space-redirects",
        --     "--max-width=130",
        --   },
        -- },

        -- SQL (COMMENTED - Not installed)
        -- sqlformat = {
        --   prepend_args = {
        --     "--max_line_length=130",
        --   },
        -- },

        -- Kotlin (COMMENTED - Not installed)
        -- ktlint = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Scala (COMMENTED - Not installed)
        -- scalafmt = {
        --   prepend_args = {
        --     "--maxColumn=130",
        --   },
        -- },

        -- Dart (COMMENTED - Not installed)
        -- dart_format = {
        --   prepend_args = {
        --     "--line-length=130",
        --   },
        -- },

        -- Swift (COMMENTED - Not installed)
        -- swiftformat = {
        --   prepend_args = {
        --     "--maxwidth=130",
        --   },
        -- },

        -- R (COMMENTED - Not installed)
        -- styler = {
        --   prepend_args = {
        --     "--style=strict",
        --     "--line-width=130",
        --   },
        -- },

        -- Julia (COMMENTED - Not installed)
        -- julia_format = {
        --   prepend_args = {
        --     "--margin=130",
        --   },
        -- },

        -- Zig (COMMENTED - Not installed)
        -- zig_fmt = {
        --   prepend_args = {
        --     "--max-width=130",
        --   },
        -- },

        -- Nim (COMMENTED - Not installed)
        -- nimpretty = {
        --   prepend_args = {
        --     "--maxLineLen=130",
        --   },
        -- },

        -- Crystal (COMMENTED - Not installed)
        -- crystal_format = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Elixir (COMMENTED - Not installed)
        -- mix_format = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Haskell (COMMENTED - Not installed)
        -- fourmolu = {
        --   prepend_args = {
        --     "--column-limit=130",
        --   },
        -- },

        -- OCaml (COMMENTED - Not installed)
        -- ocamlformat = {
        --   prepend_args = {
        --     "--margin=130",
        --   },
        -- },

        -- F# (COMMENTED - Not installed)
        -- fantomas = {
        --   prepend_args = {
        --     "--maxLineLength=130",
        --   },
        -- },

        -- Clojure (COMMENTED - Not installed)
        -- cljstyle = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Erlang (COMMENTED - Not installed)
        -- erlfmt = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Prolog (COMMENTED - Not installed)
        -- swipl_format = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- V (COMMENTED - Not installed)
        -- v_fmt = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Nix (COMMENTED - Not installed)
        -- nixpkgs_fmt = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Terraform (COMMENTED - Not installed)
        -- terraform_fmt = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Docker (COMMENTED - Not installed)
        -- hadolint = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },

        -- Make (COMMENTED - Not installed)
        -- make_format = {
        --   prepend_args = {
        --     "--max-line-length=130",
        --   },
        -- },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
