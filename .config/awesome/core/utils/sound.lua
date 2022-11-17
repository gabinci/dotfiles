local awful = require("awful")
local naughty = require("naughty")

Volnotify = {}

Volnotify.id = nil
function Volnotify:notify(msg)
	self.id = naughty.notify({ text = msg, timeout = 1, replaces_id = self.id }).id
end

local M = {}

M.volume = function(incdec)
	awful.util.spawn_with_shell(
		"vol=$(amixer set Master 5%"
			.. incdec
			.. "|tail -1|cut -d % -f 1|cut -d '[' -f 2) && echo \"volnotify:notify('Volume $vol%')\"|awesome-client -",
		false
	)
end

M.toggleMute = function()
	awful.util.spawn_with_shell(
		"vol=$(amixer set Master toggle|tail -n 1|cut -d '[' -f 3|cut -d ']' -f 1) && echo \"volnotify:notify('Volume $vol')\"|awesome-client -",
		false
	)
end

return M
