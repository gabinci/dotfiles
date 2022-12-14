local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local awful = require("awful") --Everything related to window managment
local exp = require("core.exports")
local wibox = require("wibox")
local gears = require("gears") --Utilities such as color parsing and objects

-- {{{ Menu
local myawesomemenu = {
	{
		"hotkeys",
		function()
			return false, hotkeys_popup.show_help
		end,
	},
	{ "arandr", "arandr" },
}

awful.util.mymainmenu = freedesktop.menu.build({
	before = {
		{ "Awesome", myawesomemenu },
		--{ "Atom", "atom" },
		-- other triads can be put here
	},
	after = {
		{ "Terminal", exp.terminal },
		{
			"Log out",
			function()
				awesome.quit()
			end,
		},
		{ "Sleep", "systemctl suspend" },
		{ "Restart", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" },
		-- other triads can be put here
	},
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", function(s)
-- 	-- Wallpaper
-- 	if beautiful.wallpaper then
-- 		local wallpaper = beautiful.wallpaper
-- 		-- If wallpaper is a function, call it with the screen
-- 		if type(wallpaper) == "function" then
-- 			wallpaper = wallpaper(s)
-- 		end
-- 		gears.wallpaper.maximized(wallpaper, s, true)
-- 	end
-- end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if only_one and not c.floating or c.maximized then
			c.border_width = 2
		else
			c.border_width = beautiful.border_width
		end
	end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
	s.systray = wibox.widget.systray()
	s.systray.visible = true
end)
-- }}}
