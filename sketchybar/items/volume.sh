#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  padding_left=0
  padding_right=0
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$MAGENTA
  slider.background.height=3
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=off
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=6
  padding_right=3
  icon=$VOLUME_100
  icon.width=18
  icon.align=center
  icon.color=$RED
  icon.font="$FONT:Regular:15.0"
  label.drawing=off
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                              mouse.entered     \
                              mouse.exited      \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
