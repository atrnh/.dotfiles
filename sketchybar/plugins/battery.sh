#!/bin/bash

source "$HOME/.config/sketchybar/catppuccin.sh"
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

battery_info=$(pmset -g batt)
percentage=$(grep -Eo '[0-9]+%' <<< "$battery_info" | head -1 | tr -d '%')

[ -n "$percentage" ] || exit 0

color=$MOCHA_blue
if grep -q 'AC Power' <<< "$battery_info"; then
  icon=$BATTERY_CHARGING
  color=$MOCHA_green
elif [ "$percentage" -ge 80 ]; then
  icon=$BATTERY_100
elif [ "$percentage" -ge 60 ]; then
  icon=$BATTERY_75
elif [ "$percentage" -ge 40 ]; then
  icon=$BATTERY_50
elif [ "$percentage" -ge 20 ]; then
  icon=$BATTERY_25
else
  icon=$BATTERY_0
fi

sketchybar --set "$NAME" drawing=on icon="$icon" label="$percentage" icon.color="$color" label.color="$color"
