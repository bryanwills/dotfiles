require("bryan.core")
require("bryan.lazy")

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"') -- single double-quote, NOT two quotes
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, { mark[1], mark[2] })
    end
  end,
})
