import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../widgets/ui_kit.dart';

class LiveWorkout {
  LiveWorkout._();

  static const _channel = MethodChannel('gymmane/live_activity');
  static const _android = MethodChannel('gymmane/live');
  static bool _listening = false;

  static String _lastKey = '';
  static bool _busy = false;
  static bool _dirty = false;
  static int _flashes = 0;
  static DateTime? _flashAt;

  static bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static Future<void> sync() async {
    if (!_supported) return;
    if (!_listening && Platform.isAndroid) {
      _listening = true;
      _android.setMethodCallHandler((call) async {
        if (call.method == 'action') _act(call.arguments as String? ?? '');
      });
    }
    if (_busy) {
      _dirty = true;
      return;
    }
    _busy = true;
    try {
      do {
        _dirty = false;
        await _push();
      } while (_dirty);
    } finally {
      _busy = false;
    }
  }

  static Future<void> _push() async {
    final s = fit.session;
    if (s == null || s.complete || s.manual) {
      await end();
      return;
    }
    final ex = fit.currentExercise;
    final total = s.exercises.length;
    final index = s.currentIndex.clamp(0, total == 0 ? 0 : total - 1);
    final paused = fit.sessionPaused;
    final restEnd = paused ? null : s.restEndsAt;
    final resting = restEnd != null && s.restRemaining != null;

    final name = ex == null ? 'GymMane' : t.catalogName(ex.id, ex.name);
    String detail;
    if (paused) {
      detail = titleCase(t.paused);
    } else if (ex == null) {
      detail = '';
    } else {
      final pending = ex.sets.indexWhere((st) => !st.done);
      if (pending < 0) {
        detail = t.liveAllDone;
      } else {
        final st = ex.sets[pending];
        final load = st.sec != null || st.km != null
            ? fit.loggedSetLabel(st.logged)
            : fit.isRepsOnly(ex.id)
                ? '${st.reps} ${t.repsCol.toLowerCase()}'
                : '${st.reps} × ${fit.weightLabel(st.weight)}';
        detail = '${t.liveSet(pending + 1, ex.sets.length)} · $load';
      }
    }

    final nextIdx = fit.pendingAfter(index) ?? (index + 1 < total ? index + 1 : null);
    final nextEx = nextIdx == null ? null : s.exercises[nextIdx];
    final nextName = nextEx == null ? null : t.catalogName(nextEx.id, nextEx.name);
    var position = 0;
    for (var i = 0; i < index; i++) {
      position += s.exercises[i].sets.length;
    }
    final pendingIdx = ex?.sets.indexWhere((st) => !st.done) ?? -1;
    position += pendingIdx < 0 ? (ex?.sets.length ?? 0) : pendingIdx;
    final chip = ex == null || ex.sets.isEmpty
        ? null
        : '${pendingIdx < 0 ? ex.sets.length : pendingIdx + 1}/${ex.sets.length}';
    final finished = [for (final e in s.exercises) e.sets.isNotEmpty && e.sets.every((st) => st.done)];
    final flashing = _flashAt != null && DateTime.now().difference(_flashAt!) < const Duration(seconds: 2);
    final actions = <(String, String)>[
      if (paused)
        ('pause', '▶  ${t.liveResume}')
      else ...[
        if (resting) ...[
          ('add', '+15 s'),
          ('skip', '${t.liveSkipRest}  ›'),
        ] else if (pendingIdx >= 0)
          ('done', '✓  ${t.liveDoneSet}')
        else if (nextEx != null)
          ('next', '${t.liveNext}  ›'),
        ('pause', '❚❚  ${t.livePause}'),
      ],
    ];

    final key = [
      name, detail, index, total, resting ? restEnd.millisecondsSinceEpoch : 0, paused, position,
      actions.length, finished.join(), _flashes, paused ? fit.sessionElapsed : 0,
    ].join('|');
    if (key == _lastKey) return;
    _lastKey = key;

    try {
      if (Platform.isIOS) {
        await _channel.invokeMethod<void>('update', {
          'exercise': name,
          'detail': detail,
          'index': index,
          'total': total,
          'restEnd': resting ? restEnd.millisecondsSinceEpoch : null,
          'restLabel': t.liveResting,
          'paused': paused,
        });
        return;
      }
      await _android.invokeMethod<void>('update', {
        'title': name,
        'detail': detail,
        'restLabel': t.liveResting,
        'next': nextName == null ? null : t.liveUpNext(nextName),
        'resting': resting,
        'paused': paused,
        'restEnd': resting ? restEnd.millisecondsSinceEpoch : 0,
        'startedAt': DateTime.now().millisecondsSinceEpoch - fit.sessionElapsed * 1000,
        'elapsed': fit.sessionElapsed,
        'index': index,
        'total': total,
        'segments': [for (final e in s.exercises) e.sets.length],
        'done': finished,
        'progress': position,
        'chip': paused ? '❚❚' : chip,
        'flash': flashing ? '+15 s' : null,
        'flashId': _flashes,
        'channel': t.liveChannel,
        'channelWhy': t.liveChannelWhy,
        'actions': [
          for (final (id, label) in actions) {'id': id, 'label': label},
        ],
      });
    } catch (e) {
      _lastKey = '';
      debugPrint('LiveWorkout no disponible: $e');
    }
  }

  static void _act(String id) {
    final s = fit.session;
    if (s == null || s.complete) return;
    switch (id) {
      case 'done':
        final ex = fit.currentExercise;
        final pending = ex?.sets.indexWhere((st) => !st.done) ?? -1;
        if (pending >= 0) fit.toggleSet(s.currentIndex, pending);
      case 'pause':
        fit.toggleSessionPause();
      case 'add':
        _flashes++;
        _flashAt = DateTime.now();
        fit.nudgeRest(15);
      case 'skip':
        fit.skipRest();
      case 'next':
        fit.goNextPending();
    }
  }

  static Future<void> end() async {
    if (!_supported) return;
    final wasShown = _lastKey.isNotEmpty;
    _lastKey = '';
    try {
      if (Platform.isIOS) {
        await _channel.invokeMethod<void>('end');
      } else if (wasShown || !_cleared) {
        await _android.invokeMethod<void>('end');
      }
      _cleared = true;
    } catch (e) {
      debugPrint('LiveWorkout.end falló: $e');
    }
  }

  static bool _cleared = false;
}
