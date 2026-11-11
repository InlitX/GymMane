import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../state/fit_state.dart';

class WearSurfaces {
  WearSurfaces._();

  static const _channel = MethodChannel('gymmane/wear');
  static String _last = '';

  static void watch() {
    fit.addListener(_push);
    _push();
  }

  static void _push() {
    final planned = fit.todayRoutine;
    final data = <String, Object>{
      'done': fit.daysDoneThisWeek,
      'goal': fit.weeklyTarget,
      'streak': fit.currentStreak,
      'next': planned != null && planned.exerciseIds.isNotEmpty ? planned.name : '',
      'live': fit.session != null && !fit.session!.complete,
    };
    final signature = data.values.join('|');
    if (signature == _last) return;
    _last = signature;
    _channel.invokeMethod<void>('update', data).catchError((Object e) {
      debugPrint('WearSurfaces: $e');
    });
  }
}
