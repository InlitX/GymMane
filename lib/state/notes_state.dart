part of 'fit_state.dart';

mixin NotesState on FitCore, LibraryState {
  NoteKind? noteFilter;
  String noteScope = '';
  String? editingNoteId;
  String noteDraftExercise = '';
  DateTime noteDraftDate = DateTime.now();
  NoteKind noteDraftKind = NoteKind.note;
  bool notesAllView = false;
  DateTime noteMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime noteDay = _dayKey(DateTime.now());
  int _noteSeq = 0;

  int _noteRank(GymNote n) => n.date.millisecondsSinceEpoch;

  List<GymNote> get notesSorted {
    final list = [...notes];
    list.sort((a, b) {
      final byDay = _noteRank(b).compareTo(_noteRank(a));
      return byDay != 0 ? byDay : b.createdAt.compareTo(a.createdAt);
    });
    return list;
  }

  List<GymNote> notesFor(String exerciseId) =>
      notesSorted.where((n) => n.exerciseId == exerciseId).toList();

  GymNote? noteById(String? id) {
    if (id == null) return null;
    for (final n in notes) {
      if (n.id == id) return n;
    }
    return null;
  }

  GymNote? get editingNote => noteById(editingNoteId);

  List<GymNote> get notesInScope =>
      noteScope.isEmpty ? notesSorted : notesFor(noteScope);

  List<GymNote> get notesFiltered {
    final scoped = notesInScope;
    return noteFilter == null ? scoped : scoped.where((n) => n.kind == noteFilter).toList();
  }

  List<GymNote> notesOn(DateTime day) {
    final key = _dayKey(day);
    return notesInScope.where((n) => _dayKey(n.date) == key).toList();
  }

  List<NoteKind> noteKindsOn(DateTime day) {
    final seen = <NoteKind>[];
    for (final n in notesOn(day)) {
      if (!seen.contains(n.kind)) seen.add(n.kind);
    }
    seen.sort((a, b) => a.index.compareTo(b.index));
    return seen;
  }

  int get notesInMonth => notesInScope
      .where((n) => n.date.year == noteMonth.year && n.date.month == noteMonth.month)
      .length;

  void showNoteMonth(int delta) {
    noteMonth = DateTime(noteMonth.year, noteMonth.month + delta);
    notifyListeners();
  }

  void selectNoteDay(DateTime day) {
    noteDay = _dayKey(day);
    noteMonth = DateTime(noteDay.year, noteDay.month);
    notifyListeners();
  }

  void setNotesAllView(bool all) {
    notesAllView = all;
    notifyListeners();
  }

  Map<NoteKind, int> get noteKindCounts {
    final out = {for (final k in NoteKind.values) k: 0};
    for (final n in notesInScope) {
      out[n.kind] = out[n.kind]! + 1;
    }
    return out;
  }

  String noteExerciseName(GymNote n) {
    if (n.isGeneral) return '';
    final ex = exerciseById(n.exerciseId);
    return ex == null ? '' : exerciseName(ex);
  }

  void setNoteFilter(NoteKind? k) {
    noteFilter = noteFilter == k ? null : k;
    notifyListeners();
  }

  Future<String?> importNoteMedia(String srcPath) => MediaStore.importFor('note', srcPath);

  void saveNote({
    String? id,
    required String exerciseId,
    required DateTime date,
    required NoteKind kind,
    required String text,
    List<String> media = const [],
  }) {
    final body = text.trim();
    if (body.isEmpty) return;
    final day = _dayKey(date);
    final index = id == null ? -1 : notes.indexWhere((n) => n.id == id);

    if (index < 0) {
      notes.add(GymNote(
        id: 'n${DateTime.now().microsecondsSinceEpoch}-${_noteSeq++}',
        exerciseId: exerciseId,
        date: day,
        kind: kind,
        text: body,
        media: [...media],
        createdAt: DateTime.now(),
      ));
    } else {
      final old = notes[index];
      for (final m in old.media) {
        if (!media.contains(m)) MediaStore.delete(m);
      }
      notes[index] = old.copyWith(
        exerciseId: exerciseId,
        date: day,
        kind: kind,
        text: body,
        media: [...media],
      );
    }
    noteDay = day;
    noteMonth = DateTime(day.year, day.month);
    _persist();
    notifyListeners();
  }

  void deleteNote(String id) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index < 0) return;
    for (final m in notes[index].media) {
      MediaStore.delete(m);
    }
    notes.removeAt(index);
    _persist();
    notifyListeners();
  }

  void goNotes({String exerciseId = '', bool all = false}) {
    noteScope = exerciseId;
    noteFilter = null;
    notesAllView = all;
    noteDay = _dayKey(DateTime.now());
    noteMonth = DateTime(noteDay.year, noteDay.month);
    pushRoute('notes');
  }

  void backFromNotes() {
    if (notesAllView) {
      notesAllView = false;
      notifyListeners();
      return;
    }
    popRoute();
  }

  void openNoteEditor({String? id, String exerciseId = '', DateTime? date, NoteKind? kind}) {
    final existing = noteById(id);
    editingNoteId = existing?.id;
    noteDraftExercise = existing?.exerciseId ?? exerciseId;
    noteDraftDate = existing?.date ?? _dayKey(date ?? DateTime.now());
    noteDraftKind = existing?.kind ?? kind ?? NoteKind.note;
    pushRoute('note-edit');
  }

  void closeNoteEditor() {
    editingNoteId = null;
    popRoute();
  }
}
