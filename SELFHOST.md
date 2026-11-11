# Self-hosting GymMane

The whole GymMane app also runs in the browser, served from your own machine: a home server, a
NAS, a Raspberry Pi or your laptop. Same design, same features, laid out for a big screen. Your data
stays in one folder on that machine. No account, no cloud, nothing leaves your network.

The phone app does not change: it still has no internet permission at all. If you want the phone and
the server to share data, they do it through a folder you sync with Syncthing (see below).

## Install with the guided script

**Linux, a VPS or a Raspberry Pi** (also macOS):

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh
```

The script shows what it found on the machine and asks a few questions, each with a default you can
take by pressing Enter:

- whether to use Docker, if Docker is running there (otherwise it uses the standalone server, no
  Docker needed);
- the port (`8080`);
- whether to ask for a password in the browser, and which one (press Enter and it makes one up);
- whether to also run Syncthing for the phone app (Docker only);
- whether to open the port in the firewall (only when run as root and `ufw` or `firewalld` is on).

Then it shows a summary, asks to go ahead, installs, checks that GymMane answers and prints the
address to open and the password.

GymMane starts again on its own after a reboot: with Docker, through Docker; on Linux, as a systemd
service; on macOS, as a login item (a system service if you run the script as root). On a Linux
without systemd the script tells you the command to start it.

Run the same command again to **update** or **remove** it: the script sees it is installed and asks.
Updating keeps your settings and your data. Removing keeps your data.

No questions, take every default: add `-s -- --yes`. Other options: `--docker`, `--binary`,
`--sync`, `--uninstall`.

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh -s -- --yes
```

The standalone server is built for 64-bit Linux (`x64` and `arm64`, so a Raspberry Pi 4 or 5 with a
64-bit system) and Apple silicon Macs.

**Windows** (a PC or a server you reach over Remote Desktop), in PowerShell:

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.ps1 | iex
```

It asks the same questions. Run PowerShell as administrator to start GymMane with Windows and open
the port in Windows Firewall; without admin it starts when you log in. Run the command again to
update or remove it.

## Docker by hand

```sh
mkdir gymmane && cd gymmane
curl -fsSLO https://raw.githubusercontent.com/InlitX/GymMane/main/compose.yaml
echo "GYMMANE_PASSWORD=pick-something-long" > .env
docker compose up -d gymmane
```

Open `http://localhost:8080` (or `http://<server-ip>:8080` from any device on your network).
Everything you log is stored in `./gymmane-data`. Back up that folder and you have everything.

Or with plain Docker:

```sh
docker run -d --name gymmane -p 8080:8080 -v gymmane-data:/data --restart unless-stopped ghcr.io/inlitx/gymmane
```

Images are built for `amd64` and `arm64` (Raspberry Pi 4/5 with a 64-bit system, most NAS boxes).

## By hand, without Docker or scripts

Download the archive for your system from the
[latest release](https://github.com/InlitX/GymMane/releases/latest), unpack it and run
`gymmane-server` (on Windows, `start.bat`). The `web` folder must stay next to it. On macOS, if the
system blocks the binary, run `xattr -d com.apple.quarantine gymmane-server` once.

## Settings

All settings are environment variables:

| Variable | Default | What it does |
|---|---|---|
| `GYMMANE_PORT` | `8080` | Port to listen on |
| `GYMMANE_PASSWORD` | none | Ask for a password in the browser (any user name works) |
| `GYMMANE_SYNC` | `<data>/sync` | Folder shared with your phone. `off` turns it off |
| `GYMMANE_KEEP_DAYS` | `30` | Daily copies of your data kept in `<data>/history` |
| `GYMMANE_HOST` | `0.0.0.0` | Address to bind. `127.0.0.1` keeps it to this machine. Not with Docker |
| `GYMMANE_DATA` | `data` next to the server | Where your data lives. Not with Docker: there it is `./gymmane-data` |

Put them in the settings file of your install, one per line, and restart GymMane:

| Installed with | Settings file | Restart |
|---|---|---|
| Docker Compose | `.env` next to `compose.yaml` | `docker compose up -d` |
| Script, Linux or macOS | `~/gymmane/.env` (`/opt/gymmane/.env` as root) | run the script again and pick Update |
| Script, Windows | `%LOCALAPPDATA%\GymMane\gymmane.env` | run the script again and pick Update |

Updating with the script keeps whatever you added. In the web app, Settings › Data & backup shows
the folder the server shares with your phone.

The password uses plain HTTP authentication, so on your own network it travels unencrypted. If you
open GymMane from outside your home, put it behind a reverse proxy with HTTPS (Caddy, Traefik, Nginx
Proxy Manager…) or reach it through a VPN like Tailscale or WireGuard. Don't open the port to the
internet as it is.

## Using it on several devices

Open the same address on your laptop, tablet or phone browser. They all read and write the same data
on the server. Each open tab checks for changes every 20 seconds, and right away when you come back
to it.

Browsers only offer to install it as an app ("Install app", "Add to Home Screen") over HTTPS or on
`localhost`. On a plain `http://<server-ip>` address it works as a normal web page.

## Sharing data with the phone app (Syncthing)

The phone app never connects to the server. They share a folder instead: each side leaves its copy
there, and each side brings in what the other left, merging it with what it already has.

1. **On the server**, choose Syncthing in the installer (or run
   `docker compose --profile sync up -d`). Open `http://<server-ip>:8384`, the Syncthing page, and
   set a password for it under Actions › Settings › GUI. Then Add Folder with the path
   `/var/syncthing/GymMane` (on disk it is `gymmane-data/sync`).

2. **On the phone**, install [Syncthing-Fork](https://f-droid.org/packages/com.github.catfriend1.syncthingandroid/)
   from F-Droid. Add the server as a device (on the server, Actions › Show ID), share the folder from
   the server with the phone and accept it into a folder on the phone. For a home server you can turn
   off Global Discovery, Relaying and NAT traversal on both: they find each other on your Wi-Fi.

3. **In GymMane on the phone**: Settings › Data & backup › Auto backup, and choose that same folder.

From then on:

- Every automatic backup the phone makes lands in the folder, and the server merges it within about
  15 seconds. Open browser tabs pick it up on their next check.
- Whatever you log in the browser, the server leaves in the folder about half a minute later. The
  phone brings it in when the app starts, or right away with Auto backup › Sync now.

How merging works:

- **Nothing is lost.** A workout, note, food or routine that exists on either side ends up on both.
- **The same item edited on both sides:** the most recent copy wins.
- **Deleting doesn't travel.** Merging never removes anything, so delete it on both sides.
- Settings follow the most recent copy.

The server also keeps a daily copy of its data in `history`, just in case.

Not using Docker? Install Syncthing yourself and point it at the server's `sync` folder, by default
`data/sync` inside the install folder.

## What works differently in the browser

Everything in the app works, with these exceptions, because browsers can't do them:

- No notifications or reminders while the tab is closed (the rest timer still beeps while it's open).
- No home screen widgets, Health Connect or Apple Health.
- Photos and backups are uploaded and downloaded through the browser.

## Updating

Script: run it again and pick Update. Docker: `docker compose pull && docker compose up -d`.
Without Docker or scripts: replace the files with the new release. Your data folder is never touched
by an update.

## Building it yourself

```sh
docker build -t gymmane .
```

Or by hand: `flutter build web --wasm --release --no-web-resources-cdn` for the app, and
`dart compile exe server/bin/server.dart` for the server, then set `GYMMANE_WEB` to `build/web`.
