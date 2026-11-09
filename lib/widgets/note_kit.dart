import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:video_player/video_player.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/note.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'exercise_media.dart';
import 'exercise_preview.dart';
import 'dialogs.dart';
import 'file_thumb.dart';
import 'glass.dart';
import 'note_folder.dart';
import 'ui_kit.dart';

Color noteKindColor(GymColors gc, NoteKind k) => switch (k) {
      NoteKind.note => gc.info,
      NoteKind.plan => gc.warn,
      NoteKind.done => gc.sage,
      NoteKind.pain => gc.danger,
    };

String noteKindLabel(NoteKind k) => switch (k) {
      NoteKind.note => t.noteKindNote,
      NoteKind.plan => t.noteKindPlan,
      NoteKind.done => t.noteKindDone,
      NoteKind.pain => t.noteKindPain,
    };

IconData noteKindIcon(NoteKind k) => switch (k) {
      NoteKind.note => PhosphorIconsRegular.notePencil,
      NoteKind.plan => PhosphorIconsRegular.crosshair,
      NoteKind.done => PhosphorIconsRegular.checkCircle,
      NoteKind.pain => PhosphorIconsRegular.warning,
    };

String noteDayLabel(DateTime d) {
  final now = DateTime.now();
  final diff = daysBetween(d, now);
  if (diff == 0) return t.noteToday;
  if (diff == 1) return t.noteYesterday;
  return now.year == d.year ? t.shortDate(d) : t.shortDateYear(d);
}

class NoteCalendar extends StatelessWidget {
  const NoteCalendar({
    super.key,
    required this.month,
    required this.selected,
    required this.kindsOn,
    required this.onPick,
    required this.onHold,
    required this.onMonth,
  });

  final DateTime month;
  final DateTime selected;
  final List<NoteKind> Function(DateTime day) kindsOn;
  final ValueChanged<DateTime> onPick;
  final ValueChanged<DateTime> onHold;
  final ValueChanged<int> onMonth;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final today = DateTime.now();
    final first = DateTime(month.year, month.month);
    final days = DateTime(month.year, month.month + 1, 0).day;
    final lead = (first.weekday - fit.weekStartDay + 7) % 7;

    return Column(
      children: [
        Row(
          children: [
            _arrow(gc, PhosphorIconsBold.caretLeft, t.notePrevMonth, () => onMonth(-1)),
            Expanded(
              child: Text(t.monthYear(month),
                  textAlign: TextAlign.center,
                  style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
            ),
            _arrow(gc, PhosphorIconsBold.caretRight, t.noteNextMonth, () => onMonth(1)),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (int i = 0; i < 7; i++)
              Expanded(
                child: Text(t.weekdayInitial(fit.weekdayAt(i)).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(10.5,
                        weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 1)),
              ),
          ],
        ),
        const SizedBox(height: 8),
        for (int row = 0; row * 7 < lead + days; row++)
          Row(
            children: [
              for (int col = 0; col < 7; col++)
                Expanded(
                  child: () {
                    final n = row * 7 + col - lead + 1;
                    if (n < 1 || n > days) return const SizedBox(height: 46);
                    return _cell(gc, DateTime(month.year, month.month, n), today);
                  }(),
                ),
            ],
          ),
      ],
    );
  }

  Widget _arrow(GymColors gc, IconData icon, String label, VoidCallback onTap) => Semantics(
        button: true,
        label: label,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
            child: Icon(icon, size: 13, color: gc.text),
          ),
        ),
      );

  Widget _cell(GymColors gc, DateTime day, DateTime today) {
    final kinds = kindsOn(day);
    final isToday = day.year == today.year && day.month == today.month && day.day == today.day;
    final on = day == DateTime(selected.year, selected.month, selected.day);

    return Semantics(
      button: true,
      selected: on,
      label: t.fullDate(day),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onPick(day),
        onLongPress: () => onHold(day),
        child: Container(
          height: 46,
          margin: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: on ? gc.emberSoft : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: on ? gc.ember : Colors.transparent),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${day.day}',
                  style: AppTheme.f(13.5,
                      weight: isToday || on ? FontWeight.w700 : FontWeight.w500,
                      color: on
                          ? gc.text
                          : isToday
                              ? gc.ember
                              : gc.textSecondary)),
              const SizedBox(height: 4),
              SizedBox(
                height: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final k in kinds.take(3)) ...[
                      if (k != kinds.first) const SizedBox(width: 3),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: noteKindColor(gc, k),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showNoteDaySheet(BuildContext context, DateTime day) async {
  final gc = context.gc;
  final kind = await showAppSheet<NoteKind>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: sheetPad(context, bottom: 26),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(noteDayLabel(day), subtitle: t.fullDate(day)),
          const SizedBox(height: 14),
          OptionGroup([
            for (final k in NoteKind.values)
              OptionItem(
                noteKindLabel(k),
                leading: Icon(noteKindIcon(k), size: 19, color: noteKindColor(gc, k)),
                onTap: () => Navigator.of(sheet).pop(k),
              ),
          ]),
        ],
      ),
    ),
  );
  if (kind != null) fit.openNoteEditor(exerciseId: fit.noteScope, date: day, kind: kind);
}

