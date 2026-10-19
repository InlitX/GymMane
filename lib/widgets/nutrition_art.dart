import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui show Image, Picture, PictureRecorder;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../models/nutrition.dart';
import '../services/food_library.dart';
import '../services/media_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

extension NutritionColors on GymColors {
  Color get water => info;
  Color get protein => accent;
  Color get carbs => warn;
  Color get fat => sage;
}

class CalorieRing extends StatelessWidget {
  const CalorieRing({
    super.key,
    required this.pct,
    this.size = 150,
    this.stroke = 13,
    this.child,
    this.color,
  });

  final double pct;
  final double size;
  final double stroke;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: pct.clamp(0.0, 2.0)),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, v, kid) => CustomPaint(
          painter: _CalorieRingPainter(
            pct: v,
            track: gc.bgRaised2,
            from: Color.lerp(color ?? gc.accent, gc.bgRaised2, 0.35)!,
            to: color ?? gc.accent,
            over: gc.danger,
            stroke: stroke,
          ),
          child: kid,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _CalorieRingPainter extends CustomPainter {
  _CalorieRingPainter({
    required this.pct,
    required this.track,
    required this.from,
    required this.to,
    required this.over,
    required this.stroke,
  });

  final double pct;
  final Color track, from, to, over;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 - stroke / 2;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = track,
    );
    if (pct <= 0.002) return;
    final first = math.min(pct, 1.0);
    final sweep = first * 2 * math.pi;
    final cap = stroke / r;
    final shader = SweepGradient(
      colors: [from, from, to, to],
      stops: const [0, 0.03, 0.85, 1],
      transform: GradientRotation(-math.pi / 2 - cap),
    ).createShader(rect);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke * 1.9
        ..strokeCap = StrokeCap.round
        ..color = to.withValues(alpha: 0.1),
    );
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = shader,
    );
    if (pct > 1) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        (pct - 1).clamp(0.0, 1.0) * 2 * math.pi,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke * 0.55
          ..strokeCap = StrokeCap.round
          ..color = over,
      );
    }
  }

  @override
  bool shouldRepaint(_CalorieRingPainter o) => o.pct != pct || o.track != track || o.to != to;
}

class MacroTrack extends StatelessWidget {
  const MacroTrack({super.key, required this.pct, required this.color, this.height = 7});

  final double pct;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return DecoratedBox(
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(height)),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(end: pct.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, v, _) => FractionallySizedBox(
                widthFactor: v,
                heightFactor: 1,
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height),
                    gradient: LinearGradient(colors: [Color.lerp(color, Colors.white, 0.18)!, color]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodSticker extends StatelessWidget {
  const FoodSticker({
    super.key,
    required this.photo,
    required this.name,
    this.size = 72,
    this.tilt = true,
    this.shadow = true,
    this.dim = false,
  });

  final String photo;
  final String name;
  final double size;
  final bool tilt;
  final bool shadow;
  final bool dim;

  static const _faded = AlwaysStoppedAnimation(0.45);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final asset = isAssetPhoto(photo);
    final path = photo.isEmpty || asset ? null : MediaStore.pathFor(photo);
    final file = path == null ? null : File(path);
    final angle = tilt ? ((name.hashCode % 9) - 4) * 0.012 : 0.0;
    final cache = (size * MediaQuery.devicePixelRatioOf(context)).round();
    Widget art;
    if (asset || file != null) {
      final image = asset
          ? Image.asset(
              assetOfPhoto(photo),
              width: size,
              height: size,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              cacheWidth: cache,
              opacity: dim ? _faded : null,
              errorBuilder: (_, _, _) => _Placeholder(name: name, size: size, gc: gc),
            )
          : Image.file(
              file!,
              width: size,
              height: size,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              cacheWidth: cache,
              opacity: dim ? _faded : null,
              errorBuilder: (_, _, _) => _Placeholder(name: name, size: size, gc: gc),
            );
      art = !shadow
          ? image
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: size * 0.1,
                  right: size * 0.1,
                  bottom: -size * 0.03,
                  height: size * 0.2,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Color(0x66000000), Color(0x00000000)],
                        transform: _Stretch(4),
                      ),
                    ),
                  ),
                ),
                image,
              ],
            );
    } else {
      art = _Placeholder(name: name, size: size, gc: gc);
    }
    return SizedBox(
      width: size,
      height: size,
      child: Transform.rotate(angle: angle, child: art),
    );
  }
}

