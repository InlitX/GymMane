import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/sheet_page.dart';
import '../widgets/dialogs.dart';
import '../widgets/file_thumb.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/ui_kit.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key});

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  bool _busy = false;
  bool _grouped = false;

  Future<void> _add() async {
    if (_busy) return;
    final source = await pickPhotoSource(context);
    if (source == null) return;
    setState(() => _busy = true);
    await addMomentsFrom(source);
    if (mounted) setState(() => _busy = false);
  }

  void _open(Moment moment) => openMoment(context, moment);

  void _press(Moment moment) {
    if (fit.momentPicks.isEmpty) return _open(moment);
    fit.toggleMomentPick(moment.file);
  }

  void _hold(Moment moment) {
    HapticFeedback.selectionClick();
    fit.toggleMomentPick(moment.file);
  }

  Future<void> _removePicked() async {
    final n = fit.momentPicks.length;
    final ok = await askConfirm(
      context,
      title: n == 1 ? t.deletePhotoTitle : t.deletePhotosTitle(n),
      body: t.deletePhotoBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (ok) fit.deleteMoments([...fit.momentPicks]);
  }

  Widget _picked(GymColors gc, Moment moment, Widget child) {
    final on = fit.momentPicks.contains(moment.file);
    if (fit.momentPicks.isEmpty) return child;
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedScale(
          scale: on ? 0.9 : 1,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: child,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: on ? gc.accent : Colors.black.withValues(alpha: 0.3),
              border: Border.all(color: Colors.white, width: 1.6),
            ),
            child: on ? const Icon(PhosphorIconsBold.check, size: 12, color: Colors.black) : null,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final shots = fit.momentsNewest;
    final picks = fit.momentPicks.length;

    return RiseScope(
      id: 'moments',
      once: false,
      child: SheetPage(
        title: t.photosCard,
        eyebrow: picks > 0 ? t.photosSelected(picks) : t.profile,
        onBack: fit.backFromMoments,
        actions: picks > 0
            ? [
                RoundAction(
                  onTap: _removePicked,
                  label: t.delete,
                  child: Icon(PhosphorIconsRegular.trash, size: 17, color: gc.danger),
                ),
                RoundAction(
                  onTap: fit.clearMomentPicks,
                  label: t.cancel,
                  child: Icon(PhosphorIconsRegular.x, size: 17, color: gc.text),
                ),
              ]
            : [
                RoundAction(
                  onTap: () => setState(() => _grouped = !_grouped),
                  label: t.photosCard,
                  child: Icon(_grouped ? PhosphorIconsRegular.squaresFour : PhosphorIconsRegular.rows,
                      size: 17, color: gc.text),
                ),
                RoundAction(
                  onTap: _add,
                  label: t.snapNow,
                  child: Icon(PhosphorIconsRegular.camera, size: 17, color: gc.text),
                ),
              ],
        children: shots.isEmpty
            ? [Rise(index: 0, child: _empty(gc))]
            : [
                Rise(index: 0, child: _stats(gc, shots)),
                const SizedBox(height: 22),
                Rise(index: 1, child: _grouped ? _byDate(gc, shots) : _plainGrid(gc, shots)),
              ],
      ),
    );
  }

  Widget _stats(GymColors gc, List<Moment> shots) {
    final now = DateTime.now();
    final month = shots.where((m) => m.date.year == now.year && m.date.month == now.month).length;
    final days = {for (final m in shots) DateTime(m.date.year, m.date.month, m.date.day)}.length;
    Widget cell(String value, String label) => Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RollIn(value, style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text, height: 1.05)),
            const SizedBox(height: 5),
            Text(label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.1)),
          ]),
        );
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
      child: Row(children: [
        cell('${shots.length}', t.photosCard),
        cell('$month', t.momentsThisMonth),
        cell('$days', t.momentsDays),
      ]),
    );
  }

  Widget _plainGrid(GymColors gc, List<Moment> shots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: shots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.74,
      ),
      itemBuilder: (_, i) => _tile(gc, shots[i]),
    );
  }

  String _bucket(DateTime d) {
    final now = DateTime.now();
    final day = DateTime(d.year, d.month, d.day);
    final today = DateTime(now.year, now.month, now.day);
    final days = today.difference(day).inDays;
    if (days <= 0) return titleCase(t.today);
    if (days < 7) return titleCase(t.thisWeek);
    if (d.year == now.year) return t.monthName(d.month);
    return '${t.monthName(d.month)} ${d.year}';
  }

  Widget _byDate(GymColors gc, List<Moment> shots) {
    final groups = <String, List<Moment>>{};
    for (final m in shots) {
      groups.putIfAbsent(_bucket(m.date), () => []).add(m);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final entry in groups.entries) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 6, 0, 12),
            child: Text(entry.key, style: AppTheme.f(16, color: gc.text)),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entry.value.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (_, i) => _square(gc, entry.value[i]),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _square(GymColors gc, Moment moment) {
    final path = MediaStore.pathFor(moment.file) ?? '';
    return GestureDetector(
      onTap: () => _press(moment),
      onLongPress: () => _hold(moment),
      child: _picked(
        gc,
        moment,
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: moment.file,
            flightShuttleBuilder: _photoFlight(path),
            child: FileThumb(path, errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
          ),
        ),
      ),
    );
  }

  Widget _empty(GymColors gc) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIconsRegular.camera, size: 34, color: gc.textTertiary),
          const SizedBox(height: 14),
          Text(t.momentsEmptyTitle, style: AppTheme.f(16, color: gc.text)),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(t.momentsEmptyHint,
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5,
                    weight: FontWeight.w500, color: gc.textTertiary, height: 1.45)),
          ),
          const SizedBox(height: 18),
          GhostButton(label: t.snapNow, icon: PhosphorIconsRegular.camera, onTap: _add),
        ],
      ),
    );
  }

  Widget _tile(GymColors gc, Moment moment) {
    final path = MediaStore.pathFor(moment.file) ?? '';
    return GestureDetector(
      onTap: () => _press(moment),
      onLongPress: () => _hold(moment),
      child: _picked(gc, moment, ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: moment.file,
              flightShuttleBuilder: _photoFlight(path),
              child: FileThumb(path, errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.black.withValues(alpha: 0.45),
                child: Text(t.shortDate(moment.date),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(10.5, weight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

Future<void> addMomentsFrom(ImageSource source, {DateTime? date}) async {
  try {
    if (source == ImageSource.gallery) {
      final shots = await ImagePicker().pickMultiImage(maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
      for (final shot in shots) {
        await fit.addMoment(shot.path, date: date);
      }
      return;
    }
    final shot = await ImagePicker().pickImage(source: source, maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
    if (shot == null) return;
    await fit.addMoment(shot.path, date: date);
  } catch (_) {}
}

HeroFlightShuttleBuilder _photoFlight(String path) => (_, animation, _, _, _) => AnimatedBuilder(
      animation: animation,
      builder: (_, _) => ClipRRect(
        borderRadius: BorderRadius.circular(ui.lerpDouble(18, 22, animation.value)!),
        child: SizedBox.expand(
          child: Image.file(File(path), fit: BoxFit.cover, gaplessPlayback: true),
        ),
      ),
    );

Future<void> openMoment(BuildContext context, Moment moment) async {
  final path = MediaStore.pathFor(moment.file) ?? '';
  if (path.isEmpty) return;
  try {
    await precacheImage(FileImage(File(path)), context);
  } catch (_) {}
  if (!context.mounted) return;
  await Navigator.of(context).push(PageRouteBuilder<void>(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, animation, _) => _PhotoView(moment: moment, path: path, animation: animation),
  ));
}

class _PhotoView extends StatelessWidget {
  const _PhotoView({required this.moment, required this.path, required this.animation});

  final Moment moment;
  final String path;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final v = Curves.easeOutCubic.transform(animation.value);
        return Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 20 * v, sigmaY: 20 * v),
                    child: ColoredBox(color: gc.pageBg.withValues(alpha: 0.62 * v)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 86, 24, 36),
                    child: Hero(
                      tag: moment.file,
                      flightShuttleBuilder: _photoFlight(path),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.file(File(path), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 54,
                  child: Opacity(
                    opacity: v,
                    child: Text(
                      t.fullDate(moment.date),
                      textAlign: TextAlign.center,
                      style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
