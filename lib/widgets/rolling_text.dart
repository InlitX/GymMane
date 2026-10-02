import 'package:flutter/material.dart';

final _digitCells = <(TextStyle, double), double>{};

double digitCell(TextStyle style, TextScaler scaler) {
  if (_digitCells.length > 48) _digitCells.clear();
  return _digitCells.putIfAbsent((style, scaler.scale(100)), () {
    var widest = 0.0;
    for (var d = 0; d < 10; d++) {
      final p = TextPainter(
        text: TextSpan(text: '$d', style: style),
        textDirection: TextDirection.ltr,
        textScaler: scaler,
      )..layout();
      if (p.width > widest) widest = p.width;
      p.dispose();
    }
    return widest.ceilToDouble();
  });
}

class RollingText extends StatefulWidget {
  const RollingText(
    this.text, {
    super.key,
    required this.style,
    this.duration = const Duration(milliseconds: 420),
    this.countsDown,
    this.textAlign = TextAlign.left,
  });

  final String text;
  final TextStyle style;
  final Duration duration;
  final bool? countsDown;
  final TextAlign textAlign;

  @override
  State<RollingText> createState() => _RollingTextState();
}

class _RollingTextState extends State<RollingText> {
  static const _burst = Duration(milliseconds: 180);

  bool _up = true;
  bool _rapid = false;
  DateTime? _changedAt;

  static double? _numeric(String s) {
    final digits = s.replaceAll(RegExp(r'[,٫]'), '.').replaceAll(RegExp(r'[^0-9.]'), '');
    return digits.isEmpty ? null : double.tryParse(digits);
  }

  @override
  void didUpdateWidget(RollingText old) {
    super.didUpdateWidget(old);
    if (old.text == widget.text) return;
    final now = DateTime.now();
    _rapid = _changedAt != null && now.difference(_changedAt!) < _burst;
    _changedAt = now;
    final forced = widget.countsDown;
    if (forced != null) {
      _up = !forced;
      return;
    }
    final a = _numeric(old.text), b = _numeric(widget.text);
    if (a != null && b != null && a != b) _up = b > a;
  }

  @override
  Widget build(BuildContext context) {
    final chars = widget.text.characters.toList();
    final n = chars.length;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final scaler = MediaQuery.textScalerOf(context);
    final line = scaler.scale(widget.style.fontSize ?? 14) * (widget.style.height ?? 1.2);
    final digit = digitCell(widget.style, scaler);
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < n; i++)
          _RollingChar(
            key: ValueKey(n - i),
            char: chars[i],
            style: widget.style,
            up: _up,
            duration: reduce || _rapid ? Duration.zero : widget.duration,
            solo: _rapid,
            line: line,
            width: _isDigit(chars[i]) ? digit : null,
          ),
      ],
    );
    return Semantics(
      label: widget.text,
      excludeSemantics: true,
      child: AnimatedSize(
        duration: reduce || _rapid ? const Duration(milliseconds: 1) : const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        alignment: switch (widget.textAlign) {
          TextAlign.right || TextAlign.end => Alignment.centerRight,
          TextAlign.center => Alignment.center,
          _ => Alignment.centerLeft,
        },
        child: row,
      ),
    );
  }

  static bool _isDigit(String c) => c.length == 1 && c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
}

class _RollingChar extends StatelessWidget {
  const _RollingChar({
    super.key,
    required this.char,
    required this.style,
    required this.up,
    required this.duration,
    required this.line,
    this.solo = false,
    this.width,
  });

  final String char;
  final TextStyle style;
  final bool up;
  final Duration duration;
  final double line;
  final bool solo;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: line,
        width: width,
        child: AnimatedSwitcher(
          duration: duration,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [if (!solo) ...previous, ?current],
          ),
          transitionBuilder: (child, animation) {
            final incoming = (child.key as ValueKey?)?.value == char;
            final from = incoming ? (up ? 0.72 : -0.72) : (up ? -0.72 : 0.72);
            return AnimatedBuilder(
              animation: animation,
              child: child,
              builder: (_, kid) {
                final t = animation.value;
                return Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: Transform.translate(offset: Offset(0, from * line * (1 - t)), child: kid),
                );
              },
            );
          },
          child: Text(char, key: ValueKey(char), style: style, textHeightBehavior: _tight),
        ),
      ),
    );
  }

  static const _tight = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
  );
}
