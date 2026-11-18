#!/bin/sh
set -eu

REPO=InlitX/GymMane
TOOLS="${HOME}/.local/share/gymmane/platform-tools"
APK="${1:-}"

say() { printf '  %s\n' "$*"; }
step() { printf '\n  %s/4  %s\n\n' "$1" "$2"; }
ok() { printf '     OK  %s\n' "$*"; }
fail() { printf '\n  %s\n\n' "$*" >&2; exit 1; }
ask() { printf '  ? %s ' "$1"; IFS= read -r REPLY </dev/tty || REPLY=""; }
have() { command -v "$1" >/dev/null 2>&1; }
fetch() { if have curl; then curl -fsSL "$1" -o "$2"; else wget -q "$1" -O "$2"; fi; }

case "$APK" in
  -h|--help)
    echo 'GymMane watch installer'
    echo
    echo '  ./install.sh              connects to the watch and installs the right APK from the latest release'
    echo '  ./install.sh <file.apk>   installs that APK instead'
    exit 0 ;;
esac

printf '\n  GymMane for Wear OS\n'
say 'Before you start, on the watch: Settings > System > About > Versions, tap Build number 7 times.'
say 'Then Settings > Developer options: turn on ADB debugging and Wireless debugging.'
say 'The watch and this computer must be on the same Wi-Fi.'

step 1 adb
if have adb; then
  ADB=$(command -v adb)
elif [ -x "$TOOLS/adb" ]; then
  ADB="$TOOLS/adb"
else
  have curl || have wget || fail 'This script needs curl or wget.'
  have unzip || fail 'This script needs unzip to set up adb. Install unzip, or install adb (android-tools) yourself.'
  case "$(uname -s)" in
    Darwin) os=darwin ;;
    *) os=linux ;;
  esac
  say 'adb (Android platform-tools) is not installed. Downloading it from Google...'
  tmpzip=$(mktemp)
  fetch "https://dl.google.com/android/repository/platform-tools-latest-$os.zip" "$tmpzip" ||
    fail 'Could not download platform-tools. Install adb (android-tools) and run this again.'
  mkdir -p "$(dirname "$TOOLS")"
  unzip -qo "$tmpzip" -d "$(dirname "$TOOLS")"
  rm -f "$tmpzip"
  ADB="$TOOLS/adb"
fi
ok "$ADB"

watches() {
  "$ADB" devices | sed 1d | while read -r serial state; do
    [ "$state" = device ] || continue
    if "$ADB" -s "$serial" shell pm list features 2>/dev/null | grep -q android.hardware.type.watch; then
      echo "$serial"
    fi
  done
}

step 2 'Connect to the watch'
WATCH=$(watches | head -n 1)
if [ -z "$WATCH" ]; then
  say 'On the watch, open Developer options > Wireless debugging.'
  ask 'IP address and port shown there (like 192.168.1.20:41235):'
  address=$REPLY
  [ -n "$address" ] || fail 'No address given.'
  out=$("$ADB" connect "$address" 2>&1 || true)
  case "$out" in
    *"connected to"*) ;;
    *)
      say 'The watch needs pairing first. On the watch, tap Pair new device.'
      ask 'Pairing address and port shown in that dialog:'
      pair=$REPLY
      ask 'Pairing code:'
      code=$REPLY
      p=$("$ADB" pair "$pair" "$code" 2>&1 || true)
      case "$p" in
        *"Successfully paired"*) ok Paired ;;
        *) fail "Pairing failed: $p" ;;
      esac
      "$ADB" connect "$address" >/dev/null 2>&1 || true ;;
  esac
  sleep 1
  WATCH=$(watches | head -n 1)
  [ -n "$WATCH" ] || fail 'The watch did not answer. Check that it is awake, on the same Wi-Fi, and that you allowed debugging on its screen.'
fi
model=$("$ADB" -s "$WATCH" shell getprop ro.product.model | tr -d '\r')
ok "$model ($WATCH)"

step 3 GymMane
TMPAPK=""
if [ -n "$APK" ]; then
  [ -f "$APK" ] || fail "$APK does not exist."
  FILE=$APK
else
  have curl || have wget || fail 'This script needs curl or wget.'
  abis=$("$ADB" -s "$WATCH" shell getprop ro.product.cpu.abilist | tr -d '\r')
  abi=""
  for a in $(echo "$abis" | tr ',' ' '); do
    case "$a" in arm64-v8a|armeabi-v7a|x86_64) abi=$a; break ;; esac
  done
  [ -n "$abi" ] || fail "This watch reports $abis, and there is no GymMane APK for it."
  TMPDIR_APK=$(mktemp -d)
  TMPAPK="$TMPDIR_APK/GymMane-$abi.apk"
  say "Downloading GymMane for $abi from the latest release..."
  fetch "https://github.com/$REPO/releases/latest/download/GymMane-$abi.apk" "$TMPAPK" ||
    { rm -rf "$TMPDIR_APK"; fail 'Could not download the APK. Check the connection and try again.'; }
  FILE=$TMPAPK
  ok "GymMane-$abi.apk"
fi
[ -n "$TMPAPK" ] || ok "$(basename "$FILE")"

step 4 Install
r=$("$ADB" -s "$WATCH" install -r "$FILE" 2>&1 || true)
[ -z "$TMPAPK" ] || rm -rf "$TMPDIR_APK"
case "$r" in
  *Success*) ok 'GymMane is on the watch' ;;
  *VERSION_DOWNGRADE*) fail 'The watch already has a newer GymMane than this one. Nothing to do.' ;;
  *UPDATE_INCOMPATIBLE*) fail 'The GymMane on the watch was signed by someone else. Uninstall it from the watch first, then run this again.' ;;
  *) fail "The watch refused the install: $r" ;;
esac

printf '\n'
say 'Open GymMane on the watch. To sync it with your phone, see WEAR.md.'
say 'You can turn Wireless debugging off now.'
printf '\n'