class NoteKindBadge extends StatelessWidget {
  const NoteKindBadge({super.key, required this.kind, this.compact = false});

  final NoteKind kind;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = noteKindColor(context.gc, kind);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 9, vertical: compact ? 3 : 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(noteKindIcon(kind), size: compact ? 10 : 12, color: color),
          SizedBox(width: compact ? 4 : 5),
          Text(noteKindLabel(kind).toUpperCase(),
              style: AppTheme.f(compact ? 9.5 : 10.5,
                  weight: FontWeight.w600, color: color, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class NoteKindPicker extends StatelessWidget {
  const NoteKindPicker({super.key, required this.selected, required this.onChanged});

  final NoteKind selected;
  final ValueChanged<NoteKind> onChanged;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Row(
      children: [
        for (final kind in NoteKind.values) ...[
          if (kind != NoteKind.values.first) const SizedBox(width: 8),
          Expanded(
            child: Semantics(
              button: true,
              selected: selected == kind,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(kind),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: selected == kind
                        ? noteKindColor(gc, kind).withValues(alpha: 0.16)
                        : gc.bgRaised,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Icon(noteKindIcon(kind),
                          size: 18,
                          color: selected == kind ? noteKindColor(gc, kind) : gc.textTertiary),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          noteKindLabel(kind),
                          maxLines: 1,
                          style: AppTheme.f(11.5,
                              weight: FontWeight.w600,
                              color: selected == kind
                                  ? noteKindColor(gc, kind)
                                  : gc.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class NoteFilterBar extends StatelessWidget {
  const NoteFilterBar({
    super.key,
    required this.selected,
    required this.counts,
    required this.onPick,
    this.padding = EdgeInsets.zero,
  });

  final NoteKind? selected;
  final EdgeInsets padding;
  final Map<NoteKind, int> counts;
  final ValueChanged<NoteKind?> onPick;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;

    Widget chip({
      required String label,
      required Color color,
      required bool on,
      required VoidCallback onTap,
    }) =>
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            margin: const EdgeInsetsDirectional.only(end: 8),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              color: on ? color.withValues(alpha: 0.16) : gc.bgRaised,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: on ? color : gc.border),
            ),
            child: Center(
              child: Text(label,
                  style: AppTheme.f(12.5,
                      weight: FontWeight.w600, color: on ? color : gc.textSecondary)),
            ),
          ),
        );

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: padding.copyWith(right: padding.right - 8),
        children: [
          chip(
            label: t.noteFilterAll,
            color: gc.ember,
            on: selected == null,
            onTap: () => onPick(null),
          ),
          for (final kind in NoteKind.values)
            if ((counts[kind] ?? 0) > 0)
              chip(
                label: '${noteKindLabel(kind)} ${counts[kind]}',
                color: noteKindColor(gc, kind),
                on: selected == kind,
                onTap: () => onPick(kind),
              ),
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.showExercise = true,
    this.showDate = true,
    this.onTap,
  });

  final GymNote note;
  final bool showExercise;
  final bool showDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final color = noteKindColor(gc, note.kind);
    final exercise = showExercise && !note.isGeneral ? fit.exerciseById(note.exerciseId) : null;
    final folder = fit.noteFolderScope.isEmpty ? fit.noteFolderById(note.folder) : null;
    final day = showDate ? noteDayLabel(note.date) : '';
    final dark = gc.bg.computeLuminance() < 0.5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Pressable(
        scale: 0.98,
        onTap: onTap ?? () => showNoteSheet(context, note),
        child: Stack(children: [
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.lerp(gc.bgRaised, Colors.black, dark ? 0.3 : 0.08),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Container(
          margin: const EdgeInsets.only(bottom: 5),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: dark ? 0.28 : 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: CustomPaint(
            foregroundPainter: _NoteEar(color: color, bg: gc.bg, paper: gc.bgRaised, dark: dark),
            painter: _NoteGlow(color: color, glow: dark ? 0.13 : 0.1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (exercise != null) ...[
                        GestureDetector(
                          onTap: () => showExercisePreview(context, exercise),
                          child: SizedBox(
                            width: 40,
                            child: ExerciseMedia(ex: exercise, height: 40, radius: 12, bordered: false),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Icon(noteKindIcon(note.kind), size: 13, color: color),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(noteKindLabel(note.kind).toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(10, weight: FontWeight.w800, color: color, letterSpacing: 1.2)),
                            ),
                            if (note.pinned) ...[
                              const SizedBox(width: 6),
                              Semantics(
                                label: t.workoutNoteEvery,
                                child: Icon(PhosphorIconsFill.pushPin, size: 12, color: gc.accent),
                              ),
                            ],
                          ]),
                          if (exercise != null) ...[
                            const SizedBox(height: 2),
                            Text(exerciseName(exercise),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
                          ],
                        ]),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(note.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text, height: 1.25, letterSpacing: -0.2)),
                  if (note.body.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(note.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                  ],
                  if (note.media.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    NotePhotos(media: note.media, scope: note.id),
                  ],
                  if (folder != null || day.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(children: [
                      if (folder != null)
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
                            decoration: BoxDecoration(
                              color: gc.text.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(color: noteFolderHue(folder), shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(folder.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary)),
                              ),
                            ]),
                          ),
                        ),
                      const Spacer(),
                      if (day.isNotEmpty)
                        Text(day, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
                    ]),
                  ],
                ],
              ),
            ),
          ),
        ),
        ]),
      ),
    );
  }
}

