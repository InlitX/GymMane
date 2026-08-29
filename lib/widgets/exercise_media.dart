import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:video_player/video_player.dart';

import '../models/exercise.dart';
import '../services/media_store.dart';
import '../theme/app_colors.dart';
import 'exercise_art.dart';

class ExerciseMedia extends StatelessWidget {
  const ExerciseMedia({
    super.key,
    required this.ex,
    this.height = 210,
    this.radius = 20,
    this.live = false,
  });

  final Exercise ex;
  final double height;
  final double radius;
  final bool live;

  @override
  Widget build(BuildContext context) {
    final path = ex.media.isEmpty ? null : MediaStore.pathFor(ex.media);
    if (path == null) {
      return ExerciseArt(slug: ex.art, height: height, radius: radius, live: live);
    }
    final isVideo = MediaStore.isVideo(ex.media);
    if (isVideo && live) {
      return _VideoTile(key: ValueKey(path), path: path, height: height, radius: radius);
    }
    return _MediaFrame(
      height: height,
      radius: radius,
      child: isVideo
          ? _VideoPoster(height: height)
          : Center(
              child: Image.file(
                File(path),
                key: ValueKey(ex.media),
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
  const _MediaFrame({required this.child, required this.height, required this.radius});
  final Widget child;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: gc.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _VideoPoster extends StatelessWidget {
  const _VideoPoster({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Center(
      child: Icon(PhosphorIconsFill.playCircle,
          size: (height * 0.34).clamp(18.0, 54.0), color: gc.textSecondary),
    );
  }
}

class _VideoTile extends StatefulWidget {
  const _VideoTile({super.key, required this.path, required this.height, required this.radius});
  final String path;
  final double height;
  final double radius;

  @override
  State<_VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<_VideoTile> {
  VideoPlayerController? _c;
  bool _ok = false;
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
      await c.setVolume(0);
      await c.play();
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() {
        _c = c;
        _ok = true;
      });
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
    Widget child;
    if (_ok && _c != null) {
      child = FittedBox(
        fit: BoxFit.cover,
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
      child = const Center(
        child: SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    return _MediaFrame(height: widget.height, radius: widget.radius, child: child);
  }
}