class _Stretch extends GradientTransform {
  const _Stretch(this.x);

  final double x;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final c = bounds.center;
    return Matrix4.identity()
      ..translateByDouble(c.dx, c.dy, 0, 1)
      ..scaleByDouble(x, 1, 1, 1)
      ..translateByDouble(-c.dx, -c.dy, 0, 1);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.name, required this.size, required this.gc});

  final String name;
  final double size;
  final GymColors gc;

  @override
  Widget build(BuildContext context) {
    final base = gc.bgRaised2;
    return Padding(
      padding: EdgeInsets.all(size * 0.04),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.lerp(base, Colors.white, 0.06)!,
              base,
              Color.lerp(base, Colors.white, 0.12)!,
              Color.lerp(base, Colors.black, 0.3)!,
            ],
            stops: const [0, 0.62, 0.8, 1],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: size * 0.08,
              offset: Offset(0, size * 0.04),
            ),
          ],
        ),
        child: Center(
          child: Icon(PhosphorIconsFill.forkKnife, size: size * 0.34, color: gc.textTertiary),
        ),
      ),
    );
  }
}

class PhotoVessel extends StatefulWidget {
  const PhotoVessel({
    super.key,
    required this.asset,
    required this.level,
    required this.height,
    required this.liquid,
    this.top = 0.12,
    this.bottom = 0.95,
    this.curve = 0.08,
    this.texture,
    this.animate = true,
  });

  final String asset;
  final double level;
  final bool animate;
  final double height;
  final Color liquid;
  final double top;
  final double bottom;
  final double curve;
  final String? texture;

  @override
  State<PhotoVessel> createState() => _PhotoVesselState();
}

