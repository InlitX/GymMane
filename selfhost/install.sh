#!/bin/sh
set -eu

REPO="InlitX/GymMane"
RAW="https://raw.githubusercontent.com/$REPO/main"
IMAGE="ghcr.io/inlitx/gymmane"
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

UTF=0
case "${LC_ALL:-${LC_CTYPE:-${LANG:-}}}" in
  *UTF-8*|*utf-8*|*UTF8*|*utf8*) UTF=1 ;;
esac

COLOR=0
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ] && [ "${TERM:-}" != dumb ]; then COLOR=1; fi

if [ "$COLOR" = 1 ]; then
  esc=$(printf '\033')
  R="$esc[0m"; B="$esc[1m"
  case "${COLORTERM:-}" in
    truecolor|24bit)
      A="$esc[38;2;217;161;132m"; S2="$esc[38;2;185;143;114m"; G="$esc[38;2;143;181;140m"
      D="$esc[38;2;128;128;128m"; F="$esc[38;2;80;80;80m"; Y="$esc[38;2;230;190;110m"; E="$esc[38;2;230;120;110m"
      SH="$esc[38;2;96;78;66m"
      L1="$esc[38;2;242;200;174m"; L2="$esc[38;2;234;188;160m"; L3="$esc[38;2;225;175;146m"
      L4="$esc[38;2;212;164;135m"; L5="$esc[38;2;198;153;124m"; L6="$esc[38;2;185;143;114m" ;;
    *)
      A="$esc[38;5;180m"; S2="$esc[38;5;137m"; G="$esc[38;5;108m"
      D="$esc[38;5;244m"; F="$esc[38;5;239m"; Y="$esc[38;5;179m"; E="$esc[38;5;167m"
      SH="$esc[38;5;95m"
      L1="$esc[38;5;223m"; L2="$esc[38;5;216m"; L3="$esc[38;5;180m"
      L4="$esc[38;5;180m"; L5="$esc[38;5;173m"; L6="$esc[38;5;137m" ;;
  esac
  HIDE="$esc[?25l"; SHOW="$esc[?25h"; CLR="$(printf '\r')$esc[K"
else
  R=""; B=""; A=""; S2=""; G=""; D=""; F=""; Y=""; E=""; SH=""
  L1=""; L2=""; L3=""; L4=""; L5=""; L6=""; HIDE=""; SHOW=""; CLR=""
fi

if [ "$UTF" = 1 ]; then
  TICK="✓"; CROSS="✗"; DOT="·"; BUL="›"; WARN="!"
  TL="╭"; TR="╮"; BL="╰"; BR="╯"; HZ="─"; VT="│"
else
  TICK="+"; CROSS="x"; DOT="-"; BUL=">"; WARN="!"
  TL="+"; TR="+"; BL="+"; BR="+"; HZ="-"; VT="|"
fi

TTY=0
if [ "$YES" = 0 ] && (: </dev/tty) 2>/dev/null; then TTY=1; fi

STEP=0
STEPS=4
LOGF=$(mktemp 2>/dev/null || echo "/tmp/gymmane-install.$$")
TMPD=""
cleanup() {
  rc=$?
  printf '%s' "$SHOW"
  stty echo </dev/tty 2>/dev/null || true
  rm -f "$LOGF"
  [ -z "$TMPD" ] || rm -rf "$TMPD"
  exit "$rc"
}
trap cleanup EXIT
trap 'exit 130' INT TERM

say() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
step() {
  STEP=$((STEP + 1))
  printf '\n  %s%s%s%s%s/%s%s  %s%s%s\n\n' "$A" "$B" "$STEP" "$R" "$F" "$STEPS" "$R" "$B" "$*" "$R"
}
ok() { printf '     %s%s%s  %s\n' "$G" "$TICK" "$R" "$*"; }
note() { printf '     %s%s  %s%s\n' "$D" "$DOT" "$*" "$R"; }
warn() { printf '     %s%s%s  %s\n' "$Y" "$WARN" "$R" "$*"; }
die() {
  printf '%s' "$CLR"
  printf '\n     %s%s  %s%s\n\n' "$E" "$CROSS" "$*" "$R" >&2
  exit 1
}

rule() {
  n=$1; out=""
  while [ "$n" -gt 0 ]; do out="$out$HZ"; n=$((n - 1)); done
  printf '%s' "$out"
}

