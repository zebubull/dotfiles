#!/usr/bin/env sh

set -e
hyprctl dispatch workspace 2
firefox >/dev/null 2>/dev/null &
sleep 3
hyprctl dispatch workspace 3
discord >/dev/null 2>/dev/null &
disown
sleep 8
hyprctl dispatch workspace 4
steam >/dev/null 2>/dev/null &
disown
sleep 15
hyprctl dispatch workspace 2
