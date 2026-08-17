#!/bin/bash

WORKSPACES=($(aerospace list-workspaces --all))

# Focus workspace on left click.

spaces=()
for sid in "${WORKSPACES[@]}"; do
  space=(
    icon.font="$TEXT_FONT"
    icon=$sid
    icon.padding_left=4
    icon.padding_right=4
    padding_left=2
    padding_right=2
    label.padding_left=3
    label.padding_right=3
    icon.highlight_color=$MOCHA_maroon
    label.font="sketchybar-app-font:Regular:15.0"
    label.color=$MOCHA_rosewater
    label.highlight_color=$MOCHA_maroon
    label.background.height=22
    label.background.drawing=on
    label.background.color=$BACKGROUND_1
    label.background.corner_radius=4
    label.background.y_offset=1
    label.drawing=off
    click_script="$PLUGIN_DIR/space.sh $sid"
  )

  sketchybar --add item space.$sid left \
    --set space.$sid "${space[@]}"
done

spaces=(
  background.border_color=$TRANSPARENT
  background.border_width=0
  background.drawing=on
)

sketchybar --add bracket spaces '/space\..*/' \
  --set spaces "${spaces[@]}" script="$PLUGIN_DIR/space.sh" \
  --add event aerospace_workspace_change \
  --add event window_created \
  --subscribe spaces aerospace_workspace_change window_created space_windows_change
