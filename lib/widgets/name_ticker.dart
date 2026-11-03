import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme/app_theme.dart';

class NameTicker extends StatefulWidget {
  const NameTicker({
    super.key,
    required this.text,
    required this.color,
    this.rows = 5,
    this.size = 118,
    this.speed = 38,
    this.running = true,
  });

  final String text;
  final Color color;
  final int rows;
  final double size;
  final double speed;
  final bool running;

  @override
  State<NameTicker> createState() => _NameTickerState();
}

class _NameTickerState extends State<NameTicker> with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_tick);
  final _clock = ValueNotifier<double>(0);
  Duration _base = Duration.zero;
  Duration _last = Duration.zero;

  void _tick(Duration elapsed) {
    _last = elapsed;
    _clock.value = (_base + elapsed).inMicroseconds / 1e6;
  }

  void _sync() {
    final calm = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final run = widget.running && !calm;
    if (run && !_ticker.isActive) {
      _ticker.start();
    } else if (!run && _ticker.isActive) {
      _base += _last;
      _last = Duration.zero;
      _ticker.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(NameTicker old) {
    super.didUpdateWidget(old);
    _sync();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.infinite,
        painter: _TickerPainter(
          text: widget.text.toUpperCase(),
          style: AppTheme.f(widget.size,
              weight: FontWeight.w900, color: widget.color, letterSpacing: -widget.size * 0.04, height: 1),
          rows: widget.rows,
          speed: widget.speed,
          clock: _clock,
        ),
      ),
    );
  }
}

class _TickerPainter extends CustomPainter {
  _TickerPainter({
    required this.text,
    required this.style,
    required this.rows,
    required this.speed,
    required this.clock,
  }) : super(repaint: clock);

  final String text;
  final TextStyle style;
  final int rows;
  final double speed;
  final ValueNotifier<double> clock;

  static final _cache = <(String, TextStyle), TextPainter>{};

  TextPainter get _painter => _cache.putIfAbsent((text, style), () {
        if (_cache.length > 12) _cache.clear();
        return TextPainter(
          text: TextSpan(text: '$text  ·  ', style: style),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout();
      });

  @override
  void paint(Canvas canvas, Size size) {
    if (text.trim().isEmpty || size.isEmpty) return;
    final tp = _painter;
    final w = tp.width;
    if (w <= 0) return;
    final line = tp.height * 0.86;
    final shown = rows <= 0 ? (size.height / line).ceil() + 1 : rows;
    final top = (size.height - line * shown) / 2;
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    for (var i = 0; i < shown; i++) {
      final pace = speed * (1 + 0.18 * (i % 3));
      final travel = (clock.value * pace) % w;
      final start = i.isEven ? -travel : travel - w;
      final y = top + i * line - tp.height * 0.07;
      for (var x = start; x < size.width; x += w) {
        tp.paint(canvas, Offset(x, y));
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TickerPainter old) =>
      old.text != text || old.style != style || old.rows != rows || old.speed != speed;
}
