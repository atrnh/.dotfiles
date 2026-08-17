#!/bin/bash

calendar=(
  icon=cal
  icon.font="$TEXT_FONT"
  icon.padding_right=6
  label.font="$TEXT_FONT"
  label.color=$MOCHA_mauve
  label.width=36
  label.padding_left=8
  label.align=right
  padding_left=3
  padding_right=11
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
