#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    icon.font="$FONT:Bold:12.0"
    icon=${SPACE_ICONS[i]}
    icon.padding_left=8
    icon.padding_right=8
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color=$MOCHA_maroon
    label.font="sketchybar-app-font:Regular:13.0"
    label.color=$MOCHA_rosewater
    label.highlight_color=$MOCHA_maroon
    label.background.height=24
    label.background.drawing=on
    label.background.color=$BACKGROUND_1
    label.background.corner_radius=4
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

spaces=(
  background.border_color=$TRANSPARENT
  background.border_width=0
  background.drawing=on
)

separator=(
  icon=􀅼
  icon.font="$FONT:Heavy:10.0"
  padding_left=8
  padding_right=0
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger space_change'
  icon.color=$WHITE
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
                                              \
           --add item separator left          \
           --set separator "${separator[@]}"
