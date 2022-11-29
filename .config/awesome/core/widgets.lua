local lain = require("lain")
local wibox = require("wibox")
-- WIDGETS
local M = {}

M.logout = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
M.volume = require("awesome-wm-widgets.volume-widget.volume")

-- Create a textclock widget
M.mytextclock = wibox.widget({
	widget = wibox.widget.textclock,
})

return M
