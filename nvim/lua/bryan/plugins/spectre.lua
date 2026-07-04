---@diagnostic disable: undefined-global
-- nvim-spectre: project-wide search & replace (VSCode-style "Replace in Files").
-- Requires ripgrep (rg) and sed, both available via Homebrew on macOS/Linux.
return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup()
  end,
  keys = {
    { "<leader>sr", function() require("spectre").toggle() end, desc = "Search & Replace in project (Spectre)" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search current word (Spectre)" },
  },
}
