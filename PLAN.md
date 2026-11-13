# GymMinimal — Minimal Mode implementation plan

**Last updated:** 14 November 2026  
**Repository:** https://github.com/HackerXMindset/GymMinimal  
**Reference:** root `Sample.html`, phone UI inside `#app` only  
**Scope:** native Flutter Minimal Mode. Standard Mode must remain unchanged.

## Goal and rules

Rebuild the reference's compact phone experience in the existing Flutter app using real user data and existing state/models/services.

- One stage per branch and PR.
- Minimal-only UI changes; do not redesign Standard Mode.
- No WebView/HTML wrapper and no use of the prototype's fake sample data.
- Preserve existing functionality and persisted data; hide or relocate non-reference controls instead of deleting features.
- Run formatting, Flutter analysis, tests and exactly one APK build for each PR.
- The APK must be named `GymMinimal.apk`; do not use ABI splitting.
- A stage is complete only after implementation, tests, Standard-mode regression checks and visual/interaction review.
- Keep this file, the roadmap and the handoff guide synchronized after every merge.

## Progress

**4 of 11 stages implemented and merged (36%).** Seven stages remain. Stage 4 is now in progress. Final cross-screen visual verification is consolidated in Stage 10.

| Stage | Area | Status | Last change / next step |
|---|---|---|---|
| 0 | Reference audit and baseline | Complete | `Sample.html` boundary and reference inventory documented |
| 1 | Minimal shell and navigation | Complete | PR #8 merged |
| 2 | Today screen | Complete | PR #9 merged; CI run #43506289411 passed |
| 3 | Live workout | Complete | PR #11 merged; CI run #43515792250 passed analysis, tests and one-APK build |
| 4 | Exercise library | **In progress (PR #12)** | Minimal Name / Muscle / 1RM table, All/muscle chips and real historical 1RM values |
| 5 | Exercise details | Planned | Ten metrics, range controls, 1RM/volume charts, PR history and session table |
| 6 | History | Planned | Latest-40 list, List/Table, eight-column table, search/sort and Excel |
| 7 | Stats dashboard | Planned | Weekly volume, exercise 1RM, days-since-PR, 16-week heatmap, muscle sets |
| 8 | Settings | Planned | Minimal display options, rest timer, Excel/JSON export |
| 9 | Behaviour and persistence | Planned | End-to-end flows, persistence and export parity |
| 10 | Visual and functional QA | Planned | Phone screenshots, interaction audit, Standard regression and final install |

## Current state and next action

- **Latest merged UI work:** PR #11, Stage 3 Live Workout, merge commit `7b9a8e3ea4492b56d3391f640c708062991c6297`.
- **Latest merged repository baseline:** PR #11 Stage 3 merge commit `7b9a8e3ea4492b56d3391f640c708062991c6297`.
- **Current implementation:** Stage 4 — Exercise library, PR #12, branch `feature/sample-html-parity-stage-4-exercise-library`.
- **Stage 3 gate passed:** PR #11 Actions run #43515792250 passed analysis, full tests and the single-APK build; PR #11 is merged. The post-merge main run #43518506146 passed analysis and tests and was building the APK at this snapshot.
- **Do not restart Stage 2.** Reopen it only for a confirmed regression or mismatch. Its final screenshot/manual parity check belongs in Stage 10.

## Build and release

Workflow: [`.github/workflows/build-apk.yml`](.github/workflows/build-apk.yml).

The current workflow (merged in PR #9) runs analysis, tests, a single APK build and artifact upload in one job. On a push to `main` or manual dispatch, that same job conditionally publishes the already-built APK to the rolling `minimal-mode-preview` release. There is no second Flutter build or separate release-job rebuild.

- PR #9 CI run #43506289411: analysis, tests, one-APK build and artifact upload succeeded.
- Main push run #43508196293: completed successfully, including the Release publish steps.
- Verified the [rolling release](https://github.com/HackerXMindset/GymMinimal/releases/tag/minimal-mode-preview) now contains exactly one APK asset named `GymMinimal.apk`.
- PR #11 Stage 3 run #43515792250 passed analysis, full tests and the single-APK build. Post-merge main run #43518506146: analysis and tests passed; APK build/release steps were still running at this snapshot.
- A persistent release keystore has not been confirmed. Do not assume seamless in-place upgrades between separately built APKs until stable signing is configured and tested.

## Documents and source map

- [Detailed stage roadmap](docs/MINIMAL_MODE_PARITY.md) — stage status and checklists.
- [Complete project handoff](docs/MINIMAL_MODE_HANDOFF.md) — product intent, design, architecture, per-stage requirements, testing, release and takeover procedure.
- [Reference prototype](Sample.html) — use the functions/CSS for behavior and appearance, only inside `#app`.

Main native locations:

- Shell/navigation: `lib/app/app_shell.dart`
- Today: `lib/screens/home_screen.dart`
- Live workout: `lib/screens/session_screen.dart`
- Exercise library: `lib/screens/exercises_screen.dart`
- Exercise detail: `lib/screens/exercise_detail_screen.dart`
- History: `lib/screens/history_screen.dart`
- Stats: `lib/screens/progress_screen.dart`
- Settings: `lib/screens/settings_screen.dart`
- Shared state: `lib/state/fit_state.dart` and its part files
- Models: `lib/models/live_session.dart`, `lib/models/workout.dart`
- Persistence/export: `lib/services/local_store.dart`, `lib/services/workout_history_xlsx.dart`
- Tests: `test/`

## PR workflow

1. Check the live PR list and latest `main` before branching.
2. Read the detailed handoff section for the next stage and the matching `Sample.html` function.
3. Branch from latest `main`; one stage/topic only.
4. Reuse existing `fit` state and model logic. Keep UI changes inside Minimal branches.
5. Add focused tests and a phone-sized visual check; run formatting, analysis and the full test suite.
6. Confirm CI built one `GymMinimal.apk` and inspect the PR diff for accidental Standard changes.
7. Update this dashboard, the detailed roadmap and handoff record. Merge only when the evidence is green.

