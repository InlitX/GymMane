# Translating GymMane

All the app's text lives in one file per language, inside
[`lib/l10n`](lib/l10n). English is [`app_en.arb`](lib/l10n/app_en.arb) and the
rest follow the same name: `app_es.arb`, `app_de.arb`, `app_ja.arb`…

## Fix or finish a language

1. Open your language's file, for example `lib/l10n/app_fr.arb`.
2. Change the text after the colon. Only the text, never the key on the left:

   ```json
   "startWorkout": "COMMENCER LA SÉANCE",
   ```

3. Send a pull request. You can do it all from GitHub in the browser with the
   pencil icon, no tools needed.

Any string missing from your file shows in English, so you don't have to do
everything at once.

## Add a new language

1. Copy `app_en.arb` and name it with your language code, for example
   `app_id.arb` for Indonesian.
2. Change `"@@locale": "en"` at the top to your code (`"id"`).
3. Translate `languageName` first. It's the name shown in the language picker
   (`Bahasa Indonesia`).
4. Delete the lines that start with `"@`, they're notes for English only.
5. Translate what you can and send a pull request.

If you're not sure about your code, open an issue and I'll help.

## A few rules

- **Keep `{placeholders}` as they are.** Anything in curly braces gets
  replaced by a number or a name. Move it where your language needs it, but
  don't translate it.
- **Plurals** look like `{n, plural, =1{1 set} other{{n} sets}}`. Translate the
  words inside and use the forms your language needs (`one`, `few`, `many`,
  `other`…).
- **Keep it short.** Most text sits on buttons and small cards on a phone.
- **"GymMane" stays "GymMane".**
- **Talk to the user informally**: "tú", not "usted"; "du", not "Sie".

Dates, months and weekdays come from the phone, so there's nothing to
translate there.

## Exercise names (optional)

Exercise names and their steps are in a separate, much longer file, for
example [`lib/l10n/catalog_es.dart`](lib/l10n/catalog_es.dart). Leave it for
later: without it, the app just shows the English names. If you want to do it,
open an issue first and I'll tell you how to hook it up.

Not sure where a text shows up? Open an
[issue](https://github.com/InlitX/GymMane/issues) with a screenshot.

Translations are shared under the project's [GPL-3.0 license](LICENSE).
