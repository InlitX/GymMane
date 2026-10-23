import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:video_player/video_player.dart';

import '../models/exercise.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import 'exercise_art.dart';
import 'shimmer.dart';

const _shortDemo = Duration(seconds: 10);

class ExerciseMedia extends StatelessWidget {
  const ExerciseMedia({
    super.key,
    required this.ex,
    this.height = 210,
    this.radius = 20,
    this.live = false,
    this.bordered = true,
    this.loops,
  });

  final Exercise ex;
  final double height;
  final double radius;
  final bool live;
  final bool bordered;
  final int? loops;

  @override
  Widget build(BuildContext context) {
    final media = fit.mediaFor(ex.id);
    final path = media.isEmpty ? null : MediaStore.pathFor(media);
    if (path == null) {
      return ExerciseArt(
          slug: ex.art,
          height: height,
          radius: radius,
          live: live,
          bordered: bordered,
          loops: loops);
    }
    final isVideo = MediaStore.isVideo(media);
    if (isVideo && live) {
      return _VideoTile(
          key: ValueKey(path), path: path, height: height, radius: radius, short: loops != null);
    }
    if (isVideo) {
      return Stack(children: [
        _VideoTile(
            key: ValueKey('still-$path'), path: path, height: height, radius: radius, bordered: bordered, still: true),
        Positioned(right: 6, bottom: 6, child: _PlayBadge(height: height)),
      ]);
    }
    return _MediaFrame(
      height: height,
      radius: radius,
      bordered: bordered,
      child: Center(
        child: Image.file(
          File(path),
          key: ValueKey(media),
          fit: BoxFit.contain,
          alignment: Alignment.center,
          gaplessPlayback: true,
          errorBuilder: (_, _, _) => _fallbackIcon(context, height),
        ),
      ),
    );
  }
}

Widget _fallbackIcon(BuildContext context, double height) => Center(
      child: Icon(PhosphorIconsRegular.barbell,
          size: height * 0.32, color: context.gc.textTertiary),
    );

class _MediaFrame extends StatelessWidget {
  const _MediaFrame(
      {required this.child,
      required this.height,
      required this.radius,
      this.bordered = true});
  final Widget child;
  final double height;
  final double radius;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(radius),
        border: bordered ? Border.all(color: gc.border) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _PlayBadge extends StatelessWidget {
  const _PlayBadge({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final size = (height * 0.2).clamp(16.0, 30.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: gc.bg.withValues(alpha: 0.72), shape: BoxShape.circle),
      child: Icon(PhosphorIconsFill.play, size: size * 0.5, color: gc.text),
    );
  }
}

class _VideoTile extends StatefulWidget {
  const _VideoTile(
      {super.key,
      required this.path,
      required this.height,
      required this.radius,
      this.short = false,
      this.still = false,
      this.bordered = true});
  final String path;
  final double height;
  final double radius;
  final bool short;
  final bool still;
  final bool bordered;

  @override
  State<_VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<_VideoTile> {
  VideoPlayerController? _c;
  Timer? _stop;
  bool _ok = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final c = VideoPlayerController.file(File(widget.path), videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
      await c.initialize();
      await c.setVolume(0);
      if (widget.still) {
        final ms = c.value.duration.inMilliseconds;
        await c.seekTo(Duration(milliseconds: math.min(500, ms ~/ 3)));
      } else {
        await c.setLooping(true);
        await c.play();
      }
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() {
        _c = c;
        _ok = true;
      });
      if (widget.short) _stop = Timer(_shortDemo, () => c.setLooping(false));
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _stop?.cancel();
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_ok && _c != null) {
      child = FittedBox(
        fit: BoxFit.contain,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: _c!.value.size.width,
          height: _c!.value.size.height,
          child: VideoPlayer(_c!),
        ),
      );
    } else if (_failed) {
      child = _fallbackIcon(context, widget.height);
    } else {
      child = Stack(children: [
        Positioned.fill(child: Shimmer(radius: widget.radius)),
        const Center(child: CupertinoActivityIndicator()),
      ]);
    }
    return _MediaFrame(height: widget.height, radius: widget.radius, bordered: widget.bordered, child: child);
  }
}
