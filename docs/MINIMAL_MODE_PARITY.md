# Minimal Mode — Sample.html Parity Roadmap

**Scope:** Native Android Minimal Mode only. The target is the phone UI inside `#app` in the root `Sample.html`. The browser/demo frame and the prototype's rough Standard-mode mockup are not targets. Standard mode must remain unchanged and fully functional.

**Working method:** One focused stage per branch and pull request. Run Flutter analysis and relevant tests on every PR. Build one APK per PR. Only mark a stage complete after its UI and interactions have been checked against the HTML reference. A successful merge to `main` publishes one `GymMinimal.apk` asset on the rolling GitHub preview release.

## Overall progress

- [x] Stage 0 — Reference specification and baseline
- [x] Stage 1 — Minimal shell and navigation
- [ ] Stage 2 — Today screen
- [ ] Stage 3 — Live workout
- [ ] Stage 4 — Exercise library
- [ ] Stage 5 — Exercise details and per-exercise statistics
- [ ] Stage 6 — History
- [ ] Stage 7 — Stats dashboard
- [ ] Stage 8 — Settings
- [ ] Stage 9 — Behaviour, persistence and export parity
- [ ] Stage 10 — Visual and functional QA

**Progress: 2 of 11 stages complete (18%).** Nine stages remain. Release automation is tracked separately and does not count as a UI stage.

## Stage details

### Stage 0 — Reference specification and baseline — COMPLETE
- [x] Inspect the complete `Sample.html` and identify the actual `#app` target.
- [x] Inventory screens, navigation, controls, settings, visual tokens and sample states.
- [x] Compare the reference with the current Flutter Minimal implementation.
- [x] Record differences and define Standard mode as out of scope.

### Stage 1 — Minimal shell and navigation — COMPLETE
- [x] Add flat five-destination Minimal navigation: Today, Exercises, History, Stats and Settings.
- [x] Keep existing Standard-mode navigation and presentation conditional on Standard mode.
- [x] Apply reference palette and remove Standard shell chrome from Minimal screens.
- [x] Route the live-workout settings control to Minimal Settings.
- [x] Add navigation regression coverage.
- [x] Merge PR #8.

### Stage 2 — Today screen — NEXT
- [ ] Match Today header, date and seven-day strip.
- [ ] Match active-workout resume/start card and empty state.
- [ ] Match routine presentation and actions.
- [ ] Match last-workout summary; remove extra cards/actions absent from the reference.
- [ ] Verify date selection, resume/start and routine navigation.

### Stage 3 — Live workout
- [ ] Match toolbar, timer, pause and finish actions.
- [ ] Match compact duration/volume/set totals strip.
- [ ] Match collapsed exercise headers, muscle labels, status counts and optional controls.
- [ ] Match shared set-table header and reference columns while preserving supported workout data.
- [ ] Match bottom rest dock and timer controls.
- [ ] Verify add/edit/complete sets, add exercise, notes, expansion, rest and finish flows.

### Stage 4 — Exercise library
- [ ] Match search and muscle filter chips.
- [ ] Match Name / Muscle / 1RM table and compact row density.
- [ ] Match custom exercise entry and empty/search states.
- [ ] Keep richer library features outside the reference Minimal surface where needed.

### Stage 5 — Exercise details and per-exercise statistics
- [ ] Show all reference metrics: last done, last sets, first done, sessions, total sets, total reps, total volume, heaviest set, best 1RM and last PR.
- [ ] Match 4W / 8W / 12W / All range controls and previous/next navigation.
- [ ] Add estimated 1RM trend and volume-per-session charts.
- [ ] Match PR history and every-session table.
- [ ] Verify metric calculations and chart ranges against stored workout data.

### Stage 6 — History
- [ ] Match List / Table switch and Excel export.
- [ ] Match latest-40 expandable workout list.
- [ ] Match 8-column table, search, sorting, 200-row bound and result count.
- [ ] Remove calendar/month-summary presentation from the reference Minimal history surface.
- [ ] Verify export contents and table interactions.

### Stage 7 — Stats dashboard
- [ ] Match weekly volume and historical range navigation.
- [ ] Match selected-exercise 1RM trend and summary values.
- [ ] Add days-since-last-PR chart.
- [ ] Match 16-week training heatmap.
- [ ] Match muscle sets in the last 30 days.
- [ ] Verify chart values and range changes.

### Stage 8 — Settings
- [ ] Match the single reference Settings page.
- [ ] Match Minimal toggle, text size and row-height options.
- [ ] Match previous column, How-to, Notes, icons, totals strip and header-button toggles.
- [ ] Match rest-timer adjustments, Excel export, JSON backup and offline/local-data message.
- [ ] Keep settings persistent and Standard mode settings working.

### Stage 9 — Behaviour, persistence and export parity
- [ ] Verify timers, pause/resume, volume, set counts, 1RM and PR calculations.
- [ ] Verify range selectors, sorting, filtering and navigation state.
- [ ] Verify settings and workout data persist across app restarts.
- [ ] Verify Excel and JSON exports contain expected data.
- [ ] Resolve behaviour mismatches found against the HTML prototype.

### Stage 10 — Visual and functional QA
- [ ] Compare each Minimal screen against `Sample.html` at a matching phone viewport.
- [ ] Check typography, spacing, colors, borders, row heights, charts and navigation.
- [ ] Test all visible controls and key workout flows.
- [ ] Run Flutter analysis and full test suite.
- [ ] Build and install the final single APK; verify Standard-mode regression safety.
- [ ] Publish final verified APK to GitHub Releases.

## Release pipeline status

- [x] Build one APK instead of ABI-split APKs.
- [x] Run analysis and tests before APK build.
- [x] Upload one `GymMinimal.apk` Actions artifact.
- [ ] Publish the same tested artifact to the rolling GitHub Release successfully.
- [ ] Verify release page contains exactly one APK asset.

**Signing diagnosis:** The previous release job tried to read a keystore from empty repository secrets and failed with `KeytoolException: Tag number over 30 is not supported`. This follow-up publishes the exact APK artifact from the successful build job instead of rebuilding and attempting a second signed APK. The APK uses the build job's default debug signing when no private release key is configured. For seamless in-place upgrades across separate CI runs, configure a persistent private release keystore and its repository Actions secrets before switching to release signing.

## Change log

| Date | Change |
|---|---|
| 2026-11-13 | Baseline comparison and staged parity roadmap established. |
| 2026-11-13 | PR #8 merged: Minimal-only shell/navigation parity and one-APK build workflow. |
| 2026-11-14 | Release failure traced to empty signing secrets; follow-up workflow fix and tracker added. |
