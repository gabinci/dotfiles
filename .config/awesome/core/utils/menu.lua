local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local conf = require("core.config")

local M = {}

M.myawesomemenu = {
	{
		"Hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Manual", conf.terminal .. " -e man awesome" },
	{ "Edit config", conf.editor_cmd .. " " .. awesome.conffile },
	{ "Restart", awesome.restart },
	{
		"Quit",
		function()
			awesome.quit()
		end,
	},
}

M.mymainmenu = awful.menu({
	items = {
		{ "Awesome", M.myawesomemenu, beautiful.awesome_icon },
		{ "Open terminal", conf.terminal },
	},
})

-- Menubar configuration
menubar.utils.terminal = conf.terminal -- Set the terminal for applications that require it
-- }}}

return M
