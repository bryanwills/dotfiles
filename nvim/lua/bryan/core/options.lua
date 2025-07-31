---@diagnostic disable: undefined-global
local opt = vim.opt -- for conciseness

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- word wrap settings
opt.wrap = true -- enable word wrapping
opt.textwidth = 130 -- set character limit to 130
opt.colorcolumn = "130" -- visual indicator at 130 characters
opt.linebreak = true -- break at word boundaries (not in middle of words)
opt.breakindent = true -- preserve indentation in wrapped lines
opt.showbreak = "↪ " -- show wrap indicator
opt.formatoptions = "tcroql2c" -- set format options for manual text wrapping with comment support

-- enable automatic formatting for all file types
opt.formatprg = "fmt -w 130" -- use fmt program for formatting

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard = "unnamedplus" -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- session options for auto-session compatibility
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ensure textwidth is set for all file types
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt_local.textwidth = 130
    vim.opt_local.colorcolumn = "130"
  end,
})

-- Set comment formats for different file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "zsh", "sh", "bash" },
  callback = function()
    vim.opt_local.comments = ":#"
    -- Don't modify formatoptions, it's already set globally
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.opt_local.comments = ":--"
    -- Don't modify formatoptions, it's already set globally
  end,
})