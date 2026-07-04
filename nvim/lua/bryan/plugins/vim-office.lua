---@diagnostic disable: undefined-global
return {
  "Konfekt/vim-office",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Configure vim-office for editing .docx, .pdf, and other office files
    -- This plugin allows direct editing of Microsoft Office and PDF files
    vim.g.vim_office_enabled = 1
  end,
}
