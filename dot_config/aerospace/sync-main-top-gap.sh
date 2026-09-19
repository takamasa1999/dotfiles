#!/bin/zsh
# Reserve SketchyBar space only on the macOS main display.

set -euo pipefail

config_path="${0:A:h}/aerospace.toml"
aerospace_bin="/opt/homebrew/bin/aerospace"

main_monitor="$(${aerospace_bin} list-monitors --format '%{monitor-name}|%{monitor-is-main}' | /usr/bin/awk -F '|' '$2 == "true" { print $1; exit }')"

case "${main_monitor}" in
  'RTK FHD') top_gap=30 ;;
  'Built-in Retina Display') top_gap=0 ;;
  *) top_gap=0 ;;
esac

new_setting="outer.top = [{ monitor.main = ${top_gap} }, 0]"
current_setting="$(/usr/bin/grep '^outer\.top = ' "${config_path}" || true)"

# Avoid needless reloads when focus changes but the main display did not.
[[ "${current_setting}" == "${new_setting}" ]] && exit 0

/usr/bin/sed -i '' "s|^outer\.top = .*|${new_setting}|" "${config_path}"
${aerospace_bin} reload-config --no-gui
