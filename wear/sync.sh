#!/bin/sh
set -eu

WATCH_DIR=/sdcard/Android/data/com.gymmane.app/files/sync
PREFIX=gymmane-auto-

if [ $# -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "GymMane watch sync"
  echo ""
  echo "  sh sync.sh <folder>            the folder where your phone or server leaves its backups"
  echo "  sh sync.sh <backup.zip>        a single backup exported from the phone"
  echo "  sh sync.sh <folder> <serial>   pick the watch when more than one device is connected"
  echo ""
  echo "Sends your newest backup to the watch and brings back the workouts done on the watch."
  exit 0
fi

SOURCE=$1
SERIAL=${2:-}

command -v adb >/dev/null 2>&1 || { echo "adb was not found. Install Android platform-tools first."; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip was not found. Install it and try again."; exit 1; }

adb_() {
  if [ -n "$SERIAL" ]; then adb -s "$SERIAL" "$@"; else adb "$@"; fi
}

if [ -z "$SERIAL" ]; then
  COUNT=$(adb devices | awk 'NR > 1 && $2 == "device"' | wc -l | tr -d ' ')
  if [ "$COUNT" = 0 ]; then echo "No device connected. Pair the watch first (see WEAR.md)."; exit 1; fi
  if [ "$COUNT" != 1 ]; then
    echo "More than one device is connected. Run it again with the watch serial:"
    adb devices | awk 'NR > 1 && $2 == "device" { print "  " $1 }'
    exit 1
  fi
fi

adb_ shell pm path com.gymmane.app >/dev/null 2>&1 || { echo "GymMane is not installed on that device."; exit 1; }
adb_ shell mkdir -p "$WATCH_DIR"

if [ -d "$SOURCE" ]; then
  FOLDER=$SOURCE
  NEWEST=$(ls "$FOLDER" 2>/dev/null | grep "^$PREFIX[a-z]*-.*\.zip$" | grep -v "^${PREFIX}watch" |
    sed "s/^$PREFIX\([a-z]*\)-\(.*\)\.zip$/\2 &/" | sort | tail -n 1 | cut -d' ' -f2-)
  [ -z "$NEWEST" ] || NEWEST="$FOLDER/$NEWEST"
  TARGET=$(basename "${NEWEST:-none}" .zip).json
elif [ -f "$SOURCE" ]; then
  FOLDER=$(dirname "$SOURCE")
  NEWEST=$SOURCE
  TARGET="${PREFIX}phone-$(date -u +%Y-%m-%d-%H%M%S).json"
else
  echo "$SOURCE is not a folder or a file."
  exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

if [ -n "$NEWEST" ]; then
  if unzip -p "$NEWEST" gymmane.json >"$TMP/$TARGET" 2>/dev/null && [ -s "$TMP/$TARGET" ]; then
    adb_ push "$TMP/$TARGET" "$WATCH_DIR/$TARGET" >/dev/null
    echo "Sent to the watch: $(basename "$NEWEST")"
  else
    echo "$(basename "$NEWEST") is not a GymMane backup, nothing was sent."
  fi
else
  echo "No backup found in $FOLDER, nothing was sent."
fi

BROUGHT=0
for NAME in $(adb_ shell ls "$WATCH_DIR" 2>/dev/null | tr -d '\r' | grep "^${PREFIX}watch[a-z]*-.*\.zip$" || true); do
  [ -f "$FOLDER/$NAME" ] && continue
  adb_ pull "$WATCH_DIR/$NAME" "$FOLDER/$NAME" >/dev/null
  BROUGHT=$((BROUGHT + 1))
done

if [ "$BROUGHT" = 0 ]; then echo "Nothing new on the watch."
else echo "Brought from the watch: $BROUGHT file(s) into $FOLDER"; fi

echo "On the watch, open GymMane > Settings > Sync now."
