part of 'fit_state.dart';

class Moment {
  const Moment(this.date, this.file, {this.note = ''});

  final DateTime date;
  final String file;
  final String note;

  Map<String, dynamic> toJson() =>
      {'d': date.toIso8601String(), 'f': file, if (note.isNotEmpty) 'n': note};

  factory Moment.fromJson(Map<String, dynamic> j) => Moment(
        DateTime.tryParse((j['d'] as String?) ?? '') ?? DateTime.now(),
        (j['f'] as String?) ?? '',
        note: (j['n'] as String?) ?? '',
      );
}

mixin MomentsState on FitCore {
  final List<Moment> moments = [];

  List<Moment> get momentsNewest {
    final out = [...moments]..sort((a, b) => b.date.compareTo(a.date));
    return out;
  }

  int get momentCount => moments.length;

  Future<bool> addMoment(String srcPath, {String note = ''}) async {
    final saved = await MediaStore.importFor('moment', srcPath);
    if (saved == null) return false;
    moments.add(Moment(DateTime.now(), saved, note: note));
    _persist();
    notifyListeners();
    return true;
  }

  void deleteMoment(Moment moment) {
    moments.removeWhere((m) => m.file == moment.file);
    MediaStore.delete(moment.file);
    _persist();
    notifyListeners();
  }

  void goMoments() => pushRoute('moments');

  void backFromMoments() => popRoute(fallback: 'settings');
}
