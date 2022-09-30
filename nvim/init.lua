require('bryanwi09.base')
require('bryanwi09.highlights')
require('bryanwi09.maps')
require('bryanwi09.plugins')


local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('bryanwi09.macos')
end
if is_win then
  require('bryanwi09.windows')
end
