local awful = require("awful")

awful.spawn.with_shell(
	"picom -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350"
)
awful.spawn.with_shell("~/.config/polybar/launch.sh")
awful.spawn.with_shell("setxkbmap br abnt2")
awful.spawn.with_shell("setxkbmap -option caps:escape")
