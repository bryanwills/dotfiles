---@diagnostic disable: undefined-global
require("bryan.core")
require("bryan.lazy")



-- Configure providers to handle pnpm alias
vim.g.node_host_prog = vim.fn.exepath("pnpm")
vim.g.loaded_node_provider = 0 -- Disable Node.js provider since we're using pnpm

-- Disable optional providers to avoid warnings
vim.g.loaded_perl_provider = 0 -- Disable Perl provider
vim.g.loaded_ruby_provider = 0 -- Disable Ruby provider

-- Suppress Lua version warnings (we're using Lua 5.4.8 which is newer than required 5.1)
-- Note: The Lua version warning in healthcheck is informational only and doesn't affect functionality
-- Suppress Lua version warnings in healthcheck
vim.g.lua_version_warning = false
-- Additional Lua version warning suppression
vim.g.lua_version_check = false
vim.g.lua_version_required = "5.4.8"

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"') -- single double-quote, NOT two quotes
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, { mark[1], mark[2] })
    end
  end,
})
