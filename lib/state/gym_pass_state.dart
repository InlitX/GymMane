part of 'fit_state.dart';

mixin GymPassState on FitCore {
  final List<GymPass> gymPasses = [];
  String lastPassId = '';

  GymPass? get lastPass {
    if (gymPasses.isEmpty) return null;
    return gymPasses.firstWhere((p) => p.id == lastPassId, orElse: () => gymPasses.first);
  }

  String addGymPass({required String name, required String code, PassFormat format = PassFormat.qr, int hue = 0}) {
    var id = 'pass${DateTime.now().microsecondsSinceEpoch}';
    while (gymPasses.any((p) => p.id == id)) {
      id = '${id}x';
    }
    gymPasses.add(GymPass(id: id, name: name.trim(), code: code, format: format, hue: hue));
    lastPassId = id;
    _persist();
    notifyListeners();
    return id;
  }

  void updateGymPass(GymPass pass) {
    final i = gymPasses.indexWhere((p) => p.id == pass.id);
    if (i < 0) return;
    gymPasses[i] = pass.copyWith(name: pass.name.trim());
    _persist();
    notifyListeners();
  }

  VoidCallback? removeGymPass(String id) {
    final i = gymPasses.indexWhere((p) => p.id == id);
    if (i < 0) return null;
    final gone = gymPasses.removeAt(i);
    _persist();
    notifyListeners();
    return () {
      gymPasses.insert(i.clamp(0, gymPasses.length), gone);
      _persist();
      notifyListeners();
    };
  }

  void moveGymPass(int from, int to) {
    if (from < 0 || from >= gymPasses.length) return;
    final target = to.clamp(0, gymPasses.length - 1);
    if (target == from) return;
    gymPasses.insert(target, gymPasses.removeAt(from));
    _persist();
    notifyListeners();
  }

  void useGymPass(String id) {
    if (lastPassId == id) return;
    lastPassId = id;
    _persist();
  }

  void goGymPasses() => pushRoute('passes');

  void backFromGymPasses() => popRoute(fallback: 'settings');

  void _loadGymPasses(Map<String, dynamic> data) {
    gymPasses.clear();
    final raw = data['passes'];
    if (raw is List) {
      gymPasses.addAll(raw
          .map((e) => GymPass.fromJson((e as Map).cast<String, dynamic>()))
          .where((p) => p.code.isNotEmpty));
    }
    lastPassId = data['lastPass'] as String? ?? '';
  }
}
