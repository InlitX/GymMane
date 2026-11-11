#!/bin/sh
set -eu

REPO="InlitX/GymMane"
RAW="https://raw.githubusercontent.com/$REPO/main"
MODE=""
SYNC=""
ACTION=""
YES=0

for arg in "$@"; do
  case "$arg" in
    --docker) MODE=docker ;;
    --binary) MODE=binary ;;
    --sync) SYNC=1 ;;
    --no-sync) SYNC=0 ;;
    --uninstall) ACTION=uninstall ;;
    -y|--yes) YES=1 ;;
    -h|--help)
      echo "GymMane installer"
      echo ""
      echo "  sh install.sh              guided install or update"
      echo "  sh install.sh --yes        no questions, use the defaults"
      echo "  sh install.sh --docker     use Docker"
      echo "  sh install.sh --binary     use the standalone server, no Docker"
      echo "  sh install.sh --sync       also run Syncthing to share data with the phone app (Docker)"
      echo "  sh install.sh --uninstall  remove GymMane (your data is kept)"
      echo ""
      echo "Environment: GYMMANE_PORT, GYMMANE_PASSWORD (empty = no password), GYMMANE_HOME,"
      echo "             GYMMANE_ARCHIVE (a release .tar.gz already downloaded, for --binary)"
      exit 0 ;;
    *) echo "Unknown option: $arg (try --help)"; exit 1 ;;
  esac
done

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  esc=$(printf '\033')
  B="$esc[1m"; D="$esc[2m"; R="$esc[0m"
  A="$esc[38;5;180m"; G="$esc[32m"; Y="$esc[33m"; E="$esc[31m"
else
  B=""; D=""; R=""; A=""; G=""; Y=""; E=""
fi
case "${LC_ALL:-${LC_CTYPE:-${LANG:-}}}" in
  *UTF-8*|*utf-8*|*UTF8*|*utf8*) TICK="✓"; CROSS="✗"; ARROW="›"; DOT="•" ;;
  *) TICK="+"; CROSS="x"; ARROW=">"; DOT="-" ;;
esac

TTY=0
if [ "$YES" = 0 ] && (: </dev/tty) 2>/dev/null; then TTY=1; fi

say() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
step() { printf '\n  %s%s%s %s%s%s\n' "$A" "$ARROW" "$R" "$B" "$*" "$R"; }
ok() { printf '    %s%s%s %s\n' "$G" "$TICK" "$R" "$*"; }
note() { printf '    %s%s %s%s\n' "$D" "$DOT" "$*" "$R"; }
warn() { printf '    %s!%s %s\n' "$Y" "$R" "$*"; }
die() { printf '\n  %s%s %s%s\n\n' "$E" "$CROSS" "$*" "$R" >&2; exit 1; }

ask() {
  if [ "$TTY" = 0 ]; then REPLY=$2; return 0; fi
  printf '  %s?%s %s %s(%s)%s ' "$A" "$R" "$1" "$D" "$2" "$R"
  IFS= read -r REPLY </dev/tty || REPLY=""
  [ -n "$REPLY" ] || REPLY=$2
}

yes_no() {
  if [ "$TTY" = 0 ]; then [ "$2" = y ]; return; fi
  if [ "$2" = y ]; then hint="Y/n"; else hint="y/N"; fi
  while :; do
    printf '  %s?%s %s %s[%s]%s ' "$A" "$R" "$1" "$D" "$hint" "$R"
    IFS= read -r answer </dev/tty || answer=""
    [ -n "$answer" ] || answer=$2
    case "$answer" in
      y|Y|yes|Yes|YES|s|S|si|Si) return 0 ;;
      n|N|no|No|NO) return 1 ;;
      *) note "Type y or n." ;;
    esac
  done
}

secret() {
  printf '  %s?%s %s ' "$A" "$R" "$1"
  stty -echo </dev/tty 2>/dev/null || true
  IFS= read -r REPLY </dev/tty || REPLY=""
  stty echo </dev/tty 2>/dev/null || true
  printf '\n'
}