class _PhotoVesselState extends State<PhotoVessel> with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..addListener(_tick);
  final _phase = ValueNotifier<double>(0);
  final _streams = <ImageStream>[];
  final _listeners = <ImageStreamListener>[];
  ui.Image? _image;
  ui.Image? _mask;
  ui.Image? _texture;
  ValueListenable<bool>? _scrolling;
  bool _front = true;
  Duration _last = Duration.zero;
  ui.Image? _still;
  double _stillLevel = -1;
  double _level = 0;
  Size _size = Size.zero;

  _VesselPainter _painter(double level) => _VesselPainter(
    image: _image!,
    mask: _mask!,
    texture: _texture,
    level: level,
    spin: _phase,
    top: widget.top,
    bottom: widget.bottom,
    curve: widget.curve,
    liquid: widget.liquid,
  );

  void _freeze() {
    if (_image == null || _mask == null || _size.isEmpty) return;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)..scale(dpr);
    _painter(_level).paint(canvas, _size);
    final picture = recorder.endRecording();
    final still = picture.toImageSync((_size.width * dpr).ceil(), (_size.height * dpr).ceil());
    picture.dispose();
    setState(() {
      _still?.dispose();
      _still = still;
      _stillLevel = _level;
    });
  }

  void _thaw() {
    final still = _still;
    if (still == null) return;
    setState(() => _still = null);
    WidgetsBinding.instance.addPostFrameCallback((_) => still.dispose());
  }

  void _tick() {
    final now = _spin.lastElapsedDuration ?? Duration.zero;
    if ((now - _last).inMilliseconds.abs() < 32) return;
    _last = now;
    _phase.value = _spin.value;
  }

  bool get _onScreen {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return true;
    final top = box.localToGlobal(Offset.zero).dy;
    final screen = MediaQuery.sizeOf(context).height;
    return top < screen && top + box.size.height > 0;
  }

  void _sync() {
    if (!mounted) return;
    final run = widget.animate && _front && !(_scrolling?.value ?? false) && _onScreen;
    if (run && !_spin.isAnimating) {
      _thaw();
      _spin.repeat();
    } else if (!run && (_spin.isAnimating || _still == null || (_level - _stillLevel).abs() >= 0.0005)) {
      _spin.stop(canceled: false);
      _freeze();
    }
  }

  void _unlisten() {
    for (var i = 0; i < _streams.length; i++) {
      _streams[i].removeListener(_listeners[i]);
    }
    _streams.clear();
    _listeners.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _front = ModalRoute.isCurrentOf(context) ?? true;
    final scrolling = Scrollable.maybeOf(context)?.position.isScrollingNotifier;
    if (scrolling != _scrolling) {
      _scrolling?.removeListener(_sync);
      _scrolling = scrolling?..addListener(_sync);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
    _unlisten();
    final config = createLocalImageConfiguration(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);
    void watch(String asset, void Function(ui.Image) set, {bool fit = true}) {
      final l = ImageStreamListener((info, _) {
        if (mounted) setState(() => set(info.image));
      });
      final provider = fit
          ? ResizeImage(
              AssetImage(asset),
              height: (widget.height * dpr).round(),
              policy: ResizeImagePolicy.fit,
            )
          : AssetImage(asset) as ImageProvider;
      _streams.add(provider.resolve(config)..addListener(l));
      _listeners.add(l);
    }

    watch(widget.asset, (i) => _image = i);
    watch(widget.asset.replaceFirst('.webp', '-mask.webp'), (i) => _mask = i);
    final texture = widget.texture;
    if (texture != null) watch(texture, (i) => _texture = i, fit: false);
  }

  @override
  void didUpdateWidget(PhotoVessel old) {
    super.didUpdateWidget(old);
    if (old.animate != widget.animate || old.level != widget.level) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!widget.animate) {
          Future.delayed(const Duration(milliseconds: 1150), _sync);
        } else {
          _sync();
        }
      });
    }
  }

  @override
  void dispose() {
    _unlisten();
    _scrolling?.removeListener(_sync);
    _still?.dispose();
    _spin.dispose();
    _phase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = _image, mask = _mask;
    if (image == null || mask == null || (widget.texture != null && _texture == null)) {
      return SizedBox(height: widget.height);
    }
    final width = widget.height * image.width / image.height;
    return SizedBox(
      width: width,
      height: widget.height,
      child: RepaintBoundary(
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: widget.level.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeOutCubic,
          builder: (context, level, _) {
            _level = level;
            _size = Size(width, widget.height);
            final still = _still;
            if (still != null && (level - _stillLevel).abs() < 0.0005) {
              return RawImage(image: still, width: width, height: widget.height, fit: BoxFit.fill);
            }
            return CustomPaint(painter: _painter(level));
          },
        ),
      ),
    );
  }
}

Color shakeColor(FoodItem? shake) {
  final name = foldText('${shake?.name ?? ''} ${FoodLibrary.byId(shake?.id ?? '')?.names['en'] ?? ''}');
  bool has(List<String> words) => words.any(name.contains);
  if (has(['choc', 'cacao', 'cocoa', 'kakao', 'coffee', 'cafe', 'mocha'])) return const Color(0xFF8A5A3C);
  if (has(['fresa', 'strawberr', 'berry', 'frutos rojos', 'erdbeer', 'fraise'])) {
    return const Color(0xFFE3A7AE);
  }
  if (has(['platano', 'banana', 'mango'])) return const Color(0xFFE6D08E);
  return const Color(0xFFE2D5BC);
}

class VesselLook {
  const VesselLook({
    required this.asset,
    required this.top,
    required this.bottom,
    required this.curve,
    required this.liquid,
    this.texture,
  });

  final String asset;
  final double top;
  final double bottom;
  final double curve;
  final Color liquid;
  final String? texture;

  static const water = VesselLook(
    asset: 'assets/img/vessel-water.webp',
    top: 0.269,
    bottom: 0.989,
    curve: 0.08,
    liquid: Color(0xFF4FB4F2),
  );

  static VesselLook shake(Color liquid) => VesselLook(
    asset: 'assets/img/vessel-shake.webp',
    top: 0.407,
    bottom: 0.975,
    curve: 0.066,
    liquid: liquid,
    texture: 'assets/img/shake-texture.webp',
  );
}

