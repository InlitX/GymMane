part of 'fit_state.dart';

mixin NotesState on FitCore, LibraryState {
  NoteKind? noteFilter;
  String noteScope = '';
  String noteFolderScope = '';
  String noteDraftFolder = '';
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

  List<GymNote> get notesInScope {
    final base = noteScope.isEmpty ? notesSorted : notesFor(noteScope);
    return noteFolderScope.isEmpty ? base : base.where((n) => n.folder == noteFolderScope).toList();
  }

  NoteFolder? noteFolderById(String id) {
    for (final f in noteFolders) {
      if (f.id == id) return f;
    }
    return null;
  }

  NoteFolder? get openFolder => noteFolderById(noteFolderScope);

  List<GymNote> notesInFolder(String id) => notesSorted.where((n) => n.folder == id).toList();

  String addNoteFolder(String name, int color) {
    var id = 'f${DateTime.now().microsecondsSinceEpoch}';
    while (noteFolderById(id) != null) {
      id = '${id}x';
    }
    noteFolders.add(NoteFolder(id: id, name: name.trim(), color: color));
    _persist();
    notifyListeners();
    return id;
  }

  void editNoteFolder(String id, {String? name, int? color}) {
    final f = noteFolderById(id);
    if (f == null) return;
    if (name != null && name.trim().isNotEmpty) f.name = name.trim();
    if (color != null) f.color = color;
    _persist();
    notifyListeners();
  }

  void deleteNoteFolder(String id) {
    if (noteFolderById(id) == null) return;
    noteFolders.removeWhere((f) => f.id == id);
    for (var i = 0; i < notes.length; i++) {
      if (notes[i].folder == id) notes[i] = notes[i].copyWith(folder: '');
    }
    if (noteFolderScope == id) noteFolderScope = '';
    _persist();
    notifyListeners();
  }

  void moveNoteToFolder(String noteId, String folder) {
    final i = notes.indexWhere((n) => n.id == noteId);
    if (i < 0 || notes[i].folder == folder) return;
    notes[i] = notes[i].copyWith(folder: folder);
    _persist();
    notifyListeners();
  }

  void openNoteFolder(String id) {
    if (noteFolderById(id) == null) return;
    noteFolderScope = id;
    noteFilter = null;
    notesAllView = true;
    notifyListeners();
  }

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
    bool? pinned,
    String? folder,
    List<NoteLink> links = const [],
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
        pinned: (pinned ?? false) && exerciseId.isNotEmpty,
        folder: folder ?? '',
        links: [...links],
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
        pinned: exerciseId.isEmpty ? false : pinned,
        folder: folder,
        links: [...links],
      );
    }
    noteDay = day;
    noteMonth = DateTime(day.year, day.month);
    _persist();
    notifyListeners();
  }

  void setNotePinned(String id, bool on) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index < 0 || notes[index].pinned == on || notes[index].exerciseId.isEmpty) return;
    notes[index] = notes[index].copyWith(pinned: on);
    _persist();
    notifyListeners();
  }

  List<GymNote> workoutNotesFor(String exerciseId) {
    if (exerciseId.isEmpty) return const [];
    final today = _dayKey(DateTime.now());
    final mine = notesFor(exerciseId);
    DateTime? lastDone;
    for (final s in sessions) {
      final day = _dayKey(s.day);
      if (!day.isBefore(today) || !s.exercises.any((e) => e.id == exerciseId)) continue;
      if (lastDone == null || day.isAfter(lastDone)) lastDone = day;
    }
    final since = lastDone ?? today.subtract(const Duration(days: 30));
    final next = mine.where((n) =>
        !n.pinned && n.kind == NoteKind.plan && !n.date.isBefore(since));
    return [...mine.where((n) => n.pinned), ...next.take(1)];
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
    noteFolderScope = '';
    noteFilter = null;
    notesAllView = all;
    noteDay = _dayKey(DateTime.now());
    noteMonth = DateTime(noteDay.year, noteDay.month);
    pushRoute('notes');
  }

  void backFromNotes() {
    if (noteFolderScope.isNotEmpty) {
      noteFolderScope = '';
      notifyListeners();
      return;
    }
    if (notesAllView && noteScope.isEmpty) {
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
    noteDraftFolder = existing?.folder ?? noteFolderScope;
    pushRoute('note-edit');
  }

  void closeNoteEditor() {
    editingNoteId = null;
    popRoute();
  }
}
