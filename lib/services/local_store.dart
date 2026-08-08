import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/workout.dart';

class Store {
  Store._();
  static final Store instance = Store._();

  static const _key = 'gymmane_v1';
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Map<String, dynamic> load() {
    final raw = _prefs?.getString(_key);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (_) {
      return {};
    }
  }

  Future<void> save(Map<String, dynamic> data) async {
    try {
      await _prefs?.setString(_key, jsonEncode(data));
    } catch (_) {}
  }

  String exportJson(Map<String, dynamic> data) =>
      const JsonEncoder.withIndent('  ').convert(data);

  String exportCsv(List<LoggedSession> sessions) {
    final rows = StringBuffer('date,exercise,muscle,set,reps,weight_kg,volume_kg,est_1rm_kg\n');
    final ordered = [...sessions]..sort((a, b) => a.date.compareTo(b.date));
    for (final s in ordered) {
      final day = s.date.toIso8601String().split('T').first;
      for (final e in s.exercises) {
        for (var i = 0; i < e.sets.length; i++) {
          final st = e.sets[i];
          rows.writeln([
            day,
            _csv(e.name),
            e.primary,
            i + 1,
            st.reps,
            _num(st.weight),
            _num(st.volume),
            _num(st.oneRm),
          ].join(','));
        }
      }
    }
    return rows.toString();
  }

  static String _csv(String v) =>
      v.contains(RegExp('[",\n]')) ? '"${v.replaceAll('"', '""')}"' : v;

  static String _num(double v) => v.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');

  Map<String, dynamic>? tryParse(String raw) {
    try {
      final decoded = jsonDecode(raw.trim());
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }
}
