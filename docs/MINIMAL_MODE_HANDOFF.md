# Minimal Mode — Complete Project Handoff

> **Purpose of this file:** A developer or AI agent should be able to open this repository, start at any unfinished stage, and continue without needing the original conversation or verbal explanations.
>
> **Read this first:** [Minimal Mode parity roadmap](MINIMAL_MODE_PARITY.md). This guide supplies the context and implementation rules behind that checklist.

**Snapshot date:** 2026-11-14  
**Repository:** `HackerXMindset/GymMinimal`  
**Latest merged baseline:** PR #10 documentation/conflict-resolution merge commit `7fbc49522965e638a110e9988c4fe53b29a11301`.  
**Latest merged UI stage:** Stage 2 — Today screen (PR #9, merged).  
**Current UI stage:** Stage 3 — Live workout (in progress; PR #11).  
**Progress at this snapshot:** Stages 0, 1 and 2 are implemented and merged; 8 of 11 total stages remain.  
**Verified Stage 2 CI:** Actions run #43506289411 passed analysis, tests, one-APK build and artifact upload.  
**Verified release:** main run #43508196293 succeeded; the rolling preview release contains exactly one `GymMinimal.apk`.

---

## 1. Product goal — what is being built

Implement the **Minimal Mode phone experience as native Flutter UI**, matching the Minimal design and behavior shown inside the `#app` element in the root `Sample.html`.

The required Minimal experience has five top-level destinations:

1. Today
2. Exercises
3. History
4. Stats
5. Settings

It also has supporting screens/flows for a live workout and individual exercise details.

The intended result is not a new app, a web page, or an HTML wrapper. It is the existing GymMane Flutter application with a polished, coherent Minimal Mode. Users must be able to switch between Minimal and Standard modes without losing data or breaking either experience.

### Non-negotiable requirements

- **Minimal Mode only:** visual changes in these stages must be scoped to Minimal Mode. Do not redesign Standard Mode.
- **Native Flutter:** do not use WebView, HTML rendering, or a web prototype as the app UI. Implement with the existing Flutter widgets, state and services.
- **Preserve the real app:** use real exercise, routine, workout, history and statistics data. Do not replace the app with the prototype's hard-coded sample records.
- **Preserve existing capabilities:** prefer hiding, simplifying or moving advanced UI out of the Minimal primary surface over deleting working app functionality or changing its stored data.
- **Offline/local-first:** retain the app's existing offline and local-data behavior. Do not add accounts, analytics, a remote backend, network permission or a dependency on a paid API.
- **One APK:** build one installable APK, not one APK per ABI. The intended asset name is `GymMinimal.apk`.
- **Stage-based delivery:** one focused stage per branch/PR. Do not combine unrelated screen stages.
- **Tests and evidence:** each stage needs relevant tests, a successful project CI build, and visual/interaction verification before it can be marked complete.
- **Keep the handoff current:** update the roadmap and the stage handoff record whenever implementation status changes.

## 2. Source-of-truth hierarchy

When two sources appear to disagree, use this order:

1. **Current app behavior/data model:** the current Flutter code, existing state methods and persistence contracts. Preserve valid existing behavior.
2. **Minimal appearance and interaction target:** the phone UI inside `#app` in root `Sample.html`.
3. **This handoff guide:** context, intent, constraints and recommended implementation locations.
4. **The roadmap:** current stage status, acceptance checklist and PR history.

The guide is not permission to ignore the actual code. Before editing a file, read its current implementation on the branch being changed. File names and line numbers can move.

### What exactly in Sample.html is the target?

Target only the phone app content rendered inside:

```html
<div id="app"></div>
```

Do **not** reproduce the surrounding prototype presentation:
- Browser/demo page header or its explanatory paragraph.
- Standard/Minimal selector outside the phone.
- Side screen-description rail.
- Device/browser frame and outer page background.
- Summary/footer outside the phone.
- Prototype's rough Standard Mode mockup.

The prototype intentionally uses made-up exercise names, workout numbers, routines and history. These are fixtures to demonstrate layout, not the app's initial data or a data-import specification.

The prototype's script also seeds an active sample workout and starts on the Workout screen so the workout design is visible when the standalone file opens. **That is a preview fixture, not a requirement that the actual app launch into a workout.** The app's regular Today/home behavior must remain intact.

### Use the prototype correctly

- Read the relevant function and surrounding CSS in `Sample.html` before implementing a screen.
- Use the markup/functions to understand order, labels, controls, empty states and intended interactions.
- Use the CSS variables and classes to understand spacing, typography, colors and density.
- Translate the behavior to native Flutter and real `fit` state.
- Do not copy browser-only implementation details such as `localStorage`, DOM event delegation, JavaScript-generated data, or its in-memory sample model into Flutter.
- If a prototype control is marked as a demo-only placeholder (for example, a `soon` action), do not invent a new product feature. Use the existing app's real equivalent where one exists; otherwise document the mismatch and keep behavior safe.

## 3. Design specification

The reference's principal Minimal palette is:

| Token | Value |
|---|---|
| Page background | `#0E0E0D` |
| Main surface | `#141413` |
| Raised surface | `#1B1B1A` |
| Card surface | `#222221` |
| Border/line | `#2C2C2A` |
| Primary text | `#E9E7E2` |
| Secondary text | `#8D8A84` |
| Tertiary/dim text | `#5F5D58` |
| Accent | `#C8A45F` |

Additional reference density values:
- Text-size choices: Normal 12.5 px, Small 11.5 px, Tiny 10.5 px.
- Row-height choices: Roomy 26 px, Compact 22 px, Tight 18 px.
- Minimal surfaces are flat and compact; reference corners are generally 4 px rather than the large rounded cards used in Standard Mode.
- Workout rows should align as a shared table rather than independent, widely spaced cards.
- Keep the five-item bottom navigation visually restrained and fixed to the bottom.

These are reference CSS values, not an instruction to ignore Flutter logical pixels, device scaling, safe areas or accessible tap targets. Match the appearance on a phone viewport while keeping controls usable.

The app already has a Minimal palette helper and Minimal styling branches in the shell/screens. Reuse or consolidate them rather than adding competing color systems. Check `lib/app/app_shell.dart`, `lib/theme/app_colors.dart`, `lib/theme/app_theme.dart` and existing Minimal branches before introducing new tokens.

## 4. How the native app is structured

This is an existing, feature-rich Flutter app. The main folders are:

| Path | Responsibility |
|---|---|
| `lib/main.dart` | Startup, local store initialization, services and app launch |
| `lib/app/gymmane_app.dart` | MaterialApp, themes, localization and root widget |
| `lib/app/app_shell.dart` | Route selection, screen hosting, app shell and bottom navigation |
| `lib/screens/` | Screen-level UI |
| `lib/models/` | Workout, exercise, routine and other data models |
| `lib/state/` | Global app state, split into feature mixins/part files |
| `lib/services/` | Local persistence, exports, alarms, timers, backup and integrations |
| `lib/theme/` | Shared colors and typography |
| `lib/widgets/` | Reusable UI components |
| `lib/catalog/` | Exercise catalogue and related data |
| `test/` | Flutter unit and widget tests |

### Key state architecture

- `lib/state/fit_state.dart` defines `FitState` and the global `fit` instance. It combines state parts using Dart `part` files.
- Relevant state parts include `settings_state.dart`, `workout_state.dart`, `routines_state.dart` and `stats_state.dart`.
- UI should call existing `fit` methods/getters for actions and derived values. Do not duplicate state in a screen when the app already owns that state.
- Session state is represented by the models in `lib/models/live_session.dart`; completed workout/history data is represented in `lib/models/workout.dart`.
- `lib/services/local_store.dart` is the persistence boundary. Preserve existing serialization and backup compatibility when changing models or settings.
- User-visible text must use the localization system (`t.<key>`) and the corresponding ARB translation entries. Do not hard-code visible strings in a widget.

### Existing route and screen map

The Minimal bottom navigation is implemented by `_MinimalNavBar` in `lib/app/app_shell.dart`. It maps the five destinations to existing routes:

| Minimal destination | Route | Native screen / entry point |
|---|---|---|
| Today | `home` | `lib/screens/home_screen.dart` → `HomeScreen._minimalHome` |
| Exercises | `exercises` | `lib/screens/exercises_screen.dart` |
| History | `history` | `lib/screens/history_screen.dart` → Minimal history branch |
| Stats | `progress` | `lib/screens/progress_screen.dart` → `_MinimalProgressScreen` |
| Settings | `preferences` | `lib/screens/settings_screen.dart` → existing preferences and Minimal options |

Supporting routes:

| Flow | Route / source |
|---|---|
| Active workout | `session` → `lib/screens/session_screen.dart` → Minimal active-session branch |
| Exercise detail | `exercise-detail` → `lib/screens/exercise_detail_screen.dart` |
| Routines | Existing routines route and `lib/screens/routines_screen.dart` |
| Start workout | Existing start flow in `lib/screens/start_sheet.dart` and `FitState` workout methods |

The exact route helper names are in `_MinimalNavBar` and the relevant state parts. Read them before changing navigation. Do not create parallel navigation state just for Minimal Mode.

### Most relevant implementation files by stage

| Stage | Start by reading | Related state/model/service/test locations |
|---|---|---|
| 2 — Today | `lib/screens/home_screen.dart` (`_minimalHome`) | `lib/state/routines_state.dart`, `lib/state/workout_state.dart`, `lib/models/workout.dart`, `test/home_test.dart` |
| 3 — Live workout | `lib/screens/session_screen.dart` | `lib/models/live_session.dart`, `lib/state/workout_state.dart`, rest alarm/services, `test/session_test.dart`, `test/workout_session_test.dart`, `test/workout_flow_test.dart` |
| 4 — Exercise library | `lib/screens/exercises_screen.dart` | `lib/state/fit_state.dart` and library state part, exercise catalogue/models, `test/exercise_library_test.dart`, `test/custom_exercises_test.dart` |
| 5 — Exercise detail | `lib/screens/exercise_detail_screen.dart` | `lib/models/workout.dart`, stats/library state, history and records tests |
| 6 — History | `lib/screens/history_screen.dart` | `lib/models/workout.dart`, `lib/services/workout_history_xlsx.dart`, stats state, `test/history_test.dart`, `test/workout_history_xlsx_test.dart` |
| 7 — Stats | `lib/screens/progress_screen.dart` | `lib/state/stats_state.dart`, `lib/widgets/charts.dart`, records/stats tests |
| 8 — Settings | `lib/screens/settings_screen.dart` | `lib/state/settings_state.dart`, `lib/services/local_store.dart`, `test/settings_test.dart`, `test/persistence_test.dart` |
| 9 — Persistence/export | Relevant screens only after tracing the action | `lib/services/local_store.dart`, backup/export services and their tests |
| 10 — QA | All Minimal branches above | Full `test/` suite and GitHub Actions workflow |

This is an orientation map, not a restriction: follow actual call sites and tests when a feature crosses files.

## 5. Reference screen requirements

The following is the functional target from the phone UI in `Sample.html`. It is deliberately expressed in app terms so each stage can be built independently.

### Today

Reference function: `today()`; week indicator helper: `weekStrip()`.

- Header says Today and shows the current date.
- A seven-day Monday–Sunday strip shows trained days and distinguishes the current day.
- When a workout is active, show a clear Resume workout action and elapsed time.
- Always provide Start empty workout when no workout is active.
- Show routines as compact rows with name, exercise count, scheduled day and a Start action. Tapping the row expands/collapses its exercise list.
- Show a compact last-workout summary when history exists.
- Avoid adding unrelated cards, body-map widgets, suggestions or oversized hero sections to this Minimal surface unless the user explicitly changes the reference.
- Use real routines, sessions and live-session state. An empty-history state must not crash or display fabricated history.

### Live workout

Reference functions: `workoutMin()`, `groupHtml()`, `setRow()`, `noteRow()`, `restHtml()`.

- Compact top toolbar: Back, active indicator/timer, optional Settings, Pause/Resume and Finish.
- Optional compact totals strip: duration, volume and completed/total sets.
- One shared set-table header above the exercise groups. Columns are set number/type, optional Previous, Kg, Reps and completion.
- Each exercise is a compact collapsible group with exercise name, muscle, completed/total count when collapsed, and a small chevron.
- Exercise controls include optional How-to, Notes, Add Set and More/Remove or the existing equivalent.
- When expanded, its sets align beneath the shared header. Completed rows have a restrained completed state.
- Keep the exercise picker searchable and usable; do not replace the app's catalogue or custom exercises.
- A rest dock appears when rest is active, with remaining time, −15, +15 and Skip.
- Support pause/resume, editing weight/reps, previous-set copy, set type, completion, add/remove exercise, notes, rest controls, finish and discard using existing app logic.
- Preserve existing workout types and capabilities that the simpler reference does not illustrate. A screen-density change must not silently corrupt or flatten the underlying model.

### Exercises

Reference functions: `exercises()`, `exList()`.

- Header and Custom action.
- Search field.
- Muscle filter chips including All.
- Compact table header: Name / Muscle / 1RM.
- Selecting an exercise opens its detail page.
- Show a meaningful empty state for no matches.
- Use the real catalogue and calculated best 1RM where available; show a dash when no history exists. Never invent a 1RM.

### Exercise detail and per-exercise statistics

Reference function: `exercise()`.

Display these ten metrics, calculated from actual history:
1. Last done
2. Last sets
3. First done
4. Sessions
5. Total sets
6. Total reps
7. Total volume
8. Heaviest set
9. Best estimated 1RM
10. Last PR

Then show:
- Range selection: 4W / 8W / 12W / All.
- Earlier/later navigation when a bounded range is selected.
- Estimated 1RM trend chart.
- Volume-per-session chart.
- PR history.
- Every-session table.

Be explicit about which set kinds count in each metric. Follow the app's established warm-up/working-set and 1RM rules; do not invent a competing formula. Handle zero sessions, one session, equal-value PRs, empty charts and missing historical data.

### History

Reference functions: `history()`, `tableBody()`, `flat()`.

- List / Table switch and Excel export.
- List view shows the latest 40 sessions, newest first, with expandable exercise/set detail.
- Table view has eight columns: Date, Exercise, Set, Kg, Reps, Volume, 1RM, Muscle.
- Search table rows by exercise, muscle or date.
- Sort by each column and show the active sort direction.
- Cap rendered results at 200 and clearly show the total/result count when more exist.
- Include useful empty states.
- Export actual history; preserve the existing workbook/export implementation and data conventions.

### Stats

Reference functions: `stats()`, `volChart()`, `lineChart()`, `prBars()`, `heat()`, `muscleBars()`.

- Weekly training volume chart and historical range controls.
- Select an exercise for its estimated 1RM trend.
- Show meaningful best / last PR / sessions context.
- Days since last PR chart.
- 16-week training-day heatmap.
- Sets per muscle in the last 30 days.
- All values must be computed from real logged sessions and sets. Charts need useful empty/one-data-point states and must not fabricate observations.

### Settings

Reference function: `settings()`.

The reference presents a single compact Settings page. It contains:
- Minimal view toggle.
- Text size: Normal / Small / Tiny.
- Row height: Roomy / Compact / Tight.
- Previous column toggle.
- How-to button toggle.
- Notes toggle.
- Exercise icons toggle.
- Totals strip toggle.
- Settings button in the live-workout header toggle.
- Rest timer adjustment in 15-second increments.
- Excel (.xlsx) export.
- JSON backup.
- Clear offline/local-data statement.

The current app already has persisted Minimal preferences in `lib/state/settings_state.dart`: `minimalMode`, `minimalTextSize`, `minimalRowHeight`, `minimalShowPrevious`, `minimalShowHowTo`, `minimalShowNotes`, `minimalShowExerciseIcons`, `minimalShowTotals` and `minimalShowSettingsButton`. Use `setMinimalMode` and `updateMinimalOptions` (verify current signatures) instead of introducing duplicate preference keys. The prototype's names and storage keys are not the Flutter persistence contract.

## 6. Stage-by-stage implementation contract

Each stage is independently actionable. A stage is not complete merely because the screen compiles or looks close in one screenshot.

### Stage 0 — Reference specification and baseline — COMPLETE

Purpose: establish the reference boundary, screen inventory, design tokens and Standard Mode exclusion.

Evidence already recorded in the roadmap. Re-open `Sample.html` whenever a later change touches an undocumented control or visual behavior.

### Stage 1 — Minimal shell and navigation — COMPLETE

Purpose: establish the five-item Minimal bottom navigation, Minimal palette/shell and route selection while leaving Standard navigation intact.

PR #8 is recorded as merged in the roadmap. Do not redo the shell without a demonstrated regression or a specific reference mismatch. When changing routes later, test both Minimal and Standard navigation.

### Stage 2 — Today screen — COMPLETE (PR #9 merged)

**Primary file:** `lib/screens/home_screen.dart`, method `_minimalHome`.  
**Reference:** `Sample.html` → `today()`, `weekStrip()`.

**Merged implementation**
- Replaced the seven full date cards with the compact Monday–Sunday training strip.
- Highlighted the current day and marked days with logged sessions.
- Simplified routine rows; added an expandable exercise list and direct Start action.
- Replaced multiple recent-workout cards with one real last-workout summary and empty state.
- Kept active-session resume and empty-workout start actions.
- Kept the changes in the Minimal Home implementation; Standard Home was not redesigned.

**Evidence**
- [x] PR #9 merged on 2026-11-13: `f0ed1cf4a5626ee0806cd7bee87c225d361439f9`.
- [x] Actions run #43506289411 passed Flutter analysis, tests, one-APK build and artifact upload.
- [ ] Final phone-viewport screenshot/manual visual comparison remains in the consolidated Stage 10 QA pass.

Do not reimplement Stage 2 unless a regression or a specific mismatch is found. The next implementation stage is Stage 3.

### Stage 3 — Live workout (IN PROGRESS — PR #11)

**Primary file:** `lib/screens/session_screen.dart`; model/state: `live_session.dart`, workout state.

**Current implementation in PR #11**
- [x] Single-row Minimal workout toolbar with step-out, timer, optional Settings, lock, pause/resume and Finish.
- [x] Compact totals strip remains backed by real session state.
- [x] Compact shared table columns, including when Previous is hidden; Minimal-only row density changes preserve Standard dimensions.
- [x] Exercise groups open by default, show completed/total sets, and expose How-to, Notes, Add Set and More actions in the header.
- [x] Flat Minimal rest dock with timer editing, −15, +15 and Skip.
- [x] Duplicate Finish removed; Discard requires confirmation and uses the existing state discard method.
- [x] Regression test added to ensure discarding an active session does not create a history entry.
- [ ] PR #11 Flutter analysis, full tests and one-APK build must pass.
- [ ] Verify narrow phone width, optional Previous on/off, and all supported set types on device.
- [ ] Attach/review phone screenshot and check Standard workout regression before merge.

The items above describe implemented code, not a completed stage. Do not start Stage 4 until PR #11 passes its full gate and is merged.

**Implementation outline**
1. Trace the existing Minimal active-session branch before changing it. It already exists; improve it rather than creating a second workout flow.
2. Map each reference action to existing state methods such as set toggles/edits, previous-set copy, adding/removing exercises, pause/resume, rest, finish and discard.
3. Build the shared header and compact exercise groups while preserving all underlying `WorkoutSession`, `SessionExercise` and `SessionSet` fields.
4. Respect existing app types (warm-up, drop, failure, timed/cardio, sided reps, notes, RPE, supersets/linked exercises and other model-supported data). Show them without forcing every control into the default compact surface.
5. Ensure the shared column header stays aligned with each exercise set row at narrow phone widths and when the optional Previous column is disabled.
6. Add regression tests for set edits/completion, collapsed/expanded groups, pause/resume, rest timer, adding an exercise, finishing and restoring an interrupted session.

**Acceptance**
- [ ] Toolbar, timer, optional totals, shared table and compact groups match the reference.
- [ ] Rest dock appears and its controls work.
- [ ] Every visible control calls real app logic.
- [ ] Active-session save/restore and all existing set types remain correct.
- [ ] No horizontal overflow at supported phone width and text scaling.
- [ ] Standard workout UI and completion flow are unchanged.
- [ ] Tests, analysis and one-APK CI build pass; screenshot/manual review recorded.

### Stage 4 — Exercise library

**Primary file:** `lib/screens/exercises_screen.dart`.

**Implementation outline**
1. Trace existing search, selected muscle, custom exercise creation and exercise-detail navigation.
2. Apply the Minimal layout to search, chips and list rows only when `fit.minimalMode` is active.
3. Provide the compact Name / Muscle / 1RM presentation. Calculate 1RM from the same source/rules as exercise stats; use an empty marker when there is no history.
4. Keep custom exercise creation functional and consistent with the app's catalogue/custom-exercise persistence.
5. Preserve accessibility, keyboard/search behavior, filtering, scroll position and large catalogue performance.

**Acceptance**
- [ ] Search, All/muscle filtering, empty state and detail navigation work.
- [ ] Name / Muscle / 1RM information is aligned and compact.
- [ ] Custom exercise flow still works.
- [ ] No fake values and no regression to Standard library.
- [ ] Tests, analysis, one-APK build and screenshot/manual review pass.

### Stage 5 — Exercise detail and per-exercise statistics

**Primary file:** `lib/screens/exercise_detail_screen.dart`.

**Implementation outline**
1. Trace existing exercise detail, PR/history calculations, charts and return navigation.
2. Add the ten reference metrics using real logged sets and established app calculations.
3. Implement 4W / 8W / 12W / All range selection and previous/later navigation without resetting the selected exercise.
4. Add or adapt the 1RM trend and per-session volume chart.
5. Present PR history and every-session records.
6. Reuse shared chart components where appropriate; avoid a duplicate stats engine.

**Acceptance**
- [ ] All ten metrics are present and correctly labelled.
- [ ] Values match the underlying session history.
- [ ] Date ranges and earlier/later controls work.
- [ ] Trend, volume, PR and session history states handle no data/one data point.
- [ ] Back navigation returns to the originating screen where appropriate.
- [ ] Standard detail view is unchanged; tests, analysis, APK and visual review pass.

### Stage 6 — History

**Primary file:** `lib/screens/history_screen.dart`; export service: `lib/services/workout_history_xlsx.dart`.

**Implementation outline**
1. Trace the current Minimal history branch and the app's existing editing/deletion/export behavior.
2. Provide List / Table modes. List is newest first, capped to the latest 40 sessions and expandable.
3. Build the eight-column set table using real session data.
4. Add search across exercise, muscle and date; sortable column headings; a 200-row render limit and truthful count messaging.
5. Keep Excel export connected to the established export service, including the complete dataset as intended by the service.
6. Do not discard the current date/month grouping data model just because the prototype presents a flatter list.

**Acceptance**
- [ ] List and Table switches work and preserve sensible state.
- [ ] Newest 40 session list expands correctly.
- [ ] All eight columns show correct values and sort correctly.
- [ ] Search, 200-row bound and result count work together.
- [ ] Excel export opens/shares a valid workbook with real history.
- [ ] Empty history/no-match states are clear.
- [ ] Standard history unchanged; tests, analysis, APK and review pass.

### Stage 7 — Stats dashboard

**Primary file:** `lib/screens/progress_screen.dart`; state: `lib/state/stats_state.dart`; charts: `lib/widgets/charts.dart`.

**Implementation outline**
1. Inspect existing Minimal progress implementation and reuse existing computed state wherever possible.
2. Implement weekly volume and range navigation.
3. Add exercise selection and a real estimated 1RM series.
4. Add days-since-last-PR chart, 16-week heatmap and sets-per-muscle last-30-days chart.
5. Keep date boundaries, working-set rules and PR definitions consistent across Today, Exercise Detail, History and Stats.
6. Do not calculate numbers from display-rounded values if underlying precise values are available.

**Acceptance**
- [ ] All reference sections are in the right order.
- [ ] Range changes update the correct charts and labels.
- [ ] Exercise selection updates the 1RM chart.
- [ ] PR aging, 16-week activity and last-30-day muscle sets use real data.
- [ ] Empty data, sparse data and long exercise names render safely.
- [ ] Standard progress screen unchanged; tests, analysis, APK and review pass.

### Stage 8 — Settings

**Primary file:** `lib/screens/settings_screen.dart`; settings state: `lib/state/settings_state.dart`.

**Implementation outline**
1. Locate the Minimal Settings destination and current Minimal preference controls.
2. Reconcile the reference's single compact settings page with current preference routing. Do not break Standard preferences or hide unrelated settings from Standard Mode.
3. Use existing persisted Minimal settings fields and update methods.
4. Confirm each toggle visibly changes the matching UI: previous values, How-to, notes, icons, totals strip, header settings button, text size and row density.
5. Confirm rest timer adjustments are persisted if the existing model intends persistence; otherwise preserve established behavior and document it.
6. Verify Excel and JSON backup use existing export/backup paths.

**Acceptance**
- [ ] All reference options are discoverable from the Minimal Settings tab.
- [ ] Each option changes only the intended Minimal UI.
- [ ] Settings survive app restart.
- [ ] Export and backup actions work.
- [ ] Switching to Standard does not unexpectedly change its presentation/preferences.
- [ ] Tests, analysis, APK and screenshot/manual review pass.

### Stage 9 — Behaviour, persistence and export parity

This is a cross-screen integration stage, not a reason to rewrite the state architecture.

**Implementation outline**
1. Test a complete user journey: launch → Today → start routine/empty workout → edit and complete sets → rest → pause/resume → finish → History → Exercise Detail → Stats.
2. Restart the app with an active session and verify the intended resume behavior.
3. Change every Minimal preference, restart, and verify it remains applied.
4. Export Excel and JSON, then verify the exported data can be opened and restored through supported import/restore paths.
5. Verify calculations are consistent across exercise list, detail, history and stats.
6. Resolve issues found by the end-to-end test and add regression coverage.

**Acceptance**
- [ ] Main workout journey works end to end.
- [ ] In-progress session and settings persistence are correct.
- [ ] Excel/JSON exports contain the expected real data.
- [ ] 1RM, volume, set counts and PRs agree across screens.
- [ ] No duplicate state source or regression in Standard Mode.
- [ ] Full tests, analysis, one-APK build and end-to-end review pass.

### Stage 10 — Visual and functional QA

This is the final verification and release-readiness stage.

**Implementation outline**
1. Compare every Minimal screen to the relevant state in `Sample.html` using the same logical phone viewport and comparable content.
2. Check typography, spacing, colors, borders, density, row alignment, scrolling, safe areas, charts and nav selection.
3. Test every visible button, switch, filter, row, tab, timer and export action.
4. Repeat critical flows with empty data, long exercise names, lots of history, small phone width and increased system text scaling.
5. Switch between Minimal and Standard throughout the test; make sure the stored data is identical.
6. Run the full CI checks and install the single APK on a real Android device.
7. Verify the GitHub Release page and that it contains exactly one APK asset named `GymMinimal.apk`.

**Acceptance**
- [ ] All seven reference screen groups and their flows reviewed.
- [ ] No visible overflow, clipped controls or broken interactions.
- [ ] Minimal/Standard switching preserves data and functionality.
- [ ] Flutter analysis and full test suite pass.
- [ ] One APK installs and launches successfully.
- [ ] Release page contains exactly one expected APK asset.
- [ ] Roadmap reflects the actual final status and known limitations.

## 7. Development workflow and quality gates

### Environment

The current project metadata specifies Dart SDK `^3.11.5`; the build workflow pins Flutter `3.41.9` and Java 17. Use the workflow version for reproducible CI.

### Local commands

Run from the repository root:

```bash
flutter pub get
dart format <changed-dart-files>
flutter analyze --no-fatal-infos
flutter test
flutter build apk --release
```

The single APK normally appears at:

```
build/app/outputs/flutter-apk/app-release.apk
```

Do not use `--split-per-abi`. The workflow renames the single output to `GymMinimal.apk`.

Run the narrow relevant test while iterating, then run the full suite before the PR is ready. Existing tests use Flutter's test framework and, where persistence is involved, often initialize `SharedPreferences.setMockInitialValues({})` and `Store.instance.init()`. Follow the setup/teardown pattern of the closest existing test rather than inventing a new fixture.

### Branch and PR process

1. Check the current default branch and all open PRs. Do not assume the snapshot in this document is still current.
2. Merge/resolve prerequisite PRs before starting a new stage, or deliberately stack the new stage PR on the prerequisite branch and state that dependency in its description.
3. Create one branch per stage, e.g. `feat/minimal-stage-02-today`.
4. Keep the PR focused on that stage. Include changed screens, behavior, tests and any known limitations in the PR description.
5. Add phone screenshots for visual changes.
6. Run formatting, analysis, relevant tests and the full test suite. CI must build one APK.
7. Update `docs/MINIMAL_MODE_PARITY.md` and this handoff guide in the same PR: progress, PR link, tested commit, acceptance evidence and next stage.
8. Do not tick a stage complete before its UI, interactions, tests and relevant regression checks pass.
9. Merge only after CI is green and the PR diff is reviewed for unintended Standard-mode changes.

### Required PR description template

Use this structure for each stage:

```markdown
## Stage
Stage N — <name>

## Reference
Sample.html: <function(s)/screen(s)> inside #app

## What changed
- <Minimal-only UI/behavior changes>

## Existing logic reused
- <fit methods, models, services>

## Standard Mode protection
- <how Standard Mode was kept unchanged and checked>

## Tests and validation
- [ ] dart format
- [ ] flutter analyze --no-fatal-infos
- [ ] relevant tests
- [ ] flutter test
- [ ] one APK CI build
- [ ] phone screenshot/manual interaction review

## Screenshots
<before/after or reference comparison>

## Known gaps
- <explicitly list anything not finished>
```

### Definition of done for every screen stage

A stage is done only when all are true:
- Required reference content and order are present in Minimal Mode.
- Every visible control performs its intended action.
- Data comes from the real app model/state, not demo placeholders.
- Empty, loading, no-match and sparse-data states are safe.
- The affected screen has relevant tests.
- Flutter analysis and CI tests/build pass.
- Standard Mode was checked and has no unintended change.
- A phone screenshot or manual comparison was reviewed.
- Roadmap and handoff notes are updated.

## 8. Single-APK build and GitHub Release

Workflow file: `.github/workflows/build-apk.yml`.

**Use the current version on `main` as the source of truth.** PR #9 merged the single-job workflow; PR #10 preserves that version.

The current workflow uses one job:

1. On every PR to `main`, check out the project, install dependencies, run `flutter analyze --no-fatal-infos`, run `flutter test`, build one release-mode APK, rename it `GymMinimal.apk` and upload one artifact named `gymminimal-apk`.
2. On a push to `main` or manual workflow dispatch, the same job continues after the build and runs the conditional release steps. It tags the tested commit, removes older APK assets from the rolling release, and publishes the APK already present at `build/app/outputs/flutter-apk/GymMinimal.apk`.
3. It does not run a second Flutter build and does not need to download the artifact into a separate release job.
4. The rolling preview tag is `minimal-mode-preview`; a manual dispatch may provide a tag override.

### Signing caveat — read before promising seamless updates

The earlier release attempt failed because the keystore-related GitHub Actions secrets were empty, causing Gradle to read an invalid keystore. The current workflow avoids that second signing/build attempt and publishes the one APK produced by the build job.

A persistent private release signing key has not yet been established. Treat the APK as installable, but do not assume that APKs from separate CI runs will have a stable signing identity or support seamless in-place upgrades. For reliable upgrades, configure a persistent private release keystore and the required GitHub Actions secrets, then deliberately update and test the signing workflow. Never commit a keystore, passwords or secret values to the repository or this documentation.

### Release verification

Do not infer release success from a green PR build alone. After a merge to `main`:
- Confirm the main-branch workflow run completed successfully, including the release steps.
- Open the GitHub Releases page.
- Confirm the rolling preview release has exactly one APK asset named `GymMinimal.apk`.
- Download/install the APK and launch it.
- Record the release URL and tested commit in the roadmap.

**Verified on 2026-11-14:** main-branch run #43508196293 completed successfully. The [rolling preview release](https://github.com/HackerXMindset/GymMinimal/releases/tag/minimal-mode-preview) contains exactly one APK asset, `GymMinimal.apk`.

## 9. Takeover protocol — how to resume at any stage

A new contributor should be able to do the following without reading the original chat:

1. Open `docs/MINIMAL_MODE_PARITY.md` and find the first unchecked stage. The first unchecked stage is the next planned stage unless the changelog says it is blocked.
2. Open this file and read Sections 1–4 (product goal, source hierarchy, design and architecture).
3. Read that stage's full section in Section 6, including primary files, implementation outline and acceptance criteria.
4. Open the corresponding screen, model/state/services and tests listed in Section 4 on the current branch. Search for existing Minimal branches and reuse their state methods.
5. Open the corresponding function(s) in `Sample.html` and compare the target inside `#app`.
6. Check the last PR, current branch head and Actions status. Continue from the latest merged code; do not assume a PR shown in this snapshot is still open.
7. Implement only the current stage, test it, and prepare its focused PR.
8. Update the stage record below and the roadmap before handing off again.

### Stage handoff record

Update this record at the end of every stage PR:

| Field | Current value |
|---|---|
| Current stage | Stage 3 — Live workout |
| Stage state | In progress — PR #11 open; code implemented, CI and device review pending |
| Last known base | `main` commit `7fbc49522965e638a110e9988c4fe53b29a11301` (PR #10 merge) |
| Current prerequisite | PR #10 merged; its updated Actions run #43510832870 passed |
| Last completed UI stage | Stage 2 — Today screen (PR #9 merged) |
| Current owner | Unassigned / whoever takes the next stage |
| Current branch | `feature/sample-html-parity-stage-3-live-workout` |
| Current PR | [PR #11](https://github.com/HackerXMindset/GymMinimal/pull/11) |
| Last verified test commit | PR #10 head `d0dedd8cbd0fec6dfa5f115cc300b3970e0a7771`; Actions run #43510832870 passed |
| Known blocker | PR #11 CI has not yet passed; no physical-device screenshot/manual review is attached yet. |
| Next concrete action | Check the newest PR #11 run, fix any analysis/test/build failures, perform phone-width and Standard-mode review, then merge only when all gates pass |

For each future handoff, replace these values with the real current stage and live commit/PR/test state. Keep completed stages' PR references in the roadmap changelog. If a stage is partially done, state exactly which acceptance boxes passed, which failed, and the next unfinished item. Do not simply write "mostly done".

### Progress update template

Append a row to the roadmap changelog after each meaningful merge:

| Date | Stage / PR | Commit | What was completed | Tests / visual proof | Next action |
|---|---|---|---|---|---|

Also update the overall percentage using completed stages divided by 11. Release automation status is tracked separately from UI stage completion.

## 10. Decisions and open risks

These decisions prevent future contributors from having to rediscover intent:

- The reference target is Minimal content inside `#app`, not the external demo page or the rough Standard mockup.
- The HTML's sample data is illustrative. Real Flutter state and persisted user data are authoritative for values.
- Standard Mode is out of scope for visual redesign and must remain functional.
- Existing advanced app capabilities should not be removed to make the reference look smaller. Simplify their default Minimal presentation and retain access where a compatible route/control already exists.
- Minimal Settings should use the existing persisted settings state. Do not make duplicate config keys from the prototype's browser storage.
- Do not recreate calculations separately per screen. Use shared app state/calculation rules so 1RM, PR, set count and volume agree.
- A UI-only stage should not introduce new packages, backend calls, migrations or broad model changes unless the stage demonstrably requires them.
- The rolling preview Release is separate from PR build artifacts. A successful PR artifact does not mean the Release page has been updated.

Open risks to verify during implementation:
- Some reference controls are demo placeholders rather than finished product behavior. Match the existing app's equivalent, not a dead-end button.
- Minimal mode already has partial implementations across several large screens. Always inspect the current Minimal branch before writing a replacement.
- Multiple screens currently have their own Minimal color/style branches. Avoid visual drift and consolidate shared tokens only when the change is safe and tested.
- The release signing certificate is not yet established as a persistent production key. Resolve this before distributing upgrades broadly.

## 11. Useful repository links

- Repository: https://github.com/HackerXMindset/GymMinimal
- Reference prototype: https://github.com/HackerXMindset/GymMinimal/blob/main/Sample.html
- Roadmap: https://github.com/HackerXMindset/GymMinimal/blob/main/docs/MINIMAL_MODE_PARITY.md
- Build/release workflow: https://github.com/HackerXMindset/GymMinimal/blob/main/.github/workflows/build-apk.yml
- PR #8 (Minimal shell/navigation): https://github.com/HackerXMindset/GymMinimal/pull/8
- PR #10 (single APK workflow and handoff documentation): https://github.com/HackerXMindset/GymMinimal/pull/10
- GitHub Actions: https://github.com/HackerXMindset/GymMinimal/actions
- Releases: https://github.com/HackerXMindset/GymMinimal/releases

---

**Handoff standard:** the next contributor should not have to ask what the goal is, which screen to build, where the current state lives, what must not change, how the reference works, which tests to run, or what proof is needed to close a stage. If any one of those answers changes, update this document in the same PR that changes the project.
