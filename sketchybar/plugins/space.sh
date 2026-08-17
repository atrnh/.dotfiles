#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

update_highlights() {
  focused_space="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

  args=()
  while IFS= read -r space; do
    selected=off
    if [ "$space" = "$focused_space" ]; then
      selected=on
    fi
    args+=(--set space.$space icon.highlight="$selected" label.highlight="$selected")
  done <<< "$current_spaces"

  sketchybar -m "${args[@]}"
}

update_windows() {
  args=()
  while IFS= read -r space; do
    icon_strip=" "
    apps=$(aerospace list-windows --workspace "$space" --json --format '%{window-parent-container-layout}%{app-name}' |
      jq -r '[.[] | select(.["window-parent-container-layout"] != "floating") | .["app-name"]] | unique[]')
    if [ "$apps" != "" ]; then
      while IFS= read -r app; do
        icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
      done <<< "$apps"
    fi
    args+=(--set space.$space label="$icon_strip" label.drawing=on)
  done <<< "$current_spaces"

  sketchybar -m "${args[@]}"
}

if [ -n "${BUTTON:-}" ]; then
  [ "$BUTTON" = "right" ] || aerospace workspace "$1" 2>/dev/null
  exit
fi

current_spaces="$(aerospace list-workspaces --all)"
update_highlights
[ "$SENDER" = "aerospace_workspace_change" ] || update_windows
