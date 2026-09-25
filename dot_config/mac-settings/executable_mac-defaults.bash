#!/usr/bin/env bash
# mac-defaults.bash -- personal macOS defaults that are safe to re-run.
#
# Usage:
#   ./mac-defaults.bash                 # apply user-level settings
#   ./mac-defaults.bash --yes           # do not ask for confirmation
#   ./mac-defaults.bash --system-feature-flags
#                                     # also change OS-wide experimental flags
#
# Some settings are deliberately not applied by default:
# FeatureFlags are undocumented, OS-version-dependent settings and require sudo.
# A log-out (or restart) may still be needed for the menu bar and input settings.

set -Eeuo pipefail

SCRIPT_NAME="$(basename "$0")"
ASSUME_YES=false
APPLY_SYSTEM_FEATURE_FLAGS=false

usage() {
  cat <<EOF
Usage: $SCRIPT_NAME [options]

Apply the preferred macOS defaults for the current user. The script is
idempotent: it can be run again after a macOS upgrade or on another Mac.

Options:
  -y, --yes                   Do not ask for confirmation.
  --system-feature-flags      Apply undocumented, system-wide FeatureFlags too
                              (requires an administrator password).
  -h, --help                  Show this help.
EOF
}

note() { printf '%s\n' "==> $*"; }
warn() { printf '%s\n' "Warning: $*" >&2; }
die() { printf '%s\n' "Error: $*" >&2; exit 1; }

while (($#)); do
  case "$1" in
    -y|--yes) ASSUME_YES=true ;;
    --system-feature-flags) APPLY_SYSTEM_FEATURE_FLAGS=true ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown option: $1 (use --help)" ;;
  esac
  shift
done

[[ "${OSTYPE:-}" == darwin* ]] || die "This script can only run on macOS."
command -v defaults >/dev/null || die "The macOS 'defaults' command was not found."

if ! $ASSUME_YES && [[ -t 0 ]]; then
  printf 'Apply these macOS defaults for %s? [y/N] ' "$USER"
  read -r reply
  [[ "$reply" =~ ^[Yy]([Ee][Ss])?$ ]] || { note "Cancelled."; exit 0; }
elif ! $ASSUME_YES; then
  die "Non-interactive use requires --yes."
fi

write_default() {
  # Print the target so a failure can be located without dumping preference data.
  note "defaults write $1"
  defaults write "$@"
}

restart_if_running() {
  local process_name="$1"
  if pgrep -x "$process_name" >/dev/null 2>&1; then
    note "Restarting $process_name"
    killall "$process_name" || warn "Could not restart $process_name; restart it manually."
  fi
}

note "Configuring keyboard and pointer settings"
# Make F1--F12 standard function keys. Fn still accesses media-key behavior.
write_default -g com.apple.keyboard.fnState -bool true
# Do not change the input source when Fn is pressed (takes effect after log-out).
write_default com.apple.HIToolbox AppleFnUsageType -int 0

# Custom red cursor, with a white outline, at 1.5x the default size.
write_default com.apple.universalaccess cursorFill -dict red 1 green 0 blue 0 alpha 1
write_default com.apple.universalaccess cursorOutline -dict red 1 green 1 blue 1 alpha 1
write_default com.apple.universalaccess cursorIsCustomized -bool true
write_default com.apple.universalaccess mouseDriverCursorSize -float 1.5

# Enable Look Up with a three-finger tap for both built-in and Bluetooth trackpads.
write_default com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
write_default com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

note "Configuring appearance and window management"
# AeroSpace's recommended Mission Control settings.
write_default com.apple.dock expose-group-apps -bool true
write_default com.apple.spaces spans-displays -bool true

# Keep the Dock out of the way until the pointer is intentionally held at its edge.
write_default com.apple.dock autohide -bool true
write_default com.apple.dock autohide-delay -float 1000

# These accessibility settings improve readability and reduce animation.
write_default NSGlobalDomain _HIHideMenuBar -bool true
write_default com.apple.universalaccess reduceTransparency -bool true
write_default com.apple.universalaccess reduceMotion -bool true

note "Configuring Finder"
write_default com.apple.finder FXDefaultSearchScope -string SCcf
write_default com.apple.finder ShowPathbar -bool true

note "Configuring Kitty"
# Allows AeroSpace navigation while Kitty is focused. This is a Kitty preference.
write_default net.kovidgoyal.kitty SecureKeyboardEntry -bool false

if $APPLY_SYSTEM_FEATURE_FLAGS; then
  note "Applying OS-wide FeatureFlags (administrator authentication is required)"
  sudo -v
  # These keys are undocumented and may disappear or change in future macOS releases.
  sudo defaults write /Library/Preferences/FeatureFlags/Domain/InputMethod.plist \
    CapsuleIndicator -dict-add Enabled -bool false
  sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist \
    redesigned_text_cursor -dict-add Enabled -bool false
else
  note "Skipping OS-wide FeatureFlags (use --system-feature-flags to opt in)"
fi

# Reload affected applications. A subsequent log-out/restart is still recommended
# for menu-bar visibility and input-source behavior.
restart_if_running cfprefsd
restart_if_running Dock
restart_if_running Finder
restart_if_running SystemUIServer

note "Done. Log out and back in (or restart) to apply every setting."