class _NoteGlow extends CustomPainter {
  _NoteGlow({required this.color, required this.glow});

  final Color color;
  final double glow;

  @override
  void paint(Canvas canvas, Size size) {
    final light = RadialGradient(
      center: const Alignment(-1, -1),
      radius: 1.1,
      colors: [color.withValues(alpha: glow), color.withValues(alpha: 0)],
    ).createShader(Rect.fromLTWH(0, 0, size.width * 0.9, size.height * 1.6));
    canvas.drawRect(Offset.zero & size, Paint()..shader = light);
  }

  @override
  bool shouldRepaint(_NoteGlow o) => o.color != color || o.glow != glow;
}

class _NoteEar extends CustomPainter {
  _NoteEar({required this.color, required this.bg, required this.paper, required this.dark});

  final Color color;
  final Color bg;
  final Color paper;
  final bool dark;

  static const double _ear = 24;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width;
    canvas.drawPath(
      Path()
        ..moveTo(x - _ear, 0)
        ..lineTo(x, 0)
        ..lineTo(x, _ear)
        ..close(),
      Paint()..color = bg,
    );
    final flap = Path()
      ..moveTo(x - _ear, 0)
      ..lineTo(x - _ear, _ear - 5)
      ..quadraticBezierTo(x - _ear, _ear, x - _ear + 5, _ear)
      ..lineTo(x, _ear)
      ..close();
    canvas.drawPath(
      flap.shift(const Offset(-2, 2.5)),
      Paint()
        ..color = Colors.black.withValues(alpha: dark ? 0.45 : 0.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    final base = Color.lerp(paper, color, 0.22)!;
    canvas.drawPath(
      flap,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.lerp(base, Colors.black, dark ? 0.28 : 0.1)!,
            base,
            Color.lerp(base, Colors.white, dark ? 0.12 : 0.35)!,
          ],
          stops: const [0, 0.55, 1],
        ).createShader(Rect.fromLTWH(x - _ear, 0, _ear, _ear)),
    );
    canvas.drawLine(
      Offset(x - _ear + 0.5, 0.5),
      Offset(x - 0.5, _ear - 0.5),
      Paint()
        ..color = Colors.white.withValues(alpha: dark ? 0.1 : 0.4)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_NoteEar o) => o.color != color || o.bg != bg || o.paper != paper || o.dark != dark;
}

