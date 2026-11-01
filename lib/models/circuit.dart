class CircuitStep {
  CircuitStep(this.exerciseId, {this.work = 40, this.rest = 15});

  String exerciseId;
  int work;
  int rest;

  CircuitStep copy() => CircuitStep(exerciseId, work: work, rest: rest);

  Map<String, dynamic> toJson() => {'e': exerciseId, 'w': work, 'r': rest};

  static CircuitStep? fromJson(Map<String, dynamic> j) {
    final id = j['e'] as String? ?? '';
    if (id.isEmpty) return null;
    return CircuitStep(id,
        work: ((j['w'] as num?)?.toInt() ?? 40).clamp(5, 3600), rest: ((j['r'] as num?)?.toInt() ?? 0).clamp(0, 3600));
  }
}

class Circuit {
  Circuit(this.id, this.name, {List<CircuitStep>? steps, this.rounds = 3, this.roundRest = 60})
      : steps = steps ?? [];

  final String id;
  String name;
  final List<CircuitStep> steps;
  int rounds;
  int roundRest;

  int get totalSeconds {
    if (steps.isEmpty) return 0;
    var round = 0;
    for (var i = 0; i < steps.length; i++) {
      round += steps[i].work;
      if (i < steps.length - 1) round += steps[i].rest;
    }
    return round * rounds + roundRest * (rounds - 1);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'n': name,
        's': steps.map((s) => s.toJson()).toList(),
        'rn': rounds,
        'rr': roundRest,
      };

  static Circuit? fromJson(Map<String, dynamic> j) {
    final id = j['id'] as String? ?? '';
    if (id.isEmpty) return null;
    return Circuit(
      id,
      j['n'] as String? ?? '',
      steps: [
        for (final s in (j['s'] as List?) ?? const [])
          if (s is Map) ?CircuitStep.fromJson(s.cast<String, dynamic>()),
      ],
      rounds: ((j['rn'] as num?)?.toInt() ?? 3).clamp(1, 50),
      roundRest: ((j['rr'] as num?)?.toInt() ?? 60).clamp(0, 3600),
    );
  }
}
