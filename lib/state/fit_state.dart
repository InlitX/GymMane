import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' show PlatformDispatcher;

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/live_session.dart';
import '../models/profile.dart';
import '../models/workout.dart';
import '../services/alarm_store.dart';
import '../services/local_store.dart';
import '../services/media_store.dart';
import '../services/rest_alarm.dart';
import '../services/exercise_match.dart';
import '../services/workout_import.dart';

part 'fit_core.dart';
part 'library_state.dart';
part 'routines_state.dart';
part 'settings_state.dart';
part 'stats_state.dart';
part 'tools_state.dart';
part 'workout_state.dart';

class FitState extends FitCore
    with ToolsState, SettingsState, LibraryState, StatsState, RoutinesState, WorkoutState {
  void loadFromStore() {
    final data = Store.instance.load();
    _loading = true;
    if (data['language'] == null) _adoptDeviceLanguage();
    if (data.isNotEmpty) {
      profile = Profile.fromJson((data['profile'] as Map?)?.cast<String, dynamic>() ?? {});

      if (const {'Athlete', 'Atleta', 'Name'}.contains(profile.name)) profile.name = 'InlitX';
      dark = data['dark'] as bool? ?? true;
      units = data['units'] as String? ?? 'kg';

      _applyLanguage(data['language'] as String? ?? language);
      restSeconds = (data['rest'] as num?)?.toInt() ?? 90;
      alarmSound = data['alarmSound'] as String?;
      alarmSoundName = data['alarmSoundName'] as String?;
      RestAlarm.instance.customSoundPath = alarmSoundPath;

      if (alarmSoundPath == null) {
        alarmSound = null;
        alarmSoundName = null;
      }
      bgPattern = data['bg'] as String? ?? 'none';
      alarmAskedAt = (data['alarmAskedAt'] as num?)?.toInt();
      onboarded = data['onboarded'] as bool? ?? false;
      favorites
        ..clear()
        ..addAll(((data['favorites'] as Map?) ?? {}).map((k, v) => MapEntry(k as String, v as bool)));
      _loadNotes(data);
      checkins
        ..clear()
        ..addAll(((data['checkins'] as List?) ?? []).cast<String>());
      routines
        ..clear()
        ..addAll(((data['routines'] as List?) ?? [])
            .map((e) => Routine.fromJson((e as Map).cast<String, dynamic>())));
      weeklyPlan
        ..clear()
        ..addAll(((data['weeklyPlan'] as Map?) ?? {})
            .map((k, v) => MapEntry(int.parse(k as String), v as String)));
      customExercises
        ..clear()
        ..addAll(((data['custom'] as List?) ?? [])
            .map((e) => Exercise.fromJson((e as Map).cast<String, dynamic>())));
      sessions
        ..clear()
        ..addAll(((data['sessions'] as List?) ?? [])
            .map((e) => LoggedSession.fromJson((e as Map).cast<String, dynamic>())));
      bodyweight
        ..clear()
        ..addAll(((data['bodyweight'] as List?) ?? [])
            .map((e) => BodyweightEntry.fromJson((e as Map).cast<String, dynamic>())));
      _restoreLiveSession(data);
    }
    _seedCalculatorsFromProfile();
    _loading = false;
    notifyListeners();
  }

  void _restoreLiveSession(Map<String, dynamic> data) {
    final live = data['live'] as Map?;
    if (live == null) return;
    session = WorkoutSession.fromJson(live.cast<String, dynamic>());
    _elapsedBefore = (data['liveElapsed'] as num?)?.toInt() ?? 0;
    sessionPaused = data['livePaused'] as bool? ?? false;
    final started = data['liveStart'] as String?;
    if (sessionPaused || started == null) {
      _runningSince = null;
    } else {
      _runningSince = DateTime.tryParse(started);
      _startTicking(from: _runningSince);
    }
    route = 'session';
    prevRoute = 'home';
  }

  void _loadNotes(Map<String, dynamic> data) {
    exNotes.clear();
    final raw = data['exNotes'] as Map?;
    if (raw != null) {
      raw.forEach((k, v) {
        exNotes[k as String] = (v as List)
            .map((e) => ExerciseNote.fromJson((e as Map).cast<String, dynamic>()))
            .toList();
      });
    } else {
      (data['notes'] as Map?)?.forEach((k, v) {
        final t = (v as String).trim();
        if (t.isNotEmpty) exNotes[k as String] = [ExerciseNote(DateTime.now(), t)];
      });
    }
  }

  @override
  Map<String, dynamic> toJson() => {
        'profile': profile.toJson(),
        'dark': dark,
        'units': units,
        'language': language,
        'rest': restSeconds,
        'alarmSound': alarmSound,
        'alarmSoundName': alarmSoundName,
        'bg': bgPattern,
        'alarmAskedAt': alarmAskedAt,
        'onboarded': onboarded,
        'favorites': favorites,
        'exNotes': exNotes.map((k, v) => MapEntry(k, v.map((n) => n.toJson()).toList())),
        'checkins': checkins.toList(),
        'routines': routines.map((r) => r.toJson()).toList(),
        'weeklyPlan': weeklyPlan.map((k, v) => MapEntry(k.toString(), v)),
        'custom': customExercises.map((e) => e.toJson()).toList(),
        'sessions': sessions.map((s) => s.toJson()).toList(),
        'bodyweight': bodyweight.map((b) => b.toJson()).toList(),
        if (session != null && !session!.complete) ...{
          'live': session!.toJson(),
          'liveStart': _runningSince?.toIso8601String(),
          'liveElapsed': _elapsedBefore,
          'livePaused': sessionPaused,
        },
      };

  void resetAllData() {
    _saveDebounce?.cancel();
    _sessionTimer?.cancel();
    _restTimer?.cancel();
    RestAlarm.instance.cancel();
    session = null;
    _runningSince = null;
    _elapsedBefore = 0;
    sessionPaused = false;
    sessions.clear();
    bodyweight.clear();
    exNotes.clear();
    checkins.clear();
    routines.clear();
    weeklyPlan.clear();
    customExercises.clear();
    favorites.clear();
    sessionPicks.clear();
    selectedMuscles.clear();
    profile = Profile();
    onboarded = false;
    strengthExerciseId = null;
    _photoBytes = null;
    _photoCacheKey = null;
    _seedCalculatorsFromProfile();
    route = 'home';
    prevRoute = 'home';
    trainStep = 'select';
    persistNow();
    _refreshWidgets();
    notifyListeners();
  }

  String exportJson() => Store.instance.exportJson(toJson());

  String exportCsv() => Store.instance.exportCsv(sessions);

  bool importJson(String raw) {
    final map = Store.instance.tryParse(raw);
    if (map == null) return false;
    _loading = true;
    profile = Profile.fromJson((map['profile'] as Map?)?.cast<String, dynamic>() ?? {});
    dark = map['dark'] as bool? ?? dark;
    units = map['units'] as String? ?? units;
    _applyLanguage(map['language'] as String? ?? language);
    restSeconds = (map['rest'] as num?)?.toInt() ?? restSeconds;
    bgPattern = map['bg'] as String? ?? bgPattern;
    onboarded = map['onboarded'] as bool? ?? onboarded;
    favorites
      ..clear()
      ..addAll(((map['favorites'] as Map?) ?? {}).map((k, v) => MapEntry(k as String, v as bool)));
    _loadNotes(map);
    checkins
      ..clear()
      ..addAll(((map['checkins'] as List?) ?? []).cast<String>());
    routines
      ..clear()
      ..addAll(((map['routines'] as List?) ?? [])
          .map((e) => Routine.fromJson((e as Map).cast<String, dynamic>())));
    weeklyPlan
      ..clear()
      ..addAll(((map['weeklyPlan'] as Map?) ?? {})
          .map((k, v) => MapEntry(int.parse(k as String), v as String)));
    customExercises
      ..clear()
      ..addAll(((map['custom'] as List?) ?? [])
          .map((e) => Exercise.fromJson((e as Map).cast<String, dynamic>())));
    sessions
      ..clear()
      ..addAll(((map['sessions'] as List?) ?? [])
          .map((e) => LoggedSession.fromJson((e as Map).cast<String, dynamic>())));
    bodyweight
      ..clear()
      ..addAll(((map['bodyweight'] as List?) ?? [])
          .map((e) => BodyweightEntry.fromJson((e as Map).cast<String, dynamic>())));
    _seedCalculatorsFromProfile();
    _loading = false;
    _persist();
    _refreshWidgets();
    notifyListeners();
    return true;
  }

  static String _normName(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();

  Exercise? matchExerciseByName(String name) => matchExercise(name, allExercises);

  static String _sessionKey(LoggedSession s) =>
      '${s.date.toIso8601String()}|${s.exercises.map((e) => '${e.id}:${e.sets.length}').join(',')}';
  int importParsedSessions(List<ParsedSession> parsed) {
    final seen = sessions.map(_sessionKey).toSet();
    var added = 0;
    for (final ps in parsed) {
      final exs = <LoggedExercise>[];
      for (final pe in ps.exercises) {
        if (pe.sets.isEmpty) continue;
        final match = matchExerciseByName(pe.name);
        final id = match?.id ?? 'imp:${_normName(pe.name).replaceAll(' ', '-')}';
        final hint = (pe.muscle ?? '').toLowerCase();
        final primary =
            match?.primary ?? (kFilterMuscles.contains(hint) ? hint : guessMuscle(pe.name) ?? 'other');
        exs.add(LoggedExercise(id, match?.name ?? pe.name, primary,
            [for (final s in pe.sets) LoggedSet(s.reps, s.weightKg)]));
      }
      if (exs.isEmpty) continue;
      final ls = LoggedSession(ps.date, ps.durationSec, exs);
      final key = _sessionKey(ls);
      if (seen.contains(key)) continue;
      sessions.add(ls);
      seen.add(key);
      added++;
    }
    if (added > 0) {
      sessions.sort((a, b) => a.date.compareTo(b.date));
      _persist();
      _refreshWidgets();
      notifyListeners();
    }
    return added;
  }

  int importParsedWeights(List<ParsedWeight> parsed) {
    final seen = bodyweight.map((e) => _dayKey(e.date)).toSet();
    var added = 0;
    for (final w in parsed) {
      if (w.kg <= 0) continue;
      if (!seen.add(_dayKey(w.date))) continue;
      bodyweight.add(BodyweightEntry(w.date, _round3(w.kg)));
      added++;
    }
    if (added > 0) {
      bodyweight.sort((a, b) => a.date.compareTo(b.date));
      final latest = latestBodyweight;
      if (latest != null) {
        profile.weightKg = latest.kg;
        _seedCalculatorsFromProfile();
      }
      _persist();
      notifyListeners();
    }
    return added;
  }

  bool handleBack() {
    switch (route) {
      case 'exercise-detail':
        closeExerciseDetail();
      case 'about':
        backFromAbout();
      case 'tools':
        backFromTools();
      case 'tools-detail':
        closeTool();
      case 'routines':
        backFromRoutines();
      case 'routine-edit':
        closeRoutineEdit();
      case 'train':
        trainStep == 'review' ? trainBack() : closeTrain();
      case 'progress':
      case 'exercises':
      case 'settings':
        goHome();
      default:
        return false;
    }
    return true;
  }

  void goAbout() {
    if (route != 'about') prevRoute = route;
    route = 'about';
    notifyListeners();
  }

  void backFromAbout() {
    route = prevRoute;
    notifyListeners();
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _restTimer?.cancel();
    super.dispose();
  }
}

final fit = FitState();
