#!/bin/sh
set -eu

REPO="InlitX/GymMane"
RAW="https://raw.githubusercontent.com/$REPO/main"
PORT="${GYMMANE_PORT:-8080}"
MODE=""
SYNC=0
UNINSTALL=0

for arg in "$@"; do
  case "$arg" in
    --docker) MODE=docker ;;
    --binary) MODE=binary ;;
    --sync) SYNC=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)
      echo "GymMane installer"
      echo "  sh install.sh             install or update (Docker if it is there, otherwise the binary)"
      echo "  sh install.sh --sync      also run Syncthing to share data with the phone app"
      echo "  sh install.sh --docker    force Docker"
      echo "  sh install.sh --binary    force the standalone binary"
      echo "  sh install.sh --uninstall remove GymMane (your data folder is kept)"
      echo "Environment: GYMMANE_PORT (8080), GYMMANE_PASSWORD (empty = no password), GYMMANE_HOME"
      exit 0 ;;
  esac
done

say() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

if [ "$(id -u)" = 0 ]; then
  ROOT=1
  HOME_DIR="${GYMMANE_HOME:-/opt/gymmane}"
else
  ROOT=0
  HOME_DIR="${GYMMANE_HOME:-$HOME/gymmane}"
fi

fetch() {
  if have curl; then curl -fsSL "$1" -o "$2"; else wget -q "$1" -O "$2"; fi
}

password() {
  if [ "${GYMMANE_PASSWORD+set}" = set ]; then
    printf '%s' "$GYMMANE_PASSWORD"
  elif [ -f "$HOME_DIR/.env" ] && grep -q '^GYMMANE_PASSWORD=' "$HOME_DIR/.env"; then
    grep '^GYMMANE_PASSWORD=' "$HOME_DIR/.env" | head -n1 | cut -d= -f2-
  else
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom 2>/dev/null | head -c 16 || date +%s | sha256sum | head -c 16
  fi
}

addresses() {
  ips=""
  if have hostname; then ips=$(hostname -I 2>/dev/null || true); fi
  if [ -z "$ips" ] && have ip; then
    ips=$(ip -4 -o addr show scope global 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | tr '\n' ' ')
  fi
  say "  http://localhost:$PORT"
  for ip in $ips; do
    case "$ip" in *:*) ;; *) say "  http://$ip:$PORT" ;; esac
  done
}

open_port() {
  [ "$ROOT" = 1 ] || return 0
  if have ufw && ufw status 2>/dev/null | grep -q 'Status: active'; then
    ufw allow "$PORT"/tcp >/dev/null 2>&1 || true
    [ "$SYNC" = 1 ] && { ufw allow 22000 >/dev/null 2>&1 || true; ufw allow 21027/udp >/dev/null 2>&1 || true; }
  fi
  if have firewall-cmd && firewall-cmd --state >/dev/null 2>&1; then
    firewall-cmd --permanent --add-port="$PORT"/tcp >/dev/null 2>&1 || true
    firewall-cmd --reload >/dev/null 2>&1 || true
  fi
}

finish() {
  pass="$1"
  say ""
  say "GymMane is running. Open it at:"
  addresses
  if [ -n "$pass" ]; then
    say ""
    say "Password: $pass   (any user name works)"
    say "Change it in $HOME_DIR/.env and run this script again."
  fi
  if [ "$SYNC" = 1 ]; then
    say ""
    say "Syncthing is at http://<this-machine>:8384 . Share the GymMane folder with the phone,"
    say "then in the app pick it in Settings > Data & backup > Auto backup."
  fi
  say ""
  say "Your data lives in $DATA_DIR. Run this script again any time to update."
}

compose() {
  if docker compose version >/dev/null 2>&1; then docker compose "$@"; else docker-compose "$@"; fi
}

if [ "$UNINSTALL" = 1 ]; then
  if [ -f "$HOME_DIR/compose.yaml" ] && have docker; then
    (cd "$HOME_DIR" && compose --profile sync down) || true
  fi
  if have systemctl; then
    if [ "$ROOT" = 1 ]; then
      systemctl disable --now gymmane.service >/dev/null 2>&1 || true
      rm -f /etc/systemd/system/gymmane.service
      systemctl daemon-reload || true
    else
      systemctl --user disable --now gymmane.service >/dev/null 2>&1 || true
      rm -f "$HOME/.config/systemd/user/gymmane.service"
      systemctl --user daemon-reload || true
    fi
  fi
  rm -rf "$HOME_DIR/web" "$HOME_DIR/gymmane-server" "$HOME_DIR/compose.yaml"
  say "GymMane removed. Your data is still in $HOME_DIR (delete it yourself if you want it gone)."
  exit 0
