<div align="center">

<img src="screenshots/banner-en.png" alt="GymMane — Lift. Log it. Grow." width="860" />

<br/>

<img src="screenshots/icon.png" width="94" alt="GymMane" />

# GymMane

### A dark, offline gym log for Android

Pick your muscles on a real body map, log your sets,
and watch your numbers move.

<br/>

<p>
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white" />
  <img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white" />
  <img alt="Android 7.0+" src="https://img.shields.io/badge/Android-7.0%2B-3DDC84?style=flat&logo=android&logoColor=white" />
  <img alt="License GPLv3" src="https://img.shields.io/badge/License-GPLv3-C2410C?style=flat&logo=gnu&logoColor=white" />
  <img alt="No ads, no tracking" src="https://img.shields.io/badge/No%20ads%20%C2%B7%20No%20tracking-22C55E?style=flat&logo=shield&logoColor=white" />
  <a href="https://github.com/InlitX/GymMan/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/InlitX/GymMan?style=flat&color=D9A184&labelColor=181717&logo=github" /></a>
</p>

<sub>
  <a href="#features">Features</a> ·
  <a href="#coming-from-another-app">Import</a> ·
  <a href="#privacy">Privacy</a> ·
  <a href="#translations">Translations</a> ·
  <a href="#building">Build</a>
</sub>

<br/>
<br/>

<sub><b>English</b> · <a href="README.es.md">Español</a></sub>

</div>

---

<div align="center">

<img src="screenshots/store/en/01-hero.jpg" width="250" alt="Lift. Log it. Grow." />
<img src="screenshots/store/en/02-train.jpg" width="250" alt="Tap the muscle, get the session" />
<img src="screenshots/store/en/03-rest.jpg" width="250" alt="Tick the set, rest rings itself" />

<img src="screenshots/store/en/04-progress.jpg" width="250" alt="Progress from your own sets" />
<img src="screenshots/store/en/05-library.jpg" width="250" alt="360+ exercises with animations" />
<img src="screenshots/store/en/06-privacy.jpg" width="250" alt="No account. No internet. No smoke." />

<br/>

<details>
<summary><sub><b>Plain screenshots</b> — every screen, straight off the phone</sub></summary>
<br/>

<img src="screenshots/mock/01-home.png" width="215" alt="Today" />
<img src="screenshots/mock/03-train.png" width="215" alt="Body map" />
<img src="screenshots/mock/04-session.png" width="215" alt="Live session" />
<img src="screenshots/mock/02-progress.png" width="215" alt="Progress" />

<sub><b>Today</b> &nbsp;·&nbsp; <b>Body map</b> &nbsp;·&nbsp; <b>Live session</b> &nbsp;·&nbsp; <b>Progress</b></sub>

<br/>
<br/>

<img src="screenshots/mock/05-history.png" width="215" alt="History" />
<img src="screenshots/mock/06-library.png" width="215" alt="Library" />
<img src="screenshots/mock/07-routines.png" width="215" alt="Routines" />
<img src="screenshots/mock/08-settings.png" width="215" alt="Settings" />

<sub><b>History</b> &nbsp;·&nbsp; <b>Library</b> &nbsp;·&nbsp; <b>Routines</b> &nbsp;·&nbsp; <b>Settings</b></sub>

</details>

</div>

---

## Overview

GymMane is an open-source strength log built for the gym floor. Tap the muscles
you want to train on an interactive body, log reps and weight set by set, rest
with an alarm that actually gets your attention, and read progress that comes
from **your** own sets — volume, records, streak and muscle split. Nothing
decorative.

> [!TIP]
> **Yours, completely.** No account, no ads, no subscription — and no internet
> permission at all. Every set stays on your phone.

<div align="center">
<br/>
<b>360+</b> exercises &nbsp;·&nbsp; <b>6</b> calculators &nbsp;·&nbsp; <b>100%</b> offline &nbsp;·&nbsp; <b>0</b> internet permissions
</div>

---

## Features

<table>
<tr>
<td width="50%" valign="top">

### 🏋️ Training

- **Interactive body map**, front and back — tap what you want to train
- A session picked for you, then edited set by set
- Reps, weight and a **rest timer** with your own alarm sound
- A live session survives a reboot — carry on where you left off
- **Routines** you can reorder and schedule per weekday

</td>
<td width="50%" valign="top">

### 📊 Progress

- Volume, streak, weekly goal ring and **PRs**, all from your own sets
- GitHub-style **activity heatmap** with per-day detail
- **Strength curves** with estimated 1RM per exercise
- Muscle split across the last 30 days
- Bodyweight tracking with history

</td>
</tr>
<tr>
<td width="50%" valign="top">

### 📚 Exercises & tools

- **360+ exercises** with animations and step-by-step instructions
- Search, filters, favourites and **your own exercises** (photo, GIF or video)
- **Six calculators** — 1RM, plates, BMI, calories & macros, body fat, warm-up
- Two home-screen widgets — activity and stats

</td>
<td width="50%" valign="top">

### 🔒 Your data

- Export to **CSV** or a full **JSON backup**, and import it back
- Import your history from **Hevy**, **Strong** or **FitNotes** — workouts *and* bodyweight
- Delete everything in one tap
- Dark and light themes, kg or lb, English and Spanish

</td>
</tr>
</table>

---

## Coming from another app?

Bring your history with you. GymMane reads the workout and measurement exports
of **Hevy** and **Strong** — CSV or the measurements zip — and the whole
**FitNotes** backup, which is a SQLite database. Every exercise is matched
against its own library and anything you already logged is skipped.

| App | What to hand it |
|---|---|
| **Hevy** | `workout_data.csv`, plus the measurements zip |
| **Strong** | `strong.csv` |
| **FitNotes** | the whole `.fitnotes` backup (SQLite) |

<div align="center"><sub><b>Settings → Data → Import from another app</b></sub></div>

---

## Privacy

> [!IMPORTANT]
> GymMane has **no analytics, no ad SDK and no network code**. The app never
> asks for Android's `INTERNET` permission, so it cannot send your training
> anywhere. The only outbound actions are links you tap yourself.

Everything it *does* ask for, and why:

| Permission | What it is for |
|---|---|
| `POST_NOTIFICATIONS` | show the rest timer and its alarm |
| `USE_EXACT_ALARM` | ring at the right second, not "sometime later" |
| `VIBRATE` | the alarm buzzes |
| `WAKE_LOCK` | the alarm fires with the screen off |

---

## Translations

GymMane speaks English and Spanish today, and more languages are very welcome.
Translations live in plain [ARB files](lib/l10n) — one file per
language, nothing to compile.

The full guide lives in **TRANSLATING.md**.

---

## Building

```bash
git clone https://github.com/InlitX/GymMan.git
cd GymMan
flutter pub get
flutter test
flutter build apk --release
```

---

## Contributing

Bug reports, ideas and pull requests are all welcome — see
**CONTRIBUTING.md**. For anything larger than a fix, open an
issue first so we can agree on the direction.

---

<div align="center">

<a href="https://github.com/InlitX/GymMan"><img src="https://img.shields.io/badge/Star%20on%20GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="Star on GitHub" height="38" /></a>
&nbsp;&nbsp;
<a href="https://ko-fi.com/inlitx"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on Ko-fi" height="38" /></a>

<br/>
<br/>

Released under the <b>GNU GPL v3</b>.
Free forever, and nobody can close it up and resell it.

</div>