class NotePhotos extends StatelessWidget {
  const NotePhotos({super.key, required this.media, this.scope});

  final List<String> media;
  final String? scope;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget tile(int i, double w, double h, {String? badge}) {
      final name = media[i];
      final path = MediaStore.pathFor(name);
      final photo = path != null && !MediaStore.isVideo(name);
      Widget inner = photo
          ? FileThumb(path, width: w, height: h, errorBuilder: (_, _, _) => const SizedBox.shrink())
          : Center(
              child: Icon(path == null ? PhosphorIconsRegular.imageSquare : PhosphorIconsFill.playCircle,
                  size: 26, color: gc.textSecondary));
      final tag = scope;
      if (photo && tag != null) inner = Hero(tag: noteHeroTag(tag, name), child: inner);
      return GestureDetector(
        onTap: () => showNoteMedia(context, media, i, scope: scope),
        child: Container(
          width: w,
          height: h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
          child: Stack(fit: StackFit.expand, children: [
            inner,
            if (badge != null)
              ColoredBox(
                color: const Color(0x8C000000),
                child: Center(
                  child: Text(badge, style: AppTheme.f(16, weight: FontWeight.w800, color: Colors.white)),
                ),
              ),
          ]),
        ),
      );
    }

    return LayoutBuilder(builder: (context, box) {
      final w = box.maxWidth;
      const gap = 6.0;
      if (media.length == 1) return tile(0, w, 160);
      if (media.length == 2) {
        final half = (w - gap) / 2;
        return Row(children: [tile(0, half, 130), const SizedBox(width: gap), tile(1, half, 130)]);
      }
      final big = (w - gap) * 0.62;
      final side = w - gap - big;
      final extra = media.length - 3;
      return Row(children: [
        tile(0, big, 160),
        const SizedBox(width: gap),
        Column(children: [
          tile(1, side, (160 - gap) / 2),
          const SizedBox(height: gap),
          tile(2, side, (160 - gap) / 2, badge: extra > 0 ? '+$extra' : null),
        ]),
      ]);
    });
  }
}

Future<void> showNoteSheet(BuildContext context, GymNote note) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NoteSheetView(id: note.id),
    );

class _NoteSheetView extends StatelessWidget {
  const _NoteSheetView({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fit,
      builder: (context, _) {
        final note = fit.noteById(id);
        if (note == null) return const SizedBox.shrink();
        final gc = context.gc;
        final color = noteKindColor(gc, note.kind);
        final exercise = note.isGeneral ? null : fit.exerciseById(note.exerciseId);
        final folder = fit.noteFolderById(note.folder);
        return AppSheet(maxHeight: 0.92, children: [
          Row(children: [
            Icon(noteKindIcon(note.kind), size: 15, color: color),
            const SizedBox(width: 6),
            Text(noteKindLabel(note.kind).toUpperCase(),
                style: AppTheme.f(11, weight: FontWeight.w800, color: color, letterSpacing: 1.3)),
            if (note.pinned) ...[
              const SizedBox(width: 8),
              Icon(PhosphorIconsFill.pushPin, size: 13, color: gc.accent),
            ],
            const SizedBox(width: 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(t.fullDate(note.date),
                    maxLines: 1, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
              ),
            ),
          ]),
          const SizedBox(height: 14),
          Text(note.title,
              style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, height: 1.2, letterSpacing: -0.5)),
          if (note.body.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(note.body, style: AppTheme.f(15, weight: FontWeight.w500, color: gc.textSecondary, height: 1.55)),
          ],
          if (exercise != null) ...[
            const SizedBox(height: 18),
            Pressable(
              scale: 0.98,
              onTap: () => showExercisePreview(context, exercise),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  SizedBox(width: 48, child: ExerciseMedia(ex: exercise, height: 48, radius: 12, bordered: false)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(exerciseName(exercise),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, height: 1.25)),
                  ),
                  Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
                  const SizedBox(width: 6),
                ]),
              ),
            ),
          ],
          if (note.links.isNotEmpty) ...[
            const SizedBox(height: 18),
            for (final link in note.links) ...[
              NoteLinkTile(link: link, onTap: () => openNoteLink(context, link)),
              const SizedBox(height: 8),
            ],
          ],
          if (note.media.isNotEmpty) ...[
            const SizedBox(height: 18),
            _AllPhotos(media: note.media, scope: 'sheet${note.id}'),
          ],
          const SizedBox(height: 20),
          Row(children: [
            if (folder != null)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 6, 12, 6),
                  decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(100)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(color: noteFolderHue(folder), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(folder.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
                    ),
                  ]),
                ),
              ),
            const Spacer(),
          ]),
          const SizedBox(height: 16),
          GhostButton(
            label: t.editNote,
            icon: PhosphorIconsRegular.pencilSimple,
            onTap: () {
              Navigator.of(context).pop();
              fit.openNoteEditor(id: note.id);
            },
          ),
        ]);
      },
    );
  }
}

