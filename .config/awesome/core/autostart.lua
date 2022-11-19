local awful = require("awful")

awful.spawn.with_shell("picom -b --experimental-backends --animations ") -- compositor
awful.spawn.with_shell("setxkbmap br abnt2 -option caps:escape") -- keyboard

awful.spawn.with_shell("~/.config/polybar/launch.sh") -- polybar
awful.spawn.with_shell("kmix --keepvisibility")
awful.spawn.with_shell("nm-applet")

awful.spawn.with_shell("nitrogen --restore")
