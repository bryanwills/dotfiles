---@diagnostic disable: undefined-global
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    local select_modes = { "x", "o" }
    local move_modes = { "n", "x", "o" }

    local function map_select(lhs, query, desc)
      vim.keymap.set(select_modes, lhs, function()
        select.select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    local function map_move(lhs, fn, query, query_group, desc)
      vim.keymap.set(move_modes, lhs, function()
        fn(query, query_group or "textobjects")
      end, { desc = desc })
    end

    map_select("a=", "@assignment.outer", "Select outer part of an assignment")
    map_select("i=", "@assignment.inner", "Select inner part of an assignment")
    map_select("l=", "@assignment.lhs", "Select left hand side of an assignment")
    map_select("r=", "@assignment.rhs", "Select right hand side of an assignment")

    map_select("a:", "@property.outer", "Select outer part of an object property")
    map_select("i:", "@property.inner", "Select inner part of an object property")
    map_select("l:", "@property.lhs", "Select left part of an object property")
    map_select("r:", "@property.rhs", "Select right part of an object property")

    map_select("aa", "@parameter.outer", "Select outer part of a parameter/argument")
    map_select("ia", "@parameter.inner", "Select inner part of a parameter/argument")

    map_select("ai", "@conditional.outer", "Select outer part of a conditional")
    map_select("ii", "@conditional.inner", "Select inner part of a conditional")

    map_select("al", "@loop.outer", "Select outer part of a loop")
    map_select("il", "@loop.inner", "Select inner part of a loop")

    map_select("af", "@call.outer", "Select outer part of a function call")
    map_select("if", "@call.inner", "Select inner part of a function call")

    map_select("am", "@function.outer", "Select outer part of a method/function definition")
    map_select("im", "@function.inner", "Select inner part of a method/function definition")

    map_select("ac", "@class.outer", "Select outer part of a class")
    map_select("ic", "@class.inner", "Select inner part of a class")

    vim.keymap.set("n", "<leader>na", function()
      swap.swap_next("@parameter.inner")
    end, { desc = "Swap parameter/argument with next" })
    vim.keymap.set("n", "<leader>n:", function()
      swap.swap_next("@property.outer")
    end, { desc = "Swap object property with next" })
    vim.keymap.set("n", "<leader>nm", function()
      swap.swap_next("@function.outer")
    end, { desc = "Swap function with next" })

    vim.keymap.set("n", "<leader>pa", function()
      swap.swap_previous("@parameter.inner")
    end, { desc = "Swap parameter/argument with previous" })
    vim.keymap.set("n", "<leader>p:", function()
      swap.swap_previous("@property.outer")
    end, { desc = "Swap object property with previous" })
    vim.keymap.set("n", "<leader>pm", function()
      swap.swap_previous("@function.outer")
    end, { desc = "Swap function with previous" })

    map_move("]f", move.goto_next_start, "@call.outer", "textobjects", "Next function call start")
    map_move("]m", move.goto_next_start, "@function.outer", "textobjects", "Next method/function def start")
    map_move("]c", move.goto_next_start, "@class.outer", "textobjects", "Next class start")
    map_move("]i", move.goto_next_start, "@conditional.outer", "textobjects", "Next conditional start")
    map_move("]l", move.goto_next_start, "@loop.outer", "textobjects", "Next loop start")
    map_move("]s", move.goto_next_start, "@scope", "locals", "Next scope")
    map_move("]z", move.goto_next_start, "@fold", "folds", "Next fold")

    map_move("]F", move.goto_next_end, "@call.outer", "textobjects", "Next function call end")
    map_move("]M", move.goto_next_end, "@function.outer", "textobjects", "Next method/function def end")
    map_move("]C", move.goto_next_end, "@class.outer", "textobjects", "Next class end")
    map_move("]I", move.goto_next_end, "@conditional.outer", "textobjects", "Next conditional end")
    map_move("]L", move.goto_next_end, "@loop.outer", "textobjects", "Next loop end")

    map_move("[f", move.goto_previous_start, "@call.outer", "textobjects", "Previous function call start")
    map_move("[m", move.goto_previous_start, "@function.outer", "textobjects", "Previous method/function def start")
    map_move("[c", move.goto_previous_start, "@class.outer", "textobjects", "Previous class start")
    map_move("[i", move.goto_previous_start, "@conditional.outer", "textobjects", "Previous conditional start")
    map_move("[l", move.goto_previous_start, "@loop.outer", "textobjects", "Previous loop start")

    map_move("[F", move.goto_previous_end, "@call.outer", "textobjects", "Previous function call end")
    map_move("[M", move.goto_previous_end, "@function.outer", "textobjects", "Previous method/function def end")
    map_move("[C", move.goto_previous_end, "@class.outer", "textobjects", "Previous class end")
    map_move("[I", move.goto_previous_end, "@conditional.outer", "textobjects", "Previous conditional end")
    map_move("[L", move.goto_previous_end, "@loop.outer", "textobjects", "Previous loop end")

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