class NoteLinkTile extends StatelessWidget {
  const NoteLinkTile({super.key, required this.link, required this.onTap, this.onRemove});

  final NoteLink link;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      scale: 0.98,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 6, 10),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Icon(PhosphorIconsRegular.link, size: 18, color: gc.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(link.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, height: 1.25)),
              const SizedBox(height: 2),
              Text(link.url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
            ]),
          ),
          const SizedBox(width: 6),
          if (onRemove == null)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Icon(PhosphorIconsRegular.arrowUpRight, size: 15, color: gc.textTertiary),
            )
          else
            Semantics(
              button: true,
              label: t.delete,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onRemove,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(PhosphorIconsBold.x, size: 13, color: gc.textTertiary),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

class _AllPhotos extends StatelessWidget {
  const _AllPhotos({required this.media, required this.scope});

  final List<String> media;
  final String scope;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget tile(int i, double w, double h) {
      final name = media[i];
      final path = MediaStore.pathFor(name);
      final photo = path != null && !MediaStore.isVideo(name);
      Widget inner = photo
          ? FileThumb(path, width: w, height: h, errorBuilder: (_, _, _) => const SizedBox.shrink())
          : Center(
              child: Icon(path == null ? PhosphorIconsRegular.imageSquare : PhosphorIconsFill.playCircle,
                  size: 30, color: gc.textSecondary));
      if (photo) inner = Hero(tag: noteHeroTag(scope, name), child: inner);
      return GestureDetector(
        onTap: () => showNoteMedia(context, media, i, scope: scope),
        child: Container(
          width: w,
          height: h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
          child: inner,
        ),
      );
    }

    return LayoutBuilder(builder: (context, box) {
      final w = box.maxWidth;
      const gap = 8.0;
      final half = (w - gap) / 2;
      final rest = media.length - 1;
      return Column(children: [
        tile(0, w, w * 0.66),
        for (var r = 0; r * 2 < rest; r++) ...[
          const SizedBox(height: gap),
          Row(children: [
            tile(1 + r * 2, 2 + r * 2 > rest ? w : half, half),
            if (2 + r * 2 <= rest) ...[const SizedBox(width: gap), tile(2 + r * 2, half, half)],
          ]),
        ],
      ]);
    });
  }
}

class NoteMediaStrip extends StatelessWidget {
  const NoteMediaStrip({super.key, required this.media, this.size = 64, this.max = 4, this.scope});

  final List<String> media;
  final double size;
  final int max;
  final String? scope;

