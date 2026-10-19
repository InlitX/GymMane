import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../services/beeper.dart';
import '../theme/app_theme.dart';

@immutable
class LiquidNotchFrame {
  const LiquidNotchFrame(this.width, this.height, this.y, this.neck, this.shoulder, this.opacity);
  final double width, height, y, neck, shoulder, opacity;

  static LiquidNotchFrame lerp(LiquidNotchFrame a, LiquidNotchFrame b, double t) => LiquidNotchFrame(
    ui.lerpDouble(a.width, b.width, t)!,
    ui.lerpDouble(a.height, b.height, t)!,
    ui.lerpDouble(a.y, b.y, t)!,
    ui.lerpDouble(a.neck, b.neck, t)!,
    ui.lerpDouble(a.shoulder, b.shoulder, t)!,
    ui.lerpDouble(a.opacity, b.opacity, t)!,
  );

  static const _enter = <(double, LiquidNotchFrame)>[
    (0, LiquidNotchFrame(0, 0, 47, 0, 0, 0)),
    (.08, LiquidNotchFrame(12, 10, 49, 9, 36, 0)),
    (.16, LiquidNotchFrame(24, 19, 56, 12, 31, 0)),
    (.24, LiquidNotchFrame(29, 27, 63, 10, 28, 0)),
    (.32, LiquidNotchFrame(31, 36, 72, 7, 25, 0)),
    (.40, LiquidNotchFrame(35, 44, 83, 3.5, 21, 0)),
    (.48, LiquidNotchFrame(51, 57, 97, 1, 14, .05)),
    (.53, LiquidNotchFrame(69, 66, 105, 0, 0, .15)),
    (.60, LiquidNotchFrame(100, 72, 113, 0, 0, .32)),
    (.68, LiquidNotchFrame(150, 69, 116, 0, 0, .50)),
    (.76, LiquidNotchFrame(205, 61, 115, 0, 0, .68)),
    (.86, LiquidNotchFrame(270, 55, 107, 0, 0, .90)),
    (1, LiquidNotchFrame(307, 53, 102, 0, 0, 1)),
  ];
  static const _exit = <(double, LiquidNotchFrame)>[
    (0, LiquidNotchFrame(307, 53, 102, 0, 0, 1)),
    (.12, LiquidNotchFrame(285, 51, 102, 0, 0, .96)),
    (.25, LiquidNotchFrame(244, 48, 102, 0, 0, .80)),
    (.37, LiquidNotchFrame(191, 44, 101, 0, 0, .60)),
    (.48, LiquidNotchFrame(137, 41, 100, 0, 0, .35)),
    (.58, LiquidNotchFrame(84, 43, 87, 24, 45, .06)),
    (.69, LiquidNotchFrame(58, 43, 72, 21, 42, 0)),
    (.80, LiquidNotchFrame(36, 29, 58, 15, 36, 0)),
    (.91, LiquidNotchFrame(17, 12, 50, 8, 29, 0)),
    (1, LiquidNotchFrame(0, 0, 47, 0, 0, 0)),
  ];

  static LiquidNotchFrame sample(double progress, {bool exiting = false}) {
    final keys = exiting ? _exit : _enter;
    final p = progress.clamp(0.0, 1.0);
    for (var i = 1; i < keys.length; i++) {
      if (p <= keys[i].$1) {
        final a = keys[i - 1];
        final b = keys[i];
        return lerp(a.$2, b.$2, (p - a.$1) / (b.$1 - a.$1));
      }
    }
    return keys.last.$2;
  }
}

class LiquidNotch extends StatefulWidget {
  const LiquidNotch({
    super.key,
    required this.visible,
    required this.child,
    required this.sourceRect,
    this.sourceColor = Colors.black,
    this.pillColor = Colors.black,
    this.enterDuration = const Duration(milliseconds: 650),
    this.exitDuration = const Duration(milliseconds: 450),
    this.onTap,
    this.onDismissed,
    this.extraHeight = 0,
  });

  final bool visible;
  final Widget child;
  final Rect sourceRect;
  final double extraHeight;
  final Color sourceColor, pillColor;
  final Duration enterDuration, exitDuration;
  final VoidCallback? onTap, onDismissed;

