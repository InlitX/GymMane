---
date: 2026-11-11
order: 0
tag_es: Por dentro
tag_en: Under the hood
title_es: Cómo está hecho GymMane, y cómo tenerlo en tu propio servidor
title_en: How GymMane is made, and how to run it on your own server
desc_es: Una sola base de código, cero servidores ajenos y una versión web que montas en casa con un comando. Te explico cómo funciona y cómo ponerla en marcha en cinco minutos.
desc_en: One codebase, zero third-party servers and a web version you run at home with one command. Here's how it works and how to get it running in five minutes.
---

<div data-l="es">

## Una app sin servidor

La mayoría de apps de gimnasio son dos cosas: una app en tu móvil y un servidor en la nube donde viven tus datos. GymMane es solo la primera. **Todo pasa en tu móvil**: tus entrenos, tus fotos, tus notas y tus cálculos.

Está hecha con [Flutter](https://flutter.dev), el sistema de Google para crear apps con una sola base de código en Dart. Eso me deja cuidar cada detalle del diseño (los números que ruedan, las hojas que suben desde abajo, las animaciones de los ejercicios) y, a la vez, compilar la misma app para otros sitios sin reescribirla.

Algunas decisiones que no se ven pero que lo explican todo:

- **Sin permiso de internet.** El manifiesto de Android no lo pide, así que el sistema no deja que la app se conecte a nada.
- **Tus datos en un solo sitio.** El historial se guarda en el almacenamiento privado de la app. Una copia completa es un único archivo que puedes guardar donde quieras.
- **Todo dentro del paquete.** Los ejercicios, sus animaciones, los alimentos y las fórmulas de las calculadoras van incluidos. Nada se descarga después.
- **Código abierto (GPL-3.0).** Cualquiera puede leerlo, y F-Droid compila la app desde ese código, así que lo que instalas es lo que está publicado.

## La misma app, en tu navegador

Como Flutter también compila para la web, la app entera puede funcionar en un navegador. No es una versión recortada: es **la misma app**, con el mismo diseño, adaptada a pantallas grandes con una barra lateral y paneles que aprovechan el ancho.

Para que eso tenga sentido sin romper la idea de «tus datos son tuyos», la web no vive en ningún servidor mío. **La montas tú**, en un ordenador de casa, un NAS, una Raspberry Pi o un servidor que ya tengas. Lo que te instalas son dos piezas:

1. **La app web**, compilada a WebAssembly para que vaya fluida.
2. **Un servidor muy pequeño**, escrito también en Dart, que guarda tus datos en una carpeta y sirve la app. No usa base de datos ni servicios externos.

Tus datos quedan en una carpeta de esa máquina. Si copias esa carpeta, lo tienes todo. Además, el servidor guarda una copia de cada día por si algo sale mal.

## Ponerlo en marcha

<div class="note">
<p>Necesitas un equipo que esté encendido cuando quieras usarlo: un portátil vale para probar, un NAS o una Raspberry Pi para dejarlo siempre listo.</p>
</div>

**Linux, un VPS o una Raspberry Pi.** Un solo comando:

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh
```

El script te hace tres o cuatro preguntas, cada una con una respuesta ya puesta: con pulsar Enter vale. Usa Docker si lo tienes y, si no, descarga un programa que funciona solo. Al terminar te dice la dirección que tienes que abrir y la contraseña.

<img class="shot" src="/assets/shots/selfhost-install.webp" width="804" height="1094" alt="El instalador de GymMane en una terminal: comprueba el equipo, pregunta el puerto y la contraseña, instala y enseña la dirección para abrirlo" loading="lazy">

**No hace falta root.** Lanzado con tu usuario, GymMane se instala en tu carpeta personal y arranca como un servicio tuyo, también tras reiniciar. Con `sudo` se instala para todo el equipo y, si tienes un cortafuegos activo, te ofrece abrir el puerto.

**Windows.** En PowerShell:

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.ps1 | iex
```

Sin permisos de administrador, GymMane arranca cuando inicias sesión. Como administrador, arranca con Windows y abre el puerto en el cortafuegos.

**Con Docker, a mano.** Si prefieres verlo todo:

```sh
mkdir -p gymmane/gymmane-data/sync && cd gymmane
curl -fsSLO https://raw.githubusercontent.com/InlitX/GymMane/main/compose.yaml
echo "GYMMANE_PASSWORD=algo-largo" > .env
docker compose up -d
```

El contenedor no corre como root, sino con un usuario normal. Por eso conviene crear tú la carpeta de datos antes de arrancarlo, como arriba.

Después abre `http://localhost:8080` en ese equipo, o `http://ip-del-equipo:8080` desde cualquier otro de tu casa. El navegador te pedirá la contraseña; el nombre de usuario da igual. Las imágenes funcionan en ordenadores normales y en ARM (Raspberry Pi 4 y 5, la mayoría de NAS).

## Configurarlo

Todo se ajusta con unas pocas variables, una por línea, en el archivo de ajustes de tu instalación (con Docker es el `.env` junto a `compose.yaml`):

| Variable | Qué hace |
|---|---|
| `GYMMANE_PORT` | El puerto. Por defecto, `8080`. |
| `GYMMANE_PASSWORD` | La contraseña que pide el navegador. Vacía, no pide nada. |
| `GYMMANE_SYNC` | La carpeta que comparte con el móvil. `off` la apaga. |
| `GYMMANE_KEEP_DAYS` | Cuántos días de copias guarda. Por defecto, 30. |

Cambias lo que quieras y vuelves a lanzar el instalador (o `docker compose up -d`). Lo que añadiste se conserva al actualizar.

Si vas a entrar desde fuera de casa, ponlo detrás de HTTPS (Caddy, Traefik o Nginx Proxy Manager) o úsalo a través de una VPN como Tailscale o WireGuard. Así la contraseña nunca viaja sin cifrar.

## Juntar el móvil y el servidor

La app del móvil sigue sin internet, así que **nunca se conecta al servidor**. Se juntan de otra forma: comparten una carpeta con Syncthing.

<ol class="steps">
<li>En el servidor, di que sí a Syncthing en el instalador (o lanza <code>docker compose --profile sync up -d</code>). Abre Syncthing en <code>http://ip-del-equipo:8384</code>, ponle una contraseña y añade la carpeta <code>/var/syncthing/GymMane</code>.</li>
<li>En el móvil, instala <a href="https://f-droid.org/packages/com.github.catfriend1.syncthingandroid/">Syncthing-Fork</a> desde F-Droid, emparéjalo con el servidor y acepta la carpeta.</li>
<li>En GymMane: Ajustes › Datos y copia de seguridad › Copia automática, y elige esa misma carpeta.</li>
</ol>

Desde ahí, cada lado deja su copia en la carpeta y se trae la del otro. Al juntarlas **nunca se pierde nada**: lo que existe en un lado acaba en los dos, y si editaste lo mismo en los dos sitios gana lo más reciente. En la web, Ajustes › Datos te enseña qué carpeta usa el servidor y cuándo llegó la última copia del móvil.

## Actualizar y llevártelo

Para actualizar, vuelve a lanzar el mismo comando (o `docker compose pull && docker compose up -d`). Tus datos nunca se tocan al actualizar.

Y si un día quieres dejarlo, copia la carpeta de datos o exporta una copia desde la app. Es tuyo, en un formato abierto, y te lo llevas cuando quieras.

Toda la guía, con todos los detalles, está en [SELFHOST.md](https://github.com/InlitX/GymMane/blob/main/SELFHOST.md). Si algo no te funciona, cuéntamelo en [GitHub](https://github.com/InlitX/GymMane/issues).

</div>

<div data-l="en">

## An app without a server

Most gym apps are two things: an app on your phone and a server in the cloud where your data lives. GymMane is only the first one. **Everything happens on your phone**: your workouts, your photos, your notes and your numbers.

It's built with [Flutter](https://flutter.dev), Google's toolkit for building apps from a single Dart codebase. That lets me take care of every detail of the design (rolling numbers, sheets that slide up, exercise animations) and also build the same app for other places without rewriting it.

A few choices you don't see but that explain everything:

- **No internet permission.** The Android manifest doesn't ask for it, so the system won't let the app connect to anything.
- **Your data in one place.** Your history is stored in the app's private storage. A full backup is a single file you can keep wherever you like.
- **Everything ships inside.** Exercises, their animations, foods and the calculator formulas are all included. Nothing is downloaded later.
- **Open source (GPL-3.0).** Anyone can read it, and F-Droid builds the app from that code, so what you install is what's published.

## The same app, in your browser

Because Flutter also builds for the web, the whole app can run in a browser. It isn't a cut-down version: it's **the same app**, with the same design, adapted to big screens with a sidebar and panels that use the width.

To make that work without breaking the “your data is yours” idea, the web version doesn't live on any server of mine. **You run it**, on a computer at home, a NAS, a Raspberry Pi or a server you already have. You install two pieces:

1. **The web app**, compiled to WebAssembly so it runs smoothly.
2. **A very small server**, also written in Dart, that stores your data in a folder and serves the app. No database and no outside services.

Your data stays in a folder on that machine. Copy that folder and you have everything. The server also keeps a copy of every day, just in case.

## Getting it running

<div class="note">
<p>You need a machine that's on when you want to use it: a laptop is fine to try it, a NAS or a Raspberry Pi to leave it always ready.</p>
</div>

**Linux, a VPS or a Raspberry Pi.** One command:

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.sh | sh
```

The script asks three or four questions, each with an answer already filled in: pressing Enter is enough. It uses Docker if you have it and otherwise downloads a program that runs on its own. When it's done it tells you the address to open and the password.

<img class="shot" src="/assets/shots/selfhost-install.webp" width="804" height="1094" alt="The GymMane installer in a terminal: it checks the machine, asks for the port and the password, installs and shows the address to open" loading="lazy">

**No root needed.** Run as your own user, GymMane goes into your home folder and runs as your own service, also after a reboot. With `sudo` it installs for the whole machine and, if a firewall is on, offers to open the port.

**Windows.** In PowerShell:

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/selfhost/install.ps1 | iex
```

Without administrator rights, GymMane starts when you log in. As administrator, it starts with Windows and opens the firewall port.

**With Docker, by hand.** If you'd rather see every step:

```sh
mkdir -p gymmane/gymmane-data/sync && cd gymmane
curl -fsSLO https://raw.githubusercontent.com/InlitX/GymMane/main/compose.yaml
echo "GYMMANE_PASSWORD=something-long" > .env
docker compose up -d
```

The container doesn't run as root but as a normal user. That's why it's best to create the data folder yourself before starting it, as above.

Then open `http://localhost:8080` on that machine, or `http://machine-ip:8080` from any other device at home. The browser asks for the password; any user name works. The images run on regular computers and on ARM (Raspberry Pi 4 and 5, most NAS boxes).

## Setting it up

Everything is set with a few variables, one per line, in your install's settings file (with Docker it's the `.env` next to `compose.yaml`):

| Variable | What it does |
|---|---|
| `GYMMANE_PORT` | The port. `8080` by default. |
| `GYMMANE_PASSWORD` | The password the browser asks for. Empty asks for nothing. |
| `GYMMANE_SYNC` | The folder shared with your phone. `off` turns it off. |
| `GYMMANE_KEEP_DAYS` | How many days of copies to keep. 30 by default. |

Change what you want and run the installer again (or `docker compose up -d`). Whatever you added is kept when you update.

If you'll reach it from outside your home, put it behind HTTPS (Caddy, Traefik or Nginx Proxy Manager) or use it through a VPN like Tailscale or WireGuard. That way the password never travels unencrypted.

## Bringing the phone and the server together

The phone app still has no internet, so **it never connects to the server**. They meet another way: they share a folder with Syncthing.

<ol class="steps">
<li>On the server, say yes to Syncthing in the installer (or run <code>docker compose --profile sync up -d</code>). Open Syncthing at <code>http://machine-ip:8384</code>, give it a password and add the folder <code>/var/syncthing/GymMane</code>.</li>
<li>On the phone, install <a href="https://f-droid.org/packages/com.github.catfriend1.syncthingandroid/">Syncthing-Fork</a> from F-Droid, pair it with the server and accept the folder.</li>
<li>In GymMane: Settings › Data &amp; backup › Auto backup, and choose that same folder.</li>
</ol>

From then on, each side leaves its copy in the folder and picks up the other's. When they merge, **nothing is lost**: whatever exists on one side ends up on both, and if you edited the same thing in both places the most recent one wins. In the web app, Settings › Data shows which folder the server uses and when the last copy from the phone arrived.

## Updating and taking it with you

To update, run the same command again (or `docker compose pull && docker compose up -d`). Your data is never touched by an update.

And if one day you want to stop, copy the data folder or export a backup from the app. It's yours, in an open format, and you can take it whenever you like.

The full guide, with every detail, is in [SELFHOST.md](https://github.com/InlitX/GymMane/blob/main/SELFHOST.md). If something doesn't work for you, tell me on [GitHub](https://github.com/InlitX/GymMane/issues).

</div>
