---@diagnostic disable: undefined-global
return {
  "echasnovski/mini.icons",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.icons").setup()
  end,
}