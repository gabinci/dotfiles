local wibox = require("wibox")

local M = {}

M.logout = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
M.volume = require("awesome-wm-widgets.volume-widget.volume")
M.batteryarc = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
M.brightness = require("awesome-wm-widgets.brightness-widget.brightness")

-- Create a textclock et
M.mytextclock = wibox.widget({
	widget = wibox.widget.textclock,
})

return M