fi

if [ -z "$MODE" ]; then
  if have docker && docker info >/dev/null 2>&1; then MODE=docker; else MODE=binary; fi
fi

mkdir -p "$HOME_DIR"
PASS=$(password)
EXTRA=""
if [ -f "$HOME_DIR/.env" ]; then
  EXTRA=$(grep -E '^GYMMANE_' "$HOME_DIR/.env" | grep -vE '^GYMMANE_(PASSWORD|PORT|DATA|WEB)=' || true)
fi

if [ "$MODE" = docker ]; then
  DATA_DIR="$HOME_DIR/gymmane-data"
  say "Installing GymMane with Docker in $HOME_DIR"
  fetch "$RAW/compose.yaml" "$HOME_DIR/compose.yaml"
  {
    say "GYMMANE_PASSWORD=$PASS"
    say "GYMMANE_PORT=$PORT"
    if [ -n "$EXTRA" ]; then say "$EXTRA"; fi
  } >"$HOME_DIR/.env"
  chmod 600 "$HOME_DIR/.env"
  cd "$HOME_DIR"
  if [ "$SYNC" = 1 ]; then
    compose --profile sync pull
    compose --profile sync up -d
  else
    compose pull gymmane
    compose up -d gymmane
  fi
  open_port
  finish "$PASS"
  exit 0
fi

os=$(uname -s)
arch=$(uname -m)
case "$os" in
  Linux) os=linux ;;
  Darwin) os=macos ;;
  *) say "Sorry, $os is not supported by this script. Use Docker or the Windows installer."; exit 1 ;;
esac
case "$arch" in
  x86_64|amd64) arch=x64 ;;
  aarch64|arm64) arch=arm64 ;;
  *) say "Sorry, $arch is not supported yet. Use Docker instead."; exit 1 ;;
esac
if [ "$os" = macos ] && [ "$arch" = x64 ]; then
  say "Intel Macs are not built yet. Use Docker instead."
  exit 1
fi

DATA_DIR="$HOME_DIR/data"
asset="gymmane-selfhost-$os-$arch.tar.gz"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
say "Downloading $asset"
fetch "https://github.com/$REPO/releases/latest/download/$asset" "$tmp/$asset"
tar -xzf "$tmp/$asset" -C "$tmp"
if have systemctl; then
  if [ "$ROOT" = 1 ]; then systemctl stop gymmane.service >/dev/null 2>&1 || true
  else systemctl --user stop gymmane.service >/dev/null 2>&1 || true; fi
fi
rm -rf "$HOME_DIR/web"
cp -R "$tmp/gymmane/." "$HOME_DIR/"
chmod +x "$HOME_DIR/gymmane-server"
mkdir -p "$DATA_DIR"
{
  say "GYMMANE_PASSWORD=$PASS"
  say "GYMMANE_PORT=$PORT"
  say "GYMMANE_DATA=$DATA_DIR"
  say "GYMMANE_WEB=$HOME_DIR/web"
  if [ -n "$EXTRA" ]; then say "$EXTRA"; fi
} >"$HOME_DIR/.env"
chmod 600 "$HOME_DIR/.env"
[ "$os" = macos ] && xattr -d com.apple.quarantine "$HOME_DIR/gymmane-server" 2>/dev/null || true

if [ "$os" = linux ] && have systemctl; then
  if [ "$ROOT" = 1 ]; then
    unit=/etc/systemd/system/gymmane.service
    target=multi-user.target
    ctl="systemctl"
  else
    unit="$HOME/.config/systemd/user/gymmane.service"
    target=default.target
    ctl="systemctl --user"
    mkdir -p "$(dirname "$unit")"
  fi
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
  $ctl daemon-reload
  $ctl enable --now gymmane.service
  if [ "$ROOT" = 0 ] && have loginctl; then loginctl enable-linger "$(id -un)" >/dev/null 2>&1 || true; fi
  open_port
  [ "$SYNC" = 1 ] && say "Tip: for Syncthing without Docker, install the 'syncthing' package and share $DATA_DIR/sync."
  finish "$PASS"
else
  say ""
  say "Installed in $HOME_DIR. Start it with:"
  say "  set -a; . $HOME_DIR/.env; set +a; $HOME_DIR/gymmane-server"
  finish "$PASS"
fi
