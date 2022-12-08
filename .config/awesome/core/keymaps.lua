local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table = awful.util.table or gears.table
local exp = require("core.exports")

local M = {}

-- {{{ Mouse bindings
root.buttons(my_table.join(
	awful.button({}, 3, function()
		awful.util.mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalkeys = my_table.join(

	-- {{{ Personal keybindings
	awful.key({ exp.modkey }, "w", function()
		awful.util.spawn(exp.browser1)
	end, { description = exp.browser1, group = "function keys" }),
	-- dmenu
	awful.key({ exp.modkey, "Shift" }, "d", function()
		awful.spawn(
			string.format(
				"dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
				beautiful.bg_normal,
				beautiful.fg_normal,
				beautiful.bg_focus,
				beautiful.fg_focus
			)
		)
	end, { description = "show dmenu", group = "hotkeys" }),

	-- Function keys
	awful.key({}, "F12", function()
		awful.util.spawn("xfce4-terminal --drop-down")
	end, { description = "dropdown terminal", group = "function keys" }),

	-- super + ... function keys
	awful.key({ exp.modkey }, "F1", function()
		awful.util.spawn(exp.browser1)
	end, { description = exp.browser1, group = "function keys" }),
	awful.key({ exp.modkey }, "F2", function()
		awful.util.spawn(exp.editorgui)
	end, { description = exp.editorgui, group = "function keys" }),
	awful.key({ exp.modkey }, "F3", function()
		awful.util.spawn("inkscape")
	end, { description = "inkscape", group = "function keys" }),
	awful.key({ exp.modkey }, "F4", function()
		awful.util.spawn("gimp")
	end, { description = "gimp", group = "function keys" }),
	awful.key({ exp.modkey }, "F5", function()
		awful.util.spawn("meld")
	end, { description = "meld", group = "function keys" }),
	awful.key({ exp.modkey }, "F6", function()
		awful.util.spawn("vlc --video-on-top")
	end, { description = "vlc", group = "function keys" }),
	awful.key({ exp.modkey }, "F7", function()
		awful.util.spawn("virtualbox")
	end, { description = exp.virtualmachine, group = "function keys" }),
	awful.key({ exp.modkey }, "F8", function()
		awful.util.spawn(exp.filemanager)
	end, { description = exp.filemanager, group = "function keys" }),
	awful.key({ exp.modkey }, "F9", function()
		awful.util.spawn(exp.mailclient)
	end, { description = exp.mailclient, group = "function keys" }),
	awful.key({ exp.modkey }, "F10", function()
		awful.util.spawn(exp.mediaplayer)
	end, { description = exp.mediaplayer, group = "function keys" }),
	awful.key({ exp.modkey }, "F11", function()
		awful.util.spawn("rofi -theme-str 'window {width: 100%;height: 100%;}' -show drun")
	end, { description = "rofi fullscreen", group = "function keys" }),
	awful.key({ exp.modkey }, "space", function()
		awful.spawn.with_shell("rofi -show drun")
	end, { description = "run prompt", group = "launcher" }),
	awful.key({ exp.modkey, "Control" }, "=", function()
		awful.tag.incgap(5)
	end, { description = "increase gaps", group = "customise" }),
	awful.key({ exp.modkey, "Control" }, "-", function()
		awful.tag.incgap(-5)
	end, { description = "decrease gaps", group = "customise" }),

	-- super + ...
	awful.key({ exp.modkey }, "v", function()
		awful.util.spawn("pavucontrol")
	end, { description = "pulseaudio control", group = "super" }),
	awful.key({ exp.modkey }, "x", function()
		awful.util.spawn("archlinux-logout")
	end, { description = "exit", group = "hotkeys" }),

	-- super + shift + ...
	awful.key({ exp.modkey, "Shift" }, "Return", function()
		awful.util.spawn(exp.filemanager)
	end),
	awful.key({ exp.modkey, "Shift" }, "Escape", function()
		awful.util.spawn("xkill")
	end, { description = "Kill proces", group = "hotkeys" }),

	-- ctrl + shift + ...
	awful.key({ exp.modkey1, "Shift" }, "Escape", function()
		awful.util.spawn("xfce4-taskmanager")
	end),

	-- ctrl+alt +  ...
	awful.key({ exp.modkey1, exp.altkey }, "w", function()
		awful.util.spawn("arcolinux-welcome-app")
	end, { description = "ArcoLinux Welcome App", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "e", function()
		awful.util.spawn("archlinux-tweak-tool")
	end, { description = "ArcoLinux Tweak Tool", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "a", function()
		awful.util.spawn("xfce4-appfinder")
	end, { description = "Xfce appfinder", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "b", function()
		awful.util.spawn(exp.filemanager)
	end, { description = exp.filemanager, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "c", function()
		awful.util.spawn("catfish")
	end, { description = "catfish", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "f", function()
		awful.util.spawn(exp.browser2)
	end, { description = exp.browser2, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "g", function()
		awful.util.spawn(exp.browser3)
	end, { description = exp.browser3, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "i", function()
		awful.util.spawn("nitrogen")
	end, { description = exp.nitrogen, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "k", function()
		awful.util.spawn("archlinux-logout")
	end, { description = exp.scrlocker, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "l", function()
		awful.util.spawn("archlinux-logout")
	end, { description = exp.scrlocker, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "s", function()
		awful.util.spawn(exp.mediaplayer)
	end, { description = exp.mediaplayer, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "t", function()
		awful.util.spawn(exp.terminal)
	end, { description = exp.terminal, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "u", function()
		awful.util.spawn("pavucontrol")
	end, { description = "pulseaudio control", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "v", function()
		awful.util.spawn(exp.browser1)
	end, { description = exp.browser1, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "Return", function()
		awful.util.spawn(exp.terminal)
	end, { description = exp.terminal, group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "m", function()
		awful.util.spawn("xfce4-settings-manager")
	end, { description = "Xfce settings manager", group = "alt+ctrl" }),
	awful.key({ exp.modkey1, exp.altkey }, "p", function()
		awful.util.spawn("pamac-manager")
	end, { description = "Pamac Manager", group = "alt+ctrl" }),

	-- alt + ...
	awful.key({ exp.altkey, "Shift" }, "t", function()
		awful.spawn.with_shell("variety -t  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
	end, { description = "Pywal Wallpaper trash", group = "exp.altkey" }),
	awful.key({ exp.altkey, "Shift" }, "n", function()
		awful.spawn.with_shell("variety -n  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
	end, { description = "Pywal Wallpaper next", group = "exp.altkey" }),
	awful.key({ exp.altkey, "Shift" }, "u", function()
		awful.spawn.with_shell("wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
	end, { description = "Pywal Wallpaper update", group = "exp.altkey" }),
	awful.key({ exp.altkey, "Shift" }, "p", function()
		awful.spawn.with_shell("variety -p  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&")
	end, { description = "Pywal Wallpaper previous", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "t", function()
		awful.util.spawn("variety -t")
	end, { description = "Wallpaper trash", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "n", function()
		awful.util.spawn("variety -n")
	end, { description = "Wallpaper next", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "p", function()
		awful.util.spawn("variety -p")
	end, { description = "Wallpaper previous", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "f", function()
		awful.util.spawn("variety -f")
	end, { description = "Wallpaper favorite", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "Left", function()
		awful.util.spawn("variety -p")
	end, { description = "Wallpaper previous", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "Right", function()
		awful.util.spawn("variety -n")
	end, { description = "Wallpaper next", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "Up", function()
		awful.util.spawn("variety --pause")
	end, { description = "Wallpaper pause", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "Down", function()
		awful.util.spawn("variety --resume")
	end, { description = "Wallpaper resume", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "F2", function()
		awful.util.spawn("xfce4-appfinder --collapsed")
	end, { description = "Xfce appfinder", group = "exp.altkey" }),
	awful.key({ exp.altkey }, "F3", function()
		awful.util.spawn("xfce4-appfinder")
	end, { description = "Xfce appfinder", group = "exp.altkey" }),
	-- awful.key({ exp.altkey }, "F5", function () awful.spawn.with_shell( "xlunch --config ~/.config/xlunch/default.conf --input ~/.config/xlunch/entries.dsv" ) end,
	--    {description = "Xlunch app launcher", group = "exp.altkey"}),

	-- screenshots
	awful.key({}, "Print", function()
		awful.util.spawn("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")
	end, { description = "Scrot", group = "screenshots" }),
	awful.key({ exp.modkey1 }, "Print", function()
		awful.util.spawn("xfce4-screenshooter")
	end, { description = "Xfce screenshot", group = "screenshots" }),
	awful.key({ exp.modkey1, "Shift" }, "Print", function()
		awful.util.spawn("gnome-screenshot -i")
	end, { description = "Gnome screenshot", group = "screenshots" }),

	-- Personal keybindings}}}

	-- Hotkeys Awesome

	awful.key({ exp.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Tag browsing with exp.modkey
	awful.key({ exp.modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ exp.modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ exp.altkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	-- Tag browsing alt + tab
	awful.key({ exp.altkey }, "Tab", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ exp.altkey, "Shift" }, "Tab", awful.tag.viewprev, { description = "view previous", group = "tag" }),

	-- Tag browsing exp.modkey + tab
	-- awful.key({ exp.modkey }, "Tab", awful.tag.viewnext, { description = "view next", group = "tag" }),
	-- awful.key({ exp.modkey, "Shift" }, "Tab", awful.tag.viewprev, { description = "view previous", group = "tag" }),

	-- Non-empty tag browsing
	--awful.key({ exp.modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
	--{description = "view  previous nonempty", group = "tag"}),
	-- awful.key({ exp.modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
	-- {description = "view  next nonempty", group = "tag"}),

	-- Default client focus
	awful.key({ exp.modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ exp.modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ exp.modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),
	awful.key({ exp.modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ exp.modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	-- By direction client focus
	-- awful.key({ exp.modkey }, "j", function()
	-- 	awful.client.focus.global_bydirection("down")
	-- 	if client.focus then
	-- 		client.focus:raise()
	-- 	end
	-- end, { description = "focus down", group = "client" }),
	-- awful.key({ exp.modkey }, "k", function()
	-- 	awful.client.focus.global_bydirection("up")
	-- 	if client.focus then
	-- 		client.focus:raise()
	-- 	end
	-- end, { description = "focus up", group = "client" }),
	awful.key({ exp.modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ exp.modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),

	-- Layout manipulation
	awful.key({ exp.modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ exp.modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	-- awful.key({ exp.modkey, "Control" }, "j", function()
	-- 	awful.screen.focus_relative(1)
	-- end, { description = "focus the next screen", group = "screen" }),
	-- awful.key({ exp.modkey, "Control" }, "k", function()
	-- 	awful.screen.focus_relative(-1)
	-- end, { description = "focus the previous screen", group = "screen" }),
	-- awful.key(
	-- 	{ exp.modkey },
	-- 	"u",
	-- 	awful.client.urgent.jumpto,
	-- 	{ description = "jump to urgent client", group = "client" }
	-- ),
	awful.key({ exp.modkey1 }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Show/Hide Wibox
	awful.key({ exp.modkey }, "b", function()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end, { description = "toggle wibox", group = "awesome" }),

	-- Show/Hide Systray
	awful.key({ exp.modkey }, "-", function()
		awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
	end, { description = "Toggle systray visibility", group = "awesome" }),

	-- Show/Hide Systray
	awful.key({ exp.modkey }, "KP_Subtract", function()
		awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
	end, { description = "Toggle systray visibility", group = "awesome" }),

	-- Dynamic tagging
	-- awful.key({ exp.modkey, "Shift" }, "n", function()
	-- 	lain.util.add_tag()
	-- end, { description = "add new tag", group = "tag" }),
	-- awful.key({ exp.modkey, "Control" }, "r", function()
	-- 	lain.util.rename_tag()
	-- end, { description = "rename tag", group = "tag" }),
	-- awful.key({ exp.modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
	--          {description = "move tag to the left", group = "tag"}),
	-- awful.key({ exp.modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
	--          {description = "move tag to the right", group = "tag"}),
	-- awful.key({ exp.modkey, "Shift" }, "y", function()
	-- 	lain.util.delete_tag()
	-- end, { description = "delete tag", group = "tag" }),

	-- Standard program
	awful.key({ exp.modkey }, "Return", function()
		awful.spawn(exp.terminal)
	end, { description = exp.terminal, group = "super" }),
	awful.key({ exp.modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	-- awful.key({ exp.modkey, "Shift"   }, "x", awesome.quit,
	--          {description = "quit awesome", group = "awesome"}),

	awful.key({ exp.modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ exp.modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ exp.modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ exp.modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ exp.modkey, "Control" }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	--awful.key({ exp.modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
	-- {description = "select previous", group = "layout"}),

	awful.key({ exp.modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end, { description = "restore minimized", group = "client" }),

	-- Widgets popups
	--awful.key({ exp.altkey, }, "c", function () lain.widget.calendar.show(7) end,
	--{description = "show calendar", group = "widgets"}),
	--awful.key({ exp.altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
	--{description = "show filesystem", group = "widgets"}),
	--awful.key({ exp.altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
	--{description = "show weather", group = "widgets"}),

	-- Brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		os.execute("light -A 10")
	end, { description = "+10%", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		os.execute("light -U 10")
	end, { description = "-10%", group = "hotkeys" }),

	-- ALSA volume control
	--awful.key({ exp.modkey1 }, "Up",
	awful.key({}, "XF86AudioRaiseVolume", function()
		os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	--awful.key({ exp.modkey1 }, "Down",
	awful.key({}, "XF86AudioLowerVolume", function()
		os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({}, "XF86AudioMute", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({ exp.modkey1, "Shift" }, "m", function()
		os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
		beautiful.volume.update()
	end),
	awful.key({ exp.modkey1, "Shift" }, "0", function()
		os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
		beautiful.volume.update()
	end),

	--Media keys supported by vlc, spotify, audacious, xmm2, ...
	--awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
	--awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
	--awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
	--awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end),

	--Media keys supported by mpd.
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("mpc toggle")
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("mpc next")
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("mpc prev")
	end),
	awful.key({}, "XF86AudioStop", function()
		awful.util.spawn("mpc stop")
	end),

	-- MPD control
	awful.key({ exp.modkey1, "Shift" }, "Up", function()
		os.execute("mpc toggle")
		beautiful.mpd.update()
	end, { description = "mpc toggle", group = "widgets" }),
	awful.key({ exp.modkey1, "Shift" }, "Down", function()
		os.execute("mpc stop")
		beautiful.mpd.update()
	end, { description = "mpc stop", group = "widgets" }),
	awful.key({ exp.modkey1, "Shift" }, "Left", function()
		os.execute("mpc prev")
		beautiful.mpd.update()
	end, { description = "mpc prev", group = "widgets" }),
	awful.key({ exp.modkey1, "Shift" }, "Right", function()
		os.execute("mpc next")
		beautiful.mpd.update()
	end, { description = "mpc next", group = "widgets" }),
	awful.key({ exp.modkey1, "Shift" }, "s", function()
		local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
		if beautiful.mpd.timer.started then
			beautiful.mpd.timer:stop()
			common.text = common.text .. lain.util.markup.bold("OFF")
		else
			beautiful.mpd.timer:start()
			common.text = common.text .. lain.util.markup.bold("ON")
		end
		naughty.notify(common)
	end, { description = "mpc on/off", group = "widgets" }),

	-- Copy primary to clipboard (terminals to gtk)
	--awful.key({ exp.modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
	-- {description = "copy terminal to gtk", group = "hotkeys"}),
	--Copy clipboard to primary (gtk to terminals)
	--awful.key({ exp.modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
	--{description = "copy gtk to terminal", group = "hotkeys"}),

	-- Default
	-- Menubar

	-- awful.key({ exp.modkey }, "p", function() menubar.show() end,
	--           {description = "show the menubar", group = "super"})
	--

	awful.key({ exp.altkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" })
	--]]
)

M.clientkeys = my_table.join(
	awful.key(
		{ exp.altkey, "Shift" },
		"m",
		lain.util.magnify_client,
		{ description = "magnify client", group = "client" }
	),
	awful.key({ exp.modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ exp.modkey, "Shift" }, "q", function(c)
		c:kill()
	end, { description = "close", group = "hotkeys" }),
	awful.key({ exp.modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "hotkeys" }),
	awful.key(
		{ exp.modkey, "Shift" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ exp.modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ exp.modkey, "Shift" }, "Left", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ exp.modkey, "Shift" }, "Right", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	--awful.key({ exp.modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
	--{description = "toggle keep on top", group = "client"}),
	awful.key({ exp.modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ exp.modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = { description = "view tag #", group = "tag" }
		descr_toggle = { description = "toggle tag #", group = "tag" }
		descr_move = { description = "move focused client to tag #", group = "tag" }
		descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
	end
	globalkeys = my_table.join(
		globalkeys,
		-- View tag only.
		awful.key({ exp.modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({ exp.modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({ exp.modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({ exp.modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

M.clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ exp.modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ exp.modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

return M
