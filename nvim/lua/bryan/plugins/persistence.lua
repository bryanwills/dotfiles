---@diagnostic disable: undefined-global
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
  },
  config = function(_, opts)
    require("persistence").setup(opts)

    local keymap = vim.keymap

    keymap.set("n", "<leader>qs", function()
      require("persistence").load()
    end, { desc = "Restore session for current directory" })

    keymap.set("n", "<leader>qS", function()
      require("persistence").select()
    end, { desc = "Select session to load" })

    keymap.set("n", "<leader>ql", function()
      require("persistence").load({ last = true })
    end, { desc = "Restore last session" })

    keymap.set("n", "<leader>qd", function()
      require("persistence").stop()
    end, { desc = "Stop session autosave" })
  end,
}
