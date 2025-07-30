---@diagnostic disable: undefined-global
return {
  "Konfekt/vim-office",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Configure office files to respect word wrap limits
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "pdf", "docx", "doc", "xlsx", "xls", "pptx", "ppt", "odt", "ods", "odp", "epub" },
      callback = function()
        -- Set word wrap settings for office files
        vim.opt_local.textwidth = 130
        vim.opt_local.colorcolumn = "130"
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.showbreak = "↪ "

        -- Set format options for proper text wrapping
        vim.opt_local.formatoptions = "tcroql2"
      end,
    })

    -- Auto-format office files when opened
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = { "*.pdf", "*.docx", "*.doc", "*.xlsx", "*.xls", "*.pptx", "*.ppt", "*.odt", "*.ods", "*.odp", "*.epub" },
      callback = function()
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
      end,
    })

    -- Auto-format when leaving insert mode
    vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = { "*.pdf", "*.docx", "*.doc", "*.xlsx", "*.xls", "*.pptx", "*.ppt", "*.odt", "*.ods", "*.odp", "*.epub" },
      callback = function()
        local line = vim.api.nvim_get_current_line()
        if #line > vim.opt.textwidth:get() then
          vim.cmd("normal! gqq")
        end
      end,
    })

    -- Auto-format when text changes in insert mode
    vim.api.nvim_create_autocmd("TextChangedI", {
      pattern = { "*.pdf", "*.docx", "*.doc", "*.xlsx", "*.xls", "*.pptx", "*.ppt", "*.odt", "*.ods", "*.odp", "*.epub" },
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
  end,
}