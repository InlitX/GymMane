import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
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
    try {
      if (source == ImageSource.gallery) {
        final shots = await ImagePicker()
            .pickMultiImage(maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
        for (final shot in shots) {
          await fit.addMoment(shot.path);
        }
        return;
      }
      final shot = await ImagePicker()
          .pickImage(source: source, maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
      if (shot == null) return;
      await fit.addMoment(shot.path);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _open(Moment moment) {
    final path = MediaStore.pathFor(moment.file) ?? '';
    if (path.isEmpty) return;
    Navigator.of(context).push(PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, animation, _) =>
          _PhotoView(moment: moment, path: path, animation: animation),
    ));
  }

  Future<void> _remove(Moment moment) async {
    final ok = await askConfirm(
      context,
      title: t.deletePhotoTitle,
      body: t.deletePhotoBody,
      confirmLabel: t.delete,
      danger: true,
    );
    if (ok) fit.deleteMoment(moment);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final shots = fit.momentsNewest;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: t.photosCard,
              onBack: fit.backFromMoments,
              subtitle: shots.isEmpty ? null : t.momentCount(shots.length),
              actions: [
                RoundAction(
                  onTap: () => setState(() => _grouped = !_grouped),
                  label: t.photosCard,
                  child: Icon(
                      _grouped
                          ? PhosphorIconsRegular.squaresFour
                          : PhosphorIconsRegular.rows,
                      size: 17,
                      color: context.gc.text),
                ),
                const SizedBox(width: 8),
                RoundAction(
                  onTap: _add,
                  label: t.snapNow,
                  child: Icon(PhosphorIconsRegular.camera, size: 17, color: context.gc.text),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: shots.isEmpty
                  ? _empty(gc)
                  : (_grouped ? _byDate(gc, shots) : _plainGrid(gc, shots)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _plainGrid(GymColors gc, List<Moment> shots) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 110),
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
    return ListView(
      padding: const EdgeInsets.only(bottom: 110),
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
      onTap: () => _open(moment),
      onLongPress: () => _remove(moment),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Hero(
          tag: moment.file,
          child: Image.file(File(path),
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
        ),
      ),
    );
  }

  Widget _empty(GymColors gc) {
    return Center(
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
      onTap: () => _open(moment),
      onLongPress: () => _remove(moment),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: moment.file,
              child: Image.file(File(path),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
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
      ),
    );
  }
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
