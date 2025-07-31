---@diagnostic disable: undefined-global
-- Temporarily disabled vim-office plugin to test autocmd issue
-- This will be re-enabled once we confirm the autocmd issue is resolved
return {
  "Konfekt/vim-office",
  enabled = false, -- Temporarily disabled
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Plugin temporarily disabled
  end,
}