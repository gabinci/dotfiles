local M = {}

M.modkey = "Mod4"
M.altkey = "Mod1"
M.modkey1 = "Control"

-- personal variables
--change these variables if you want
M.browser1 = "firefox"
M.browser2 = "vivaldi-stable"
M.browser3 = "chromium -no-default-browser-check"
M.editor = os.getenv("EDITOR") or "nano"
M.editorgui = "atom"
M.filemanager = "nautilus"
M.mailclient = "evolution"
M.mediaplayer = "spotify"
M.terminal = "kitty"
M.virtualmachine = "virtualbox"

-- {{{ Variable definitions
-- keep themes in alfabetical order for ATT
local lain = require("lain")
local beautiful = require("beautiful")
local awful = require("awful") --Everything related to window managment
local gears = require("gears") --Utilities such as color parsing and objects
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi

local themes = {
	"blackburn", -- 1
	"copland", -- 2
	"multicolor", -- 3
	"powerarrow", -- 4
	"powerarrow-blue", -- 5
	"powerarrow-dark", -- 6
}

-- choose your theme here
local chosen_theme = themes[2]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- awesome variables
awful.util.terminal = M.terminal
awful.util.tagnames = { "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
	awful.layout.suit.tile.right,
	awful.layout.suit.floating,
}

awful.util.taglist_buttons = my_table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ M.modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ M.modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.util.tasklist_buttons = my_table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			--c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({}, 3, function()
		local instance = nil

		return function()
			if instance and instance.wibox.visible then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ theme = { width = dpi(250) } })
			end
		end
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

return M
