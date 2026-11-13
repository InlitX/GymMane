# Minimal Mode — Sample.html Parity Roadmap

> **Start here for takeover context:** [Complete Project Handoff](MINIMAL_MODE_HANDOFF.md). It explains the product goal, authoritative reference boundary, native code map, exact screen requirements, per-stage implementation contracts, testing, APK release and how to resume from any stage.

**Scope:** Native Android Minimal Mode only. The target is the phone UI inside `#app` in the root `Sample.html`. The browser/demo frame and the prototype's rough Standard-mode mockup are not targets. Standard mode must remain unchanged and fully functional.

**Working method:** One focused stage per branch and pull request. Reuse real Flutter state/models/services; do not copy the HTML prototype's sample data or browser implementation. Run Flutter analysis, relevant tests and the one-APK build on every PR. Only mark a stage complete after its UI and interactions have been checked against the HTML reference. A successful merge to `main` should publish the same tested `GymMinimal.apk` artifact to the rolling GitHub preview release.

**Snapshot:** 2026-11-14. PR #10 is open at the time this handoff was prepared; its `Analyze, test and build one APK` check was still in progress. Verify live PR and Actions status before branching or changing status.

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

**Progress: 2 of 11 stages complete (18%).** Nine stages remain. Release automation is tracked separately and is not counted as a UI stage.

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

**Primary source:** `lib/screens/home_screen.dart` → `HomeScreen._minimalHome`.  
**Reference:** `Sample.html` → `today()`, `weekStrip()`.

- [ ] Match Today header/date and seven-day Monday–Sunday strip, including trained-day marks and today's highlight.
- [ ] Match active-workout Resume state and empty Start workout action.
- [ ] Match compact routine rows, exercise count, scheduled day, expand/collapse and Start action.
- [ ] Match last-workout summary using real history; handle no history.
- [ ] Remove or relocate extra cards/actions from the Minimal home surface without deleting Standard features.
- [ ] Verify routine starts, active-session resume, empty states and Standard home regression.
- [ ] Add tests and attach a phone screenshot/manual comparison.

### Stage 3 — Live workout

**Primary source:** `lib/screens/session_screen.dart`, active-session Minimal branch.  
**Reference:** `Sample.html` → `workoutMin()`, `groupHtml()`, `setRow()`, `noteRow()`, `restHtml()`.

- [ ] Match compact toolbar, active timer, pause/resume and Finish actions.
- [ ] Match optional duration/volume/completed-total set strip.
- [ ] Match one shared set-table header: set number/type, optional Previous, Kg, Reps, Done.
- [ ] Match compact, collapsible exercise headers with muscle and completed/total count.
- [ ] Match optional How-to, Notes, Add Set, More/Remove and searchable Add Exercise flow.
- [ ] Match bottom rest dock with countdown, −15, +15 and Skip.
- [ ] Preserve existing session model fields and supported set types; do not flatten underlying workout data.
- [ ] Verify edit/copy/complete set, add/remove exercise, note, pause/resume, rest, finish, discard and restore flows.
- [ ] Test narrow phone width, optional Previous column and Standard workout regression.

### Stage 4 — Exercise library

**Primary source:** `lib/screens/exercises_screen.dart`.  
**Reference:** `Sample.html` → `exercises()`, `exList()`.

- [ ] Match search and All/muscle filter chips.
- [ ] Match compact Name / Muscle / 1RM table header and aligned rows.
- [ ] Calculate best 1RM from real history; show an empty marker where no value exists.
- [ ] Match custom exercise action and no-match state.
- [ ] Verify search, filters, custom creation, navigation and Standard library regression.

### Stage 5 — Exercise details and per-exercise statistics

**Primary source:** `lib/screens/exercise_detail_screen.dart`.  
**Reference:** `Sample.html` → `exercise()`, `rangeBar()`, `exSessions()`, `lineChart()`, `barsSvg()`.

