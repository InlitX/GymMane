import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/file_thumb.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/ui_kit.dart';
import 'moments_screen.dart';

class SessionPhotos extends StatefulWidget {
  const SessionPhotos(this.session, {super.key, this.framed = true});

  final LoggedSession session;
  final bool framed;

  @override
  State<SessionPhotos> createState() => _SessionPhotosState();
}

class _SessionPhotosState extends State<SessionPhotos> {
  bool _busy = false;

  Future<void> _add() async {
    if (_busy) return;
    final source = await pickPhotoSource(context);
    if (source == null || !mounted) return;
    setState(() => _busy = true);
    await addMomentsFrom(source, date: widget.session.date);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return ListenableBuilder(
      listenable: fit,
      builder: (context, _) {
        final photos = fit.momentsOf(widget.session);
        final body = photos.isEmpty ? _empty(gc) : _strip(gc, photos);
        if (!widget.framed) return body;
        return SoftCard(
          radius: 22,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(PhosphorIconsFill.camera, size: 14, color: gc.accent),
              const SizedBox(width: 7),
              Expanded(
                child: Text(t.sessionPhotos.toUpperCase(),
                    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
              ),
              if (photos.isNotEmpty)
                Text('${photos.length}', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
            ]),
            const SizedBox(height: 12),
            body,
          ]),
        );
      },
    );
  }

  Widget _addTile(GymColors gc, {double size = 72}) => Pressable(
        onTap: _add,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: gc.bgRaised2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gc.border),
          ),
          child: Center(
            child: _busy
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.2, color: gc.accent),
                  )
                : Icon(PhosphorIconsBold.plus, size: 20, color: gc.accent),
          ),
        ),
      );

  Widget _empty(GymColors gc) => Row(children: [
        _addTile(gc, size: 60),
        const SizedBox(width: 14),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _add,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.sessionPhotosAdd, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 3),
              Text(t.sessionPhotosHint,
                  style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
            ]),
          ),
        ),
      ]);

  Widget _strip(GymColors gc, List<Moment> photos) => SizedBox(
        height: 72,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: photos.length + 1,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            if (i == photos.length) return _addTile(gc);
            final m = photos[i];
            final path = MediaStore.pathFor(m.file) ?? '';
            return Pressable(
              onTap: () => openMoment(context, m),
              child: Hero(
                tag: m.file,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: path.isEmpty
                        ? ColoredBox(color: gc.bgRaised2)
                        : FileThumb(path, width: 72, height: 72),
                  ),
                ),
              ),
            );
          },
        ),
      );
}
