---@diagnostic disable: undefined-global
-- Preserve ASCII diagrams and manual formatting in Markdown buffers
vim.opt_local.textwidth = 0
vim.opt_local.colorcolumn = ""
vim.opt_local.wrap = false
vim.opt_local.linebreak = false

-- Do not auto-wrap or auto-format text
vim.opt_local.formatoptions:remove('t')
vim.opt_local.formatoptions:remove('a')
vim.opt_local.formatoptions:remove('2')

-- Ensure external formatprg is not used for Markdown
vim.opt_local.formatprg = ""

-- Optional: visually hint where 130 chars is without enforcing
-- vim.opt_local.colorcolumn = "130"
