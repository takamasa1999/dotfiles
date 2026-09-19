#!/bin/bash

# Controller for all AeroSpace workspace items.
#
# 1. Updates every space.<id> item: icon = #<id>M or #<id>E and label = full app names in that
#    workspace, highlight when focused, hidden when empty & unfocused.
# 2. Notch avoidance: measures the rendered width of each visible item,
#    finds the first one that would collide with the notch and moves an
#    invisible fixed-width spacer (notch_gap) in front of it. The spacer is
#    shown only when the macOS main display is the built-in, notched panel.

# --- Tunables -------------------------------------------------------------
NOTCH_WIDTH=230
BAR_PAD=10
ITEM_PAD=8
FOCUSED_BG=0x70f5a623
PREVIOUS_BG=0x40ffffff
NOTCH_MONITOR="Built-in Retina Display"
# ---------------------------------------------------------------------------

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
WORKSPACE_INFO=$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-is-main}')
WORKSPACES=$(printf '%s\n' "$WORKSPACE_INFO" | awk -F '|' '{ print $1 }')

STATE_DIR="${TMPDIR:-/tmp}/sketchybar"
PREVIOUS_STATE_FILE="$STATE_DIR/previous_workspace"

if [ "${PREVIOUS_WORKSPACE+x}" = x ]; then
  PREVIOUS="$PREVIOUS_WORKSPACE"
  if [ -n "$PREVIOUS" ] && [ "$PREVIOUS" != "$FOCUSED" ]; then
    mkdir -p "$STATE_DIR"
    printf '%s\n' "$PREVIOUS" > "$PREVIOUS_STATE_FILE"
  fi
elif [ -r "$PREVIOUS_STATE_FILE" ]; then
  PREVIOUS=$(cat "$PREVIOUS_STATE_FILE")
else
  PREVIOUS=""
fi

[ "$PREVIOUS" = "$FOCUSED" ] && PREVIOUS=""

##### Pass 1: update labels / visibility in a single batched call #####
set_args=()
for sid in $WORKSPACES; do
  monitor_is_main=$(printf '%s\n' "$WORKSPACE_INFO" | awk -F '|' -v sid="$sid" '$1 == sid { print $2; exit }')
  if [ "$monitor_is_main" = "true" ]; then monitor_suffix="M"; else monitor_suffix="E"; fi
  apps=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null |
    awk '!seen[$0]++ { printf "%s%s", sep, $0; sep=" | " }')
  if [ -n "$apps" ]; then label=": $apps"; else label=""; fi

  highlight=off
  background_color="$FOCUSED_BG"
  if [ "$sid" = "$FOCUSED" ]; then
    highlight=on
    background_color="$FOCUSED_BG"
  elif [ "$sid" = "$PREVIOUS" ]; then
    highlight=on
    background_color="$PREVIOUS_BG"
  fi

  if [ -z "$apps" ] && [ "$sid" != "$FOCUSED" ] && [ "$sid" != "$PREVIOUS" ]; then drawing=off; else drawing=on; fi
  if [ -n "$apps" ]; then label_drawing=on; else label_drawing=off; fi

  set_args+=(--set "space.$sid"
    icon="#${sid}${monitor_suffix}"
    drawing="$drawing"
    label="$label"
    label.drawing="$label_drawing"
    background.color="$background_color"
    background.drawing="$highlight")
done
sketchybar "${set_args[@]}"

##### Pass 2: measure rendered widths and place the notch spacer #####
main_monitor=$(aerospace list-monitors --format '%{monitor-name}|%{monitor-is-main}' 2>/dev/null |
  awk -F '|' '$2 == "true" { print $1; exit }')
if [ "$main_monitor" != "$NOTCH_MONITOR" ]; then
  sketchybar --set notch_gap drawing=off
  exit 0
fi

sleep 0.15

display_w=$(sketchybar --query displays | awk -F'[: ,]+' '/"w"/ { print int($2); exit }')
[ -z "$display_w" ] || [ "$display_w" -eq 0 ] && exit 0

notch_left=$(( display_w / 2 - NOTCH_WIDTH / 2 ))
notch_right=$(( display_w / 2 + NOTCH_WIDTH / 2 ))

x=$BAR_PAD
spacer_target=""
spacer_width=0

for sid in $WORKSPACES; do
  info=$(sketchybar --query space."$sid")
  item_drawing=$(printf '%s' "$info" | awk -F'"' '/"drawing"/ { print $4; exit }')
  [ "$item_drawing" = "off" ] && continue
  w=$(printf '%s' "$info" | awk -F'[][ ,]+' '/"size"/ { print int($2); exit }')
  [ -z "$w" ] && continue

  end=$(( x + ITEM_PAD + w ))
  if [ -z "$spacer_target" ] && [ "$end" -gt "$notch_left" ]; then
    spacer_target="space.$sid"
    spacer_width=$(( notch_right - x ))
    x=$(( notch_right + ITEM_PAD + w ))
  else
    x=$end
  fi
done

if [ -n "$spacer_target" ]; then
  sketchybar --move notch_gap before "$spacer_target" \
             --set notch_gap drawing=on width="$spacer_width"
else
  sketchybar --set notch_gap drawing=off
fi