BOXW=52
box_top() { printf '  %s%s%s%s%s\n' "$F" "$TL" "$(rule $((BOXW + 2)))" "$TR" "$R"; }
box_bottom() { printf '  %s%s%s%s%s\n' "$F" "$BL" "$(rule $((BOXW + 2)))" "$BR" "$R"; }
box_row() {
  plain=$1; styled=${2:-$1}
  pad=$((BOXW - ${#plain}))
  [ "$pad" -ge 0 ] || pad=0
  sp=""
  while [ "$pad" -gt 0 ]; do sp="$sp "; pad=$((pad - 1)); done
  printf '  %s%s%s %s%s %s%s%s\n' "$F" "$VT" "$R" "$styled" "$sp" "$F" "$VT" "$R"
}
box_pair() {
  label=$1; value=$2
  box_row "$(printf '%-11s%s' "$label" "$value")" "$(printf '%s%-11s%s%s' "$D" "$label" "$R" "$value")"
}
box_fit() {
  for v in "$@"; do
    w=$((${#v} + 11))
    [ "$w" -le "$BOXW" ] || BOXW=$w
  done
}

frame() {
  if [ "$UTF" = 1 ]; then
    case $1 in
      0) f="⠋" ;; 1) f="⠙" ;; 2) f="⠹" ;; 3) f="⠸" ;; 4) f="⠼" ;;
      5) f="⠴" ;; 6) f="⠦" ;; 7) f="⠧" ;; 8) f="⠇" ;; *) f="⠏" ;;
    esac
  else
    case $(($1 % 4)) in 0) f="|" ;; 1) f="/" ;; 2) f="-" ;; *) f="\\" ;; esac
  fi
  printf '%s' "$f"
}

tick() { sleep 0.1 2>/dev/null || sleep 1; }

run() {
  msg=$1; shift
  : >"$LOGF"
  if [ "$COLOR" = 0 ]; then
    note "$msg"
    "$@" >"$LOGF" 2>&1
    return
  fi
  "$@" >"$LOGF" 2>&1 &
  pid=$!
  i=0
  printf '%s' "$HIDE"
  while kill -0 "$pid" 2>/dev/null; do
    printf '%s     %s%s%s  %s%s%s' "$CLR" "$A" "$(frame $((i % 10)))" "$R" "$D" "$msg" "$R"
    i=$((i + 1))
    tick
  done
  rc=0
  wait "$pid" || rc=$?
  printf '%s%s' "$CLR" "$SHOW"
  return "$rc"
}

show_log() {
  [ -s "$LOGF" ] || return 0
  tail -n 6 "$LOGF" | while IFS= read -r l; do printf '       %s%s%s\n' "$D" "$l" "$R"; done
}

ask() {
  if [ "$TTY" = 0 ]; then REPLY=$2; return 0; fi
  printf '  %s?%s  %s %s%s%s %s%s%s ' "$A" "$R" "$1" "$F" "$2" "$R" "$A" "$BUL" "$R"
  IFS= read -r REPLY </dev/tty || REPLY=""
  [ -n "$REPLY" ] || REPLY=$2
}

yes_no() {
  if [ "$TTY" = 0 ]; then [ "$2" = y ]; return; fi
  if [ "$2" = y ]; then hint="Y/n"; else hint="y/N"; fi
  while :; do
    printf '  %s?%s  %s %s%s%s %s%s%s ' "$A" "$R" "$1" "$F" "$hint" "$R" "$A" "$BUL" "$R"
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
  printf '  %s?%s  %s %s%s%s ' "$A" "$R" "$1" "$A" "$BUL" "$R"
  stty -echo </dev/tty 2>/dev/null || true
  IFS= read -r REPLY </dev/tty || REPLY=""
  stty echo </dev/tty 2>/dev/null || true
  printf '\n'
}

paint() {
  printf '%s' "$1" | sed -e "s/█/$2█/g" -e "s/╗/$SH╗/g" -e "s/╝/$SH╝/g" -e "s/║/$SH║/g" \
    -e "s/═/$SH═/g" -e "s/╔/$SH╔/g" -e "s/╚/$SH╚/g"
  printf '%s\n' "$R"
}