- [ ] Show all ten reference metrics: last done, last sets, first done, sessions, total sets, total reps, total volume, heaviest set, best estimated 1RM and last PR.
- [ ] Match 4W / 8W / 12W / All range controls with earlier/later navigation.
- [ ] Add estimated 1RM trend and volume-per-session charts.
- [ ] Match PR history and every-session table.
- [ ] Verify calculations against real sets, including warm-up rules, empty history, one session and ties.
- [ ] Verify back navigation returns to the originating screen where appropriate.

### Stage 6 — History

**Primary source:** `lib/screens/history_screen.dart`; export service `lib/services/workout_history_xlsx.dart`.  
**Reference:** `Sample.html` → `history()`, `tableBody()`, `flat()`.

- [ ] Match List / Table switch and Excel export.
- [ ] Match latest-40 expandable workout list, newest first.
- [ ] Match eight-column table: Date / Exercise / Set / Kg / Reps / Volume / 1RM / Muscle.
- [ ] Add search by exercise, muscle or date; sortable columns and active sort direction.
- [ ] Bound rendered rows to 200 and report the real result count.
- [ ] Verify exports, no-history and no-match states; keep Standard history unchanged.

### Stage 7 — Stats dashboard

**Primary source:** `lib/screens/progress_screen.dart`, `lib/state/stats_state.dart`, `lib/widgets/charts.dart`.  
**Reference:** `Sample.html` → `stats()`, `volChart()`, `lineChart()`, `prBars()`, `heat()`, `muscleBars()`.

- [ ] Match weekly volume chart and date-range navigation.
- [ ] Match selected-exercise estimated 1RM trend and best / last PR / sessions context.
- [ ] Add days-since-last-PR chart.
- [ ] Match 16-week training heatmap.
- [ ] Match sets per muscle over the last 30 days.
- [ ] Verify real-data calculations, range changes and empty/sparse data states.

### Stage 8 — Settings

**Primary source:** `lib/screens/settings_screen.dart`, `lib/state/settings_state.dart`.  
**Reference:** `Sample.html` → `settings()`.

- [ ] Match the single compact Minimal Settings page.
- [ ] Match Minimal toggle, text size and row-height controls.
- [ ] Match Previous, How-to, Notes, exercise icons, totals strip and workout-header Settings toggles.
- [ ] Match rest timer adjustment, Excel export, JSON backup and offline/local-data message.
- [ ] Reuse existing persisted Minimal settings fields; do not introduce duplicate prototype/localStorage settings.
- [ ] Verify persistence and Standard preference regression.

### Stage 9 — Behaviour, persistence and export parity

- [ ] Verify full workout journey: start → edit/complete sets → rest → pause/resume → finish → history → exercise detail → stats.
- [ ] Verify active workout restoration after app restart.
- [ ] Verify all Minimal settings persist and affect the correct controls.
- [ ] Verify Excel and JSON exports contain real expected data and supported restore paths work.
- [ ] Verify volume, set counts, 1RM and PR definitions agree across screens.
- [ ] Resolve integration issues and add regression tests.

### Stage 10 — Visual and functional QA

- [ ] Compare each Minimal screen with the corresponding `Sample.html` state at a comparable phone viewport.
- [ ] Check typography, spacing, palette, border, row height, shared table alignment, chart layout and bottom navigation.
- [ ] Exercise every visible button, toggle, tab, filter, timer and export action.
- [ ] Test empty/sparse/large data, long exercise names, small phone width and increased system text size.
- [ ] Switch between Minimal and Standard throughout testing; confirm data is preserved and Standard remains functional.
- [ ] Run formatting, Flutter analysis and the full test suite.
- [ ] Build/install the final single APK and verify launch.
- [ ] Verify the GitHub Release contains exactly one `GymMinimal.apk` asset.

## Native code map

| Destination | Route | Main UI |
|---|---|---|
| Today | `home` | `lib/screens/home_screen.dart` → `_minimalHome` |
| Exercises | `exercises` | `lib/screens/exercises_screen.dart` |
| History | `history` | `lib/screens/history_screen.dart` |
| Stats | `progress` | `lib/screens/progress_screen.dart` → `_MinimalProgressScreen` |
| Settings | `preferences` | `lib/screens/settings_screen.dart` |
| Active workout | `session` | `lib/screens/session_screen.dart` |
| Exercise details | `exercise-detail` | `lib/screens/exercise_detail_screen.dart` |