ui.Picture paintVesselFrame({
  required VesselLook look,
  required ui.Image image,
  required ui.Image mask,
  ui.Image? texture,
  required double level,
  required double phase,
  required Size size,
  double scale = 1,
}) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)..scale(scale);
  final spin = ValueNotifier<double>(phase);
  _VesselPainter(
    image: image,
    mask: mask,
    texture: texture,
    level: level.clamp(0.0, 1.0),
    spin: spin,
    top: look.top,
    bottom: look.bottom,
    curve: look.curve,
    liquid: look.liquid,
  ).paint(canvas, size);
  spin.dispose();
  return recorder.endRecording();
}

class _VesselPainter extends CustomPainter {
  _VesselPainter({
    required this.image,
    required this.mask,
    required this.texture,
    required this.level,
    required this.spin,
    required this.top,
    required this.bottom,
    required this.curve,
    required this.liquid,
  }) : super(repaint: spin);

  final ui.Image image;
  final ui.Image mask;
  final ui.Image? texture;
  final double level;
  final ValueListenable<double> spin;
  double get phase => spin.value;
  final double top;
  final double bottom;
  final double curve;
  final Color liquid;

  static const _textureBase = Color(0xFFC4BEB0);

  ColorFilter get _flavor {
    double k(double c, double b) => (c / b).clamp(0.0, 2.0);
    return ColorFilter.matrix([
      k(liquid.r, _textureBase.r),
      0,
      0,
      0,
      0,
      0,
      k(liquid.g, _textureBase.g),
      0,
      0,
      0,
      0,
      0,
      k(liquid.b, _textureBase.b),
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  void _wrapped(
    Canvas canvas,
    ui.Image tex,
    double w,
    double y0,
    double y1,
    double turn,
    ColorFilter? filter,
  ) {
    const strips = 24;
    final r = w / 2;
    final tile = tex.width / 4;
    final k = w * 0.92 / tile;
    for (var i = 0; i < strips; i++) {
      final xa = w * i / strips, xb = w * (i + 1) / strips;
      final xc = (xa + xb) / 2;
      final u = ((xc - r) / r).clamp(-0.995, 0.995);
      final theta = math.asin(u);
      final squeeze = math.cos(theta);
      final tx = r * theta / k + (turn % 1) * tile + tile * 1.5;
      final m = Matrix4.identity()
        ..translateByDouble(xc - k * squeeze * tx, 0, 0, 1)
        ..scaleByDouble(k * squeeze, k, 1, 1);
      canvas.drawRect(
        Rect.fromLTRB(xa - 0.4, y0, xb + 0.4, y1),
        Paint()
          ..filterQuality = FilterQuality.low
          ..colorFilter = filter
          ..shader = ImageShader(tex, TileMode.clamp, TileMode.clamp, m.storage),
      );
    }
  }

  void _water(Canvas canvas, double w, double h, double surface, double floor, double eh, Rect body) {
    final deep = Color.lerp(liquid, const Color(0xFF0B3A66), 0.55)!;
    final light = Color.lerp(liquid, Colors.white, 0.55)!;
    canvas.drawRect(
      body,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            liquid.withValues(alpha: 0.30),
            liquid.withValues(alpha: 0.42),
            deep.withValues(alpha: 0.62),
          ],
          stops: const [0, 0.45, 1],
        ).createShader(Rect.fromLTRB(0, surface, w, floor)),
    );
    canvas.drawRect(
      body,
      Paint()
        ..shader = LinearGradient(
          colors: [
            deep.withValues(alpha: 0.75),
            deep.withValues(alpha: 0.0),
            Colors.transparent,
            deep.withValues(alpha: 0.0),
            deep.withValues(alpha: 0.8),
          ],
          stops: const [0, 0.22, 0.5, 0.8, 1],
        ).createShader(body),
    );
    void streak(double x, double width, double alpha) {
      final r = Rect.fromLTWH(w * x - w * width / 2, surface, w * width, h - surface);
      canvas.drawRect(
        r,
        Paint()
          ..shader = LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0),
              Colors.white.withValues(alpha: alpha),
              Colors.white.withValues(alpha: 0),
            ],
          ).createShader(r),
      );
    }

    streak(0.27, 0.07, 0.32);
    streak(0.36, 0.03, 0.18);
    streak(0.74, 0.12, 0.12);
    final depth = floor - surface;
    if (depth > 6) {
      final caustic = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;
      for (var k = 0; k < 4; k++) {
        final y0 = floor - depth * (0.08 + 0.13 * k);
        if (y0 < surface + eh * 0.6) break;
        final path = Path();
        for (var x = 0.0; x <= w; x += 2) {
          final y =
              y0 +
              math.sin(x / w * math.pi * (3 + k) + phase * math.pi * 2 * (1 + k * 0.5)) * 2.2 +
              math.sin(x / w * math.pi * 7 - phase * math.pi * 4) * 1.1;
          x == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
        }
        canvas.drawPath(path, caustic..color = light.withValues(alpha: 0.22 - k * 0.04));
      }
    }
    for (var i = 0; i < 9; i++) {
      final speed = 2 + i % 3;
      final k = (phase * speed + i / 9) % 1;
      final y = floor - k * (floor - surface - eh * 0.45);
      if (y < surface + eh * 0.45) continue;
      final x = w * (0.22 + 0.56 * ((i * 0.618) % 1)) + math.sin(phase * 20 + i * 1.7) * w * 0.015;
      final r = w * (0.006 + 0.004 * (i % 3)) * (0.7 + 0.5 * k);
      final fade = 1 - k * 0.6;
      canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.white.withValues(alpha: 0.12 * fade));
      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7
          ..color = Colors.white.withValues(alpha: 0.55 * fade),
      );
      canvas.drawCircle(
        Offset(x - r * 0.35, y - r * 0.35),
        r * 0.3,
        Paint()..color = Colors.white.withValues(alpha: 0.7 * fade),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final dst = Offset.zero & size;
    final w = size.width, h = size.height;
    Rect src(ui.Image i) => Rect.fromLTWH(0, 0, i.width.toDouble(), i.height.toDouble());
    final tex = texture;
    canvas.saveLayer(dst, Paint());
    canvas.save();
    canvas.clipRect(dst.deflate(4));
    canvas.drawImageRect(
      mask,
      src(mask),
      dst,
      Paint()..colorFilter = const ColorFilter.mode(Color(0x33000000), BlendMode.srcIn),
    );
    if (level > 0.004) {
      final eh = w * curve * 2;
      final floor = h * bottom, ceil = h * top + eh * 0.5;
      final surface = floor - (floor - ceil) * level;
      final tau = math.pi * 2;
      final tilt =
          (math.sin(phase * tau * 3) * 0.045 + math.sin(phase * tau * 7 + 1.3) * 0.012) *
          math.min(1.0, level * 4);
      final slope = math.tan(tilt);
      final reach = (slope.abs() * w / 2) + 2;
      final body = Rect.fromLTRB(0, surface - reach, w, h);
      canvas.save();
      canvas.clipPath(
        Path()
          ..moveTo(0, surface - slope * w / 2)
          ..lineTo(w, surface + slope * w / 2)
          ..lineTo(w, h)
          ..lineTo(0, h)
          ..close(),
      );
      if (tex != null) {
        _wrapped(canvas, tex, w, surface - reach, h, phase * 2, _flavor);
        canvas.drawRect(
          body,
          Paint()
            ..shader = LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.04),
                Colors.black.withValues(alpha: 0.55),
              ],
              stops: const [0, 0.24, 0.4, 0.7, 1],
            ).createShader(body),
        );
      } else {
        _water(canvas, w, h, surface, floor, eh, body);
      }
      canvas.drawRect(
        body,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.22)],
          ).createShader(Rect.fromLTRB(0, surface, w, floor + eh)),
      );
      canvas.restore();
      final face = Rect.fromCenter(center: Offset(w / 2, surface), width: w * 1.04, height: eh);
      canvas.save();
      canvas.translate(w / 2, surface);
      canvas.rotate(tilt);
      canvas.translate(-w / 2, -surface);
      canvas.save();
      canvas.clipPath(Path()..addOval(face));
      if (tex != null) {
        _wrapped(canvas, tex, w, face.top, face.bottom, phase + 0.37, _flavor);
        canvas.drawOval(
          face,
          Paint()
            ..shader = RadialGradient(
              center: const Alignment(-0.2, -0.3),
              radius: 0.85,
              colors: [Colors.white.withValues(alpha: 0.32), Colors.black.withValues(alpha: 0.12)],
            ).createShader(face),
        );
      } else {
        canvas.drawOval(
          face,
          Paint()
            ..shader = RadialGradient(
              center: const Alignment(-0.2, -0.2),
              radius: 0.9,
              colors: [
                Color.lerp(liquid, Colors.white, 0.75)!.withValues(alpha: 0.7),
                Color.lerp(liquid, Colors.white, 0.3)!.withValues(alpha: 0.35),
              ],
            ).createShader(face),
        );
      }
      for (var k = 0; k < 3; k++) {
        final t = (phase * 4 + k / 3) % 1;
        canvas.drawOval(
          Rect.fromCenter(
            center: face.center + Offset(math.sin(phase * tau * 2 + k) * w * 0.06, 0),
            width: face.width * (0.2 + 0.75 * t),
            height: face.height * (0.2 + 0.75 * t),
          ),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.9
            ..color = Colors.white.withValues(alpha: (tex == null ? 0.32 : 0.18) * (1 - t)),
        );
      }
      canvas.restore();
      final front = Path();
      for (var i = 0; i <= 48; i++) {
        final a = 0.12 + (math.pi - 0.24) * i / 48;
        final ripple = math.sin(a * 9 - phase * tau * 10) * eh * 0.035;
        final p = Offset(
          face.center.dx + math.cos(a) * (face.width / 2 - 0.5),
          face.center.dy + math.sin(a) * (face.height / 2 - 0.5) + ripple,
        );
        i == 0 ? front.moveTo(p.dx, p.dy) : front.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(
        front,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1
          ..color = Colors.white.withValues(alpha: tex == null ? 0.75 : 0.35),
      );
      canvas.restore();
    }
    canvas.restore();
    canvas.drawImageRect(mask, src(mask), dst, Paint()..blendMode = BlendMode.dstIn);
    canvas.restore();
    canvas.drawImageRect(image, src(image), dst, Paint()..filterQuality = FilterQuality.medium);
  }

  @override
  bool shouldRepaint(_VesselPainter o) =>
      o.level != level || o.image != image || o.mask != mask || o.texture != texture || o.liquid != liquid;
}

