#!/bin/sh
set -eu

REPO="InlitX/GymMane"
RAW="https://raw.githubusercontent.com/$REPO/main"
NAME="gymmane"
YES=0

for arg in "$@"; do
  case "$arg" in
    -y|--yes) YES=1 ;;
    -h|--help)
      echo "GymMane for Proxmox VE: makes a small Debian container and installs GymMane in it."
      echo ""
      echo "  sh proxmox.sh          guided install, or update if it is already there"
      echo "  sh proxmox.sh --yes    no questions, use the defaults"
      echo ""
      echo "Environment: GYMMANE_CTID, GYMMANE_STORAGE, GYMMANE_BRIDGE (vmbr0), GYMMANE_IP (dhcp,"
      echo "             or 192.168.1.50/24,gw=192.168.1.1), GYMMANE_MEMORY (512), GYMMANE_DISK (2),"
      echo "             GYMMANE_PORT (8080), GYMMANE_PASSWORD (empty = no password), GYMMANE_PEOPLE"
      exit 0 ;;
    *) echo "Unknown option: $arg (try --help)"; exit 1 ;;
  esac
done

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ] && [ "${TERM:-}" != dumb ]; then
  esc=$(printf '\033')
  R="$esc[0m"; B="$esc[1m"; A="$esc[38;5;180m"; G="$esc[38;5;108m"; D="$esc[38;5;244m"
  F="$esc[38;5;239m"; Y="$esc[38;5;179m"; E="$esc[38;5;167m"
else
  R=""; B=""; A=""; G=""; D=""; F=""; Y=""; E=""
fi

LIVE=0
CLR=""
if [ -t 1 ]; then LIVE=1; CLR="$(printf '\033[K')"; fi
TTY=0
if [ "$YES" = 0 ] && (: </dev/tty) 2>/dev/null; then TTY=1; fi
LOGF=$(mktemp)
trap 'rm -f "$LOGF"' EXIT

say() { printf '%s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
ok() { printf '     %s+%s  %s\n' "$G" "$R" "$*"; }
note() { printf '     %s-  %s%s\n' "$D" "$*" "$R"; }
warn() { printf '     %s!%s  %s\n' "$Y" "$R" "$*"; }
die() {
  printf '\n     %sx%s  %s\n\n' "$E" "$R" "$*" >&2
  exit 1
}
step() { say ""; say "  ${A}${B}$1${R}"; say ""; }

ask() {
  if [ "$TTY" = 0 ]; then REPLY=$2; return 0; fi
  printf '  %s?%s  %s %s%s%s %s>%s ' "$A" "$R" "$1" "$F" "$2" "$R" "$A" "$R"
  IFS= read -r REPLY </dev/tty || REPLY=""
  [ -n "$REPLY" ] || REPLY=$2
}

yes_no() {
  if [ "$TTY" = 0 ]; then [ "$2" = y ]; return; fi
  if [ "$2" = y ]; then hint="Y/n"; else hint="y/N"; fi
  while :; do
    printf '  %s?%s  %s %s%s%s %s>%s ' "$A" "$R" "$1" "$F" "$hint" "$R" "$A" "$R"
    IFS= read -r answer </dev/tty || answer=""
    [ -n "$answer" ] || answer=$2
    case "$answer" in
      y|Y|yes|Yes|YES) return 0 ;;
      n|N|no|No|NO) return 1 ;;
      *) note "Type y or n." ;;
    esac
  done
}

secret() {
  printf '  %s?%s  %s %s>%s ' "$A" "$R" "$1" "$A" "$R"
  stty -echo </dev/tty 2>/dev/null || true
  IFS= read -r REPLY </dev/tty || REPLY=""
  stty echo </dev/tty 2>/dev/null || true
  printf '\n'
}

random_password() {
  LC_ALL=C tr -dc 'A-HJ-NP-Za-km-z2-9' </dev/urandom 2>/dev/null | head -c 16 || true
}

valid_password() {
  case "$1" in
    *[!A-Za-z0-9._@%+=!?~^:,/-]*) return 1 ;;
  esac
  [ "${#1}" -ge 8 ]
}

names_only() {
  printf '%s' "$1" | sed -e 's/:[^,]*//g' -e 's/ *, */, /g' -e 's/^ *//' -e 's/ *$//'
}

pending() { [ "$LIVE" = 0 ] || printf '     %s...%s  %s' "$A" "$R" "$1"; }
done_line() { [ "$LIVE" = 0 ] || printf '\r%s' "$CLR"; }

row() { printf '  %s%-11s%s%s\n' "$D" "$1" "$R" "$2"; }

run() {
  label=$1; shift
  pending "$label"
  if "$@" >>"$LOGF" 2>&1; then done_line; ok "$label"; return 0; fi
  done_line
  warn "$label failed:"
  tail -n 15 "$LOGF" | sed 's/^/        /'
  return 1
}

in_ct() { pct exec "$CTID" -- "$@"; }

