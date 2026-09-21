#!/bin/zsh
# Reserve SketchyBar space only on the macOS main display, and size the bar to match.

set -euo pipefail

config_path="${0:A:h}/aerospace.toml"
aerospace_bin="/opt/homebrew/bin/aerospace"
sketchybar_bin="/opt/homebrew/bin/sketchybar"

main_monitor="$(${aerospace_bin} list-monitors --format '%{monitor-name}|%{monitor-is-main}' | /usr/bin/awk -F '|' '$2 == "true" { print $1; exit }')"

# RTK FHD is the bigme b13. The built-in panel already reserves 28 px for the notch.
case "${main_monitor}" in
  'RTK FHD') top_gap=30; bar_height=32 ;;
  'Built-in Retina Display') top_gap=0; bar_height=28 ;;
  *) top_gap=0; bar_height=28 ;;
esac

# Cheap and idempotent, so apply it even when the gap is already correct.
${sketchybar_bin} --bar height="${bar_height}" 2>/dev/null || true

new_setting="outer.top = [{ monitor.main = ${top_gap} }, 0]"
current_setting="$(/usr/bin/grep '^outer\.top = ' "${config_path}" || true)"

# Avoid needless reloads when focus changes but the main display did not.
[[ "${current_setting}" == "${new_setting}" ]] && exit 0

/usr/bin/sed -i '' "s|^outer\.top = .*|${new_setting}|" "${config_path}"
${aerospace_bin} reload-config --no-gui
