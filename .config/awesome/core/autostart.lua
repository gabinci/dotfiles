local awful = require("awful")

awful.spawn.with_shell(
	"picom -b --experimental-backends --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350"
) -- compositor
awful.spawn.with_shell("~/.config/polybar/launch.sh") -- polybar
awful.spawn.with_shell("setxkbmap br abnt2 -option caps:escape")
