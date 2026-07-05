#!/bin/bash

# Controller for all AeroSpace workspace items.
#
# 1. Updates every space.<id> item: label = full app names in that
#    workspace, highlight when focused, hidden when empty & unfocused.
# 2. Notch avoidance: measures the rendered width of each visible item,
#    finds the first one that would collide with the notch and moves an
#    invisible fixed-width spacer (notch_gap) in front of it, so the
#    remaining items continue on the right side of the notch.

# --- Tunables -------------------------------------------------------------
NOTCH_WIDTH=230   # notch width (pt) incl. safety margin (Air 13.6" ~200pt)
BAR_PAD=10        # must match bar padding_left in sketchybarrc
ITEM_PAD=8        # outer padding_left+padding_right of each item (4+4)
FOCUSED_BG=0x70f5a623
PREVIOUS_BG=0x40ffffff
# ---------------------------------------------------------------------------

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
WORKSPACES=$(aerospace list-workspaces --all)

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
  apps=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null |
    awk '!seen[$0]++ { printf "%s%s", sep, $0; sep=" | " }')

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
    drawing="$drawing"
    label="$apps"
    label.drawing="$label_drawing"
    background.color="$background_color"
    background.drawing="$highlight")
done
sketchybar "${set_args[@]}"

##### Pass 2: measure rendered widths and place the notch spacer #####
sleep 0.15 # give sketchybar a moment to re-render before measuring

display_w=$(sketchybar --query displays | awk -F'[: ,]+' '/"w"/ { print int($2); exit }')
[ -z "$display_w" ] || [ "$display_w" -eq 0 ] && exit 0

notch_left=$(( display_w / 2 - NOTCH_WIDTH / 2 ))
notch_right=$(( display_w / 2 + NOTCH_WIDTH / 2 ))

x=$BAR_PAD
spacer_target=""
spacer_width=0

for sid in $WORKSPACES; do
  info=$(sketchybar --query space."$sid")

  # skip hidden items (first "drawing" key is the item-level one)
  item_drawing=$(printf '%s' "$info" | awk -F'"' '/"drawing"/ { print $4; exit }')
  [ "$item_drawing" = "off" ] && continue

  # rendered width: first "size" entry of bounding_rects -> [ w, h ]
  w=$(printf '%s' "$info" | awk -F'[][ ,]+' '/"size"/ { print int($2); exit }')
  [ -z "$w" ] && continue

  end=$(( x + ITEM_PAD + w ))
  if [ -z "$spacer_target" ] && [ "$end" -gt "$notch_left" ]; then
    # this item would collide with / pass under the notch:
    # pad from current x up to the right edge of the notch
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
