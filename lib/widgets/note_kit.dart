import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:video_player/video_player.dart';

import '../l10n/l10n.dart';
import '../models/note.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

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
    final lead = (first.weekday - t.firstWeekday + 7) % 7;

    return Column(
      children: [
        Row(
          children: [
            _arrow(gc, PhosphorIconsBold.caretLeft, t.notePrevMonth, () => onMonth(-1)),
            Expanded(
              child: Text(t.monthYear(month),
                  textAlign: TextAlign.center,
                  style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
            ),
            _arrow(gc, PhosphorIconsBold.caretRight, t.noteNextMonth, () => onMonth(1)),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (int i = 0; i < 7; i++)
              Expanded(
                child: Text(t.weekdayInitial((t.firstWeekday + i - 1) % 7 + 1).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTheme.d(10.5,
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
                  style: AppTheme.d(13.5,
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
  final kind = await showModalBottomSheet<NoteKind>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration:
                  BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 18),
          Text(noteDayLabel(day).toUpperCase(),
              style: AppTheme.d(13, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
          const SizedBox(height: 3),
          Text(t.fullDate(day), style: AppTheme.s(12.5, color: gc.textTertiary)),
          const SizedBox(height: 18),
          for (final k in NoteKind.values) ...[
            if (k != NoteKind.values.first) const SizedBox(height: 8),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(sheet).pop(k),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: gc.bgRaised2,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gc.border),
                ),
                child: Row(
                  children: [
                    Icon(noteKindIcon(k), size: 18, color: noteKindColor(gc, k)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(noteKindLabel(k),
                          style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                    ),
                    Icon(PhosphorIconsRegular.caretRight, size: 14, color: gc.textTertiary),
                  ],
                ),
              ),
            ),
          ],
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
              style: AppTheme.d(compact ? 9.5 : 10.5,
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
                        ? noteKindColor(gc, kind).withValues(alpha: 0.14)
                        : gc.bgRaised,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected == kind ? noteKindColor(gc, kind) : gc.border,
                      width: selected == kind ? 1.4 : 1,
                    ),
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
                          style: AppTheme.s(11.5,
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
  });

  final NoteKind? selected;
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
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              color: on ? color.withValues(alpha: 0.16) : gc.bgRaised,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: on ? color : gc.border),
            ),
            child: Center(
              child: Text(label,
                  style: AppTheme.s(12.5,
                      weight: FontWeight.w600, color: on ? color : gc.textSecondary)),
            ),
          ),
        );

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
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
    final exercise = showExercise ? fit.noteExerciseName(note) : '';
    final day = showDate ? noteDayLabel(note.date) : '';
    final meta = [day, exercise].where((p) => p.isNotEmpty).join(' · ');

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () => fit.openNoteEditor(id: note.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _NoteRail(color))),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 13, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      NoteKindBadge(kind: note.kind, compact: true),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: AppTheme.s(11.5, color: gc.textTertiary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Text(note.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.s(15, weight: FontWeight.w600, color: gc.text, height: 1.3)),
                  if (note.body.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(note.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.s(13, color: gc.textSecondary, height: 1.4)),
                  ],
                  if (note.media.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    NoteMediaStrip(media: note.media),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteRail extends CustomPainter {
  _NoteRail(this.color);

  final Color color;
  static const double _w = 3;
  static const double _r = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final fade = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [color, color, color.withValues(alpha: 0)],
      stops: const [0, 0.06, 0.26],
    ).createShader(Offset.zero & size);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(_w / 2, _w / 2, size.width - _w, size.height - _w),
        const Radius.circular(_r - _w / 2),
      ),
      Paint()
        ..shader = fade
        ..style = PaintingStyle.stroke
        ..strokeWidth = _w,
    );
  }

  @override
  bool shouldRepaint(_NoteRail o) => o.color != color;
}

class NoteMediaStrip extends StatelessWidget {
  const NoteMediaStrip({super.key, required this.media, this.size = 64, this.max = 4});

  final List<String> media;
  final double size;
  final int max;

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
              onTap: () => showNoteMedia(context, media, i),
              child: NoteThumb(
                name: shown[i],
                size: size,
                badge: i == shown.length - 1 && extra > 0 ? '+$extra' : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class NoteThumb extends StatelessWidget {
  const NoteThumb({super.key, required this.name, this.size = 64, this.badge, this.onRemove});

  final String name;
  final double size;
  final String? badge;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final path = MediaStore.pathFor(name);

    Widget inner;
    if (path == null) {
      inner = Icon(PhosphorIconsRegular.imageSquare, size: size * 0.34, color: gc.textTertiary);
    } else if (MediaStore.isVideo(name)) {
      inner = Icon(PhosphorIconsFill.playCircle, size: size * 0.38, color: gc.textSecondary);
    } else {
      inner = Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (_, _, _) =>
            Icon(PhosphorIconsRegular.imageSquare, size: size * 0.34, color: gc.textTertiary),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: gc.bgRaised2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gc.border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Center(child: inner),
            ),
          ),
          if (badge != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xA6000000),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(badge!,
                    style: AppTheme.d(14, weight: FontWeight.w700, color: Colors.white)),
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
                      border: Border.all(color: gc.border),
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

Future<void> showNoteMedia(BuildContext context, List<String> media, int index) => showDialog(
      context: context,
      barrierColor: const Color(0xF2000000),
      builder: (_) => _MediaViewer(media: media, start: index),
    );

class _MediaViewer extends StatefulWidget {
  const _MediaViewer({required this.media, required this.start});

  final List<String> media;
  final int start;

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
    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
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
              return InteractiveViewer(
                maxScale: 5,
                child: Center(child: Image.file(File(path), fit: BoxFit.contain)),
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
                          style: AppTheme.d(14, weight: FontWeight.w600, color: Colors.white)),
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
        child: SizedBox(width: 26, height: 26, child: CircularProgressIndicator(strokeWidth: 2)),
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
