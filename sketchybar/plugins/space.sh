#!/bin/bash

windows_on_spaces () {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"
  # only unique apps that aren't the floating Ghostty window
  JQ_UNIQUE_APPS_WITHOUT_FLOATING_GHOSTTY='unique_by(."app") | map(select(."subrole" == "AXFloatingWindow" and ."app" == "Ghostty" | not)) | .[].app'

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=" "
      apps=$(yabai -m query --windows --space $space | jq -r "$JQ_UNIQUE_APPS_WITHOUT_FLOATING_GHOSTTY")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
        done <<< "$apps"
      fi
      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

update() {
  WIDTH="dynamic"
  # if [ "$SELECTED" = "true" ]; then
  #   WIDTH="0"
  # fi

  # sketchybar --animate tanh 15 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
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
