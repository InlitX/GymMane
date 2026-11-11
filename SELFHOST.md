# Self-hosting GymMane

The whole GymMane app also runs in the browser, served from your own machine: a home server, a
NAS, a Raspberry Pi or your laptop. Same design, same features, laid out for a big screen. Your data
stays in one folder on that machine. No account, no cloud, nothing leaves your network.

The phone app does not change: it still has no internet permission at all. If you want the phone and
the server to share data, they do it through a folder you sync with Syncthing (see below).

## Install in one command

**Linux, a VPS or a Raspberry Pi** (also macOS):

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh
```

That's it. The script:

- uses Docker if the machine has it, and the standalone binary if it doesn't (no Docker needed);
- starts GymMane as a service that comes back on its own after a reboot;
- creates a password for you, opens the port in the firewall if you run it as root;
- prints the address to open and the password.

Add `-s -- --sync` at the end to also run Syncthing for the phone app (needs Docker):

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh -s -- --sync
```

Run the same command again to update. `--uninstall` removes it and keeps your data.

**Windows** (a PC or a server you reach over Remote Desktop), in PowerShell:

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.ps1 | iex
```

Run it as administrator to start GymMane with Windows and open the firewall port. Without admin it
starts when you log in.

No password? Set `GYMMANE_PASSWORD=` (empty) before running the script. Already have one you like?
Set `GYMMANE_PASSWORD=yours`.

## Docker by hand

```sh
mkdir gymmane && cd gymmane
curl -fsSLO https://raw.githubusercontent.com/InlitX/GymMane/main/compose.yaml
echo "GYMMANE_PASSWORD=pick-something-long" > .env
docker compose up -d
```

Open `http://localhost:8080` (or `http://<server-ip>:8080` from any device on your network).
Everything you log is stored in `./gymmane-data`. Back up that folder and you have everything.

Or with plain Docker:

```sh
docker run -d --name gymmane -p 8080:8080 -v gymmane-data:/data --restart unless-stopped ghcr.io/inlitx/gymmane
```

Images are built for `amd64` and `arm64` (Raspberry Pi 4/5 and most NAS boxes).

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
| `GYMMANE_HOST` | `0.0.0.0` | Address to bind. Use `127.0.0.1` to keep it to this machine |
| `GYMMANE_DATA` | `./data` (Docker: `/data`) | Where your data lives |
| `GYMMANE_PASSWORD` | none | Ask for a password in the browser (any user name works) |
| `GYMMANE_SYNC` | `<data>/sync` | Folder shared with your phone. `off` turns it off |
| `GYMMANE_KEEP_DAYS` | `30` | Daily copies of your data kept in `<data>/history` |

Put them in the settings file of your install, one per line, and restart GymMane:

| Installed with | Settings file | Restart |
|---|---|---|
| Docker Compose | `.env` next to `compose.yaml` | `docker compose up -d` |
| Script, Linux or macOS | `~/gymmane/.env` (`/opt/gymmane/.env` as root) | run the script again |
| Script, Windows | `%LOCALAPPDATA%\GymMane\gymmane.env` | run the script again |

Running the script again keeps whatever you added. In the web app, Settings › Data & backup shows
the folder the server shares with your phone.

The password uses plain HTTP authentication. If you open GymMane from outside your home, put it
behind a reverse proxy with HTTPS (Caddy, Traefik, Nginx Proxy Manager…) or a VPN like Tailscale or
WireGuard.

## Using it on several devices

Open the same address on your laptop, tablet or phone browser. They all read and write the same data
on the server, and each one picks up the others' changes within seconds. You can also install it as
an app from the browser menu ("Install app" or "Add to Home Screen").

## Sharing data with the phone app (Syncthing)

The phone app never connects to the server. They share a folder instead:
each side leaves its copy there, and each side brings in what the other left, merging it with what it
already has.

1. On the server, run the installer with `--sync` (or `docker compose --profile sync up -d`).
   Open `http://<server-ip>:8384`, the Syncthing page, and share the `GymMane` folder (it is
   `gymmane-data/sync` on disk).

2. On the phone, install [Syncthing-Fork](https://f-droid.org/packages/com.github.catfriend1.syncthingandroid/)
   from F-Droid, pair it with the server and accept the `GymMane` folder into a folder on your phone.
   For a home server you can turn off Global Discovery, Relaying and NAT traversal in both: they
   find each other on your Wi-Fi.

3. In GymMane on the phone: Settings › Data & backup › Auto backup, and choose that same folder.

From then on:

- Every automatic backup the phone makes reaches the server, and the server merges it within a few
  seconds. The web app shows the change on its own.
- Whatever you log in the browser, the server leaves in the folder a moment later. The phone brings it
  in when it opens, or right away with Auto backup › Sync now.

How merging works:

- **Nothing is lost.** A workout, note, food or routine that exists on either side ends up on both.
- **The same item edited on both sides:** the most recent copy wins.
- **Deleting doesn't travel.** Merging never removes anything, so delete it on both sides.
- Settings follow the most recent copy.

The server also keeps a daily copy of its data in `history`, just in case.

Not using Docker? Point Syncthing (any install) at the server's `sync` folder, by default
`data/sync` next to `gymmane-server`.

## What works differently in the browser

Everything in the app works, with these exceptions, because browsers can't do them:

- No notifications or reminders while the tab is closed (the rest timer still beeps while it's open).
- No home screen widgets, Health Connect or Apple Health.
- Photos and backups are uploaded and downloaded through the browser.

## Updating

Docker: `docker compose pull && docker compose up -d`.
Script: run it again. Without Docker or scripts: replace the files with the new release. Your data
folder is never touched by an update.

## Building it yourself

```sh
docker build -t gymmane .
```

Or by hand: `flutter build web --wasm --release --no-web-resources-cdn` for the app, and
`dart compile exe server/bin/server.dart` for the server, then set `GYMMANE_WEB` to `build/web`.