class FoodPlate extends StatelessWidget {
  const FoodPlate({super.key, required this.items, this.size = 150});

  final List<(String photo, String name)> items;
  final double size;

  static const _layouts = <List<(double, double, double)>>[
    [],
    [(0, 0, 0.62)],
    [(-0.2, 0.04, 0.48), (0.2, -0.04, 0.48)],
    [(-0.2, 0.12, 0.42), (0.2, 0.12, 0.42), (0, -0.18, 0.42)],
    [(-0.19, -0.17, 0.38), (0.19, -0.17, 0.38), (-0.19, 0.19, 0.38), (0.19, 0.19, 0.38)],
    [(-0.22, -0.18, 0.34), (0.22, -0.18, 0.34), (-0.24, 0.2, 0.34), (0.24, 0.2, 0.34), (0, 0.01, 0.36)],
  ];

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final shown = items.take(5).toList();
    final layout = _layouts[shown.length];
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.lerp(gc.bgRaised2, Colors.white, 0.05)!,
                    gc.bgRaised2,
                    Color.lerp(gc.bgRaised2, Colors.white, 0.09)!,
                    Color.lerp(gc.bgRaised2, Colors.black, 0.25)!,
                  ],
                  stops: const [0, 0.7, 0.86, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: size * 0.08,
                    offset: Offset(0, size * 0.04),
                  ),
                ],
              ),
            ),
          ),
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: size / 2 + layout[i].$1 * size - layout[i].$3 * size / 2,
              top: size / 2 + layout[i].$2 * size - layout[i].$3 * size / 2,
              child: FoodSticker(photo: shown[i].$1, name: shown[i].$2, size: layout[i].$3 * size),
            ),
        ],
      ),
    );
  }
}

