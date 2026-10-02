import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'routine_folder.dart';

class ToolArt extends StatelessWidget {
  const ToolArt(this.id, {super.key, this.width = 64, this.height = 54});

  final String id;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final dark = context.gc.bg.computeLuminance() < 0.5;
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _ToolArtPainter(id, dark)),
    );
  }
}

class _ToolArtPainter extends CustomPainter {
  _ToolArtPainter(this.id, this.dark);

  final String id;
  final bool dark;

  Color _hue(int i) => Color.lerp(kFolderHues[i], Colors.black, dark ? 0.08 : 0)!;
  Color _ink(Color c) => Color.lerp(c, Colors.black, 0.5)!;
  Color get _steel => dark ? const Color(0xFFD8D3CD) : const Color(0xFFB9B2AA);

  void _shadow(Canvas canvas, Path path, {double blur = 3.5, double dy = 2.5, double alpha = 0.28}) {
    canvas.drawPath(
      path.shift(Offset(0, dy)),
      Paint()
        ..color = Colors.black.withValues(alpha: dark ? alpha + 0.12 : alpha * 0.6)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur),
    );
  }

  void _fill(Canvas canvas, Path path, Color c) {
    final b = path.getBounds();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.lerp(c, Colors.white, 0.22)!, Color.lerp(c, Colors.black, 0.12)!],
        ).createShader(b),
    );
  }

  void _gloss(Canvas canvas, RRect rr) {
    canvas.save();
    canvas.clipRRect(rr);
    canvas.drawRRect(
      rr.deflate(0.6),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white.withValues(alpha: 0.5), Colors.white.withValues(alpha: 0)],
          stops: const [0, 0.5],
        ).createShader(rr.outerRect),
    );
    canvas.restore();
  }

  RRect _block(Canvas canvas, Rect r, double radius, Color c, {bool shadow = true, bool gloss = true}) {
    final rr = RRect.fromRectAndRadius(r, Radius.circular(radius));
    final path = Path()..addRRect(rr);
    if (shadow) _shadow(canvas, path);
    _fill(canvas, path, c);
    if (gloss) _gloss(canvas, rr);
    return rr;
  }

  void _plate(Canvas canvas, Rect r, Color c) {
    _block(canvas, r, math.min(3, r.width / 2), c);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: r.center, width: 1.4, height: r.height * 0.62), const Radius.circular(1)),
      Paint()..color = _ink(c).withValues(alpha: 0.28),
    );
  }

  void _turn(Canvas canvas, Size s, double angle, void Function() draw) {
    canvas.save();
    canvas.translate(s.width / 2, s.height / 2);
    canvas.rotate(angle);
    canvas.translate(-s.width / 2, -s.height / 2);
    draw();
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    switch (id) {
      case 'rm':
        _turn(canvas, size, -0.14, () {
          final cy = h / 2;
          _block(canvas, Rect.fromLTWH(2, cy - 2, w - 4, 4), 2, _steel, gloss: false);
          for (final left in [true, false]) {
            double x(double dx, double width) => left ? dx : w - dx - width;
            _block(canvas, Rect.fromLTWH(x(2, 3.5), cy - 3.5, 3.5, 7), 1.5, _steel, shadow: false, gloss: false);
            _plate(canvas, Rect.fromLTWH(x(8, 8), cy - 18, 8, 36), _hue(0));
            _plate(canvas, Rect.fromLTWH(x(16, 5.5), cy - 12, 5.5, 24), _hue(4));
            _block(canvas, Rect.fromLTWH(x(21.5, 3.5), cy - 5.5, 3.5, 11), 1.5, _steel, shadow: false, gloss: false);
          }
        });
      case 'bmi':
        _turn(canvas, size, 0.06, () {
          final body = Rect.fromCenter(center: Offset(w / 2, h / 2 + 2), width: 42, height: 40);
          _block(canvas, body, 11, _hue(2));
          final dial = Rect.fromCenter(center: Offset(w / 2, body.top + 15), width: 26, height: 22);
          canvas.drawArc(dial, math.pi, math.pi, true, Paint()..color = _ink(_hue(2)).withValues(alpha: 0.85));
          canvas.drawArc(dial.deflate(4), math.pi, math.pi, true, Paint()..color = Color.lerp(_hue(2), Colors.white, 0.75)!);
          final c = dial.center;
          canvas.drawLine(c, c + Offset(math.cos(-0.9) * 8, math.sin(-0.9) * 8),
              Paint()
                ..color = const Color(0xFFD9774E)
                ..strokeWidth = 2
                ..strokeCap = StrokeCap.round);
          canvas.drawCircle(c, 2, Paint()..color = _ink(_hue(2)));
          for (final dx in [-10.0, 10.0]) {
            canvas.drawRRect(
                RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(w / 2 + dx, body.bottom - 7), width: 9, height: 3),
                    const Radius.circular(2)),
                Paint()..color = _ink(_hue(2)).withValues(alpha: 0.35));
          }
        });
      case 'cal':
        final cx = w / 2;
        Path flame(double scale, double dy) {
          final fh = 44 * scale, fw = 32 * scale;
          final top = h - 4 - fh + dy, bottom = h - 4 + dy;
          return Path()
            ..moveTo(cx, top)
            ..cubicTo(cx + fw * 0.15, top + fh * 0.25, cx + fw * 0.55, top + fh * 0.4, cx + fw * 0.5, top + fh * 0.68)
            ..cubicTo(cx + fw * 0.46, top + fh * 0.92, cx + fw * 0.2, bottom, cx, bottom)
            ..cubicTo(cx - fw * 0.2, bottom, cx - fw * 0.5, top + fh * 0.92, cx - fw * 0.5, top + fh * 0.66)
            ..cubicTo(cx - fw * 0.5, top + fh * 0.45, cx - fw * 0.3, top + fh * 0.38, cx - fw * 0.22, top + fh * 0.22)
            ..cubicTo(cx - fw * 0.08, top + fh * 0.36, cx - fw * 0.02, top + fh * 0.18, cx, top)
            ..close();
        }
        final outer = flame(1, 0);
        canvas.drawCircle(Offset(cx, h - 16), 18,
            Paint()
              ..color = const Color(0xFFF2A46E).withValues(alpha: dark ? 0.22 : 0.16)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9));
        _shadow(canvas, outer);
        canvas.drawPath(
            outer,
            Paint()
              ..shader = const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF4BC86), Color(0xFFE0745A)],
              ).createShader(outer.getBounds()));
        canvas.save();
        canvas.clipPath(outer);
        canvas.drawPath(
            outer.shift(const Offset(-3, 2)),
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.white.withValues(alpha: 0.28));
        canvas.restore();
        final inner = flame(0.52, -2);
        canvas.drawPath(
            inner,
            Paint()
              ..shader = LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFFF8E2A8), Color.lerp(const Color(0xFFF8E2A8), Colors.white, 0.5)!],
              ).createShader(inner.getBounds()));
      case 'bf':
        _turn(canvas, size, 0.1, () {
          final sheet = Rect.fromCenter(center: Offset(w / 2, h / 2), width: 40, height: 46);
          _block(canvas, sheet, 8, _hue(3));
          final ring = Rect.fromCenter(center: Offset(w / 2, sheet.top + 18), width: 20, height: 20);
          canvas.drawArc(ring, 0, math.pi * 2, false,
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = _ink(_hue(3)).withValues(alpha: 0.3));
          canvas.drawArc(ring, -math.pi / 2, math.pi * 0.7, false,
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..strokeCap = StrokeCap.round
                ..color = _hue(5));
          for (final (dy, f) in [(33.0, 1.0), (38.5, 0.6)]) {
            canvas.drawRRect(
                RRect.fromRectAndRadius(Rect.fromLTWH(sheet.left + 8, sheet.top + dy, 24 * f, 2.5), const Radius.circular(2)),
                Paint()..color = _ink(_hue(3)).withValues(alpha: 0.4));
          }
        });
      case 'plate':
        _turn(canvas, size, -0.06, () {
          final cy = h / 2;
          _block(canvas, Rect.fromLTWH(4, cy - 2.5, w - 8, 5), 2.5, _steel, gloss: false);
          var x = 12.0;
          for (final (pw, ph, hue) in [(8.0, 46.0, 3), (6.5, 36.0, 4), (5.5, 27.0, 2), (4.5, 19.0, 0)]) {
            _plate(canvas, Rect.fromLTWH(x, cy - ph / 2, pw, ph), _hue(hue));
            x += pw + 1.2;
          }
          _block(canvas, Rect.fromLTWH(x + 1, cy - 6, 4, 12), 1.5, _steel, gloss: false);
        });
      case 'warmup':
        final base = h - 6;
        for (final (i, bh, hue) in [(0, 16.0, 2), (1, 27.0, 4), (2, 40.0, 0)]) {
          final r = Rect.fromLTWH(10 + i * 15.0, base - bh, 12, bh);
          _block(canvas, r, 4, _hue(hue));
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(r.left + 3, r.top + 4, 6, 2.5), const Radius.circular(2)),
              Paint()..color = Colors.white.withValues(alpha: 0.5));
        }
      case 'rpe':
        final c = Offset(w / 2, h - 10);
        final arc = Rect.fromCircle(center: c, radius: 22);
        final track = Path()..addArc(arc, math.pi, math.pi);
        _shadow(canvas, track, blur: 3);
        canvas.drawArc(arc, math.pi, math.pi, false,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 9
              ..strokeCap = StrokeCap.round
              ..shader = LinearGradient(colors: [_hue(2), _hue(4), _hue(0), const Color(0xFFE07A5A)]).createShader(arc));
        for (var k = 1; k < 5; k++) {
          final a = math.pi + math.pi * k / 5;
          canvas.drawLine(c + Offset(math.cos(a) * 18.5, math.sin(a) * 18.5), c + Offset(math.cos(a) * 25.5, math.sin(a) * 25.5),
              Paint()
                ..color = Colors.white.withValues(alpha: 0.45)
                ..strokeWidth = 1.2);
        }
        final needle = dark ? const Color(0xFFF2EEE9) : const Color(0xFF3A332D);
        final tip = c + Offset(math.cos(math.pi * 1.72) * 17, math.sin(math.pi * 1.72) * 17);
        _shadow(canvas, Path()..addOval(Rect.fromCircle(center: c, radius: 4.5)), blur: 2, dy: 1.5);
        canvas.drawLine(c, tip,
            Paint()
              ..color = needle
              ..strokeWidth = 3
              ..strokeCap = StrokeCap.round);
        canvas.drawCircle(c, 4.5, Paint()..color = needle);
        canvas.drawCircle(c, 1.6, Paint()..color = _hue(0));
      case 'dots':
        final base = h - 4;
        for (final (x, bh, hue) in [(6.0, 18.0, 1), (22.0, 28.0, 4), (38.0, 12.0, 0)]) {
          final rr = _block(canvas, Rect.fromLTWH(x, base - bh, 16, bh), 3.5, _hue(hue));
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x + 5, rr.top + 5, 6, 2.2), const Radius.circular(1.1)),
              Paint()..color = _ink(_hue(hue)).withValues(alpha: 0.35));
        }
        final medal = Offset(30, base - 28 - 11);
        for (final s in [-1.0, 1.0]) {
          final ribbon = Path()
            ..moveTo(medal.dx + s * 1.5, medal.dy - 4)
            ..lineTo(medal.dx + s * 6.5, medal.dy - 12)
            ..lineTo(medal.dx + s * 10, medal.dy - 10)
            ..lineTo(medal.dx + s * 5, medal.dy - 2)
            ..close();
          canvas.drawPath(ribbon, Paint()..color = s < 0 ? _hue(3) : _hue(5));
        }
        final disc = Path()..addOval(Rect.fromCircle(center: medal, radius: 8));
        _shadow(canvas, disc, blur: 2.5, dy: 1.5);
        canvas.drawPath(
            disc,
            Paint()
              ..shader = const RadialGradient(center: Alignment(-0.3, -0.4), colors: [Color(0xFFFBE9B8), Color(0xFFD6A55A)])
                  .createShader(Rect.fromCircle(center: medal, radius: 8)));
        canvas.drawCircle(medal, 4.5,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.4
              ..color = const Color(0xFF9C7334).withValues(alpha: 0.6));
    }
  }

  @override
  bool shouldRepaint(_ToolArtPainter o) => o.id != id || o.dark != dark;
}
