local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local conf = require("core.config")

beautiful.menu_bg_normal = "#24273a"
beautiful.menu_fg_focus = "#8aadf4"

local powermenu = {
	{
		"   Shutdown",
		function()
			awful.spawn("shutdown now")
		end,
	},
	{
		"   Reboot",
		function()
			awful.spawn("reboot")
		end,
	},
	{
		"   Log-out",
		function()
			awful.spawn.with_shell("sudo pkill -u username")
		end,
	},
}

local myawesomemenu = {
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

local mymainmenu = awful.menu({
	items = {
		{ "   Computer", powermenu },
		{ "﩯   Awesome", myawesomemenu },
		{ "   terminal", conf.terminal },
	},
})

-- Menubar configuration
menubar.utils.terminal = conf.terminal -- Set the terminal for applications that require it

return mymainmenu
