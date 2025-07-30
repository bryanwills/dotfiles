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
opt.formatoptions = "tcroql2a" -- set format options for proper text wrapping with automatic formatting

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

-- auto-format entire file when opened (like Microsoft Word)
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    -- Only format text files, not code files
    local filetype = vim.bo.filetype
    local text_filetypes = {
      "text", "markdown", "tex", "latex", "rst", "asciidoc", "",
      "log", "env", "ini", "conf", "cfg", "config", "txt", "md",
      "adoc", "asciidoc", "pod", "nroff", "man"
    }

    -- Also check file extension for common text files
    local filename = vim.fn.expand("%:t")
    local text_extensions = { ".log", ".env", ".ini", ".conf", ".cfg", ".txt", ".md", ".adoc", ".pod" }

    local is_text_file = vim.tbl_contains(text_filetypes, filetype)
    local has_text_extension = false

    for _, ext in ipairs(text_extensions) do
      if filename:match(ext .. "$") then
        has_text_extension = true
        break
      end
    end

    if is_text_file or has_text_extension then
      -- Check if any line exceeds the textwidth
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local needs_formatting = false

      for _, line in ipairs(lines) do
        if #line > vim.opt.textwidth:get() then
          needs_formatting = true
          break
        end
      end

      if needs_formatting then
        -- Format the entire file
        vim.cmd("normal! gg")
        vim.cmd("normal! gqG")
      end
    end
  end,
})

-- auto-format text when leaving insert mode (like Microsoft Word)
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local line = vim.api.nvim_get_current_line()
    if #line > vim.opt.textwidth:get() then
      vim.cmd("normal! gqq")
    end
  end,
})

-- auto-format when text changes in insert mode
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = function()
    local line = vim.api.nvim_get_current_line()
    if #line > vim.opt.textwidth:get() then
      -- Use a timer to avoid interfering with typing
      vim.defer_fn(function()
        vim.cmd("normal! gqq")
      end, 100)
    end
  end,
})