banner() {
  say ""
  if [ "$UTF" = 1 ]; then
    paint '   ██████╗ ██╗   ██╗███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗███████╗' "$L1"
    paint '  ██╔════╝ ╚██╗ ██╔╝████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔════╝' "$L2"
    paint '  ██║  ███╗ ╚████╔╝ ██╔████╔██║██╔████╔██║███████║██╔██╗ ██║█████╗  ' "$L3"
    paint '  ██║   ██║  ╚██╔╝  ██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══╝  ' "$L4"
    paint '  ╚██████╔╝   ██║   ██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║███████╗' "$L5"
    paint '   ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝' "$L6"
  else
    printf '%s' "$A"
    cat <<'ART'
     ____                 __  __
    / ___|_   _ _ __ ___ |  \/  | __ _ _ __   ___
   | |  _| | | | '_ ` _ \| |\/| |/ _` | '_ \ / _ \
   | |_| | |_| | | | | | | |  | | (_| | | | |  __/
    \____|\__, |_| |_| |_|_|  |_|\__,_|_| |_|\___|
          |___/
ART
    printf '%s' "$R"
  fi
  say ""
  say "  ${B}Self-host installer${R}  ${F}${DOT}${R}  ${D}your gym log, on your own machine${R}"
  say "  ${D}No account, no cloud. Your data stays in one folder here.${R}"
}

fetch() {
  if have curl; then curl -fsSL "$1" -o "$2"; else wget -q "$1" -O "$2"; fi
}

env_value() {
  [ -f "$HOME_DIR/.env" ] || return 0
  grep "^$1=" "$HOME_DIR/.env" | head -n1 | cut -d= -f2- || true
}

random_password() {
  LC_ALL=C tr -dc 'A-HJ-NP-Za-km-z2-9' </dev/urandom 2>/dev/null | head -c 16 || date +%s | sha256sum | head -c 16
}

valid_password() {
  case "$1" in
    *[!A-Za-z0-9._@%+=!?~^:,/-]*) return 1 ;;
  esac
  [ "${#1}" -ge 8 ]
}

lan_ips() {
  ips=""
  if [ "$OS" = linux ]; then
    ips=$(hostname -I 2>/dev/null || true)
    if [ -z "$ips" ] && have ip; then
      ips=$(ip -4 -o addr show scope global 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | tr '\n' ' ')
    fi
  elif [ "$OS" = macos ]; then
    for i in en0 en1; do ips="$ips $(ipconfig getifaddr "$i" 2>/dev/null || true)"; done
  fi
  out=""
  for ip in $ips; do
    case "$ip" in *:*|172.17.*|172.18.*|172.19.*) ;; *) out="$out $ip" ;; esac
  done
  printf '%s' "$out"
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

wait_loop() {
  n=0
  while [ "$n" -lt 30 ]; do
    rc=0
    healthy || rc=$?
    [ "$rc" = 0 ] && return 0
    [ "$rc" = 2 ] && return 0
    n=$((n + 1))
    sleep 1
  done
  return 1
}

