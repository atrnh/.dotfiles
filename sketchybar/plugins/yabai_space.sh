#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

windows_on_spaces () {
  current_spaces="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"
  jq_unique_apps_without_floating_ghostty='map(select(."role" == "AXWindow" and ."subrole" == "AXStandardWindow")) | map(select(."layer" == "above" | not)) | unique_by(."app") | .[].app'

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=" "
      apps=$(yabai -m query --windows --space $space | jq -r "$jq_unique_apps_without_floating_ghostty")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
        done <<< "$apps"
      fi
      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    done
  done <<< "$current_spaces"

  sketchybar -m "${args[@]}"
}

update() {
  WIDTH="dynamic"
  sketchybar --animate tanh 5 --set $NAME icon.highlight=$SELECTED label.highlight=$SELECTED
  windows_on_spaces
}

mouse_clicked() {
  # destroy space on right click
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
  update
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
