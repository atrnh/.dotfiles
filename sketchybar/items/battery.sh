#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="SF Pro:Regular:15.0"
  icon.color=$MOCHA_blue
  padding_right=2
  padding_left=2
  icon.drawing=on
  update_freq=120
  updates=on
  label.color=$MOCHA_blue
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
