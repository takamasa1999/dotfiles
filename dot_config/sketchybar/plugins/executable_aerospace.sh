#!/bin/bash

# Updates a single AeroSpace workspace item (space.<id>):
#   - label = first 3 characters of each app in the workspace
#   - highlighted background when focused
#   - hidden entirely when empty and not focused

SID="${NAME#space.}"

# FOCUSED_WORKSPACE is set when triggered via aerospace_workspace_change;
# fall back to querying aerospace for other events.
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

# First 3 characters of each (unique) app name in this workspace.
APPS=$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null \
  | awk '!seen[$0]++ { printf "%s ", substr($0, 1, 3) }')
APPS="${APPS% }"

if [ "$SID" = "$FOCUSED" ]; then
  HIGHLIGHT=on
else
  HIGHLIGHT=off
fi

if [ -z "$APPS" ] && [ "$SID" != "$FOCUSED" ]; then
  DRAWING=off
else
  DRAWING=on
fi

sketchybar --set "$NAME" \
  drawing="$DRAWING" \
  label="$APPS" \
  label.drawing=$([ -n "$APPS" ] && echo on || echo off) \
  background.drawing="$HIGHLIGHT"
