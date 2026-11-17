import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';

class QuickTiles {
  QuickTiles._();

  static const _ch = MethodChannel('gymmane/qs');
  static bool canAdd = false;
  static String _sent = '';

  static bool get available => !kIsWeb && Platform.isAndroid;

  static Future<void> init() async {
    if (!available) return;
    try {
      canAdd = await _ch.invokeMethod<bool>('canAdd') ?? false;
    } catch (_) {}
    push();
    fit.addListener(push);
  }

  static Map<String, String> state() {
    final now = DateTime.now();
    final names = [
      for (final r in fit.routinesOn(now))
        if (r.exerciseIds.isNotEmpty) r.name,
    ];
    final pass = fit.quickPass;
    return {
      'todayLabel': t.qsToday,
      'today': names.isNotEmpty ? names.join(' · ') : (fit.restingToday ? t.qsRest : ''),
      'passLabel': pass?.name ?? t.qsPass,
      'pass': pass == null ? '' : t.qsPass,
    };
  }

  static void push() {
    if (!available) return;
    final s = state();
    final sig = jsonEncode(s);
    if (sig == _sent) return;
    _sent = sig;
    unawaited(_ch.invokeMethod<void>('update', s).catchError((_) {}));
  }

  static Future<String> add(String tile) async {
    if (!available) return 'unsupported';
    push();
    try {
      return await _ch.invokeMethod<String>('add', {'tile': tile}) ?? 'no';
    } catch (_) {
      return 'unsupported';
    }
  }
}