wait_healthy() {
  if run "Waiting for GymMane to answer" wait_loop; then
    ok "GymMane answers on port $PORT"
    UP=1
  else
    warn "GymMane is not answering yet. See what it says with: $LOGS"
  fi
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
if [ "$OS" = linux ] && [ -r /etc/os-release ]; then
  distro=$(. /etc/os-release && printf '%s' "${PRETTY_NAME:-}")
  [ -z "$distro" ] || OS_NAME="$distro"
elif [ "$OS" = macos ] && have sw_vers; then
  OS_NAME="macOS $(sw_vers -productVersion 2>/dev/null || true)"
fi

if [ "$ROOT" = 1 ]; then SYSTEMCTL="systemctl"; JOURNAL="journalctl -u gymmane -f"
else SYSTEMCTL="systemctl --user"; JOURNAL="journalctl --user -u gymmane -f"; fi
SYSTEMD=0
if [ "$OS" = linux ] && have systemctl && [ -d /run/systemd/system ]; then
  if [ "$ROOT" = 1 ] || systemctl --user show-environment >/dev/null 2>&1; then SYSTEMD=1; fi
fi
if [ "$ROOT" = 1 ]; then PLIST=/Library/LaunchDaemons/com.gymmane.server.plist
else PLIST="$HOME/Library/LaunchAgents/com.gymmane.server.plist"; fi

banner

step "This machine"
ok "$OS_NAME ${D}($ARCH)${R}"
if [ "$ROOT" = 1 ]; then note "Running as root: GymMane goes to $HOME_DIR as a system service"
else note "Running as $(id -un), no root needed: GymMane goes to $HOME_DIR"; fi
DOCKER=0
if have docker; then
  if docker info >/dev/null 2>&1; then
    DOCKER=1
    ok "Docker $(docker version --format '{{.Server.Version}}' 2>/dev/null || true) is running"
  else note "Docker is here but this user cannot use it (sudo, or the docker group)"; fi
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
      printf '  %s?%s  What do you want to do? %s[U]pdate, [r]emove, [c]ancel%s %s%s%s ' "$A" "$R" "$F" "$R" "$A" "$BUL" "$R"
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
  STEPS=2
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

step "Settings"
if [ "$ACTION" = update ]; then ok "Keeping your port, password and data"
elif [ "$TTY" = 1 ]; then note "Press Enter to keep the value in grey."; say ""; fi
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
      secret "Password, or Enter to make one up"
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
  if yes_no "Also run Syncthing, to share data with the phone app?" n; then SYNC=1; else SYNC=0; fi
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
  HOW="systemd service"
  [ "$ROOT" = 1 ] || HOW="systemd service of $(id -un)"
  DATA_DIR="$HOME_DIR/data"
  LOGS="$JOURNAL"
elif [ "$OS" = macos ]; then
  HOW="starts when you log in"
  [ "$ROOT" = 1 ] && HOW="starts with the Mac"
  DATA_DIR="$HOME_DIR/data"
  LOGS="tail -f $HOME_DIR/gymmane.log"
else
  HOW="you start it yourself"
  DATA_DIR="$HOME_DIR/data"
  LOGS="the terminal where you started it"
fi

if [ -n "$PASS" ]; then PW_TEXT="yes"; else PW_TEXT="no, open to your network"; fi
box_fit "$HOME_DIR" "$HOW"
[ "$TTY" = 0 ] || say ""
box_top
if [ "$ACTION" = update ]; then box_row "Ready to update" "${B}Ready to update${R}"
else box_row "Ready to install" "${B}Ready to install${R}"; fi
box_row ""
box_pair "Folder" "$HOME_DIR"
box_pair "Runs with" "$HOW"
box_pair "Port" "$PORT"
box_pair "Password" "$PW_TEXT"
if [ "$MODE" = docker ]; then
  if [ "$SYNC" = 1 ]; then box_pair "Syncthing" "yes"; else box_pair "Syncthing" "no"; fi
fi
box_bottom
if [ "$TTY" = 1 ]; then
  say ""
  yes_no "Go ahead?" y || { say ""; exit 0; }
fi

mkdir -p "$HOME_DIR"
EXTRA=""
if [ -f "$HOME_DIR/.env" ]; then
  EXTRA=$(grep -E '^GYMMANE_' "$HOME_DIR/.env" | grep -vE '^GYMMANE_(PASSWORD|PORT|DATA|WEB|SYNCTHING)=' || true)
fi

if [ "$ROOT" = 1 ]; then OWNER="${SUDO_UID:-1000}"; GROUP="${SUDO_GID:-$OWNER}"
else OWNER=$(id -u); GROUP=$(id -g); fi

write_env() {
  {
    say "GYMMANE_PASSWORD=$PASS"
    say "GYMMANE_PORT=$PORT"
    if [ "$MODE" = binary ]; then
      say "GYMMANE_DATA=$DATA_DIR"
      say "GYMMANE_WEB=$HOME_DIR/web"
    else
      say "GYMMANE_SYNCTHING=$SYNC"
      say "PUID=$OWNER"
      say "PGID=$GROUP"
    fi
    if [ -n "$EXTRA" ]; then say "$EXTRA"; fi
  } >"$HOME_DIR/.env"
  chmod 600 "$HOME_DIR/.env"
}

docker_up() {
  if [ "$SYNC" = 1 ]; then compose --profile sync up -d; else compose up -d gymmane; fi
}

docker_pull() {
  if [ "$SYNC" = 1 ]; then compose --profile sync pull -q; else compose pull -q gymmane; fi
}

UP=0
if [ "$MODE" = docker ]; then
  step "Installing with Docker"
  if [ -n "${GYMMANE_COMPOSE:-}" ]; then cp "$GYMMANE_COMPOSE" "$HOME_DIR/compose.yaml"
  else fetch "$RAW/compose.yaml" "$HOME_DIR/compose.yaml" || die "Could not download compose.yaml. Check the internet connection and try again."; fi
  ok "Got compose.yaml"
  write_env
  ok "Saved the settings in $HOME_DIR/.env"
  mkdir -p "$DATA_DIR/sync"
  [ "$SYNC" = 1 ] && mkdir -p "$HOME_DIR/syncthing"
  if [ "$ROOT" = 1 ]; then
    chown -R "$OWNER:$GROUP" "$DATA_DIR"
    [ "$SYNC" = 1 ] && chown -R "$OWNER:$GROUP" "$HOME_DIR/syncthing"
  fi
  cd "$HOME_DIR"
  if run "Downloading the image, this can take a minute" docker_pull; then
    ok "Downloaded the latest image"
  elif docker image inspect "$IMAGE:latest" >/dev/null 2>&1; then
    warn "Could not download a newer image, using the one already here"
  else
    show_log
    die "Could not download the GymMane image. Check the internet connection and try again."
  fi
  run "Starting the container" docker_up || { show_log; die "Docker could not start GymMane."; }
  ok "Started the container, Docker brings it back after a reboot"
  [ "$SYNC" = 1 ] && ok "Started Syncthing"
else
  step "Installing the standalone server"
  asset="gymmane-selfhost-$OS-$ARCH.tar.gz"
  TMPD=$(mktemp -d)
  if [ -n "${GYMMANE_ARCHIVE:-}" ]; then
    [ -f "$GYMMANE_ARCHIVE" ] || die "$GYMMANE_ARCHIVE does not exist."
    tar -xzf "$GYMMANE_ARCHIVE" -C "$TMPD"
    ok "Unpacked $(basename "$GYMMANE_ARCHIVE")"
  else
    run "Downloading $asset" fetch "https://github.com/$REPO/releases/latest/download/$asset" "$TMPD/$asset" \
      || die "Could not download $asset from the latest release."
    tar -xzf "$TMPD/$asset" -C "$TMPD"
    ok "Downloaded $asset"
  fi
  if [ "$SYSTEMD" = 1 ]; then $SYSTEMCTL stop gymmane.service >/dev/null 2>&1 || true; fi
  if [ "$OS" = macos ] && [ -f "$PLIST" ]; then launchctl unload "$PLIST" >/dev/null 2>&1 || true; fi
  rm -rf "$HOME_DIR/web"
  cp -R "$TMPD/gymmane/." "$HOME_DIR/"
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

IPS=$(lan_ips)
LINKS="http://localhost:$PORT"
for ip in $IPS; do LINKS="$LINKS http://$ip:$PORT"; done
BOXW=52
for l in $LINKS; do box_fit "$l"; done
if [ "$GENERATED" = 1 ]; then box_fit "$PASS  (any user name works)"; fi

say ""
box_top
if [ "$UP" = 1 ] || [ "$MODE" = docker ] || [ "$SYSTEMD" = 1 ] || [ "$OS" = macos ]; then
  box_row "+ GymMane is running" "${G}${TICK}${R} ${B}GymMane is running${R}"
  box_row ""
  box_row "Open it from any device on your network:" "${D}Open it from any device on your network:${R}"
else
  box_row "GymMane is installed" "${B}GymMane is installed${R}"
  box_row ""
  box_row "Once it runs, open it from any device on your network:" "${D}Once it runs, open it from any device on your network:${R}"
fi
for l in $LINKS; do box_row "  $l" "  ${A}${B}$l${R}"; done
if [ -n "$PASS" ]; then
  box_row ""
  if [ "$GENERATED" = 1 ]; then
    box_pair "Password" "$PASS"
    box_row "           made up for you, any user name works" "           ${D}made up for you, any user name works${R}"
  else
    box_pair "Password" "the one you chose"
  fi
fi
box_bottom

if [ "$MODE" = binary ] && [ "$SYSTEMD" = 0 ] && [ "$OS" != macos ]; then
  say ""
  say "  Start it with:"
  say "    ${B}set -a; . $HOME_DIR/.env; set +a; $HOME_DIR/gymmane-server${R}"
fi
if [ "$SYNC" = 1 ]; then
  say ""
  say "  ${B}Phone sync${R}  ${D}open Syncthing at${R} http://<this-machine>:8384${D}, add the folder${R}"
  say "              /var/syncthing/GymMane ${D}and share it with your phone. Then, in the${R}"
  say "              ${D}phone app, choose it in Settings › Data & backup › Auto backup.${R}"
fi
say ""
say "  ${D}Data      ${R}$DATA_DIR"
say "  ${D}Settings  ${R}$HOME_DIR/.env"
say "  ${D}Logs      ${R}$LOGS"
say "  ${D}Update    ${R}run this command again"
say ""
