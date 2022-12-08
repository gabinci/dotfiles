local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local env = require("before.env")

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
	{ "Manual", env.terminal .. " -e man awesome" },
	{ "Edit config", env.editor_cmd .. " " .. awesome.conffile },
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
		{ "   terminal", env.terminal },
	},
})

-- Menubar configuration
menubar.utils.terminal = env.terminal -- Set the terminal for applications that require it

return mymainmenu
