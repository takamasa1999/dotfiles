#!/bin/zsh
# Copy a screenshot of the display under the mouse cursor to the clipboard.
# screencapture -D takes a 1-based display number (1 = main), which matches
# AppKit's NSScreen.screens order that AeroSpace exposes.

set -euo pipefail

aerospace_bin="/opt/homebrew/bin/aerospace"

display_id="$(${aerospace_bin} list-monitors --mouse --format '%{monitor-appkit-nsscreen-screens-id}' | /usr/bin/head -n 1)"

exec /usr/sbin/screencapture -c -D "${display_id:-1}"
