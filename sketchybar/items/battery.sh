#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="SF Pro:Regular:14.0"
  padding_right=0
  padding_left=0
  icon.drawing=on
  update_freq=120
  updates=on
  label.color=$WHITE
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
