#!/bin/bash

# Kill existing polybar instances
killall -q polybar

# Wait until each process killed
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar with default configuration file ~/.config/polybar/config
polybar default &