say ""
say "  ${A}${B}GymMane${R} ${F}-${R} ${B}Proxmox VE${R}"
say "  ${D}A small Debian container with GymMane in it. No account, no cloud.${R}"

[ "$(id -u)" = 0 ] || die "Run this as root in the Proxmox VE shell (Datacenter > your node > Shell)."
for tool in pct pveam pvesm pvesh; do
  have "$tool" || die "This is not a Proxmox VE host. On any other Linux, use the normal installer: curl -fsSL $RAW/selfhost/install.sh | sh"
done

step "This Proxmox"
ok "$(pveversion 2>/dev/null | head -n1 || echo 'Proxmox VE')"

EXISTING=$(pct list 2>/dev/null | awk -v n="$NAME" 'NR > 1 && $NF == n { print $1 }' | head -n1)
if [ -n "$EXISTING" ]; then
  ok "GymMane is already in container $EXISTING"
  CHOICE=update
  if [ "$TTY" = 1 ]; then
    say ""
    while :; do
      printf '  %s?%s  What do you want to do? %s[U]pdate, [n]ew container, [c]ancel%s %s>%s ' "$A" "$R" "$F" "$R" "$A" "$R"
      IFS= read -r answer </dev/tty || answer=""
      case "$answer" in
        ""|u|U) CHOICE=update; break ;;
        n|N) CHOICE=new; break ;;
        c|C) say ""; exit 0 ;;
        *) note "Type u, n or c." ;;
      esac
    done
  fi
  if [ "$CHOICE" = update ]; then
    CTID=$EXISTING
    step "Updating"
    if ! pct status "$CTID" | grep -q running; then run "Starting container $CTID" pct start "$CTID" || die "Container $CTID did not start."; fi
    run "Updating GymMane inside container $CTID" in_ct sh -c "curl -fsSL $RAW/selfhost/install.sh | TERM=dumb sh -s -- --yes" \
      || die "The update did not finish. Your data is untouched."
    IP=$(in_ct hostname -I 2>/dev/null | awk '{print $1}')
    PORT=$(in_ct sh -c 'grep "^GYMMANE_PORT=" /opt/gymmane/.env | cut -d= -f2' 2>/dev/null || echo 8080)
    say ""
    say "  ${G}+${R} ${B}GymMane is up to date${R}"
    say ""
    [ -z "$IP" ] || row "Open" "${A}${B}http://$IP:${PORT:-8080}${R}"
    row "Container" "$CTID"
    say ""
    exit 0
  fi
fi

step "Settings"
[ "$TTY" = 0 ] || { note "Press Enter to keep the value in grey."; say ""; }

CTID="${GYMMANE_CTID:-$(pvesh get /cluster/nextid)}"
if [ -z "${GYMMANE_CTID:-}" ]; then
  while :; do
    ask "Container ID" "$CTID"
    case "$REPLY" in
      ''|*[!0-9]*) note "Type a number, 100 or more." ;;
      *) if [ "$REPLY" -lt 100 ]; then note "Type a number, 100 or more."
         elif pct status "$REPLY" >/dev/null 2>&1; then note "$REPLY is already taken."
         else CTID=$REPLY; break; fi ;;
    esac
  done
fi
pct status "$CTID" >/dev/null 2>&1 && die "Container $CTID already exists. Pick another ID with GYMMANE_CTID."

STORES=$(pvesm status -content rootdir 2>/dev/null | awk 'NR > 1 && $3 == "active" { print $1 }')
[ -n "$STORES" ] || die "No storage here can hold containers (content type rootdir)."
STORAGE="${GYMMANE_STORAGE:-}"
if [ -z "$STORAGE" ]; then
  STORAGE=$(printf '%s\n' "$STORES" | grep -x 'local-lvm' || printf '%s\n' "$STORES" | head -n1)
  if [ "$(printf '%s\n' "$STORES" | wc -l)" -gt 1 ]; then
    while :; do
      ask "Storage for the container ($(printf '%s' "$STORES" | tr '\n' ' ' | sed 's/ $//'))" "$STORAGE"
      if printf '%s\n' "$STORES" | grep -qx "$REPLY"; then STORAGE=$REPLY; break; fi
      note "Type one of: $(printf '%s' "$STORES" | tr '\n' ' ')"
    done
  fi
fi

BRIDGE="${GYMMANE_BRIDGE:-vmbr0}"
NETIP="${GYMMANE_IP:-dhcp}"
MEMORY="${GYMMANE_MEMORY:-512}"
DISK="${GYMMANE_DISK:-2}"

PORT="${GYMMANE_PORT:-8080}"
if [ -z "${GYMMANE_PORT:-}" ]; then
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

if [ "${GYMMANE_PEOPLE+set}" = set ]; then
  PEOPLE="$GYMMANE_PEOPLE"
