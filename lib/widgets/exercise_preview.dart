import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:video_player/video_player.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'exercise_media.dart';
import 'glass.dart';
import 'shimmer.dart';
import 'ui_kit.dart';

Future<void> showExercisePreview(BuildContext context, Exercise ex, {bool suggestions = false}) {
  HapticFeedback.selectionClick();
  return showAppDialog<void>(
    context: context,
    builder: (_) => _ExercisePreview(ex: ex, suggestions: suggestions),
  );
}

class _ExercisePreview extends StatefulWidget {
  const _ExercisePreview({required this.ex, required this.suggestions});

  final Exercise ex;
  final bool suggestions;

  @override
  State<_ExercisePreview> createState() => _ExercisePreviewState();
}

class _ExercisePreviewState extends State<_ExercisePreview> {
  VideoPlayerController? _video;

  Exercise get ex => widget.ex;

  @override
  void initState() {
    super.initState();
    final media = fit.mediaFor(ex.id);
    final path = media.isEmpty ? null : MediaStore.pathFor(media);
    if (path != null && MediaStore.isVideo(media)) _load(path);
  }

  Future<void> _load(String path) async {
    final c = VideoPlayerController.file(File(path), videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    setState(() => _video = c);
    try {
      await c.initialize();
      await c.setLooping(true);
      await c.setVolume(0);
      await c.play();
    } catch (_) {
      if (mounted) setState(() => _video = null);
      c.dispose();
      return;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _video?.dispose();
    super.dispose();
  }

  void _seek(int ms) {
    final c = _video;
    if (c == null) return;
    HapticFeedback.selectionClick();
    c.seekTo(Duration(milliseconds: ms));
    c.play();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final pad = MediaQuery.viewPaddingOf(context);
    final steps = fit.activeExerciseSteps(ex);
    final video = _video;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, pad.top + 24, 16, pad.bottom + 24),
      child: Material(
        color: gc.bgRaised,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: gc.border),
        ),
        child: AnimatedBuilder(
          animation: fit,
          builder: (context, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(children: [
                        video == null
                            ? ExerciseMedia(ex: ex, height: 250, radius: 20, live: true, bordered: false)
                            : _VideoStage(controller: video),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: RoundAction(
                            label: MaterialLocalizations.of(context).closeButtonLabel,
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(PhosphorIconsBold.x, size: 15, color: gc.text),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exerciseName(ex),
                                style: AppTheme.f(24, weight: FontWeight.w800, color: gc.text, height: 1.1)),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _meta(gc, t.primaryLabel, muscleLabel(ex.primary)),
                                const SizedBox(width: 18),
                                _meta(gc, t.secondaryLabel,
                                    ex.secondary.isEmpty ? t.none : ex.secondary.map(muscleLabel).join(', ')),
                                const SizedBox(width: 18),
                                _meta(gc, t.equipmentLabel, t.equipment(ex.equipment)),
                              ],
                            ),
                            if (steps.isNotEmpty) ...[
                              const SizedBox(height: 24),
                              Text(titleCase(t.howTo),
                                  style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text)),
                              if (video != null) ...[
                                const SizedBox(height: 4),
                                Text(t.videoMarksHint,
                                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                              ],
                              const SizedBox(height: 14),
                              for (var i = 0; i < steps.length; i++) ...[
                                _step(gc, i, steps[i], video),
                                if (i < steps.length - 1) const SizedBox(height: 12),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.suggestions) _suggestRow(gc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _suggestRow(GymColors gc) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => fit.toggleSuggest(ex.id),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: gc.border))),
          child: Row(children: [
            Icon(PhosphorIconsRegular.sparkle, size: 18, color: gc.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(t.suggestInWorkouts, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
            ),
            TinySwitch(on: fit.suggests(ex.id)),
          ]),
        ),
      );

  Widget _meta(GymColors gc, String label, String value) => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
            const SizedBox(height: 5),
            Text(value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
          ],
        ),
      );

  Widget _step(GymColors gc, int i, String text, VideoPlayerController? video) {
    final mark = video == null ? null : fit.videoMark(ex.id, i);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: mark == null ? null : () => _seek(mark),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
            child: Text('${i + 1}', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.ember)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
          ),
          if (video != null) ...[
            const SizedBox(width: 8),
            mark == null ? _pin(gc, video, i) : _chip(gc, mark, i),
          ],
        ],
      ),
    );
  }

  Widget _pin(GymColors gc, VideoPlayerController video, int i) => Semantics(
        button: true,
        label: t.videoMarkHere,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.selectionClick();
            fit.setVideoMark(ex.id, i, video.value.position.inMilliseconds);
          },
          child: Container(
            width: 34,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: gc.border),
            ),
            child: Icon(PhosphorIconsRegular.pushPin, size: 13, color: gc.textTertiary),
          ),
        ),
      );

  Widget _chip(GymColors gc, int ms, int i) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _seek(ms),
        onLongPress: () {
          HapticFeedback.mediumImpact();
          fit.setVideoMark(ex.id, i, null);
        },
        child: Container(
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.accentSoft, borderRadius: BorderRadius.circular(100)),
          child: Text(_clock(ms), style: AppTheme.f(12, weight: FontWeight.w700, color: gc.accent)),
        ),
      );
}

String _clock(int ms) {
  final s = ms ~/ 1000;
  return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
}

class _VideoStage extends StatelessWidget {
  const _VideoStage({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.5;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ColoredBox(
        color: gc.bgRaised2,
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: controller,
          builder: (context, v, _) {
            if (!v.isInitialized) return SizedBox(height: 250, child: Shimmer(radius: 20));
            final playing = v.isPlaying;
            return Column(children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => playing ? controller.pause() : controller.play(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: Stack(alignment: Alignment.center, children: [
                    Center(child: AspectRatio(aspectRatio: v.aspectRatio, child: VideoPlayer(controller))),
                    AnimatedOpacity(
                      opacity: playing ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(color: gc.bg.withValues(alpha: 0.55), shape: BoxShape.circle),
                        child: Icon(PhosphorIconsFill.play, size: 24, color: gc.text),
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 2, 14, 4),
                child: Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 26,
                      child: VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(vertical: 10.5),
                        colors: VideoProgressColors(
                          playedColor: gc.accent,
                          bufferedColor: gc.border,
                          backgroundColor: gc.bgRaised,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('${_clock(v.position.inMilliseconds)} / ${_clock(v.duration.inMilliseconds)}',
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                ]),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
