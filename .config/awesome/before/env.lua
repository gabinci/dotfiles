local awful = require("awful")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.

local M = {}

-- This is used later as the default terminal and editor to run.
M.terminal = "kitty"
M.editor = os.getenv("EDITOR") or "nano"
M.editor_cmd = M.terminal .. " -e " .. M.editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
M.modkey = "Mod4"
M.leader = "space"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	-- awful.layout.suit.tile,
	awful.layout.suit.tile.right,
	awful.layout.suit.floating,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

return M
