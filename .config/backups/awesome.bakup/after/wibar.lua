local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local modkey = require("before.env").modkey

-- custom widgets
local logout = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local volume = require("awesome-wm-widgets.volume-widget.volume")
local batteryarc = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local brightness = require("awesome-wm-widgets.brightness-widget.brightness")
local separator = wibox.widget({
	text = " ",
	-- align = "center",
	-- valign = "center",
	font = "JetBrainsMono Nerd Font Regular 13",
	widget = wibox.widget.textbox,
})

local mytextclock = wibox.widget({
	widget = wibox.widget.textclock,
})

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
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

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	-- awful.tag({ "ﰍ", "", "", "", "", "" }, s, awful.layout.layouts[1])
	awful.tag({ "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }, s, awful.layout.layouts[1])
	--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
	--awful.util.tagnames = { "⌘", "♐", "⌥", "ℵ" }
	--awful.util.tagnames = { "www", "edit", "gimp", "inkscape", "music" }
	-- Use this : https://fontawesome.com/cheatsheet
	--awful.util.tagnames = { "", "", "", "", "" }
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		bg = "#1E2030",
		fg = "#CAD3F5",
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			logout(),
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			separator,

			volume({
				widget_type = "arc",
			}),
			separator,

			brightness({
				-- type = 'icon_and_text',
				program = "light",
				step = 10,
			}),
			separator,
			batteryarc({}),
			mytextclock,
		},
	})
end)
-- }}}
