import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../models/progress_shot.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/note_kit.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  bool _busy = false;

  Future<void> _shoot(DateTime day, String pose) async {
    if (_busy) return;
    final source = await pickPhotoSource(context);
    if (source == null) return;

    setState(() => _busy = true);
    try {
      final shot = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1440,
        maxHeight: 1920,
        imageQuality: 88,
      );
      if (shot == null) return;
      await fit.attachShot(day, pose, shot.path);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirmDelete(ProgressEntry entry) async {
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.deleteEntryTitle, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.deleteDayBody, style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.delete, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.danger)),
          ),
        ],
      ),
    );
    if (ok == true) fit.deleteEntry(entry.id);
  }

  Future<void> _confirmRemove(ProgressEntry entry, String pose) async {
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.delete, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.posePhoto(t.poseName(pose).toLowerCase()),
            style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.cancel, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.delete, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.danger)),
          ),
        ],
      ),
    );
    if (ok == true) fit.removeShot(entry.id, pose);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final body = fit.bodyTimeline;
    final entries = fit.timeline;
    final start = fit.firstEntry;
    final windows = body ? fit.bodyWindows : const <BodyWindow>[];

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                RoundBtn(icon: Ic.chevronLeft, onTap: fit.backFromTimeline),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTitle(t.timeline, size: 20),
                      const SizedBox(height: 2),
                      Text(
                          body
                              ? t.sessionsLogged(fit.totalSessions)
                              : t.photoCount(fit.shotCount),
                          style: AppTheme.s(12.5, color: gc.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _modeToggle(gc, body),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              children: body
                  ? [
                      if (windows.isEmpty)
                        _bodyEmpty(gc)
                      else ...[
                        Text(t.timelineBodyHint,
                            style: AppTheme.s(12.5, color: gc.textTertiary, height: 1.4)),
                        const SizedBox(height: 14),
                        _heatLegend(gc),
                        const SizedBox(height: 22),
                        for (int i = 0; i < windows.length; i++)
                          _bodyRow(gc, windows[i],
                              last: i == windows.length - 1,
                              gap: i == windows.length - 1
                                  ? 0
                                  : daysBetween(windows[i + 1].to, windows[i].to)),
                      ],
                    ]
                  : [
                      if (entries.isEmpty) _empty(gc) else _heroBand(gc),
                      const SizedBox(height: 20),
                      _intervalPicker(gc),
                      const SizedBox(height: 24),
                      for (int i = 0; i < entries.length; i++)
                        _entryRow(gc, entries[i], start,
                            last: i == entries.length - 1,
                            gap: i == entries.length - 1
                                ? 0
                                : daysBetween(entries[i + 1].date, entries[i].date)),
                    ],
            ),
          ),
          if (!body)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: PrimaryButton(
                label: t.addTodayPhotos,
                icon: Ic.plus,
                height: 54,
                onTap: _busy ? () {} : () => _poseSheet(DateTime.now()),
              ),
            ),
        ],
      ),
    );
  }

  Widget _modeToggle(GymColors gc, bool body) {
    Widget tab(String label, IconData icon, bool on, VoidCallback onTap) => Expanded(
          child: Semantics(
            button: true,
            selected: on,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 40,
                decoration: BoxDecoration(
                  color: on ? gc.ember : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 15, color: on ? gc.onEmber : gc.textSecondary),
                    const SizedBox(width: 7),
                    Text(label,
                        style: AppTheme.s(13,
                            weight: FontWeight.w600, color: on ? gc.onEmber : gc.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
        );

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          tab(t.timelinePhotos, PhosphorIconsRegular.image, !body, () => fit.setBodyTimeline(false)),
          tab(t.timelineBody, PhosphorIconsRegular.person, body, () => fit.setBodyTimeline(true)),
        ],
      ),
    );
  }

  Widget _bodyEmpty(GymColors gc) => Container(
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Icon(PhosphorIconsRegular.person, size: 30, color: gc.textTertiary),
            const SizedBox(height: 16),
            Text(t.timelineBodyEmpty,
                textAlign: TextAlign.center,
                style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
          ],
        ),
      );

  Widget _heatLegend(GymColors gc) => Row(
        children: [
          Text(t.heatLow, style: AppTheme.s(10.5, color: gc.textTertiary)),
          const SizedBox(width: 8),
          for (int i = 0; i <= heatLevels; i++) ...[
            if (i > 0) const SizedBox(width: 3),
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: heatLevelColor(gc, i),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
          const SizedBox(width: 8),
          Text(t.heatHigh, style: AppTheme.s(10.5, color: gc.textTertiary)),
        ],
      );

  Widget _bodyRow(GymColors gc, BodyWindow w, {required bool last, required int gap}) {
    return LayoutBuilder(
      builder: (context, c) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _rail(gc, last: last, gap: gap),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: last ? 0 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(t.timelineWindow(t.shortDate(w.from), t.shortDate(w.to)),
                            style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text)),
                        const Spacer(),
                        Text(t.sessionCount(w.sessions),
                            style: AppTheme.s(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SoftCard(
                      radius: 18,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: BodyHeatArt(
                          gc: gc,
                          intensity: w.heat,
                          width: math.min(c.maxWidth - 62, 250),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rail(GymColors gc, {required bool last, required int gap}) {
    final dash = Color.lerp(gc.border, gc.accent, 0.55)!;
    return SizedBox(
      width: 34,
      child: Column(
        children: [
          Container(
            width: 11,
            height: 11,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: gc.accent,
              shape: BoxShape.circle,
              border: Border.all(color: gc.accentSoft, width: 3),
            ),
          ),
          if (!last)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Expanded(child: DashedRail(color: dash, thickness: 2.2)),
                    if (gap > 0) ...[
                      const SizedBox(height: 4),
                      Text('${gap}d',
                          style: AppTheme.d(9.5, weight: FontWeight.w700, color: gc.textTertiary)),
                      const SizedBox(height: 4),
                    ],
                    Expanded(child: DashedRail(color: dash, thickness: 2.2)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _empty(GymColors gc) => Container(
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final pose in kPoses) ...[
                  if (pose != kPoses.first) const SizedBox(width: 10),
                  _ghostTile(gc, pose),
                ],
              ],
            ),
            const SizedBox(height: 20),
            Text(t.timelineEmptyTitle,
                textAlign: TextAlign.center,
                style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text, height: 1.25)),
            const SizedBox(height: 8),
            Text(t.timelineHint,
                textAlign: TextAlign.center,
                style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
          ],
        ),
      );

  Widget _ghostTile(GymColors gc, String pose) => Container(
        width: 56,
        height: 72,
        decoration: BoxDecoration(
          color: gc.bgRaised2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gc.border),
        ),
        child: Center(
          child: Icon(PhosphorIconsRegular.person, size: 24, color: gc.textTertiary),
        ),
      );

  Widget _heroBand(GymColors gc) {
    final pair = fit.comparePair;
    if (pair == null) {
      final only = fit.lastEntry!;
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            _thumb(gc, only.media.first, 62, 82),
            const SizedBox(width: 16),
            Expanded(
              child: Text(t.compareNeedTwo,
                  style: AppTheme.s(13, color: gc.textSecondary, height: 1.5)),
            ),
          ],
        ),
      );
    }

    final pose = fit.posesWithBoth.isEmpty ? null : (fit.posesWithBoth.contains(fit.comparePose)
        ? fit.comparePose
        : fit.posesWithBoth.first);
    final a = pose == null ? pair.from.media.first : pair.from.shot(pose)!;
    final b = pose == null ? pair.to.media.first : pair.to.shot(pose)!;
    final delta = fit.compareWeightDelta;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: pose == null ? null : fit.goCompare,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _thumb(gc, a, double.infinity, 150)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(PhosphorIconsBold.arrowRight, size: 16, color: gc.accent),
                ),
                Expanded(child: _thumb(gc, b, double.infinity, 150)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.daysApart(fit.compareDays),
                          style: AppTheme.d(15, weight: FontWeight.w700, color: gc.text)),
                      if (delta != null) ...[
                        const SizedBox(height: 2),
                        Text('${delta > 0 ? '+' : ''}${fmt(delta)} ${fit.units}',
                            style: AppTheme.s(12.5,
                                weight: FontWeight.w600,
                                color: delta == 0 ? gc.textSecondary : gc.accent)),
                      ],
                    ],
                  ),
                ),
                if (pose != null)
                  Pill(
                    label: t.compare,
                    bg: gc.ember,
                    fg: gc.onEmber,
                    fontSize: 12,
                    onTap: fit.goCompare,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _intervalPicker(GymColors gc) {
    final left = fit.daysUntilPhoto;
    final due = fit.photoDue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(t.photoEvery,
                  style: AppTheme.d(12,
                      weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 2)),
            ),
            if (left != null)
              Text(due ? t.photoDueNow : t.photoNextIn(left),
                  style: AppTheme.s(12,
                      weight: FontWeight.w600, color: due ? gc.accent : gc.textTertiary)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: gc.border),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              for (final days in kPhotoIntervals)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: fit.photoIntervalDays == days,
                    label: t.photoInterval(days),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => fit.setPhotoInterval(days),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: fit.photoIntervalDays == days ? gc.ember : Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(days <= 0 ? t.photoEveryOff : '$days',
                                maxLines: 1,
                                style: AppTheme.s(13,
                                    weight: FontWeight.w600,
                                    color: fit.photoIntervalDays == days
                                        ? gc.onEmber
                                        : gc.textSecondary)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _entryRow(GymColors gc, ProgressEntry entry, ProgressEntry? start,
      {required bool last, required int gap}) {
    final dayNo = start == null ? 1 : daysBetween(start.date, entry.date) + 1;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _rail(gc, last: last, gap: gap),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(t.shortDateYear(entry.date),
                          style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text)),
                      const SizedBox(width: 10),
                      Text(t.dayNumber(dayNo),
                          style: AppTheme.s(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
                      const Spacer(),
                      if (entry.weightKg != null)
                        Text(fit.weightLabel(entry.weightKg!),
                            style: AppTheme.s(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
                      Semantics(
                        button: true,
                        label: t.delete,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _confirmDelete(entry),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 4),
                            child: Icon(PhosphorIconsRegular.trash, size: 15, color: gc.textTertiary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (final pose in kPoses) ...[
                        if (pose != kPoses.first) const SizedBox(width: 10),
                        Expanded(child: _poseTile(gc, entry, pose)),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _poseTile(GymColors gc, ProgressEntry entry, String pose) {
    final name = entry.shot(pose);
    final path = name == null ? null : MediaStore.pathFor(name);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: name == null
          ? () => _shoot(entry.date, pose)
          : () => showNoteMedia(context, entry.media, entry.media.indexOf(name)),
      onLongPress: name == null ? null : () => _confirmRemove(entry, pose),
      child: AspectRatio(
        aspectRatio: 0.78,
        child: Container(
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: gc.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: path == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(PhosphorIconsRegular.plus, size: 16, color: gc.textTertiary),
                    const SizedBox(height: 6),
                    Text(t.poseName(pose),
                        style: AppTheme.s(10.5, weight: FontWeight.w600, color: gc.textTertiary)),
                  ],
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true,
                        errorBuilder: (_, _, _) => Icon(PhosphorIconsRegular.imageSquare,
                            size: 20, color: gc.textTertiary)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        color: const Color(0x99000000),
                        alignment: Alignment.center,
                        child: Text(t.poseName(pose),
                            style: AppTheme.s(10, weight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _thumb(GymColors gc, String name, double w, double h) {
    final path = MediaStore.pathFor(name);
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gc.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: path == null
          ? Icon(PhosphorIconsRegular.imageSquare, size: 18, color: gc.textTertiary)
          : Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true,
              errorBuilder: (_, _, _) =>
                  Icon(PhosphorIconsRegular.imageSquare, size: 18, color: gc.textTertiary)),
    );
  }

  Future<void> _poseSheet(DateTime day) async {
    final gc = context.gc;
    final pose = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 18),
            for (final p in kPoses) ...[
              if (p != kPoses.first) const SizedBox(height: 10),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(sheet).pop(p),
                child: SoftCard(
                  radius: 16,
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    Icon(PhosphorIconsRegular.person, size: 20, color: gc.textSecondary),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(t.posePhoto(t.poseName(p).toLowerCase()),
                          style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                    ),
                  ]),
                ),
              ),
            ],
          ],
        ),
      ),
    );
    if (pose != null && mounted) await _shoot(day, pose);
  }
}