class ValueLineChart extends StatelessWidget {
  const ValueLineChart({
    super.key,
    required this.values,
    required this.labels,
    required this.format,
    required this.color,
    this.goal,
    this.goalLabel,
    this.highlight,
    this.fromZero = true,
    this.height = 168,
    this.tone,
  });

  final List<double?> values;
  final List<String> labels;
  final String Function(double) format;
  final Color color;
  final double? goal;
  final String? goalLabel;
  final int? highlight;
  final bool fromZero;
  final double height;
  final Color Function(double)? tone;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TweenAnimationBuilder<double>(
        key: ValueKey(Object.hashAll([...values, goal])),
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, p, _) => CustomPaint(
          painter: _ValueLinePainter(
            values: values,
            labels: labels,
            format: format,
            color: color,
            goal: goal,
            goalLabel: goalLabel,
            highlight: highlight,
            fromZero: fromZero,
            tone: tone,
            progress: p,
            gc: gc,
          ),
        ),
      ),
    );
  }
}

class _ValueLinePainter extends CustomPainter {
  _ValueLinePainter({
    required this.values,
    required this.labels,
    required this.format,
    required this.color,
    required this.goal,
    required this.goalLabel,
    required this.highlight,
    required this.fromZero,
    required this.tone,
    required this.progress,
    required this.gc,
  });

