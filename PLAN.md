# GymMinimal — Sample.html parity plan

**Last updated:** 14 November 2026  
**Reference:** Sample.html  
**Target:** the native Android app's Minimal Mode only. Standard Mode must keep its existing screens, navigation, settings and behaviour.

## Delivery rules

- Work one stage at a time on a focused branch and pull request.
- Keep Minimal Mode changes behind the existing Minimal Mode flag; do not redesign Standard Mode.
- Run Flutter analysis, the full test suite and one APK build on every PR.
- Produce exactly one installable APK named GymMinimal.apk; do not generate ABI-split APK sets.
- When a change is merged to main, publish that same APK to the rolling GitHub Release minimal-mode-preview.
- A stage is complete only after its UI and interactions have been checked against the phone app region (#app) in Sample.html.

## Overall progress

- [x] Stage 0 — Reference audit and baseline
- [x] Stage 1 — Minimal app shell and navigation
- [ ] Stage 2 — Today screen
- [ ] Stage 3 — Live workout
- [ ] Stage 4 — Exercise library
- [ ] Stage 5 — Individual exercise details and statistics
- [ ] Stage 6 — History
- [ ] Stage 7 — Overall Stats screen
- [ ] Stage 8 — Settings
- [ ] Stage 9 — Behaviour, persistence and exports
- [ ] Stage 10 — Visual and functional QA

**Progress:** 2 of 11 stages complete. Stage 2 is the current implementation PR.

## Stage detail

### Stage 0 — Reference audit and baseline (Complete)

- [x] Read the full 910-line Sample.html reference and identify the actual phone app boundary (#app).
- [x] Inventory the seven app screens, bottom navigation, controls, settings, sample data and export behaviour.
- [x] Compare the existing Flutter Minimal screens with the reference and record the important differences.
- [x] Confirm that the outer demo page and its rough Standard Mode preview are not implementation targets.

### Stage 1 — Minimal app shell and navigation (Complete — PR #8)

- [x] Add the flat five-item navigation: Today, Exercises, History, Stats and Settings.
- [x] Keep the existing Standard Mode navigation and visual shell unchanged.
- [x] Apply the Minimal charcoal/gold palette only inside Minimal Mode.
- [x] Remove Standard Mode shell effects from Minimal Mode and use direct route changes.
- [x] Route the workout settings control to Minimal settings.
- [x] Change the workflow's build output from split APKs to one GymMinimal.apk.

PR: https://github.com/HackerXMindset/GymMinimal/pull/8

### Stage 2 — Today screen (In progress — current PR)

- [x] Replace the large seven-day date cards with the compact Monday–Sunday strip from the prototype.
- [x] Mark the current day and days containing logged workouts.
- [x] Replace the multi-card recent-workout area with one compact last-workout summary.
- [x] Simplify routine rows and expose a direct Start action.
- [x] Keep active-workout resume available and provide a direct empty-workout start when no session is active.
- [ ] Validate the screen on a real Android-sized viewport and confirm no overflow.
- [ ] Pass Flutter analysis, tests and the single-APK PR build.

### Stage 3 — Live workout

- [ ] Match the compact top toolbar: back/status/timer/settings/pause/finish.
- [ ] Match the compact totals strip and shared set-table header.
- [ ] Show exercise completion counts while sections are collapsed.
- [ ] Match the thin exercise rows, set table, notes/how-to/menu actions and add-set placement.
- [ ] Match the flat bottom rest dock with minus/plus 15 seconds and Skip while retaining required timer behaviour.
- [ ] Remove Minimal-only duplicate controls that are not in the reference without removing Standard Mode features.

### Stage 4 — Exercise library

- [ ] Match the simple search and muscle filter row.
- [ ] Match the Name | Muscle | 1RM columns and compact row density.
- [ ] Remove Minimal-only equipment and animation clutter from this screen while preserving the data elsewhere.
- [ ] Keep tapping an exercise connected to the detailed exercise page.

### Stage 5 — Individual exercise details and statistics

- [ ] Add the ten prototype summary metrics: last done, last sets, first done, sessions, total sets, total reps, total volume, heaviest set, best 1RM and last PR.
- [ ] Add the 4W/8W/12W/All range control and previous/next range navigation.
- [ ] Match the estimated 1RM line chart and volume-per-session bars.
- [ ] Add the PR history list and every-session table.
- [ ] Keep edit, archive, delete, routine and other existing capabilities accessible without cluttering the reference layout.

### Stage 6 — History

- [ ] Match the simple latest-40 workout list with expandable exercise details.
- [ ] Keep the List/Table switch and Excel export.
- [ ] Match all eight table columns: Date, Exercise, Set, Kg, Reps, Volume, 1RM and Muscle.
- [ ] Preserve search, sorting, result count and 200-row cap.
- [ ] Remove the extra calendar/month summary from the Minimal History landing view.

### Stage 7 — Overall Stats screen

- [ ] Add the 4W/8W/12W/All range control to the relevant charts.
- [ ] Match the weekly volume chart.
- [ ] Match the selected-exercise 1RM trend and best/last PR/session summary.
- [ ] Add days-since-last-PR bars.
- [ ] Match the 16-week heatmap and sets-per-muscle chart.
- [ ] Remove Minimal-only streak/goal/photo/report extras not present in the prototype screen.

### Stage 8 — Settings

- [ ] Put all prototype controls on one Minimal Settings page.
- [ ] Match Minimal on/off, text size, row height, Previous, How-to, Notes, Exercise icons, Totals strip and header Settings-button switches.
- [ ] Include rest timer adjustment, Excel export, JSON backup and the offline/local-data note.
- [ ] Keep all existing Standard Mode settings and advanced app preferences intact.

### Stage 9 — Behaviour, persistence and exports

- [ ] Verify workout start/resume/pause/finish/discard flows.
- [ ] Verify set completion, totals, timer adjustment and rest countdown behaviour.
- [ ] Verify history and per-exercise statistics update after a workout is saved.
- [ ] Verify range navigation, search, sort and settings persistence.
- [ ] Verify Excel and JSON exports contain the complete expected history.
- [ ] Keep user data local and preserve existing backup compatibility.

### Stage 10 — Visual and functional QA

- [ ] Compare screenshots screen by screen at the same phone viewport and text scale as Sample.html.
- [ ] Check normal, small and tiny text sizes and all three row densities.
- [ ] Test long exercise names, empty history, no routines, active workout and mixed exercise types.
- [ ] Test every button, row, menu, chart range and navigation destination.
- [ ] Run Flutter analysis, tests and a final single-APK release build.
- [ ] Confirm the release page contains exactly one APK asset named GymMinimal.apk.

## Build and release status

- [x] The PR build for Stage 1 passed analysis, tests and the one-APK build in GitHub Actions run #24: https://github.com/HackerXMindset/GymMinimal/actions/runs/43494966866
- [ ] The release part of run #25 failed after the build job passed. It attempted to create a keystore from empty signing secrets, so Android could not read the malformed keystore.
- [ ] Current PR removes the unnecessary second build/signing step and publishes the already-built APK from the same job.
- [ ] After this PR is merged, verify that the release page is refreshed and has exactly one GymMinimal.apk asset.

## Non-goals

- Do not change Standard Mode UI or behaviour.
- Do not reproduce the browser/demo wrapper around #app.
- Do not replace working app data models with the prototype's fake sample data.
- Do not remove existing capabilities just to make the Minimal screens visually simpler; hide or relocate non-reference controls inside Minimal Mode where appropriate.