trap 'stty echo </dev/tty 2>/dev/null || true' INT TERM

banner() {
  printf '\n%s%s' "$A" "$B"
  cat <<'ART'
     ____                 __  __
    / ___|_   _ _ __ ___ |  \/  | __ _ _ __   ___
   | |  _| | | | '_ ` _ \| |\/| |/ _` | '_ \ / _ \
   | |_| | |_| | | | | | | |  | | (_| | | | |  __/
    \____|\__, |_| |_| |_|_|  |_|\__,_|_| |_|\___|
          |___/
ART
  printf '%s' "$R"
  say "    ${B}Self-host installer${R}"
  say "    ${D}The whole app in your browser. Your data stays on this machine.${R}"
}

fetch() {
  if have curl; then curl -fsSL "$1" -o "$2"; else wget -q "$1" -O "$2"; fi
}

env_value() {
  [ -f "$HOME_DIR/.env" ] || return 0
  grep "^$1=" "$HOME_DIR/.env" | head -n1 | cut -d= -f2- || true
}

random_password() {
  LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom 2>/dev/null | head -c 16 || date +%s | sha256sum | head -c 16
}

valid_password() {
  case "$1" in
    *[!A-Za-z0-9._@%+=!?~^:,/-]*) return 1 ;;
  esac
  [ "${#1}" -ge 8 ]
}

addresses() {
  printf '      %s%shttp://localhost:%s%s\n' "$A" "$B" "$PORT" "$R"
  ips=""
  if [ "$OS" = linux ]; then
    ips=$(hostname -I 2>/dev/null || true)
    if [ -z "$ips" ] && have ip; then
      ips=$(ip -4 -o addr show scope global 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | tr '\n' ' ')
    fi
  elif [ "$OS" = macos ]; then
    for i in en0 en1; do ips="$ips $(ipconfig getifaddr "$i" 2>/dev/null || true)"; done
  fi
  for ip in $ips; do
    case "$ip" in *:*) ;; *) printf '      %s%shttp://%s:%s%s\n' "$A" "$B" "$ip" "$PORT" "$R" ;; esac
  done
}

firewall() {
  [ "$ROOT" = 1 ] || return 0
  if have ufw && ufw status 2>/dev/null | grep -q 'Status: active'; then FIREWALL=ufw
  elif have firewall-cmd && firewall-cmd --state >/dev/null 2>&1; then FIREWALL=firewalld; fi
}

open_ports() {
  ports="$PORT/tcp"
  [ "$SYNC" = 1 ] && ports="$ports 8384/tcp 22000/tcp 22000/udp 21027/udp"
  for p in $ports; do
    if [ "$FIREWALL" = ufw ]; then ufw allow "$p" >/dev/null 2>&1 || true
    else firewall-cmd --permanent --add-port="$p" >/dev/null 2>&1 || true; fi
  done
  if [ "$FIREWALL" = firewalld ]; then firewall-cmd --reload >/dev/null 2>&1 || true; fi
  ok "Opened $(echo "$ports" | sed 's/ /, /g') in $FIREWALL"
}

compose() {
  if docker compose version >/dev/null 2>&1; then docker compose "$@"; else docker-compose "$@"; fi
}

healthy() {
  url="http://127.0.0.1:$PORT/api/health"
  if have curl; then
    if [ -n "$PASS" ]; then curl -fs -m 3 -u "gymmane:$PASS" "$url" >/dev/null 2>&1
    else curl -fs -m 3 "$url" >/dev/null 2>&1; fi
  elif have wget; then
    if [ -n "$PASS" ]; then wget -q -T 3 --user=gymmane --password="$PASS" -O /dev/null "$url" 2>/dev/null
    else wget -q -T 3 -O /dev/null "$url" 2>/dev/null; fi
  else
    return 2
  fi
}

