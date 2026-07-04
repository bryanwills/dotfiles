---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "bryan.plugins" }, { import = "bryan.plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  -- Suppress Lua version warnings (we're using Lua 5.4.8 which is newer than required 5.1)
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- Configure to ignore Lua version warnings
  dev = {
    path = "~/.config/nvim",
    patterns = {},
    fallback = false,
  },
  -- Disable Lua version checks since we're using a newer version
  ui = {
    check = {
      enabled = false,
    },
  },
  -- Disable healthchecks for custom configurations
  health = {
    check = false,
  },
})
