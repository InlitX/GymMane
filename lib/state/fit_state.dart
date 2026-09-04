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
import '../models/measure.dart';
import '../models/note.dart';
import '../models/place.dart';
import '../models/progress_shot.dart';
import '../models/profile.dart';
import '../models/workout.dart';
import '../services/alarm_store.dart';
import '../services/local_store.dart';
import '../services/media_store.dart';
import '../services/progress_reminder.dart';
import '../services/rest_alarm.dart';
import '../services/exercise_match.dart';
import '../services/workout_import.dart';

part 'fit_core.dart';
part 'library_state.dart';
part 'measures_state.dart';
part 'notes_state.dart';
part 'places_state.dart';
part 'routines_state.dart';
part 'settings_state.dart';
part 'stats_state.dart';
part 'timeline_state.dart';
part 'tools_state.dart';
part 'workout_state.dart';

class FitState extends FitCore
    with ToolsState, SettingsState, LibraryState, NotesState, PlacesState, MeasuresState, TimelineState, StatsState, RoutinesState, WorkoutState {
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
      bgPattern = data['bg'] as String? ?? 'dots';
      alarmAskedAt = (data['alarmAskedAt'] as num?)?.toInt();
      onboarded = data['onboarded'] as bool? ?? false;
      favorites
        ..clear()
        ..addAll(((data['favorites'] as Map?) ?? {}).map((k, v) => MapEntry(k as String, v as bool)));
      _loadNotes(data);
      _loadPlaces(data);
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
      _loadMedia(data);
      _loadRepsOnly(data);
      _loadExerciseRest(data);
      sessions
        ..clear()
        ..addAll(((data['sessions'] as List?) ?? [])
            .map((e) => LoggedSession.fromJson((e as Map).cast<String, dynamic>())));
      bodyweight
        ..clear()
        ..addAll(((data['bodyweight'] as List?) ?? [])
            .map((e) => BodyweightEntry.fromJson((e as Map).cast<String, dynamic>())));
      _loadMeasures(data);
      _loadShots(data);
      photoIntervalDays = (data['photoEvery'] as num?)?.toInt() ?? 30;
      bodyTimeline = data['bodyTl'] as bool? ?? false;
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
    resetRoute('session');
  }

  void _loadMedia(Map<String, dynamic> data, {Map<String, String>? restored}) {
    exerciseMedia.clear();
    if (restored != null) {
      exerciseMedia.addAll(restored);
      return;
    }
    ((data['media'] as Map?) ?? {}).forEach((k, v) {
      if (v is String && v.isNotEmpty) exerciseMedia[k as String] = v;
    });
    for (final e in (data['custom'] as List?) ?? const []) {
      final legacy = (e as Map)['m'];
      final id = e['id'];
      if (id is String && legacy is String && legacy.isNotEmpty) {
        exerciseMedia.putIfAbsent(id, () => legacy);
      }
    }
  }

  void _loadExerciseRest(Map<String, dynamic> data) {
    exerciseRest.clear();
    ((data['exRest'] as Map?) ?? const {}).forEach((k, v) {
      final n = (v as num?)?.toInt();
      if (k is String && n != null) exerciseRest[k] = n.clamp(15, 600);
    });
  }

  void _loadRepsOnly(Map<String, dynamic> data) {
    repsOnly
      ..clear()
      ..addAll(((data['repsOnly'] as List?) ?? const []).cast<String>());
    repsOnlyOff
      ..clear()
      ..addAll(((data['repsOnlyOff'] as List?) ?? const []).cast<String>());
  }

  void _loadShots(Map<String, dynamic> data, {Map<String, String>? restored}) {
    shots
      ..clear()
      ..addAll(((data['shots'] as List?) ?? const [])
          .map((e) => ProgressEntry.fromJson((e as Map).cast<String, dynamic>()))
          .where((e) => !e.isEmpty));
    if (restored == null) return;
    for (var i = 0; i < shots.length; i++) {
      final e = shots[i];
      final kept = <String, String>{};
      e.shots.forEach((pose, name) {
        final now = restored[name];
        if (now != null) kept[pose] = now;
      });
      shots[i] = e.copyWith(shots: kept);
    }
    shots.removeWhere((e) => e.isEmpty);
  }

  void _loadMeasures(Map<String, dynamic> data) {
    measures
      ..clear()
      ..addAll(((data['measures'] as List?) ?? const [])
          .map((e) => BodyMeasure.fromJson((e as Map).cast<String, dynamic>()))
          .where((m) => kMeasureKeys.contains(m.key)));
  }

  void _loadPlaces(Map<String, dynamic> data) {
    places.clear();
    final raw = data['places'];
    if (raw is List) {
      places.addAll(raw.map((e) => GymPlace.fromJson((e as Map).cast<String, dynamic>())));
    }
    activePlaceId = data['place'] as String? ?? '';
    if (places.every((p) => p.id != activePlaceId)) activePlaceId = '';
  }

  void _loadNotes(Map<String, dynamic> data) {
    notes.clear();
    final raw = data['notes'];
    if (raw is List) {
      notes.addAll(raw.map((e) => GymNote.fromJson((e as Map).cast<String, dynamic>())));
      return;
    }

    var seq = 0;
    GymNote legacy(String exId, DateTime when, String text) => GymNote(
          id: 'n${when.microsecondsSinceEpoch}${seq++}',
          exerciseId: exId,
          date: _dayKey(when),
          kind: NoteKind.note,
          text: text,
          createdAt: when,
        );

    (data['exNotes'] as Map?)?.forEach((k, v) {
      for (final e in (v as List)) {
        final m = (e as Map).cast<String, dynamic>();
        final text = ((m['t'] ?? '') as String).trim();
        if (text.isEmpty) continue;
        notes.add(legacy(
            k as String, DateTime.tryParse((m['d'] ?? '') as String) ?? DateTime.now(), text));
      }
    });
    if (raw is Map) {
      raw.forEach((k, v) {
        final text = (v as String).trim();
        if (text.isNotEmpty) notes.add(legacy(k as String, DateTime.now(), text));
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
        'notes': notes.map((n) => n.toJson()).toList(),
        'places': places.map((p) => p.toJson()).toList(),
        'place': activePlaceId,
        'checkins': checkins.toList(),
        'routines': routines.map((r) => r.toJson()).toList(),
        'weeklyPlan': weeklyPlan.map((k, v) => MapEntry(k.toString(), v)),
        'custom': customExercises.map((e) => e.toJson()).toList(),
        'media': exerciseMedia,
        'exRest': exerciseRest,
        'repsOnly': repsOnly.toList(),
        'repsOnlyOff': repsOnlyOff.toList(),
        'sessions': sessions.map((s) => s.toJson()).toList(),
        'bodyweight': bodyweight.map((b) => b.toJson()).toList(),
        'measures': measures.map((m) => m.toJson()).toList(),
        'shots': shots.map((s) => s.toJson()).toList(),
        'photoEvery': photoIntervalDays,
        'bodyTl': bodyTimeline,
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
    ProgressReminder.instance.cancel();
    session = null;
    _runningSince = null;
    _elapsedBefore = 0;
    sessionPaused = false;
    sessions.clear();
    bodyweight.clear();
    measures.clear();
    shots.clear();
    compareFromId = null;
    compareToId = null;
    notes.clear();
    places.clear();
    activePlaceId = '';
    checkins.clear();
    routines.clear();
    weeklyPlan.clear();
    customExercises.clear();
    exerciseMedia.clear();
    repsOnly.clear();
    repsOnlyOff.clear();
    exerciseRest.clear();
    MediaStore.clearAll();
    favorites.clear();
    sessionPicks.clear();
    selectedMuscles.clear();
    profile = Profile();
    onboarded = false;
    strengthExerciseId = null;
    _photoBytes = null;
    _photoCacheKey = null;
    _seedCalculatorsFromProfile();
    resetRoute('home');
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
    applyBackup(map);
    return true;
  }

  /// [restoredMedia] llega de una copia en zip: los ficheros ya están en
  /// MediaStore con nombres nuevos y sustituyen al mapa del JSON.
  void applyBackup(Map<String, dynamic> map,
      {Map<String, String>? restoredMedia,
      Map<String, String>? restoredNoteMedia,
      Map<String, String>? restoredShots}) {
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
    _loadPlaces(map);
    _loadNotes(map);
    if (restoredNoteMedia != null) _remapNoteMedia(restoredNoteMedia);
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
    _loadMedia(map, restored: restoredMedia);
    _loadRepsOnly(map);
    _loadExerciseRest(map);
    sessions
      ..clear()
      ..addAll(((map['sessions'] as List?) ?? [])
          .map((e) => LoggedSession.fromJson((e as Map).cast<String, dynamic>())));
    bodyweight
      ..clear()
      ..addAll(((map['bodyweight'] as List?) ?? [])
          .map((e) => BodyweightEntry.fromJson((e as Map).cast<String, dynamic>())));
    _loadMeasures(map);
    _loadShots(map, restored: restoredShots);
    photoIntervalDays = (map['photoEvery'] as num?)?.toInt() ?? photoIntervalDays;
    bodyTimeline = map['bodyTl'] as bool? ?? bodyTimeline;
    _seedCalculatorsFromProfile();
    _loading = false;
    _persist();
    _refreshWidgets();
    notifyListeners();
  }

  void _remapNoteMedia(Map<String, String> restored) {
    for (var i = 0; i < notes.length; i++) {
      final n = notes[i];
      if (n.media.isEmpty) continue;
      final kept = [
        for (final m in n.media)
          if (restored[m] != null) restored[m]!,
      ];
      notes[i] = n.copyWith(media: kept);
    }
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
      case 'measures':
        backFromMeasures();
      case 'places':
        backFromPlaces();
      case 'timeline':
        backFromTimeline();
      case 'compare':
        backFromCompare();
      case 'notes':
        backFromNotes();
      case 'note-edit':
        closeNoteEditor();
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

  void goAbout() => pushRoute('about');

  void backFromAbout() => popRoute(fallback: 'settings');

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _restTimer?.cancel();
    super.dispose();
  }
}

final fit = FitState();