wait_healthy() {
  i=0
  while [ "$i" -lt 30 ]; do
    rc=0
    healthy || rc=$?
    if [ "$rc" = 0 ]; then ok "GymMane answers on port $PORT"; return 0; fi
    if [ "$rc" = 2 ]; then return 0; fi
    i=$((i + 1))
    sleep 1
  done
  warn "GymMane is not answering yet. See what it says with: $LOGS"
}

if [ "$(id -u)" = 0 ]; then ROOT=1; HOME_DIR="${GYMMANE_HOME:-/opt/gymmane}"
else ROOT=0; HOME_DIR="${GYMMANE_HOME:-$HOME/gymmane}"; fi

case "$(uname -s)" in
  Linux) OS=linux; OS_NAME="Linux" ;;
  Darwin) OS=macos; OS_NAME="macOS" ;;
  *) OS=other; OS_NAME="$(uname -s)" ;;
esac
case "$(uname -m)" in
  x86_64|amd64) ARCH=x64 ;;
  aarch64|arm64) ARCH=arm64 ;;
  *) ARCH="$(uname -m)" ;;
esac

if [ "$ROOT" = 1 ]; then SYSTEMCTL="systemctl"; JOURNAL="journalctl -u gymmane -f"
else SYSTEMCTL="systemctl --user"; JOURNAL="journalctl --user -u gymmane -f"; fi
SYSTEMD=0
if [ "$OS" = linux ] && have systemctl && [ -d /run/systemd/system ]; then
  if [ "$ROOT" = 1 ] || systemctl --user show-environment >/dev/null 2>&1; then SYSTEMD=1; fi
fi
if [ "$ROOT" = 1 ]; then PLIST=/Library/LaunchDaemons/com.gymmane.server.plist
else PLIST="$HOME/Library/LaunchAgents/com.gymmane.server.plist"; fi

banner

step "Checking this machine"
ok "$OS_NAME, $ARCH"
DOCKER=0
if have docker; then
  if docker info >/dev/null 2>&1; then DOCKER=1; ok "Docker is running"
  else note "Docker is installed but not usable by this user (try sudo, or join the docker group)"; fi
else
  note "No Docker here, the standalone server will be used"
fi
if ! have curl && ! have wget; then die "This script needs curl or wget."; fi

INSTALLED=0
if [ -f "$HOME_DIR/compose.yaml" ] || [ -f "$HOME_DIR/gymmane-server" ]; then
  INSTALLED=1
  ok "GymMane is already installed in $HOME_DIR"
fi

if [ "$INSTALLED" = 1 ] && [ -z "$ACTION" ]; then
  if [ "$TTY" = 1 ]; then
    say ""
    while [ -z "$ACTION" ]; do
      printf '  %s?%s What do you want to do? %s[U]pdate, [r]emove, [c]ancel%s ' "$A" "$R" "$D" "$R"
      IFS= read -r answer </dev/tty || answer=""
      case "$answer" in
        ""|u|U|update) ACTION=update ;;
        r|R|remove) ACTION=uninstall ;;
        c|C|cancel) say ""; exit 0 ;;
        *) note "Type u, r or c." ;;
      esac
    done
  else
    ACTION=update
  fi
fi

if [ "$ACTION" = uninstall ]; then
  say ""
  if [ "$TTY" = 1 ]; then yes_no "Remove GymMane? Your data stays in $HOME_DIR" n || { say ""; exit 0; }; fi
  step "Removing GymMane"
  if [ -f "$HOME_DIR/compose.yaml" ] && [ "$DOCKER" = 1 ]; then
    (cd "$HOME_DIR" && compose --profile sync down >/dev/null 2>&1) || true
    ok "Stopped the containers"
  fi
  if [ "$SYSTEMD" = 1 ]; then
    $SYSTEMCTL disable --now gymmane.service >/dev/null 2>&1 || true
    if [ "$ROOT" = 1 ]; then rm -f /etc/systemd/system/gymmane.service
    else rm -f "$HOME/.config/systemd/user/gymmane.service"; fi
    $SYSTEMCTL daemon-reload >/dev/null 2>&1 || true
    ok "Removed the service"
  fi
  if [ "$OS" = macos ] && [ -f "$PLIST" ]; then
    launchctl unload "$PLIST" >/dev/null 2>&1 || true
    rm -f "$PLIST"
    ok "Removed the login item"
  fi
  rm -rf "$HOME_DIR/web" "$HOME_DIR/gymmane-server" "$HOME_DIR/compose.yaml"
  ok "Removed the program files"
  say ""
  say "  Your data is still in ${B}$HOME_DIR${R}. Delete that folder yourself if you want it gone."
  say ""
  exit 0
