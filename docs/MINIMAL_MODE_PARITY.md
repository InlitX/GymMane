# Minimal Mode — Sample.html Parity Roadmap

> **Start here for takeover context:** [Complete Project Handoff](MINIMAL_MODE_HANDOFF.md). It explains the product goal, authoritative reference boundary, native code map, exact screen requirements, per-stage implementation contracts, testing, APK release and how to resume from any stage.

**Scope:** Native Android Minimal Mode only. The target is the phone UI inside `#app` in the root `Sample.html`. The browser/demo frame and the prototype's rough Standard-mode mockup are not targets. Standard mode must remain unchanged and fully functional.

**Working method:** One focused stage per branch and pull request. Reuse real Flutter state/models/services; do not copy the HTML prototype's sample data or browser implementation. Run Flutter analysis, relevant tests and the one-APK build on every PR. Only mark a stage complete after its UI and interactions have been checked against the HTML reference. A successful merge to `main` should publish the same tested `GymMinimal.apk` artifact to the rolling GitHub preview release.

**Snapshot:** 2026-11-14. PR #9 merged Stage 2 (Today) at `f0ed1cf4a5626ee0806cd7bee87c225d361439f9`. PR #10 then merged the conflict-resolved handoff and roadmap as `7fbc49522965e638a110e9988c4fe53b29a11301`; its updated Actions run #43510832870 passed. Stage 3 is now being implemented in PR #11 on `feature/sample-html-parity-stage-3-live-workout`. Its CI and phone-viewport/manual review are still required before Stage 3 can be marked complete.

## Overall progress

- [x] Stage 0 — Reference specification and baseline
- [x] Stage 1 — Minimal shell and navigation
- [x] Stage 2 — Today screen
- [ ] Stage 3 — Live workout
- [ ] Stage 4 — Exercise library
- [ ] Stage 5 — Exercise details and per-exercise statistics
- [ ] Stage 6 — History
- [ ] Stage 7 — Stats dashboard
- [ ] Stage 8 — Settings
- [ ] Stage 9 — Behaviour, persistence and export parity
- [ ] Stage 10 — Visual and functional QA

**Progress: 3 of 11 stages implemented and merged (27%).** Eight stages remain. Final cross-screen visual verification is consolidated in Stage 10.

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

### Stage 2 — Today screen — COMPLETE (PR #9 merged)

**Primary source:** `lib/screens/home_screen.dart` → `HomeScreen._minimalHome`.  
**Reference:** `Sample.html` → `today()`, `weekStrip()`.

- [x] Match the Today header/date and compact seven-day Monday–Sunday training strip.
- [x] Mark the current day and days containing logged workouts.
- [x] Match the active-workout Resume action and the empty-workout Start action.
- [x] Match compact routine rows with an expand/collapse exercise list and direct Start action.
- [x] Match the compact last-workout summary using real history; show a clean empty state.
- [x] Keep all home-screen changes inside the Minimal branch; Standard home remains on its existing path.
- [x] PR #9 merged on 2026-11-13 (merge commit `f0ed1cf4a5626ee0806cd7bee87c225d361439f9`).
- [x] PR Actions run #43506289411 passed analysis, tests, one-APK build and artifact upload.
- [ ] Include the final phone-viewport screenshot/manual parity check in the consolidated Stage 10 QA pass.

**Implementation is merged. Stage 3 is the next implementation stage; the remaining Today screenshot check is tracked with final visual QA in Stage 10.**

### Stage 3 — Live workout — IN PROGRESS (PR #11)

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

The authoritative workflow is the version already merged to `main` by PR #9: `.github/workflows/build-apk.yml`.

- [x] Build one APK (no ABI split) named `GymMinimal.apk`.
- [x] Run Flutter analysis and tests before the APK build.
- [x] Upload one `gymminimal-apk` Actions artifact on PR builds.
- [x] On a push to `main` or manual workflow dispatch, publish the APK produced by that same workflow job; do not run a second Flutter build.
- [x] Main-branch run #43508196293 completed successfully, including the release-publishing steps.
- [x] Verified the rolling GitHub Release contains exactly one APK asset named `GymMinimal.apk`.

**Pipeline design:** the build, test, artifact upload and conditional Release publishing steps are in one job. Release steps run only for main pushes or workflow dispatch; PR runs stop after uploading the artifact. This is the newer `main` implementation and is intentionally retained when resolving PR #10.

**Verified release:** [GymMinimal — Minimal Mode preview](https://github.com/HackerXMindset/GymMinimal/releases/tag/minimal-mode-preview). The asset list contained exactly one APK: `GymMinimal.apk`.

**Signing caveat:** no persistent private release keystore is currently established. Do not promise seamless in-place upgrades across separately built CI APKs until a stable private signing key is configured and tested. Never commit signing credentials.

## Current PR / branch snapshot

| Item | Value |
|---|---|
| PR #8 | Merged — Minimal shell/navigation |
| PR #9 | Merged — Stage 2 Today screen and single-APK workflow |
| PR #10 | Merged — conflict-resolved project handoff/roadmap documentation |
| PR #10 merge commit | `7fbc49522965e638a110e9988c4fe53b29a11301` |
| PR #10 Actions | Run #43510832870 passed; the newer single-job APK workflow was preserved |
| Current UI stage | Stage 3 — Live workout (in progress) |
| Stage 3 branch | `feature/sample-html-parity-stage-3-live-workout` |
| Stage 3 PR | [PR #11](https://github.com/HackerXMindset/GymMinimal/pull/11) |
| Stage 3 base | `main` at PR #10 merge commit `7fbc49522965e638a110e9988c4fe53b29a11301` (rebased before this update) |
| Stage 3 CI | Check the latest PR #11 Actions run; do not mark this stage complete until analysis, tests and the single-APK build pass |
| Remaining proof | Phone-sized screenshot/manual interaction review and Standard-mode regression review |
| Next action | Complete the PR #11 CI gate and review the Minimal workout UI; fix every failure before merging and starting Stage 4 |

## Change log

| Date | Change |
|---|---|
| 2026-11-13 | Baseline comparison and staged parity roadmap established. |
| 2026-11-13 | PR #8 merged: Minimal-only shell/navigation parity. |
| 2026-11-14 | PR #10 created: single tested APK release pipeline and roadmap. |
| 2026-11-14 | Expanded handoff guide: source hierarchy, code map, all screen contracts, test/release process and takeover record. |
| 2026-11-14 | PR #9 merged Stage 2 Today and the single-job APK release workflow; Actions run #43506289411 passed. |
| 2026-11-14 | PR #10 conflict resolved and merged as `7fbc49522965e638a110e9988c4fe53b29a11301`; updated PR Actions run #43510832870 passed. |
| 2026-11-14 | Started Stage 3 Live workout in PR #11; compact Minimal toolbar/table/groups/rest dock and discard regression test added. CI and phone review pending. |
| 2026-11-14 | Main run #43508196293 passed and published the rolling release with exactly one `GymMinimal.apk` asset. |

## How to continue

1. Read [Complete Project Handoff](MINIMAL_MODE_HANDOFF.md).
2. PR #10 is merged; its latest PR Actions run #43510832870 passed.
3. Continue Stage 3 in [PR #11](https://github.com/HackerXMindset/GymMinimal/pull/11), keeping later stages in separate PRs.
4. Start Stage 4 only after Stage 3's CI, interaction tests and visual review pass and its PR is merged.
