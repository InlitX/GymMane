part of 'fit_state.dart';

const List<int> kPhotoIntervals = [0, 15, 30, 60, 90];

typedef BodyWindow = ({
  DateTime from,
  DateTime to,
  Map<String, double> heat,
  int sessions,
  double volume,
});

mixin TimelineState on FitCore {
  int photoIntervalDays = 30;
  bool bodyTimeline = false;
  String comparePose = 'front';
  String? compareFromId;
  String? compareToId;

  List<ProgressEntry> get timeline {
    final out = shots.where((e) => !e.isEmpty).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  List<ProgressEntry> get timelineAsc => timeline.reversed.toList();

  int get shotCount => shots.fold(0, (n, e) => n + e.shots.length);

  ProgressEntry? get firstEntry {
    final asc = timelineAsc;
    return asc.isEmpty ? null : asc.first;
  }

  ProgressEntry? get lastEntry {
    final desc = timeline;
    return desc.isEmpty ? null : desc.first;
  }

  int get daysTracked {
    final a = firstEntry, b = lastEntry;
    if (a == null || b == null) return 0;
    return daysBetween(a.date, b.date);
  }

  DateTime? get nextPhotoDue {
    if (photoIntervalDays <= 0) return null;
    final last = lastEntry;
    if (last == null) return null;
    return DateTime(last.date.year, last.date.month, last.date.day + photoIntervalDays);
  }

  int? get daysUntilPhoto {
    final due = nextPhotoDue;
    if (due == null) return null;
    return daysBetween(DateTime.now(), due);
  }

  bool get photoDue {
    final left = daysUntilPhoto;
    return left != null && left <= 0;
  }

  ProgressEntry? entryById(String? id) {
    if (id == null) return null;
    for (final e in shots) {
      if (e.id == id) return e;
    }
    return null;
  }

  ProgressEntry? entryOn(DateTime day) {
    final key = _dayKey(day);
    for (final e in shots) {
      if (_dayKey(e.date) == key) return e;
    }
    return null;
  }

  int _shotSeq = 0;

  ProgressEntry _ensureEntry(DateTime day) {
    final found = entryOn(day);
    if (found != null) return found;
    final entry = ProgressEntry(
      id: 's${DateTime.now().microsecondsSinceEpoch}-${_shotSeq++}',
      date: _dayKey(day),
      weightKg: latestBodyweightKg,
    );
    shots.add(entry);
    return entry;
  }

  double? get latestBodyweightKg =>
      bodyweight.isEmpty ? null : (bodyweight.reduce((a, b) => a.date.isAfter(b.date) ? a : b)).kg;

  Future<bool> attachShot(DateTime day, String pose, String srcPath) async {
    if (!kPoses.contains(pose)) return false;
    final saved = await MediaStore.importFor('shot', srcPath);
    if (saved == null) return false;
    _replaceShot(day, pose, saved);
    return true;
  }

  void _replaceShot(DateTime day, String pose, String saved) {
    final entry = _ensureEntry(day);
    final old = entry.shot(pose);
    if (old != null) MediaStore.delete(old);
    _write(entry.copyWith(shots: {...entry.shots, pose: saved}));
    _syncPhotoReminder();
    _persist();
    notifyListeners();
  }

  void _write(ProgressEntry updated) {
    final i = shots.indexWhere((e) => e.id == updated.id);
    if (i < 0) {
      shots.add(updated);
    } else {
      shots[i] = updated;
    }
  }

  void removeShot(String entryId, String pose) {
    final entry = entryById(entryId);
    if (entry == null) return;
    final name = entry.shot(pose);
    if (name != null) MediaStore.delete(name);
    final left = {...entry.shots}..remove(pose);
    if (left.isEmpty) {
      shots.removeWhere((e) => e.id == entryId);
    } else {
      _write(entry.copyWith(shots: left));
    }
    _persist();
    notifyListeners();
  }

  void deleteEntry(String id) {
    final entry = entryById(id);
    if (entry == null) return;
    for (final name in entry.media) {
      MediaStore.delete(name);
    }
    shots.removeWhere((e) => e.id == id);
    if (compareFromId == id) compareFromId = null;
    if (compareToId == id) compareToId = null;
    _persist();
    notifyListeners();
  }

  void setBodyTimeline(bool on) {
    bodyTimeline = on;
    _persist();
    notifyListeners();
  }

  void setPhotoInterval(int days) {
    photoIntervalDays = kPhotoIntervals.contains(days) ? days : 30;
    _syncPhotoReminder();
    _persist();
    notifyListeners();
  }

  void syncPhotoReminder() => _syncPhotoReminder();

  void _syncPhotoReminder() {
    final due = nextPhotoDue;
    if (due == null) {
      ProgressReminder.instance.cancel();
      return;
    }
    ProgressReminder.instance.scheduleFor(due, photoIntervalDays);
  }

  ({ProgressEntry from, ProgressEntry to})? get comparePair {
    final asc = timelineAsc;
    if (asc.length < 2) return null;
    final from = entryById(compareFromId) ?? asc.first;
    final to = entryById(compareToId) ?? asc.last;
    return (from: from, to: to);
  }

  int get compareDays {
    final pair = comparePair;
    if (pair == null) return 0;
    return daysBetween(pair.from.date, pair.to.date).abs();
  }

  double? get compareWeightDelta {
    final pair = comparePair;
    final a = pair?.from.weightKg, b = pair?.to.weightKg;
    if (a == null || b == null) return null;
    return _round1(toDisplayWeight(b) - toDisplayWeight(a));
  }

  List<String> get posesWithBoth {
    final pair = comparePair;
    if (pair == null) return const [];
    return [
      for (final p in kPoses)
        if (pair.from.shot(p) != null && pair.to.shot(p) != null) p,
    ];
  }

  void setComparePose(String pose) {
    comparePose = pose;
    notifyListeners();
  }

  void setCompareFrom(String id) {
    compareFromId = id;
    notifyListeners();
  }

  void setCompareTo(String id) {
    compareToId = id;
    notifyListeners();
  }

  void goTimeline() => pushRoute('timeline');

  void backFromTimeline() => popRoute(fallback: 'progress');

  void goCompare() {
    final pair = comparePair;
    if (pair == null) return;
    compareFromId ??= pair.from.id;
    compareToId ??= pair.to.id;
    final poses = posesWithBoth;
    if (poses.isNotEmpty && !poses.contains(comparePose)) comparePose = poses.first;
    pushRoute('compare');
  }

  void backFromCompare() => popRoute(fallback: 'timeline');
}
