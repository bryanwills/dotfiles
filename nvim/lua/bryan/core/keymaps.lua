---@diagnostic disable: undefined-global
local map = vim.keymap.set

vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Mac-friendly OS shortcuts
-- Undo/Redo
keymap.set("i", "<D-z>", "<C-o>u", { desc = "Undo" })
keymap.set("i", "<D-r>", "<C-o><C-r>", { desc = "Redo" })
keymap.set("n", "<D-z>", "u", { desc = "Undo" })
keymap.set("n", "<D-r>", "<C-r>", { desc = "Redo" })
keymap.set("v", "<D-z>", "u", { desc = "Undo" })
keymap.set("v", "<D-r>", "<C-r>", { desc = "Redo" })

-- Copy/Paste (if terminal supports it)
keymap.set("i", "<D-c>", "<C-o>\"+y", { desc = "Copy" })
keymap.set("i", "<D-v>", "<C-o>\"+p", { desc = "Paste" })
keymap.set("n", "<D-c>", "\"+y", { desc = "Copy" })
keymap.set("n", "<D-v>", "\"+p", { desc = "Paste" })
keymap.set("v", "<D-c>", "\"+y", { desc = "Copy" })
keymap.set("v", "<D-v>", "\"+p", { desc = "Paste" })

-- OS-like selection shortcuts
keymap.set("i", "<S-Left>", "<Left>", { desc = "Select left" })
keymap.set("i", "<S-Right>", "<Right>", { desc = "Select right" })
keymap.set("i", "<S-Up>", "<Up>", { desc = "Select up" })
keymap.set("i", "<S-Down>", "<Down>", { desc = "Select down" })
keymap.set("i", "<S-PageUp>", "<PageUp>", { desc = "Select page up" })
keymap.set("i", "<S-PageDown>", "<PageDown>", { desc = "Select page down" })

-- Visual mode shortcuts (easier to remember)
keymap.set("n", "<leader>vv", "v", { desc = "Visual mode" })
keymap.set("n", "<leader>vl", "<S-v>", { desc = "Visual line mode" })
keymap.set("n", "<leader>vb", "<C-v>", { desc = "Visual block mode" })

-- Quick selection commands
keymap.set("n", "<leader>vw", "viw", { desc = "Select word" })
keymap.set("n", "<leader>vs", "V", { desc = "Select line" }) -- Changed from vl to vs to avoid conflict
keymap.set("n", "<leader>vp", "vip", { desc = "Select paragraph" })

-- Comment-aware word-wrap function
local function comment_aware_wrap()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:t")
  local current_line = vim.api.nvim_get_current_line()

  -- Check if current line is a comment
  local is_comment = false
  local comment_symbol = ""
  local comment_prefix = ""

  if filetype == "lua" and current_line:match("^%s*%-%-") then
    is_comment = true
    comment_symbol = "--"
    -- Extract the exact comment prefix including spaces
    comment_prefix = current_line:match("^(%s*%-%-%s*)")
  elseif (filetype == "zsh" or filetype == "sh") and current_line:match("^%s*#") then
    is_comment = true
    comment_symbol = "#"
    comment_prefix = current_line:match("^(%s*#%s*)")
  elseif filename:match("%.zshrc$") and current_line:match("^%s*#") then
    is_comment = true
    comment_symbol = "#"
    comment_prefix = current_line:match("^(%s*#%s*)")
  elseif filetype == "python" and current_line:match("^%s*#") then
    is_comment = true
    comment_symbol = "#"
    comment_prefix = current_line:match("^(%s*#%s*)")
  elseif filetype == "dockerfile" and current_line:match("^%s*#") then
    is_comment = true
    comment_symbol = "#"
    comment_prefix = current_line:match("^(%s*#%s*)")
  elseif (filetype == "yaml" or filetype == "yml") and current_line:match("^%s*#") then
    is_comment = true
    comment_symbol = "#"
    comment_prefix = current_line:match("^(%s*#%s*)")
  end

  if is_comment then
    -- For comments, manually handle the formatting to preserve comment symbols
    -- Extract content after the comment prefix
    local comment_content = current_line:sub(#comment_prefix + 1)

    -- Calculate how many characters we can fit on each line
    local max_content_length = 130 - #comment_prefix

    -- Split the content into lines that fit within the limit
    local lines = {}
    local words = {}
    for word in comment_content:gmatch("%S+") do
      table.insert(words, word)
    end

    local current_line_content = ""
    for _, word in ipairs(words) do
      if #current_line_content + #word + 1 <= max_content_length then
        if current_line_content ~= "" then
          current_line_content = current_line_content .. " " .. word
        else
          current_line_content = word
        end
      else
        if current_line_content ~= "" then
          table.insert(lines, comment_prefix .. current_line_content)
        end
        current_line_content = word
      end
    end

    if current_line_content ~= "" then
      table.insert(lines, comment_prefix .. current_line_content)
    end

    -- Replace the current line with the formatted lines
    local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, lines)

    -- Position cursor at the beginning of the first formatted line
    vim.api.nvim_win_set_cursor(0, {line_num + 1, 0})
  else
    -- Use line formatting for regular code
    vim.cmd("normal! gqq")
  end
