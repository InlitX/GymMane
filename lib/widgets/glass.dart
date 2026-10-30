import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

bool blurEffects = true;

final sheetRecede = ValueNotifier<double>(0);

final glassOpen = ValueNotifier<int>(0);
final glassShown = ValueNotifier<int>(0);

mixin _GlassCount<T> on ModalRoute<T> {
  static final _live = <_GlassCount>{};

  bool _open = false;

  static void _recede() {
    var v = 0.0;
    for (final r in _live) {
      final a = r.animation?.value ?? 0;
      if (a > v) v = a;
    }
    sheetRecede.value = Curves.easeOutCubic.transform(v.clamp(0.0, 1.0));
  }

  @override
  void install() {
    super.install();
    _open = true;
    _live.add(this);
    animation?.addListener(_recede);
    glassOpen.value++;
    glassShown.value++;
  }

  void _close() {
    if (!_open) return;
    _open = false;
    glassOpen.value--;
  }

  @override
  bool didPop(T? result) {
    _close();
    return super.didPop(result);
  }

  @override
  void dispose() {
    _close();
    animation?.removeListener(_recede);
    if (_live.remove(this)) glassShown.value--;
    _recede();
    super.dispose();
  }
}

Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  Color? backgroundColor,
  ShapeBorder? shape,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = false,
}) {
  final nav = Navigator.of(context);
  return nav.push(_GlassSheetRoute<T>(
    builder: enableDrag && isDismissible ? (c) => _PullToClose(child: builder(c)) : builder,
    isScrollControlled: isScrollControlled,
    backgroundColor: backgroundColor,
    shape: shape,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useSafeArea: useSafeArea,
    modalBarrierColor: Colors.black.withValues(alpha: 0.38),
    capturedThemes: InheritedTheme.capture(from: context, to: nav.context),
    barrierLabel: MaterialLocalizations.of(context).scrimLabel,
  ));
}

class _GlassSheetRoute<T> extends ModalBottomSheetRoute<T> with _GlassCount<T> {
  _GlassSheetRoute({
    required super.builder,
    required super.isScrollControlled,
    super.backgroundColor,
    super.shape,
    super.isDismissible,
    super.enableDrag,
    super.useSafeArea,
    super.modalBarrierColor,
    super.capturedThemes,
    super.barrierLabel,
  });
}

class _PullToClose extends StatefulWidget {
  const _PullToClose({required this.child});

  final Widget child;

  @override
  State<_PullToClose> createState() => _PullToCloseState();
}

class _PullToCloseState extends State<_PullToClose> {
  static const _limit = 72.0;
  double _pull = 0;
  bool _closing = false;

  void _set(double v) {
    if (v == _pull || _closing) return;
    setState(() => _pull = v);
  }

  void _close() {
    if (_closing) return;
    _closing = true;
    Navigator.of(context).maybePop();
  }

  bool _onScroll(ScrollNotification n) {
    if (n.metrics.axis != Axis.vertical) return false;
    if (n is OverscrollNotification && n.dragDetails != null && n.overscroll < 0 && n.metrics.extentBefore == 0) {
      final next = _pull - n.overscroll;
      if (next > _limit) {
        _close();
      } else {
        _set(next);
      }
    } else if (n is ScrollUpdateNotification && n.dragDetails != null) {
      if (n.metrics.pixels < -_limit) {
        _close();
      } else if ((n.scrollDelta ?? 0) > 0) {
        _set(0);
      }
    } else if (n is ScrollEndNotification) {
      _set(0);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: Transform.translate(offset: Offset(0, _pull * 0.5), child: widget.child),
      );
}

Future<T?> showAppDialog<T>({required BuildContext context, required WidgetBuilder builder}) {
  final nav = Navigator.of(context);
  return nav.push(_GlassDialogRoute<T>(
    context: context,
    builder: builder,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    themes: InheritedTheme.capture(from: context, to: nav.context),
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  ));
}

class _GlassDialogRoute<T> extends DialogRoute<T> with _GlassCount<T> {
  _GlassDialogRoute({
    required super.context,
    required super.builder,
    super.barrierColor,
    super.themes,
    super.barrierLabel,
  });

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondary, Widget child) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack, reverseCurve: Curves.easeInCubic);
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: ScaleTransition(scale: Tween<double>(begin: 0.92, end: 1).animate(curved), child: child),
    );
  }
}


