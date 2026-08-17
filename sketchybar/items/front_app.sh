#!/bin/bash

aerospace=(
  script="$PLUGIN_DIR/aerospace.sh"
  icon.font="$FONT:Bold:15.0"
  label.drawing=off
  icon.width=20
  icon=$AEROSPACE_ACCORDION
  icon.color=$MAGENTA
  associated_display=active
)

front_app=(
  icon.drawing=off
  padding_left=2
  label.color=$WHITE
  label.font="$TEXT_FONT"
  associated_display=active
)

sketchybar --add event aerospace_window_change              \
           --add item aerospace left                        \
           --set aerospace "${aerospace[@]}"                \
           --subscribe aerospace aerospace_window_change    \
                                                            \
           --add item front_app left                        \
           --set front_app "${front_app[@]}"
