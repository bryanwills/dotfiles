---@diagnostic disable: undefined-global
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Web Technologies
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      vue = { "eslint_d" },

      -- Python
      python = { "pylint", "flake8", "mypy" },

      -- Go
      go = { "golangci_lint", "staticcheck" },

      -- Rust
      rust = { "cargo_check", "clippy" },

      -- C/C++
      c = { "cppcheck", "clang_tidy" },
      cpp = { "cppcheck", "clang_tidy" },
      cxx = { "cppcheck", "clang_tidy" },
      h = { "cppcheck", "clang_tidy" },
      hpp = { "cppcheck", "clang_tidy" },

      -- Java
      java = { "checkstyle", "pmd" },

      -- PHP
      php = { "phpstan", "phpcs" },

      -- Ruby
      ruby = { "rubocop", "reek" },

      -- Shell
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },

      -- SQL
      sql = { "sqlfluff" },

      -- Kotlin
      kt = { "ktlint", "detekt" },
      kts = { "ktlint", "detekt" },

      -- Scala
      scala = { "scalastyle", "scalafix" },

      -- Dart
      dart = { "dart_analyzer" },

      -- Swift
      swift = { "swiftlint" },

      -- R
      r = { "lintr" },

      -- Julia
      jl = { "julia_lint" },

      -- Zig
      zig = { "zls" },

      -- Nim
      nim = { "nimcheck" },

      -- Crystal
      cr = { "crystal_lint" },

      -- Elixir
      ex = { "credo", "dialyxir" },
      exs = { "credo", "dialyxir" },

      -- Haskell
      hs = { "hlint", "stan" },
      lhs = { "hlint", "stan" },

      -- OCaml
      ml = { "merlin" },
      mli = { "merlin" },

      -- F#
      fs = { "fantomas" },
      fsi = { "fantomas" },
      fsx = { "fantomas" },

      -- Clojure
      clj = { "clj_kondo" },
      cljs = { "clj_kondo" },
      edn = { "clj_kondo" },

      -- Erlang
      erl = { "erlfmt" },

      -- Prolog
      prolog = { "swipl" },

      -- V
      v = { "v_lint" },

      -- Nix
      nix = { "statix" },

      -- Terraform
      tf = { "tflint" },
      terraform = { "tflint" },

      -- Docker
      dockerfile = { "hadolint" },

      -- Make
      make = { "checkmake" },

      -- Lua
      lua = { "luacheck" },

      -- Markdown
      markdown = { "markdownlint" },
      md = { "markdownlint" },

      -- YAML
      yaml = { "yamllint" },
      yml = { "yamllint" },

      -- JSON
      json = { "jsonlint" },
    }

    -- Configure linters with word wrap limits (restored with a safe markdownlint definition)
    lint.linters = {
      -- Web Technologies
      eslint_d = {
        cmd = "eslint_d",
        args = {
          "--max-len=130",
          "--print-width=130",
        },
      },

      -- Python
      pylint = {
        cmd = "pylint",
        args = {
          "--max-line-length=130",
        },
      },
      flake8 = {
        cmd = "flake8",
        args = {
          "--max-line-length=130",
        },
      },
      mypy = {
        cmd = "mypy",
        args = {
          "--line-length=130",
        },
      },

      -- Go
      golangci_lint = {
        cmd = "golangci-lint",
        args = {
          "--max-line-length=130",
        },
      },
      staticcheck = {
        cmd = "staticcheck",
        args = {
          "--max-line-length=130",
        },
      },

      -- Rust
      cargo_check = {
        cmd = "cargo",
        args = {
          "check",
          "--max-line-length=130",
        },
      },
      clippy = {
        cmd = "cargo",
        args = {
          "clippy",
          "--max-line-length=130",
        },
      },

      -- C/C++
      cppcheck = {
        cmd = "cppcheck",
        args = {
          "--max-line-length=130",
        },
      },
      clang_tidy = {
        cmd = "clang-tidy",
        args = {
          "--max-line-length=130",
        },
      },

      -- Java
      checkstyle = {
        cmd = "checkstyle",
        args = {
          "--max-line-length=130",
        },
      },
      pmd = {
        cmd = "pmd",
        args = {
          "--max-line-length=130",
        },
      },

      -- PHP
      phpstan = {
        cmd = "phpstan",
        args = {
          "--max-line-length=130",
        },
      },
      phpcs = {
        cmd = "phpcs",
        args = {
          "--max-line-length=130",
        },
      },

      -- Ruby
      rubocop = {
        cmd = "rubocop",
        args = {
          "--max-line-length=130",
        },
      },
      reek = {
        cmd = "reek",
        args = {
          "--max-line-length=130",
        },
      },

      -- Shell
      shellcheck = {
        cmd = "shellcheck",
        args = {
          "--max-line-length=130",
        },
      },

      -- SQL
      sqlfluff = {
        cmd = "sqlfluff",
        args = {
          "--max-line-length=130",
        },
      },

      -- Kotlin
      ktlint = {
        cmd = "ktlint",
        args = {
          "--max-line-length=130",
        },
      },
      detekt = {
        cmd = "detekt",
        args = {
          "--max-line-length=130",
        },
      },

      -- Scala
      scalastyle = {
        cmd = "scalastyle",
        args = {
          "--max-line-length=130",
        },
      },
      scalafix = {
        cmd = "scalafix",
        args = {
          "--max-line-length=130",
        },
      },

      -- Dart
      dart_analyzer = {
        cmd = "dart",
        args = {
          "analyze",
          "--max-line-length=130",
        },
      },

      -- Swift
      swiftlint = {
        cmd = "swiftlint",
        args = {
          "--max-line-length=130",
        },
      },

      -- R
      lintr = {
        cmd = "lintr",
        args = {
          "--max-line-length=130",
        },
      },

      -- Julia
      julia_lint = {
        cmd = "julia",
        args = {
          "--max-line-length=130",
        },
      },

      -- Zig
      zls = {
        cmd = "zls",
        args = {
          "--max-line-length=130",
        },
      },

      -- Nim
      nimcheck = {
        cmd = "nim",
        args = {
          "check",
          "--max-line-length=130",
        },
      },

      -- Crystal
      crystal_lint = {
        cmd = "crystal",
        args = {
          "tool",
          "format",
          "--max-line-length=130",
        },
      },

      -- Elixir
      credo = {
        cmd = "mix",
        args = {
          "credo",
          "--max-line-length=130",
        },
      },
      dialyxir = {
        cmd = "mix",
        args = {
          "dialyzer",
          "--max-line-length=130",
        },
      },

      -- Haskell
      hlint = {
        cmd = "hlint",
        args = {
          "--max-line-length=130",
        },
      },
      stan = {
        cmd = "stan",
        args = {
          "--max-line-length=130",
        },
      },

      -- OCaml
      merlin = {
        cmd = "ocamlmerlin",
        args = {
          "--max-line-length=130",
        },
      },

      -- F#
      fantomas = {
        cmd = "fantomas",
        args = {
          "--max-line-length=130",
        },
      },

      -- Clojure
      clj_kondo = {
        cmd = "clj-kondo",
        args = {
          "--max-line-length=130",
        },
      },

      -- Erlang
      erlfmt = {
        cmd = "erlfmt",
        args = {
          "--max-line-length=130",
        },
      },

      -- Prolog
      swipl = {
        cmd = "swipl",
        args = {
          "--max-line-length=130",
        },
      },

      -- V
      v_lint = {
        cmd = "v",
        args = {
          "fmt",
          "--max-line-length=130",
        },
      },

      -- Nix
      statix = {
        cmd = "statix",
        args = {
          "--max-line-length=130",
        },
      },

      -- Terraform
      tflint = {
        cmd = "tflint",
        args = {
          "--max-line-length=130",
        },
      },

      -- Docker
      hadolint = {
        cmd = "hadolint",
        args = {
          "--max-line-length=130",
        },
      },

      -- Make
      checkmake = {
        cmd = "checkmake",
        args = {
          "--max-line-length=130",
        },
      },

      -- Lua
      luacheck = {
        cmd = "luacheck",
        args = {
          "--max-line-length=130",
        },
      },

      -- Markdown (set a proper cmd and safe args)
      markdownlint = {
        cmd = "markdownlint",
        args = {
          "--stdin",
        },
      },

      -- YAML
      yamllint = {
        cmd = "yamllint",
        args = {
          "--max-line-length=130",
        },
      },

      -- JSON
      jsonlint = {
        cmd = "jsonlint",
        args = {
          "--max-line-length=130",
        },
      },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
