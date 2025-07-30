---@diagnostic disable: undefined-global
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Web Technologies
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

        -- Python
        python = { "isort", "black" },

        -- Lua
        lua = { "stylua" },

        -- Go
        go = { "gofmt", "goimports" },

        -- Rust
        rust = { "rustfmt" },

        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        cxx = { "clang_format" },
        h = { "clang_format" },
        hpp = { "clang_format" },

        -- Java
        java = { "google_java_format" },

        -- PHP
        php = { "php_cs_fixer" },

        -- Ruby
        ruby = { "rubocop" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- SQL
        sql = { "sqlformat" },

        -- Kotlin
        kt = { "ktlint" },
        kts = { "ktlint" },

        -- Scala
        scala = { "scalafmt" },

        -- Dart
        dart = { "dart_format" },

        -- Swift
        swift = { "swiftformat" },

        -- R
        r = { "styler" },

        -- Julia
        jl = { "julia_format" },

        -- Zig
        zig = { "zig_fmt" },

        -- Nim
        nim = { "nimpretty" },

        -- Crystal
        cr = { "crystal_format" },

        -- Elixir
        ex = { "mix_format" },
        exs = { "mix_format" },

        -- Haskell
        hs = { "fourmolu" },
        lhs = { "fourmolu" },

        -- OCaml
        ml = { "ocamlformat" },
        mli = { "ocamlformat" },

        -- F#
        fs = { "fantomas" },
        fsi = { "fantomas" },
        fsx = { "fantomas" },

        -- Clojure
        clj = { "cljstyle" },
        cljs = { "cljstyle" },
        edn = { "cljstyle" },

        -- Erlang
        erl = { "erlfmt" },
        hrl = { "erlfmt" },

        -- Prolog
        pl = { "swipl_format" },
        pro = { "swipl_format" },

        -- V
        v = { "v_fmt" },

        -- Nix
        nix = { "nixpkgs_fmt" },

        -- Terraform
        tf = { "terraform_fmt" },
        hcl = { "terraform_fmt" },

        -- Docker
        dockerfile = { "hadolint" },

        -- Make
        make = { "make_format" },
        makefile = { "make_format" },

        -- Microsoft Office
        docx = { "vim_office" },
        doc = { "vim_office" },
        xlsx = { "vim_office" },
        xls = { "vim_office" },
        pptx = { "vim_office" },
        ppt = { "vim_office" },
        odt = { "vim_office" },
        ods = { "vim_office" },
        odp = { "vim_office" },
        epub = { "vim_office" },

        -- PDF Documents
        pdf = { "vim_office" },
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
        goimports = {
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

        -- C/C++
        clang_format = {
          prepend_args = {
            "--style={BasedOnStyle: Google, ColumnLimit: 130}",
          },
        },

        -- Java
        google_java_format = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- PHP
        php_cs_fixer = {
          prepend_args = {
            "--rules=@PSR2",
            "--line-length=130",
          },
        },

        -- Ruby
        rubocop = {
          prepend_args = {
            "--autocorrect",
            "--max-line-length=130",
          },
        },

        -- Shell
        shfmt = {
          prepend_args = {
            "--indent=2",
            "--binary-next-line",
            "--case-indent",
            "--space-redirects",
            "--max-width=130",
          },
        },

        -- SQL
        sqlformat = {
          prepend_args = {
            "--max_line_length=130",
          },
        },

        -- Kotlin
        ktlint = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Scala
        scalafmt = {
          prepend_args = {
            "--maxColumn=130",
          },
        },

        -- Dart
        dart_format = {
          prepend_args = {
            "--line-length=130",
          },
        },

        -- Swift
        swiftformat = {
          prepend_args = {
            "--maxwidth=130",
          },
        },

        -- R
        styler = {
          prepend_args = {
            "--style=strict",
            "--line-width=130",
          },
        },

        -- Julia
        julia_format = {
          prepend_args = {
            "--margin=130",
          },
        },

        -- Zig
        zig_fmt = {
          prepend_args = {
            "--max-width=130",
          },
        },

        -- Nim
        nimpretty = {
          prepend_args = {
            "--maxLineLen=130",
          },
        },

        -- Crystal
        crystal_format = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Elixir
        mix_format = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Haskell
        fourmolu = {
          prepend_args = {
            "--column-limit=130",
          },
        },

        -- OCaml
        ocamlformat = {
          prepend_args = {
            "--margin=130",
          },
        },

        -- F#
        fantomas = {
          prepend_args = {
            "--maxLineLength=130",
          },
        },

        -- Clojure
        cljstyle = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Erlang
        erlfmt = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Prolog
        swipl_format = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- V
        v_fmt = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Nix
        nixpkgs_fmt = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Terraform
        terraform_fmt = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Docker
        hadolint = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Make
        make_format = {
          prepend_args = {
            "--max-line-length=130",
          },
        },

        -- Microsoft Office
        vim_office = {
          prepend_args = {
            "--max-line-length=130",
          },
        },
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