  final List<double?> values;
  final List<String> labels;
  final String Function(double) format;
  final Color color;
  final double? goal;
  final String? goalLabel;
  final int? highlight;
  final bool fromZero;
  final Color Function(double)? tone;
  final double progress;
  final GymColors gc;

  static const _top = 30.0, _bottom = 26.0;

  TextPainter _text(String s, TextStyle style) => TextPainter(
    text: TextSpan(text: s, style: style),
    textDirection: TextDirection.ltr,
  )..layout();

  @override
  void paint(Canvas canvas, Size size) {
    final n = values.length;
    if (n == 0) return;
    final goalTag = goal == null || goalLabel == null
        ? null
        : _text(goalLabel!, AppTheme.f(10, weight: FontWeight.w800, color: gc.textTertiary));
    final right = goalTag == null ? 0.0 : goalTag.width + 10;
    final width = size.width - right;
    final col = width / n;
    const plotTop = _top;
    final plotBottom = size.height - _bottom;
    final shown = [for (final v in values) ?v];
    var lo = shown.isEmpty ? 0.0 : shown.reduce(math.min);
    var hi = shown.isEmpty ? 1.0 : shown.reduce(math.max);
    if (goal != null) {
      lo = math.min(lo, goal!);
      hi = math.max(hi, goal!);
    }
    if (fromZero) {
      lo = 0;
    } else {
      final pad = math.max((hi - lo) * 0.25, hi.abs() * 0.01 + 0.5);
      lo -= pad;
      hi += pad * 0.4;
    }
    if (hi - lo < 1e-6) hi = lo + 1;
    double yOf(double v) => plotBottom - (v - lo) / (hi - lo) * (plotBottom - plotTop);
    double xOf(int i) => col * (i + 0.5);

    canvas.drawLine(
      Offset(0, plotBottom + 0.5),
      Offset(width, plotBottom + 0.5),
      Paint()
        ..color = gc.border.withValues(alpha: 0.6)
        ..strokeWidth = 1,
    );

    if (goal != null) {
      final gy = yOf(goal!);
      final dash = Paint()
        ..color = gc.textTertiary.withValues(alpha: 0.7)
        ..strokeWidth = 1.2;
      for (var x = 0.0; x < width; x += 8) {
        canvas.drawLine(Offset(x, gy), Offset(math.min(x + 4, width), gy), dash);
      }
      goalTag?.paint(canvas, Offset(size.width - goalTag.width, gy - goalTag.height / 2));
    }

    final pts = <(int, Offset)>[
      for (var i = 0; i < n; i++)
        if (values[i] != null) (i, Offset(xOf(i), plotBottom - (plotBottom - yOf(values[i]!)) * progress)),
    ];

    if (pts.length >= 2) {
      final line = _smooth([for (final p in pts) p.$2]);
      final area = Path.from(line)
        ..lineTo(pts.last.$2.dx, plotBottom)
        ..lineTo(pts.first.$2.dx, plotBottom)
        ..close();
      canvas.drawPath(
        area,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.26), color.withValues(alpha: 0)],
          ).createShader(Rect.fromLTRB(0, plotTop, width, plotBottom)),
      );
      canvas.drawPath(
        line,
        Paint()
          ..color = color.withValues(alpha: 0.14)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
      canvas.drawPath(
        line,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.6
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    for (final (i, o) in pts) {
      final hot = i == highlight;
      final c = tone?.call(values[i]!) ?? color;
      if (hot) canvas.drawCircle(o, 10, Paint()..color = c.withValues(alpha: 0.22));
      final r = hot ? 5.5 : 4.0;
      canvas.drawCircle(o, r, Paint()..color = gc.bgRaised);
      canvas.drawCircle(
        o,
        r,
        Paint()
          ..color = c
          ..style = PaintingStyle.stroke
          ..strokeWidth = hot ? 3 : 2.2,
      );
      final tag = _text(
        format(values[i]!),
        AppTheme.f(hot ? 11.5 : 10.5, weight: FontWeight.w800, color: hot ? gc.text : gc.textSecondary),
      );
      final at = Offset(o.dx, o.dy - 15 - tag.height / 2);
      if (hot) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: at, width: tag.width + 12, height: tag.height + 5),
            const Radius.circular(20),
          ),
          Paint()..color = c.withValues(alpha: 0.2),
        );
      }
      tag.paint(canvas, at - Offset(tag.width / 2, tag.height / 2));
    }

    for (var i = 0; i < n && i < labels.length; i++) {
      final hot = i == highlight;
      final tag = _text(
        labels[i],
        AppTheme.f(
          10.5,
          weight: hot ? FontWeight.w800 : FontWeight.w700,
          color: hot ? gc.text : gc.textTertiary,
        ),
      );
      tag.paint(canvas, Offset(xOf(i) - tag.width / 2, size.height - tag.height - 2));
    }
  }

  Path _smooth(List<Offset> p) {
    final n = p.length;
    final slope = [for (var i = 0; i < n - 1; i++) (p[i + 1].dy - p[i].dy) / (p[i + 1].dx - p[i].dx)];
    final tan = List<double>.filled(n, 0);
    tan[0] = slope.first;
    tan[n - 1] = slope.last;
    for (var i = 1; i < n - 1; i++) {
      tan[i] = slope[i - 1] * slope[i] <= 0 ? 0 : (slope[i - 1] + slope[i]) / 2;
    }
    for (var i = 0; i < n - 1; i++) {
      if (slope[i] == 0) {
        tan[i] = 0;
        tan[i + 1] = 0;
        continue;
      }
      final a = tan[i] / slope[i], b = tan[i + 1] / slope[i];
      final h = a * a + b * b;
      if (h > 9) {
        final k = 3 / math.sqrt(h);
        tan[i] = k * a * slope[i];
        tan[i + 1] = k * b * slope[i];
      }
    }
    final path = Path()..moveTo(p.first.dx, p.first.dy);
    for (var i = 0; i < n - 1; i++) {
      final dx = (p[i + 1].dx - p[i].dx) / 3;
      path.cubicTo(
        p[i].dx + dx,
        p[i].dy + tan[i] * dx,
        p[i + 1].dx - dx,
        p[i + 1].dy - tan[i + 1] * dx,
        p[i + 1].dx,
        p[i + 1].dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(_ValueLinePainter o) =>
      o.progress != progress ||
      o.values != values ||
      o.goal != goal ||
      o.color != color ||
      o.highlight != highlight ||
      o.gc != gc;
}
