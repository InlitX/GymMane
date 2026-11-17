# GymMane on Wear OS

GymMane has a watch app, in beta. It's the same app as on the phone, with its own layout for the
wrist: today's routine, sets you log with the crown, the rest timer, a tile and a complication. It
works on its own, without the phone nearby, and syncs with the phone over Bluetooth.

It runs on any watch with Wear OS 3 or newer: Galaxy Watch 4 and later, Pixel Watch, TicWatch, Fossil,
OnePlus Watch and others. It isn't on the Play Store, so you install it from a computer. It takes about
five minutes and you only do it once.

Found a bug, or something that doesn't work on your watch? Please
[open an issue](https://github.com/InlitX/GymMane/issues/new/choose) with your watch model. That's
how the watch app gets better.

## 1. Get the watch ready

1. On the watch, open **Settings › System › About › Versions** and tap **Build number** seven times.
   You'll see that developer options are on.
2. Go back to **Settings › Developer options** and turn on **ADB debugging** and **Wireless
   debugging** (on older watches it's called **Debug over Wi-Fi**).
3. Make sure the watch and your computer are on the same Wi-Fi.

## 2. Install GymMane

Download the installer and run it. It sets up adb if you don't have it, connects to the watch, picks
the right version for it and installs it.

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/wear/install.ps1 -OutFile install.ps1; .\install.ps1
```

**Linux or macOS:**

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/wear/install.sh -o install.sh && sh install.sh
```

It asks for two things shown on the watch, in **Developer options › Wireless debugging**:

- the **IP address and port** at the top;
- the first time only, a **pairing code**: tap **Pair new device** and type the address and code it
  shows.

If the watch asks to allow debugging, tap **Allow**. When it's done, turn Wireless debugging off.

To update GymMane later, run the installer again. Your data stays.

<details>
<summary>Installing by hand</summary>

With [platform-tools](https://developer.android.com/tools/releases/platform-tools):

```sh
adb pair <pairing address:port> <code>
adb connect <IP address:port>
adb shell getprop ro.product.cpu.abilist
adb install -r GymMane-<abi>.apk
```

Take the APK from the [latest release](https://github.com/InlitX/GymMane/releases/latest) that matches
the first value the third command prints: `arm64-v8a` or `armeabi-v7a`.

</details>

## 3. Sync with the phone

The phone and the watch sync over the Bluetooth link they already share. No internet, no account and
no Google services.

1. **On the phone:** Settings › Data & backup › **Wear OS watch**, turn on **Sync with the watch** and allow
   Bluetooth.
2. **On the watch:** open GymMane, go to Settings and tap **Allow Bluetooth**.
3. **Open GymMane on both.** They sync on their own whenever both are open at the same time. You can
   also tap **Sync now** on either one.

The watch gets your routines, weekly plan, settings and history. Notes, photos and nutrition stay on
the phone. Workouts you do on the watch reach the phone the next time both apps are open.

<details>
<summary>If Bluetooth sync doesn't work on your watch</summary>

A computer can carry the data instead. On the phone, turn on Settings › Data & backup › Auto backup to a
folder and copy that folder to the computer. Then, with the watch connected over adb as in step 2:

```sh
curl -fsSL https://raw.githubusercontent.com/InlitX/GymMane/main/wear/sync.sh -o sync.sh && sh sync.sh <folder>
```

```powershell
irm https://raw.githubusercontent.com/InlitX/GymMane/main/wear/sync.ps1 -OutFile sync.ps1; .\sync.ps1 <folder>
```

It sends the newest backup to the watch and brings back the workouts done on it. On the watch, tap
**Sync now** afterwards. Please also open an issue with your watch model, so Bluetooth can be fixed
for it.

</details>
