#!/usr/bin/env bash
set -euo pipefail

# Import portable Finder/System Settings preferences onto this Mac.
# Usage:
#   ./import-preferences.sh [input-dir]
# Default input dir is the directory containing this script.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IN_DIR="${1:-$SCRIPT_DIR}"

domains=(
  NSGlobalDomain
  com.apple.finder
  com.apple.dock
  com.apple.symbolichotkeys
  com.apple.AppleMultitouchTrackpad
  com.apple.AppleMultitouchMouse
  com.apple.WindowManager
  com.apple.controlcenter
  com.apple.spaces
  com.apple.universalaccess
)

for domain in "${domains[@]}"; do
  source="$IN_DIR/$domain.plist"
  if [[ -f "$source" ]]; then
    echo "Importing $source -> $domain"
    defaults import "$domain" "$source"
  else
    echo "Skipping missing file: $source" >&2
  fi
done

# Restart affected UI services so changes are applied.
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall ControlCenter 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "Done. Some settings may require logout/reboot to fully apply."
