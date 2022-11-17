local awful = require("awful")

awful.spawn.with_shell("setxkbmap br abnt2")
awful.spawn.with_shell("setxkbmap -option caps:escape")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("~/.config/polybar/launch.sh")
