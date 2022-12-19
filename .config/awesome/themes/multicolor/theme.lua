--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
--theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/backgrounds/arcolinux/arco-wallpaper.jpg"
--theme.wallpaper                                 = "/usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png"
theme.font = "JetBrains Mono Nerd Font 11"
theme.taglist_font = "Noto Sans Regular 13"
theme.menu_bg_normal = "#000000"
theme.menu_bg_focus = "#000000"
theme.bg_normal = "#000000"
theme.bg_focus = "#000000"
theme.bg_urgent = "#000000"
theme.fg_normal = "#45475A"
theme.fg_focus = "#B4BEFE"
theme.fg_urgent = "#F38BA8"
theme.fg_minimize = "#A6ADC8"
theme.border_width = dpi(3)
theme.border_normal = "#1c2022"
theme.border_focus = "#B4BEFE"
theme.border_marked = "#89B4FA"
theme.menu_border_width = 0
theme.menu_height = dpi(25)
theme.menu_width = dpi(260)
theme.menu_submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal = "#45475A"
theme.menu_fg_focus = "#B4BEFE"
theme.menu_bg_normal = "#050505dd"
theme.menu_bg_focus = "#050505dd"
theme.widget_temp = theme.confdir .. "/icons/temp.png"
theme.widget_uptime = theme.confdir .. "/icons/ac.png"
theme.widget_cpu = theme.confdir .. "/icons/cpu.png"
theme.widget_weather = theme.confdir .. "/icons/dish.png"
theme.widget_fs = theme.confdir .. "/icons/fs.png"
theme.widget_mem = theme.confdir .. "/icons/mem.png"
theme.widget_note = theme.confdir .. "/icons/note.png"
theme.widget_note_on = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown = theme.confdir .. "/icons/net_down.png"
theme.widget_netup = theme.confdir .. "/icons/net_up.png"
theme.widget_mail = theme.confdir .. "/icons/mail.png"
theme.widget_batt = theme.confdir .. "/icons/bat.png"
theme.widget_clock = theme.confdir .. "/icons/clock.png"
theme.widget_vol = theme.confdir .. "/icons/spkr.png"
theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"
theme.taglist_fg_focus = "#ffffff"
theme.taglist_bg_focus = "#1E1E2E"
theme.taglist_bg_normal = "#1E1E2E"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = 5
theme.layout_tile = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/dwindle.png"
theme.layout_max = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

local markup = lain.util.markup

local bar_spr = wibox.widget.textbox(
	markup.font("JetBrains Mono Nerd Font 3", " ")
		.. markup.fontfg(theme.font, "#777777", "|")
		.. markup.font("JetBrains Mono Nerd Font 5", " ")
)

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#B4BEFE", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		font = "Noto Sans Mono Medium 10",
		fg = theme.fg_normal,
		bg = theme.bg_normal,
	},
})

-- Battery
local bat = lain.widget.bat({
	settings = function()
		local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc
		if bat_now.ac_status == 1 then
			widget:set_markup(markup.fontfg(theme.font, "#A6E3A1", "" .. perc))
		else
			widget:set_markup(markup.fontfg(theme.font, theme.fg_urgent, "", perc))
		end
	end,
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
	settings = function()
		if volume_now.status == "off" then
			volume_now.level = volume_now.level .. "M"
		end

		widget:set_markup(markup.fontfg(theme.font, theme.fg_focus, volume_now.level .. "% "))
	end,
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
	settings = function()
		--[[ uncomment if using the weather widget
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end
        --]]

		widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
		netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
	end,
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
	end,
})

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
	settings = function()
		mpd_notification_preset = {
			text = string.format("%s [%s] - %s\n%s", mpd_now.artist, mpd_now.album, mpd_now.date, mpd_now.title),
		}
		if mpd_now.state == "play" then
			artist = mpd_now.artist .. " > "
			title = mpd_now.title .. " "
			mpdicon:set_image(theme.widget_note_on)
		elseif mpd_now.state == "pause" then
			artist = "mpd "
			title = "paused "
		else
			artist = ""
			title = ""
			--mpdicon:set_image() -- not working in 4.0
			mpdicon._private.image = nil
			mpdicon:emit_signal("widget::redraw_needed")
			mpdicon:emit_signal("widget::layout_changed")
		end
		widget:set_markup(markup.fontfg(theme.font, "#e54c62", artist) .. markup.fontfg(theme.font, "#b2b2b2", title))
	end,
})

local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
	if t.selected or #t:clients() > 0 then
		return orig_filter(t, args)
	end
end

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })
	-- s.quake = lain.util.quake({ app = "urxvt", height = 0.50, argname = "--name %s" })

	-- If wallpaper is a function, call it with the screen
	-- local wallpaper = theme.wallpaper
	-- if type(wallpaper) == "function" then
	--     wallpaper = wallpaper(s)
	-- end
	-- gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
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
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

	-- Create the wibox
	s.mywibox =
		awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			--s.mylayoutbox,
			s.mytaglist,
			s.mypromptbox,
			mpdicon,
			theme.mpd.widget,
		},
		--s.mytasklist, -- Middle widget
		nil,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			volicon,
			theme.volume.widget,
			bar_spr,
			bat.widget,
			bar_spr,
			mytextclock,
			bar_spr,
			wibox.widget.systray(),
		},
	})

	-- Create the bottom wibox
	s.mybottomwibox = awful.wibar({
		position = "bottom",
		screen = s,
		border_width = 0,
		height = dpi(20),
		bg = theme.bg_normal,
		fg = theme.fg_normal,
	})

	-- Add widgets to the bottom wibox
	s.mybottomwibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			s.mylayoutbox,
		},
	})
end

return theme
