---@diagnostic disable: undefined-global
-- flash.nvim: fast on-screen motion. Enhances f/F/t/T with multi-line labels.
-- NOTE: `s`/`S` are intentionally NOT mapped here — substitute.nvim owns them.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      -- Improve f/F/t/T (multi-line, repeat with ; and ,) without new keys.
      char = { enabled = true },
      -- Leave `/` search behaving normally (don't hijack it).
      search = { enabled = false },
    },
  },
  keys = {
    { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter select" },
  },
}
