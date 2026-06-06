#!/usr/bin/env bash
set -euo pipefail

# Export portable Finder/System Settings preferences from the current Mac.
# Usage:
#   ./export-preferences.sh [output-dir]
# Default output dir is the directory containing this script.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${1:-$SCRIPT_DIR}"
mkdir -p "$OUT_DIR"

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
  target="$OUT_DIR/$domain.plist"
  echo "Exporting $domain -> $target"
  if ! defaults export "$domain" "$target" 2>/dev/null; then
    echo "Skipping missing/unreadable domain: $domain" >&2
  fi
done

echo "Done. Exported preferences to: $OUT_DIR"
