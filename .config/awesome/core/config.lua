local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local M = {}
-- This is used later as the default terminal and editor to run.
M.terminal = "kitty"
M.editor = os.getenv("EDITOR") or "nvim"
M.editor_cmd = M.terminal .. " -e " .. M.editor

-- layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 5

return M