- App routing/navigation: `lib/app/app_shell.dart`.
- Global state: `lib/state/fit_state.dart` and its state part files.
- Preferences: `lib/state/settings_state.dart`.
- Workout models: `lib/models/live_session.dart`, `lib/models/workout.dart`.
- Persistence: `lib/services/local_store.dart`.
- Excel history export: `lib/services/workout_history_xlsx.dart`.
- Shared theme: `lib/theme/app_colors.dart`, `lib/theme/app_theme.dart`.
- Tests: `test/`; start with the existing test closest to the feature being changed.

## Per-PR quality gate

- [ ] One stage/topic per branch and PR.
- [ ] Dart formatting applied to changed Dart files.
- [ ] `flutter analyze --no-fatal-infos` passes.
- [ ] Relevant focused tests pass.
- [ ] Full `flutter test` suite passes.
- [ ] Workflow builds exactly one APK (no ABI split).
- [ ] Minimal phone screenshot/manual interaction review attached.
- [ ] Standard Mode regression checked.
- [ ] Handoff and roadmap statuses updated truthfully.

## Release pipeline status

PR #10 updates `.github/workflows/build-apk.yml` to:
- Run analyze and tests before building one APK.
- Rename the output to `GymMinimal.apk`.
- Upload one `gymminimal-apk` artifact.
- On main push, download and publish that same tested artifact instead of doing a second build.

**Snapshot status:** PR #10 was open and its build check was in progress when this roadmap was expanded. Treat the following as implemented-in-PR, not yet fully verified on main:
- [x] Workflow definition builds one APK rather than ABI-split APKs.
- [x] Workflow definition runs analysis/tests before the APK build.
- [x] Workflow definition uploads one named APK artifact.
- [ ] PR #10 CI completes successfully and the PR is merged.
- [ ] A main-branch release run successfully publishes the same artifact.
- [ ] Release page is verified to contain exactly one APK asset.

**Signing diagnosis:** The previous release job attempted to read a keystore from empty GitHub Actions secrets and failed with `KeytoolException: Tag number over 30 is not supported`. PR #10 removes the second release-time build and publishes the build job's exact APK artifact. Without a persistent private release keystore, CI falls back to debug signing. The APK is installable, but separate CI runs may have different debug certificates, so an update over an existing installation may require uninstalling the old APK first. Configure a persistent private keystore and Actions secrets before relying on seamless in-place upgrades. Never commit signing credentials.

## Current PR / branch snapshot

| Item | Value |
|---|---|
| PR #8 | Merged — Minimal shell/navigation |
| PR #10 | Open at snapshot time — workflow + roadmap + handoff guide |
| PR #10 branch | `fix/single-apk-release-and-parity-roadmap` |
| PR #10 head at snapshot | `496af390d04be4f0a37491c161e849fda2b1372f` (the handoff-doc commit will advance this) |
| Next UI stage | Stage 2 — Today |
| Next action | Check PR #10 CI and merge it before starting Stage 2 from updated main |

## Change log

| Date | Change |
|---|---|
| 2026-11-13 | Baseline comparison and staged parity roadmap established. |
| 2026-11-13 | PR #8 merged: Minimal-only shell/navigation parity. |
| 2026-11-14 | PR #10 created: single tested APK release pipeline and roadmap. |
| 2026-11-14 | Expanded handoff guide: source hierarchy, code map, all screen contracts, test/release process and takeover record. |

## How to continue

1. Read [Complete Project Handoff](MINIMAL_MODE_HANDOFF.md).
2. Verify the live status of PR #10 and its Actions check.
3. Once PR #10 is merged, branch from the updated `main` for Stage 2.
4. Do not start Stage 3 until Stage 2 has met its acceptance criteria and is merged.