  @override
  Widget build(BuildContext context) {
    final shown = media.take(max).toList();
    final extra = media.length - shown.length;
    return SizedBox(
      height: size,
      child: Row(
        children: [
          for (int i = 0; i < shown.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            GestureDetector(
              onTap: () => showNoteMedia(context, media, i, scope: scope),
              child: NoteThumb(
                name: shown[i],
                size: size,
                scope: scope,
                badge: i == shown.length - 1 && extra > 0 ? '+$extra' : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String noteHeroTag(String scope, String name) => 'nm:$scope:$name';

class NoteThumb extends StatelessWidget {
  const NoteThumb({
    super.key,
    required this.name,
    this.size = 64,
    this.badge,
    this.onRemove,
    this.natural = false,
    this.scope,
  });

  final String name;
  final double size;
  final String? badge;
  final VoidCallback? onRemove;
  final bool natural;
  final String? scope;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final path = MediaStore.pathFor(name);
    final photo = path != null && !MediaStore.isVideo(name);
    final fallback = Icon(PhosphorIconsRegular.imageSquare, size: size * 0.34, color: gc.textTertiary);

    Widget inner;
    if (path == null) {
      inner = fallback;
    } else if (!photo) {
      inner = Icon(PhosphorIconsFill.playCircle, size: size * 0.38, color: gc.textSecondary);
    } else if (natural) {
      inner = FileThumb(
        path,
        height: size,
        fit: BoxFit.contain,
        frameBuilder: (_, child, frame, sync) =>
            frame == null && !sync ? SizedBox(width: size, height: size) : child,
        errorBuilder: (_, _, _) => SizedBox(width: size, height: size, child: fallback),
      );
    } else {
      inner = FileThumb(
        path,
        width: size,
        height: size,
        errorBuilder: (_, _, _) => fallback,
      );
    }
    final tag = scope;
    if (photo && tag != null) inner = Hero(tag: noteHeroTag(tag, name), child: inner);

    final tile = natural && photo
        ? ClipRRect(borderRadius: BorderRadius.circular(16), child: inner)
        : Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Center(child: inner),
          );

    return SizedBox(
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          tile,
          if (badge != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xA6000000),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(badge!,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          if (onRemove != null)
            Positioned(
              top: -6,
              right: -6,
              child: Semantics(
                button: true,
                label: t.noteRemoveMedia,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: gc.bgRaised2,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(PhosphorIconsBold.x, size: 11, color: gc.text),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> showNoteMedia(BuildContext context, List<String> media, int index, {String? scope}) =>
    Navigator.of(context).push(PageRouteBuilder<void>(
      opaque: false,
      barrierDismissible: true,
      barrierColor: const Color(0xF2000000),
      barrierLabel: t.cancel,
      transitionDuration: const Duration(milliseconds: 360),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => _MediaViewer(media: media, start: index, scope: scope),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child),
    ));

class _MediaViewer extends StatefulWidget {
  const _MediaViewer({required this.media, required this.start, this.scope});

  final List<String> media;
  final int start;
  final String? scope;

  @override
  State<_MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<_MediaViewer> {
  late final PageController _pages = PageController(initialPage: widget.start);
  late int _index = widget.start;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = widget.scope;
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pages,
            itemCount: widget.media.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) {
              final name = widget.media[i];
              final path = MediaStore.pathFor(name);
              if (path == null) return const SizedBox.shrink();
              if (MediaStore.isVideo(name)) {
                return _FullVideo(key: ValueKey(path), path: path);
              }
              final image = Image.file(File(path), fit: BoxFit.contain);
              return InteractiveViewer(
                maxScale: 5,
                child: Center(
                  child: scope == null ? image : Hero(tag: noteHeroTag(scope, name), child: image),
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Semantics(
                      button: true,
                      label: t.cancel,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(PhosphorIconsBold.x, size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (widget.media.length > 1)
                      Text('${_index + 1}/${widget.media.length}',
                          style: AppTheme.f(14, weight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullVideo extends StatefulWidget {
  const _FullVideo({super.key, required this.path});
  final String path;

  @override
  State<_FullVideo> createState() => _FullVideoState();
}

class _FullVideoState extends State<_FullVideo> {
  VideoPlayerController? _c;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final c = VideoPlayerController.file(File(widget.path));
      await c.initialize();
      await c.setLooping(true);
      await c.play();
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() => _c = c);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _c;
    if (_failed) {
      return const Center(
          child: Icon(PhosphorIconsRegular.videoCamera, size: 48, color: Colors.white38));
    }
    if (c == null) {
      return const Center(
        child: CupertinoActivityIndicator(radius: 13, color: Colors.white70),
      );
    }
    return GestureDetector(
      onTap: () => setState(() => c.value.isPlaying ? c.pause() : c.play()),
      child: Center(
        child: AspectRatio(aspectRatio: c.value.aspectRatio, child: VideoPlayer(c)),
      ),
    );
  }
}
