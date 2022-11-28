local awful = require("awful")

awful.spawn.with_shell("picom") -- picom
awful.spawn.with_shell("setxkbmap br abnt2 -option caps:escape") -- keyboard

awful.spawn.with_shell("~/.config/polybar/launch.sh") -- polybar
-- awful.spawn.with_shell("~/.config/polybar/check.sh") -- systray check
awful.spawn.with_shell("kmix --keepvisibility")
awful.spawn.with_shell("nm-applet")

awful.spawn.with_shell("nitrogen --restore")
