return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false, -- nvim-treesitter explicitly does not support lazy-loading
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "bash",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "toml",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "python",
      "dockerfile",
      "gitignore",
      "git_config",
      "git_rebase",
      "gitcommit",
      "regex",
    }

    require("nvim-treesitter").install(parsers):wait(300000)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
