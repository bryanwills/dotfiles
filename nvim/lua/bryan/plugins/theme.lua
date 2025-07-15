return {
  {
    "bryanwills/one_monokai.nvim",
    lazy = false, -- Load the theme immediately
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      vim.cmd([[colorscheme one_monokai]])
    end,
  },
}
