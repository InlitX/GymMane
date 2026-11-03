part of 'fit_state.dart';

mixin CircuitState on FitCore, LibraryState {
  final List<Circuit> circuits = [];

  Circuit? circuitById(String id) {
    for (final c in circuits) {
      if (c.id == id) return c;
    }
    return null;
  }

  Circuit newCircuit() {
    var id = 'k${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    while (circuitById(id) != null) {
      id = '${id}x';
    }
    return Circuit(id, '');
  }

  void saveCircuit(Circuit c) {
    c.name = c.name.trim().isEmpty ? t.circuitDefaultName : c.name.trim();
    if (c.name.length > 60) c.name = c.name.substring(0, 60);
    c.rounds = c.rounds.clamp(1, 50);
    c.roundRest = c.roundRest.clamp(0, 3600);
    final i = circuits.indexWhere((x) => x.id == c.id);
    if (i < 0) {
      circuits.add(c);
    } else {
      circuits[i] = c;
    }
    _persist();
    notifyListeners();
  }

  void deleteCircuit(String id) {
    circuits.removeWhere((c) => c.id == id);
    _persist();
    notifyListeners();
  }

  Circuit copyCircuit(Circuit c) => Circuit(c.id, c.name,
      steps: [for (final s in c.steps) s.copy()], rounds: c.rounds, roundRest: c.roundRest);

  LoggedSession? logCircuit(Circuit c, List<({int step, int seconds})> done, DateTime start, DateTime end) {
    final byExercise = <String, List<LoggedSet>>{};
    for (final d in done) {
      if (d.step < 0 || d.step >= c.steps.length || d.seconds <= 0) continue;
      byExercise.putIfAbsent(c.steps[d.step].exerciseId, () => []).add(LoggedSet(0, 0, sec: d.seconds));
    }
    final exercises = <LoggedExercise>[
      for (final e in byExercise.entries)
        if (exerciseById(e.key) case final ex?) LoggedExercise(ex.id, ex.name, ex.primary, e.value),
    ];
    if (exercises.isEmpty) return null;
    final seconds = end.difference(start).inSeconds.clamp(1, 24 * 3600);
    final entry = LoggedSession(end, seconds, exercises, name: c.name);
    sessions.add(entry);
    sessions.sort((a, b) => a.date.compareTo(b.date));
    healthSave(entry);
    persistNow();
    _refreshWidgets();
    refreshAwards();
    notifyListeners();
    return entry;
  }

  void loadCircuits(List? raw) {
    circuits
      ..clear()
      ..addAll([
        for (final e in raw ?? const [])
          if (e is Map) ?Circuit.fromJson(e.cast<String, dynamic>()),
      ]);
  }

  List<Map<String, dynamic>> circuitsJson() => circuits.map((c) => c.toJson()).toList();
}
