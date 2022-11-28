local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- layouts
awful.layout.layouts = {
	awful.layout.suit.tile.right,
	awful.layout.suit.floating,
}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 5
beautiful.border_width = 3
beautiful.border_color = "#C6A0F6"

local M = {}
-- This is used later as the default terminal and editor to run.
M.terminal = "kitty"
M.editor = os.getenv("EDITOR") or "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor

return M