end

-- Word-wrap keymaps (reorganized to reduce conflicts)
-- Primary word-wrap operations
keymap.set("n", "<leader>ww", comment_aware_wrap, { desc = "Word-wrap current line (comment-aware)" })
keymap.set("v", "<leader>ww", "gq", { desc = "Word-wrap selection" })

-- Secondary word-wrap operations (using different prefixes)
keymap.set("n", "<leader>wp", "gq}", { desc = "Word-wrap paragraph" })
keymap.set("n", "<leader>wip", "gqip", { desc = "Word-wrap inner paragraph" })
keymap.set("n", "<leader>wa", "gggqG", { desc = "Word-wrap entire file" })

-- Context-aware word-wrap function
local function smart_word_wrap()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:t")

  -- Check for markdown files (including .mdx and .mdc)
  if filetype == "markdown" or filename:match("%.md[cdx]?$") then
    -- Check if we're in a code block
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^```") then
      vim.notify("Skipping word-wrap in code block", vim.log.levels.WARN)
      return
    end
    -- Use paragraph formatting for markdown
    vim.cmd("normal! gqap")
  elseif filetype == "docx" or filename:match("%.docx$") then
    -- Check for special formatting in docx
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*[-*+]") or current_line:match("^%s*%d+%.") then
      vim.notify("Skipping word-wrap in list", vim.log.levels.WARN)
      return
    end
    -- Use paragraph formatting for docx
    vim.cmd("normal! gqap")
  elseif filetype == "lua" or filename:match("%.lua$") then
    -- Smart comment preservation for Lua files
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*%-%-") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  elseif filetype == "zsh" or filename:match("%.zsh$") or filename:match("%.zshrc$") then
    -- Smart comment preservation for zsh files
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*#") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  elseif filetype == "sh" or filename:match("%.sh$") or filename:match("%.bash$") then
    -- Smart comment preservation for shell files
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*#") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  elseif filetype == "python" then
    -- Smart comment preservation for Python files
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*#") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  elseif filetype == "dockerfile" then
    -- Smart comment preservation for Dockerfile
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*#") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  elseif filetype == "yaml" or filetype == "yml" then
    -- Smart comment preservation for YAML files
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s*#") then
      -- We're in a comment, use comment-aware formatting
      vim.cmd("normal! gqap")
    else
      -- Regular code, use paragraph formatting
      vim.cmd("normal! gq}")
    end
  else
    -- Default to paragraph formatting
    vim.cmd("normal! gq}")
  end
end

-- Smart word-wrap keymap
keymap.set("n", "<leader>ws", smart_word_wrap, { desc = "Smart word-wrap (context-aware)" })

-- Range-based word-wrap
keymap.set("n", "<leader>wr", function()
  local start_line = vim.fn.input("Start line: ")
  local end_line = vim.fn.input("End line: ")
  if start_line ~= "" and end_line ~= "" then
    vim.cmd(string.format(":%s,%sgq", start_line, end_line))
  end
end, { desc = "Word-wrap range (interactive)" })

-- Quick range word-wrap (5 lines)
keymap.set("n", "<leader>w5", "gq5j", { desc = "Word-wrap 5 lines" })
keymap.set("n", "<leader>w10", "gq10j", { desc = "Word-wrap 10 lines" })

-- Word-wrap from cursor to end of file
keymap.set("n", "<leader>wf", "gqG", { desc = "Word-wrap from cursor to end" })

-- Word-wrap from beginning to cursor
keymap.set("n", "<leader>wb", "gggq", { desc = "Word-wrap from beginning to cursor" })
