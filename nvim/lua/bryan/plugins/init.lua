return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  require("bryan.plugins.theme"),

  -- Add nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = true,
        default = true,
        strict = true,
      })
    end,
  },
}

--require("bryan.plugins.theme

-- Add nvim-web-devicons
