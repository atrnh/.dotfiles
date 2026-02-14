#!/bin/bash

source "$HOME/.config/sketchybar/plugins/icon_map.sh"

windows_on_spaces () {
  current_spaces="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"
  # only unique apps that aren't the floating Ghostty window
  jq_unique_apps_without_floating_ghostty='unique_by(."app") | map(select(."subrole" == "AXFloatingWindow" and ."app" == "Ghostty" | not)) | map(select(."role" == "" and ."subrole" == "" | not)) | .[].app'

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=" "
      apps=$(yabai -m query --windows --space $space | jq -r "$jq_unique_apps_without_floating_ghostty")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          __icon_map "$app"
          icon_strip+=" $icon_result"
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