elif [ "$TTY" = 1 ] && yes_no "Will more than one person use it, each with their own data?" n; then
  while :; do
    ask "Their names, separated by commas (Ana, Pablo)" ""
    case "$REPLY" in
      *'"'*|*"'"*|*'\'*) note "Names without quotes or backslashes." ;;
      *[A-Za-z0-9]*) PEOPLE=$REPLY; break ;;
      *) note "Type at least one name." ;;
    esac
  done
else
  PEOPLE=""
fi
case "$PEOPLE" in *'"'*|*"'"*) die "GYMMANE_PEOPLE cannot have quotes in it." ;; esac
WHO=$(names_only "$PEOPLE")

say ""
row "Container" "$CTID  ${D}($NAME, Debian, unprivileged, starts with Proxmox)${R}"
row "Storage" "$STORAGE  ${D}(${DISK} GB)${R}"
row "Memory" "$MEMORY MB"
row "Network" "$BRIDGE, $NETIP"
row "Port" "$PORT"
if [ -n "$PASS" ]; then row "Password" "yes"; else row "Password" "no, open to your network"; fi
if [ -n "$WHO" ]; then row "People" "$WHO"; else row "People" "just you"; fi
if [ "$TTY" = 1 ]; then
  say ""
  yes_no "Go ahead?" y || { say ""; exit 0; }
fi

step "Creating the container"
TSTORE=$(pvesm status -content vztmpl 2>/dev/null | awk 'NR > 1 && $3 == "active" { print $1 }' | grep -x local || true)
[ -n "$TSTORE" ] || TSTORE=$(pvesm status -content vztmpl 2>/dev/null | awk 'NR > 1 && $3 == "active" { print $1 }' | head -n1)
[ -n "$TSTORE" ] || die "No storage here can hold container templates (content type vztmpl)."
run "Refreshing the template list" pveam update || warn "Using the template list Proxmox already has"
TEMPLATE=$(pveam available --section system 2>/dev/null | awk '{ print $2 }' | grep -E '^debian-[0-9]+-standard_' | sort -V | tail -n1)
[ -n "$TEMPLATE" ] || die "Could not find a Debian template. Check that this Proxmox can reach the internet."
if pveam list "$TSTORE" 2>/dev/null | grep -q "$TEMPLATE"; then
  ok "Template $TEMPLATE is already here"
else
  run "Downloading $TEMPLATE" pveam download "$TSTORE" "$TEMPLATE" || die "Could not download the Debian template."
fi

run "Creating container $CTID" pct create "$CTID" "$TSTORE:vztmpl/$TEMPLATE" \
  --hostname "$NAME" \
  --cores 1 \
  --memory "$MEMORY" \
  --swap 256 \
  --rootfs "$STORAGE:$DISK" \
  --net0 "name=eth0,bridge=$BRIDGE,ip=$NETIP" \
  --unprivileged 1 \
  --features nesting=1 \
  --onboot 1 \
  --tags gymmane \
  --description "GymMane, your gym log on your own server. Update: run the Proxmox command again." \
  || die "Proxmox could not create the container."
run "Starting it" pct start "$CTID" || die "Container $CTID did not start."

i=0
pending "Waiting for the network"
until in_ct sh -c 'getent hosts raw.githubusercontent.com >/dev/null 2>&1'; do
  i=$((i + 1))
  if [ "$i" -ge 60 ]; then done_line; die "Container $CTID has no internet. Check the bridge ($BRIDGE) and DHCP, or set GYMMANE_IP."; fi
  sleep 1
done
done_line; ok "Container $CTID is online"

step "Installing GymMane"
run "Installing curl" in_ct sh -c 'command -v curl >/dev/null || { apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq curl ca-certificates; }' \
  || die "Could not install curl inside the container."
run "Installing GymMane, this can take a minute" in_ct env GYMMANE_PORT="$PORT" GYMMANE_PASSWORD="$PASS" GYMMANE_PEOPLE="$PEOPLE" TERM=dumb \
  sh -c "curl -fsSL $RAW/selfhost/install.sh | sh -s -- --yes --binary" \
  || die "GymMane did not install. The container stays, so you can look inside with: pct enter $CTID"

IP=$(in_ct hostname -I 2>/dev/null | awk '{print $1}')

say ""
say "  ${G}+${R} ${B}GymMane is running${R}"
say ""
if [ -n "$IP" ]; then row "Open" "${A}${B}http://$IP:$PORT${R}  ${D}from any device on your network${R}"
else row "Open" "http://<container-ip>:$PORT"; fi
[ -z "$WHO" ] || row "" "${D}Each person picks their name on that page.${R}"
if [ -n "$PASS" ]; then
  if [ "$GENERATED" = 1 ]; then row "Password" "${B}$PASS${R}  ${D}made up for you, any user name works${R}"
  else row "Password" "the one you chose"; fi
fi
row "Container" "$CTID ($NAME), starts with Proxmox"
row "Data" "/opt/gymmane/data inside it, included in Proxmox backups of $CTID"
row "Settings" "pct enter $CTID, then edit /opt/gymmane/.env"
row "Update" "run this same command again"
say ""
