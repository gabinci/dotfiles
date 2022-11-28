#!/usr/bin/env bash

# # Terminate already running bar instances
# killall -q polybar
#
# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
# # select style for  polybar
# polybar mycustom -c $(dirname $0)/config.ini &
#

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar awesome -c $(dirname $0)/config.ini &

# if type "xrandr"; then
# 	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
# 		MONITOR=$m polybar --reload awesome &
# 	done
# else
# 	polybar --reload awesome &
# fi

if [[ $(xrandr -q | grep 'HDMI1 connected') ]]; then
	polybar external -c $(dirname $0)/config.ini &
fi
