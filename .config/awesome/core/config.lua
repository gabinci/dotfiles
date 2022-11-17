local awful = require("awful")

local M = {}
-- This is used later as the default terminal and editor to run.
M.terminal = "kitty"
M.editor = os.getenv("EDITOR") or "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor

-- layouts
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
}

return M