fi

if [ "$ACTION" = update ]; then
  if [ -z "$MODE" ]; then
    if [ -f "$HOME_DIR/compose.yaml" ]; then MODE=docker; else MODE=binary; fi
  fi
  [ -n "$SYNC" ] || SYNC=$(env_value GYMMANE_SYNCTHING)
  [ -n "$SYNC" ] || SYNC=0
fi

say ""
if [ -z "$MODE" ]; then
  if [ "$DOCKER" = 1 ] && yes_no "Docker is available. Run GymMane in Docker?" y; then MODE=docker; else MODE=binary; fi
fi
if [ "$MODE" = docker ] && [ "$DOCKER" = 0 ]; then die "Docker is not running or not usable by this user."; fi
if [ "$MODE" = binary ]; then
  [ "$OS" != other ] || die "$OS_NAME is not supported by this script. Use Docker or the Windows installer."
  [ "$ARCH" = x64 ] || [ "$ARCH" = arm64 ] || die "There is no build for $ARCH yet. Use Docker, or a 64-bit system."
  if [ "$OS" = macos ] && [ "$ARCH" = x64 ]; then die "There is no build for Intel Macs yet. Use Docker instead."; fi
fi

OLD_PORT=$(env_value GYMMANE_PORT)
PORT="${GYMMANE_PORT:-${OLD_PORT:-8080}}"
if [ "$ACTION" != update ] && [ -z "${GYMMANE_PORT:-}" ]; then
  while :; do
    ask "Port to open GymMane on" "$PORT"
    case "$REPLY" in
      ''|*[!0-9]*) note "Type a number between 1 and 65535." ;;
      *) if [ "$REPLY" -ge 1 ] && [ "$REPLY" -le 65535 ]; then PORT=$REPLY; break; fi
         note "Type a number between 1 and 65535." ;;
    esac
  done
fi

GENERATED=0
if [ "${GYMMANE_PASSWORD+set}" = set ]; then
  PASS="$GYMMANE_PASSWORD"
  [ -z "$PASS" ] || valid_password "$PASS" || die "GYMMANE_PASSWORD needs 8 or more characters: letters, digits and . _ @ % + = ! ? ~ ^ : , / -"
elif [ "$ACTION" = update ]; then
  PASS=$(env_value GYMMANE_PASSWORD)
elif yes_no "Ask for a password in the browser?" y; then
  PASS=""
  if [ "$TTY" = 1 ]; then
    while :; do
      secret "Password (press Enter to make one up for you)"
      [ -n "$REPLY" ] || break
      if valid_password "$REPLY"; then PASS=$REPLY; break; fi
      note "8 or more characters: letters, digits and . _ @ % + = ! ? ~ ^ : , / -"
    done
  fi
  if [ -z "$PASS" ]; then PASS=$(random_password); GENERATED=1; fi
else
  PASS=""
fi

if [ "$MODE" = docker ] && [ -z "$SYNC" ]; then
  if yes_no "Also run Syncthing, to share data with the GymMane phone app?" n; then SYNC=1; else SYNC=0; fi
fi
[ -n "$SYNC" ] || SYNC=0
if [ "$MODE" = binary ] && [ "$SYNC" = 1 ]; then
  warn "Syncthing is only set up for you with Docker. Without it, install Syncthing yourself (see the guide)."
  SYNC=0
fi

FIREWALL=""
OPEN=0
firewall
if [ -n "$FIREWALL" ] && yes_no "Open port $PORT in the firewall ($FIREWALL) so other devices can reach it?" y; then OPEN=1; fi

