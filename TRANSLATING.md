<div align="center">

# Translating GymMane

Every word in the app lives in one small file per language.
No Dart, no build tools — just text.

</div>

---

## Adding a language

1. Copy [`lib/l10n/app_en.arb`](lib/l10n/app_en.arb) to
   `app_<code>.arb`, where `<code>` is your language code — `de`, `fr`, `pt`, `ja`…
2. Change `"@@locale"` at the top to your code, and translate `"languageName"`
   into your own language (`Deutsch`, `Français`…). That is the name shown in
   the app's language picker.
3. Translate the values — the text on the right of each `:`. Leave the keys
   alone.
4. Open a pull request with that one file. Nothing else needs to change: the app
   picks up new `app_*.arb` files on its own, and a test checks that every file
   in the folder shows up in the picker.

That's it. The exercise catalogue is separate and optional — see below.

## Rules of thumb

- **Leave `{placeholders}` alone.** Anything in curly braces is replaced with a
  real value at runtime. Move it where your language needs it, but never rename
  or translate it.
- **Plurals** look like `{n, plural, =1{1 set} other{{n} sets}}`. Use the forms
  your language actually needs — `zero`, `one`, `two`, `few`, `many`, `other`.
- **Shorter wins.** Most of these strings sit on buttons, chips and tabs on a
  phone. If yours runs much longer than the English, find a tighter wording.
- **CAPS stay CAPS.** Strings written in capitals are section headers in the UI.
- **"GymMane" stays "GymMane".** The app name isn't translated.
- **Address the user informally** — "du" rather than "Sie", "tú" rather than
  "usted".
- **You don't have to finish.** Anything you leave out simply shows in English,
  so nothing ever breaks. Ten strings today, more whenever you feel like it.

## Dates, months and weekdays

Don't translate them — there is nothing to translate. Calendars, month names and
weekday initials come from the system's locale data, so they are already correct
in your language as soon as the app ships it.

## The exercise catalogue (optional, big)

Exercise names and their step-by-step instructions live in their own file, for
example [`lib/l10n/catalog_es.dart`](lib/l10n/catalog_es.dart).
It's a long file, so treat it as a separate, later job: the app falls back to
English names for any language that doesn't have one.

To add one: copy `catalog_es.dart` to `catalog_<code>.dart`, rename the two maps
inside, translate the values, and register them in
[`lib/l10n/l10n.dart`](lib/l10n/l10n.dart):

```dart
const Map<String, Map<String, String>> _catalogNames = {'es': kExerciseNameEs, 'de': kExerciseNameDe};
```

## Checking your work

If you have Flutter installed:

```bash
cd gymmane
flutter gen-l10n
flutter test
```

If you don't, open the pull request anyway — CI and the maintainer will check it
for you.

## Questions

Not sure where a string appears? Open an
[issue](https://github.com/InlitX/GymMane/issues) — a screenshot of the screen
you're unsure about is the fastest way to get an answer.

---

<div align="center">

Translations ship under the project's [GPL-3.0 license](LICENSE).

</div>