  @override
  State<LiquidNotch> createState() => _LiquidNotchState();
}

class _LiquidNotchState extends State<LiquidNotch> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this)..addStatusListener(_status);
  bool _exiting = false;
  bool _reduced = false;
  bool _dismissPending = false;
  LiquidNotchFrame? _interrupted;

  void _status(AnimationStatus s) {
    if (s == AnimationStatus.completed && _exiting && _dismissPending) {
      _dismissPending = false;
      widget.onDismissed?.call();
    }
  }

  LiquidNotchFrame get _frame {
    final sampled = LiquidNotchFrame.sample(_controller.value, exiting: _exiting);
    final previous = _interrupted;
    if (previous == null) return sampled;
    return LiquidNotchFrame.lerp(
      previous,
      sampled,
      Curves.easeOut.transform((_controller.value / .4).clamp(0.0, 1.0)),
    );
  }

  @override
  void initState() {
    super.initState();
    _exiting = !widget.visible;
    _controller.duration = widget.visible ? widget.enterDuration : widget.exitDuration;
    _controller.value = widget.visible ? 0 : 1;
    if (widget.visible) _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduced = MediaQuery.disableAnimationsOf(context);
    if (_reduced) _controller.value = 1;
  }

  @override
  void didUpdateWidget(LiquidNotch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.visible == widget.visible) return;
    final prior = _controller.isAnimating ? _frame : null;
    _exiting = !widget.visible;
    _dismissPending = _exiting;
    _interrupted = prior;
    _controller.duration = _exiting ? widget.exitDuration : widget.enterDuration;
    if (_reduced) {
      _controller.value = 0;
      _controller.value = 1;
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, bounds) {
      final scale = (bounds.maxWidth / 390).clamp(.5, 1.2);
      final source = widget.sourceRect;
      final origin = Offset(source.center.dx, source.bottom - 49 * scale);
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final frame = _frame;
          final extra = widget.extraHeight * (frame.width / 307).clamp(0.0, 1.0);
          final target = Rect.fromCenter(
            center: Offset(origin.dx, origin.dy + (frame.y + extra / 2) * scale),
            width: frame.width * scale,
            height: (frame.height + extra) * scale,
          );
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _LiquidPainter(
                      source: source,
                      target: target,
                      neck: frame.neck * scale,
                      shoulder: frame.shoulder * scale,
                      sourceColor: widget.sourceColor,
                      pillColor: widget.pillColor,
                      cap: 36 * scale,
                    ),
                  ),
                ),
              ),
              if (frame.opacity > 0 && frame.width > 0)
                Positioned.fromRect(
                  rect: target,
                  child: IgnorePointer(
                    ignoring: !widget.visible,
                    child: ExcludeSemantics(
                      excluding: !widget.visible || frame.opacity < .6,
                      child: Semantics(
                        liveRegion: true,
                        child: GestureDetector(
                          onTap: widget.onTap,
                          behavior: HitTestBehavior.opaque,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(math.min(target.height / 2, 36 * scale)),
                            child: Opacity(
                              opacity: frame.opacity,
                              child: ImageFiltered(
                                enabled: frame.opacity < 1 && !_reduced,
                                imageFilter: ui.ImageFilter.blur(
                                  sigmaX: (1 - frame.opacity) * 3,
                                  sigmaY: (1 - frame.opacity) * 3,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: 307,
                                    height: 53 + widget.extraHeight,
                                    child: widget.child,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}

class _LiquidPainter extends CustomPainter {
  const _LiquidPainter({
    required this.source,
    required this.target,
    required this.neck,
    required this.shoulder,
    required this.sourceColor,
    required this.pillColor,
    required this.cap,
  });
  final Rect source, target;
  final double neck, shoulder, cap;
  final Color sourceColor, pillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final sourcePath = Path()..addRRect(RRect.fromRectAndRadius(source, Radius.circular(source.height / 2)));
    if (target.isEmpty) {
      canvas.drawPath(sourcePath, Paint()..color = sourceColor);
      return;
    }
    final drop = Path()
      ..addRRect(RRect.fromRectAndRadius(target, Radius.circular(math.min(target.height / 2, cap))));
    if (neck <= 0) {
      canvas.drawPath(sourcePath, Paint()..color = sourceColor);
      canvas.drawPath(drop, Paint()..color = pillColor);
      return;
    }
    final x = source.center.dx;
    final y = source.bottom - 1;
    final bottom = target.center.dy;
    final waistY = ui.lerpDouble(y, target.top, .6)!;
    final attach = target.width * .44;
    final bridge = Path()
      ..moveTo(x - shoulder, y)
      ..cubicTo(x - shoulder * .43, y, x - neck, waistY - 4, x - neck, waistY)
      ..cubicTo(x - neck, waistY + 6, x - attach, bottom - 8, x - attach, bottom)
      ..lineTo(x + attach, bottom)
      ..cubicTo(x + attach, bottom - 8, x + neck, waistY + 6, x + neck, waistY)
      ..cubicTo(x + neck, waistY - 4, x + shoulder * .43, y, x + shoulder, y)
      ..close();
    final silhouette = Path.combine(
      PathOperation.union,
      sourcePath,
      Path.combine(PathOperation.union, bridge, drop),
    );
    final shader = ui.Gradient.linear(
      Offset(x, source.bottom - 2),
      Offset(x, (target.top + target.height * .62).clamp(source.bottom + 1, double.infinity)),
      [sourceColor, pillColor],
      [.0, 1],
    );
    canvas.drawPath(silhouette, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_LiquidPainter old) =>
      old.source != source ||
      old.target != target ||
      old.neck != neck ||
      old.shoulder != shoulder ||
      old.sourceColor != sourceColor ||
      old.pillColor != pillColor ||
      old.cap != cap;
}

final _sessions = Expando<_ToastSession>('notch toasts');

Future<void> showNotchToast(
  BuildContext context,
  String title, {
  String? subtitle,
  IconData? icon,
  Color accent = const Color(0xFF8FA377),
  String? action,
  VoidCallback? onTap,
  Duration? duration,
  bool sound = true,
}) {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  final words = '$title ${subtitle ?? ''}'.trim().split(RegExp(r'\s+')).length;
  if (overlay == null || !context.mounted) return Future.value();
  final request = _ToastRequest(
    title: title,
    subtitle: subtitle,
    icon: icon,
    accent: accent,
    action: action,
    onTap: onTap,
    duration: duration ?? Duration(milliseconds: math.max(2200, 900 + words * 330)),
    themes: InheritedTheme.capture(from: context, to: overlay.context),
    reducedMotion: MediaQuery.maybeOf(context)?.disableAnimations ?? false,
  );
  final session = _sessions[overlay] ??= _ToastSession(overlay);
  session.show(request);
  if (sound) Beeper.instance.chime();
  return request.done.future;
}

class _ToastRequest {
  _ToastRequest({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.action,
    required this.onTap,
    required this.duration,
    required this.themes,
    required this.reducedMotion,
  });
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color accent;
  final String? action;
  final VoidCallback? onTap;
  final Duration duration;
  final CapturedThemes themes;
  final bool reducedMotion;
  final done = Completer<void>();

  void complete() {
    if (!done.isCompleted) done.complete();
  }
}

class _ToastSession {
  _ToastSession(this.overlay);
  final OverlayState overlay;
  OverlayEntry? entry;
  GlobalKey<_ToastHostState>? hostKey;
  _ToastRequest? active, pending;

  void show(_ToastRequest request) {
    if (entry != null) {
      pending?.complete();
      pending = request;
      hostKey?.currentState?.dismiss();
      return;
    }
    active = request;
    final key = GlobalKey<_ToastHostState>();
    hostKey = key;
    entry = OverlayEntry(
      builder: (_) => _ToastHost(key: key, session: this, request: request),
    );
    overlay.insert(entry!);
  }

  void finished(_ToastRequest request) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!identical(active, request)) return;
      final next = pending;
      pending = null;
      active = null;
      final old = entry;
      entry = null;
      hostKey = null;
      old?.remove();
      old?.dispose();
      request.complete();
      if (next != null) {
        if (overlay.mounted) {
          show(next);
        } else {
          next.complete();
        }
      }
    });
    WidgetsBinding.instance.ensureVisualUpdate();
  }

  void hostDisposed(_ToastRequest request) {
    if (!identical(active, request)) return;
    active = null;
    pending?.complete();
    pending = null;
    request.complete();
    final old = entry;
    entry = null;
    hostKey = null;
    if (old != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        old.remove();
        old.dispose();
      });
    }
  }
}

class _ToastHost extends StatefulWidget {
  const _ToastHost({super.key, required this.session, required this.request});
  final _ToastSession session;
  final _ToastRequest request;

  @override
  State<_ToastHost> createState() => _ToastHostState();
}

class _ToastHostState extends State<_ToastHost> {
  bool _visible = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.session.pending != null) {
        dismiss();
        return;
      }
      final entrance = widget.request.reducedMotion ? Duration.zero : const Duration(milliseconds: 650);
      _timer = Timer(entrance + widget.request.duration, dismiss);
    });
  }

  void dismiss() {
    if (!mounted || !_visible) return;
    _timer?.cancel();
    setState(() => _visible = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.session.hostDisposed(widget.request);
    super.dispose();
  }

  static double _extraFor(_ToastRequest r) {
    final sub = r.subtitle;
    if (sub == null || sub.isEmpty) return 0;
    final room = 307 - 26 - (r.icon == null ? 0 : 46) - (r.action == null ? 0 : 60);
    final painter = TextPainter(
      text: TextSpan(text: sub, style: _ToastContent.subStyle),
      textDirection: TextDirection.ltr,
      maxLines: 3,
    )..layout(maxWidth: room.toDouble());
    final lines = painter.computeLineMetrics().length.clamp(1, 3);
    painter.dispose();
    return (lines - 1) * 14.0;
  }

  static Rect sourceFor(MediaQueryData media, double width) {
    final top = media.viewPadding.top;
    for (final f in media.displayFeatures) {
      final b = f.bounds;
      if (f.type != ui.DisplayFeatureType.cutout) continue;
      if (b.top > top || b.width > width * 0.6 || b.isEmpty) continue;
      final side = math.max(b.height, 18.0);
      final w = math.max(b.width, side);
      return Rect.fromCenter(center: b.center, width: w, height: side);
    }
    if (top > 50) {
      return Rect.fromLTWH((width - 126) / 2, math.max(11.0, top - 48), 126, 37);
    }
    const side = 20.0;
    return Rect.fromCenter(center: Offset(width / 2, math.max(side / 2, top / 2)), width: side, height: side);
  }

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final media = MediaQueryData.fromView(
      view,
    ).copyWith(disableAnimations: widget.request.reducedMotion, textScaler: MediaQuery.textScalerOf(context));
    return Positioned.fill(
      child: widget.request.themes.wrap(
        MediaQuery(
          data: media,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final source = sourceFor(media, constraints.maxWidth);
              final extra = _extraFor(widget.request);
              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: source.bottom + 170 + extra,
                  child: LiquidNotch(
                    visible: _visible,
                    extraHeight: extra,
                    sourceRect: source,
                    sourceColor: Colors.black,
                    pillColor: const Color(0xFF0B0B0B),
                    onDismissed: () => widget.session.finished(widget.request),
                    onTap: () {
                      dismiss();
                      widget.request.onTap?.call();
                    },
                    child: _ToastContent(request: widget.request),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ToastContent extends StatelessWidget {
  const _ToastContent({required this.request});
  final _ToastRequest request;

  static final subStyle = AppTheme.f(
    11.5,
    weight: FontWeight.w600,
    color: Colors.white.withValues(alpha: 0.6),
    height: 1.2,
  );

  @override
  Widget build(BuildContext context) {
    final icon = request.icon;
    final action = request.action;
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 16, 9),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: request.accent.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: request.accent),
              ),
              const SizedBox(width: 11),
            ],
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w800, color: Colors.white, height: 1.1),
                  ),
                  if (request.subtitle != null && request.subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(request.subtitle!, maxLines: 3, overflow: TextOverflow.ellipsis, style: subStyle),
                  ],
                ],
              ),
            ),
            if (action != null) ...[
              const SizedBox(width: 8),
              Text(
                action,
                style: AppTheme.f(13, weight: FontWeight.w800, color: request.accent),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