if [ "$MODE" = docker ]; then
  HOW="Docker"
  DATA_DIR="$HOME_DIR/gymmane-data"
  LOGS="docker logs -f gymmane"
elif [ "$SYSTEMD" = 1 ]; then
  HOW="standalone server, systemd service"
  DATA_DIR="$HOME_DIR/data"
  LOGS="$JOURNAL"
elif [ "$OS" = macos ]; then
  HOW="standalone server, starts at login"
  [ "$ROOT" = 1 ] && HOW="standalone server, starts with the Mac"
  DATA_DIR="$HOME_DIR/data"
  LOGS="tail -f $HOME_DIR/gymmane.log"
else
  HOW="standalone server, you start it yourself"
  DATA_DIR="$HOME_DIR/data"
  LOGS="the terminal where you started it"
fi

say ""
if [ "$ACTION" = update ]; then say "  ${B}Ready to update${R}"; else say "  ${B}Ready to install${R}"; fi
say "    Folder     $HOME_DIR"
say "    Runs with  $HOW"
say "    Port       $PORT"
if [ -n "$PASS" ]; then say "    Password   yes"; else say "    Password   no"; fi
if [ "$MODE" = docker ]; then
  if [ "$SYNC" = 1 ]; then say "    Syncthing  yes"; else say "    Syncthing  no"; fi
fi
say ""
yes_no "Go ahead?" y || { say ""; exit 0; }

mkdir -p "$HOME_DIR"
EXTRA=""
if [ -f "$HOME_DIR/.env" ]; then
  EXTRA=$(grep -E '^GYMMANE_' "$HOME_DIR/.env" | grep -vE '^GYMMANE_(PASSWORD|PORT|DATA|WEB|SYNCTHING)=' || true)
fi

write_env() {
  {
    say "GYMMANE_PASSWORD=$PASS"
    say "GYMMANE_PORT=$PORT"
    if [ "$MODE" = binary ]; then
      say "GYMMANE_DATA=$DATA_DIR"
      say "GYMMANE_WEB=$HOME_DIR/web"
    else
      say "GYMMANE_SYNCTHING=$SYNC"
    fi
    if [ -n "$EXTRA" ]; then say "$EXTRA"; fi
  } >"$HOME_DIR/.env"
  chmod 600 "$HOME_DIR/.env"
}

if [ "$MODE" = docker ]; then
  step "Installing with Docker"
  fetch "$RAW/compose.yaml" "$HOME_DIR/compose.yaml"
  ok "Downloaded compose.yaml"
  write_env
  ok "Saved the settings in $HOME_DIR/.env"
  cd "$HOME_DIR"
  note "Downloading the image, this can take a minute"
  if [ "$SYNC" = 1 ]; then
    compose --profile sync pull -q || die "Could not download the images. Check the internet connection and try again."
    compose --profile sync up -d >/dev/null 2>&1 || compose --profile sync up -d
  else
    compose pull -q gymmane || die "Could not download the GymMane image. Check the internet connection and try again."
    compose up -d gymmane >/dev/null 2>&1 || compose up -d gymmane
  fi
  ok "Started the container"
  [ "$SYNC" = 1 ] && ok "Started Syncthing"