class EdgeBlur extends StatefulWidget {
  const EdgeBlur({super.key, required this.height, this.top = true, this.sigma = 16, this.shade = 1});

  final double height;
  final bool top;
  final double sigma;
  final double shade;

  @override
  State<EdgeBlur> createState() => _EdgeBlurState();
}

class _EdgeBlurState extends State<EdgeBlur> {
  static Future<ui.FragmentProgram>? _loading;
  static ui.FragmentProgram? _program;

  final _shaders = <ui.FragmentShader>[];
  List<ui.ImageFilter>? _filters;
  Object? _filtersFor;

  @override
  void initState() {
    super.initState();
    if (_program != null || !ui.ImageFilter.isShaderFilterSupported) return;
    (_loading ??= ui.FragmentProgram.fromAsset('assets/shaders/edge_fade.frag')).then((p) {
      _program = p;
      if (mounted) setState(() {});
    }, onError: (_) {});
  }

  @override
  void dispose() {
    _dropShaders();
    super.dispose();
  }

  void _dropShaders() {
    for (final s in _shaders) {
      s.dispose();
    }
    _shaders.clear();
  }

  List<ui.ImageFilter> _layers(ui.FragmentProgram program, double dpr) {
    final key = (widget.height, widget.top, widget.sigma, dpr);
    if (_filters != null && _filtersFor == key) return _filters!;
    _dropShaders();
    ui.ImageFilter layer(double sigma, double from, double to) {
      final shader = program.fragmentShader()
        ..setFloat(2, widget.height * dpr)
        ..setFloat(3, from)
        ..setFloat(4, to)
        ..setFloat(5, widget.top ? 1 : 0);
      _shaders.add(shader);
      return ui.ImageFilter.compose(
        outer: ui.ImageFilter.shader(shader),
        inner: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: TileMode.clamp),
      );
    }

    _filtersFor = key;
    return _filters = [
      layer(widget.sigma * 0.35, 0.2, 1),
      layer(widget.sigma, 0.08, 0.66),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final program = _program;
    return IgnorePointer(
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            if (!blurEffects)
              const SizedBox.shrink()
            else if (program != null)
              for (final f in _layers(program, MediaQuery.devicePixelRatioOf(context)))
                Positioned.fill(
                  child: ClipRect(child: BackdropFilter(filter: f, child: const SizedBox.expand())),
                )
            else
              ..._strips(),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: widget.top ? Alignment.topCenter : Alignment.bottomCenter,
                    end: widget.top ? Alignment.bottomCenter : Alignment.topCenter,
                    colors: [
                      for (final a in const [0.82, 0.62, 0.38, 0.17, 0.05, 0.0]) gc.bg.withValues(alpha: a * widget.shade),
                    ],
                    stops: const [0, 0.2, 0.42, 0.64, 0.84, 1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _strips() {
    const n = 6;
    final strip = widget.height * 0.8 / n;
    return [
      for (var i = 0; i < n; i++)
        Positioned(
          left: 0,
          right: 0,
          top: widget.top ? strip * i : widget.height - strip * (i + 1),
          height: strip + 0.5,
          child: ClipRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: widget.sigma * (1 - i / n) * 0.7,
                sigmaY: widget.sigma * (1 - i / n) * 0.7,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ),
    ];
  }
}

class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.radius = 28,
    this.blur = 22,
    this.tint,
    this.padding,
  });

  final Widget child;
  final double radius;
  final double blur;
  final Color? tint;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final dark = gc.bg.computeLuminance() < 0.5;
    final shape = BorderRadius.circular(radius);
    return ClipRRect(
      borderRadius: shape,
      child: BackdropFilter.grouped(
        enabled: blurEffects,
        filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: shape,
            color: blurEffects ? tint ?? gc.bgRaised.withValues(alpha: dark ? 0.66 : 0.74) : gc.bgRaised,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: shape,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: dark ? 0.07 : 0.3),
                  Colors.white.withValues(alpha: 0),
                ],
                stops: const [0, 0.6],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: dark ? 0.08 : 0.5), width: 0.8),
            ),
            child: padding == null ? child : Padding(padding: padding!, child: child),
          ),
        ),
      ),
    );
  }
}
