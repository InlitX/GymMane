<div align="center">

# Contributing to GymMane

</div>

---

## Before you start

- **Bugs and small fixes:** open a pull request straight away.
- **Anything bigger:** open an issue first so we can agree on the direction
  before you spend an evening on it.
- **Translations:** see [TRANSLATING.md](TRANSLATING.md) — one text file and a
  pull request. No Dart, but no translation website either: it all happens here.

## Two rules that never bend

1. **No accounts, no logins, no remote user data.** Ever.
2. **No network.** The app has no `INTERNET` permission and no analytics, and it
   stays that way. A feature that needs a server is a feature GymMane won't have.

Anything that keeps working on a phone in flight mode is fair game.

## Getting set up

```bash
flutter pub get
flutter test          # 350+ tests, all of them should pass
flutter run
```

Requires Flutter 3.41+ (Dart 3.11+). Android only for now.

## Where things live

```
lib/
├── app/          the MaterialApp, the shell and the bottom nav
├── catalog/      the exercise database and the body-map SVG paths
├── l10n/         ARB translations + generated strings
├── models/       plain data classes (exercise, workout, profile…)
├── screens/      one file per screen
├── services/     storage, backup/import, alarms, home-screen widgets
├── state/        FitState, split by area (settings, library, stats, workout…)
├── theme/        colours and text styles
└── widgets/      shared UI pieces
```

The exercise catalogue is `catalog/exercise_catalog.dart`, and
`catalog/exercise_aliases.dart` is the plain list that lets people search an
exercise by the name another app gives it — one line per exercise, add yours there.

`FitState` is the single source of truth. It lives in `state/fit_state.dart` and
is split across `part` files by area, so you can work on statistics without
scrolling past the rest of the app. `fit` is its one global instance.

## House style

- **No comments.** Names and structure carry the meaning; the reason for a
  change goes in the commit message, not in the file.
- Text the user can read **always** goes through `t.<key>` and an ARB entry —
  never a literal in a widget. A test enforces this.
- Prefer small widgets and pure functions. Statistics must be computed from real
  logged sets, never estimated or faked.
- Run `dart format` before pushing, keep `flutter analyze` clean.

## Tests

Add a test with your change. The suite is plain `flutter_test` and fast:

```bash
flutter test                        # everything
flutter test test/session_test.dart # one file
```

## Pull requests

- One topic per pull request.
- Say what changed and why, and add a screenshot for anything visual.
- By contributing you agree your work ships under the project's
  [GPL-3.0 license](LICENSE).