else
  step "Installing the standalone server"
  asset="gymmane-selfhost-$OS-$ARCH.tar.gz"
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"; stty echo </dev/tty 2>/dev/null || true' EXIT
  if [ -n "${GYMMANE_ARCHIVE:-}" ]; then
    [ -f "$GYMMANE_ARCHIVE" ] || die "$GYMMANE_ARCHIVE does not exist."
    tar -xzf "$GYMMANE_ARCHIVE" -C "$tmp"
    ok "Unpacked $GYMMANE_ARCHIVE"
  else
    fetch "https://github.com/$REPO/releases/latest/download/$asset" "$tmp/$asset" || die "Could not download $asset from the latest release."
    tar -xzf "$tmp/$asset" -C "$tmp"
    ok "Downloaded $asset"
  fi
  if [ "$SYSTEMD" = 1 ]; then $SYSTEMCTL stop gymmane.service >/dev/null 2>&1 || true; fi
  if [ "$OS" = macos ] && [ -f "$PLIST" ]; then launchctl unload "$PLIST" >/dev/null 2>&1 || true; fi
  rm -rf "$HOME_DIR/web"
  cp -R "$tmp/gymmane/." "$HOME_DIR/"
  chmod +x "$HOME_DIR/gymmane-server"
  mkdir -p "$DATA_DIR"
  [ "$OS" = macos ] && { xattr -d com.apple.quarantine "$HOME_DIR/gymmane-server" 2>/dev/null || true; }
  ok "Copied it to $HOME_DIR"
  write_env
  ok "Saved the settings in $HOME_DIR/.env"

  if [ "$SYSTEMD" = 1 ]; then
    if [ "$ROOT" = 1 ]; then unit=/etc/systemd/system/gymmane.service; target=multi-user.target
    else unit="$HOME/.config/systemd/user/gymmane.service"; target=default.target; mkdir -p "$(dirname "$unit")"; fi
    cat >"$unit" <<UNIT
[Unit]
Description=GymMane
After=network-online.target
Wants=network-online.target

[Service]
EnvironmentFile=$HOME_DIR/.env
ExecStart=$HOME_DIR/gymmane-server
Restart=on-failure
RestartSec=3

[Install]
WantedBy=$target
UNIT
    $SYSTEMCTL daemon-reload
    $SYSTEMCTL enable --now gymmane.service >/dev/null 2>&1 || die "The service did not start. See why with: $JOURNAL"
    if [ "$ROOT" = 0 ] && have loginctl; then loginctl enable-linger "$(id -un)" >/dev/null 2>&1 || true; fi
    ok "Started the gymmane service, it comes back after a reboot"
  elif [ "$OS" = macos ]; then
    mkdir -p "$(dirname "$PLIST")"
    cat >"$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>com.gymmane.server</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>-c</string>
    <string>set -a; . "$HOME_DIR/.env"; set +a; exec "$HOME_DIR/gymmane-server"</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>StandardOutPath</key><string>$HOME_DIR/gymmane.log</string>
  <key>StandardErrorPath</key><string>$HOME_DIR/gymmane.log</string>
</dict>
</plist>
PLIST
    launchctl load -w "$PLIST" || die "macOS did not start GymMane. See $HOME_DIR/gymmane.log"
    ok "Started GymMane, it starts again on its own"
  fi
fi

[ "$OPEN" = 1 ] && open_ports

if [ "$MODE" = docker ] || [ "$SYSTEMD" = 1 ] || [ "$OS" = macos ]; then
  wait_healthy
fi

say ""
say "  ${G}${B}GymMane is ready.${R} Open it from any device on your network:"
addresses
if [ -n "$PASS" ]; then
  say ""
  if [ "$GENERATED" = 1 ]; then say "  Password  ${B}$PASS${R}   ${D}(made up for you, any user name works)${R}"
  else say "  Password  the one you chose   ${D}(any user name works)${R}"; fi
fi
if [ "$MODE" = binary ] && [ "$SYSTEMD" = 0 ] && [ "$OS" != macos ]; then
  say ""
  say "  Start it with:"
  say "    ${B}set -a; . $HOME_DIR/.env; set +a; $HOME_DIR/gymmane-server${R}"
fi
if [ "$SYNC" = 1 ]; then
  say ""
  say "  ${B}Phone sync${R}: open Syncthing at http://<this-machine>:8384, add the folder"
  say "  ${B}/var/syncthing/GymMane${R} and share it with your phone. Then, in the phone app,"
  say "  choose that folder in Settings › Data & backup › Auto backup."
fi
say ""
say "  ${D}Data      $DATA_DIR${R}"
say "  ${D}Settings  $HOME_DIR/.env${R}"
say "  ${D}Logs      $LOGS${R}"
say "  ${D}Update    run this command again${R}"
say ""
