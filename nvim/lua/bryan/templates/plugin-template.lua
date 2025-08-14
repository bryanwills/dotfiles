---@diagnostic disable: undefined-global
return {
  "plugin-name/plugin-repo",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Your plugin configuration here
  end,
}
