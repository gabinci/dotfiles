#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

run xfce4-power-manager
run nm-applet
run numlockx off
run setxkbmap br abnt2 -option caps:escape
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run picom
run variety
