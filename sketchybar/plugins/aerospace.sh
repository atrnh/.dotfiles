#!/bin/bash

source "$HOME/.config/sketchybar/catppuccin.sh"
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

window=$(aerospace list-windows --focused --json \
  --format '%{app-name}%{window-layout}%{window-is-fullscreen}' 2>/dev/null) || exit 0

IFS=$'\t' read -r app layout fullscreen <<< "$(
  jq -r '[.[0]["app-name"] // "", .[0]["window-layout"] // "", .[0]["window-is-fullscreen"] // false] | @tsv' <<< "$window"
)"

[ -n "$app" ] || exit 0

if [ "$fullscreen" = "true" ]; then
  icon=$AEROSPACE_FULLSCREEN
  color=$MOCHA_green
else
  case "$layout" in
    *_accordion)
      icon=$AEROSPACE_ACCORDION
      color=$MOCHA_mauve
      ;;
    *_tiles)
      icon=$AEROSPACE_TILES
      color=$MOCHA_blue
      ;;
    floating)
      icon=$AEROSPACE_FLOATING
      color=$MOCHA_sky
      ;;
    *)
      icon=$AEROSPACE_TILES
      color=$MAGENTA
      ;;
  esac
fi

sketchybar --set aerospace icon="$icon" icon.color="$color" \
           --set front_app label="$app"
