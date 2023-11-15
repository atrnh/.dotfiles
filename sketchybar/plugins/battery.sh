#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/catpuccin.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

COLOR=$MOCHA_blue
ICON="􀘾"
if [[ $CHARGING != "" ]]; then
  ICON="􀋦"
  COLOR=$MOCHA_green
fi

sketchybar --set $NAME drawing=on icon="$ICON" label="$PERCENTAGE" icon.color=$COLOR
