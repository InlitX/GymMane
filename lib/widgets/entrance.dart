import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../services/local_store.dart';
import 'rolling_text.dart';

class RiseScope extends StatefulWidget {
  const RiseScope({super.key, required this.id, required this.child, this.once = true});

  final String id;
  final Widget child;
  final bool once;

  static final _played = <String>{};

  static bool animates(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_RiseFlag>()?.on ?? true;

  @override
  State<RiseScope> createState() => _RiseScopeState();
}

class _RiseScopeState extends State<RiseScope> {
  late final bool _on = _decide();

  bool _decide() {
    if (!widget.once) return true;
    if (!RiseScope._played.add(widget.id)) return false;
    final now = DateTime.now();
    final today = '${now.year}-${now.month}-${now.day}';
    final key = 'rise_${widget.id}';
    final last = Store.instance.note(key);
    Store.instance.setNote(key, today);
    return last != today;
  }

  @override
  Widget build(BuildContext context) => _RiseFlag(on: _on, child: widget.child);
}

class _RiseFlag extends InheritedWidget {
  const _RiseFlag({required this.on, required super.child});

  final bool on;

  @override
  bool updateShouldNotify(_RiseFlag old) => old.on != on;
}

List<Widget> riseAll(List<Widget> children) {
  var i = 0;
  return [for (final c in children) c is SizedBox && c.child == null ? c : Rise(index: i++, child: c)];
}

class Rise extends StatefulWidget {
  const Rise({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<Rise> createState() => _RiseState();
}

class _RiseState extends State<Rise> with SingleTickerProviderStateMixin {
  static const _motion = 560;

  late final int _delay = 40 + widget.index.clamp(0, 7) * 70;
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: _delay + _motion),
  );
  late final Animation<double> _v = CurvedAnimation(
    parent: _c,
    curve: Interval(_delay / (_delay + _motion), 1, curve: Curves.easeOutCubic),
  );
  bool? _animate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_animate != null) return;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    _animate = RiseScope.animates(context) && !reduce;
    _animate! ? _c.forward() : _c.value = 1;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animate != true) return widget.child;
    return AnimatedBuilder(
      animation: _v,
      child: widget.child,
      builder: (context, child) {
        final v = _v.value;
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - v)),
            child: Transform.scale(scale: 0.97 + 0.03 * v, child: child),
          ),
        );
      },
    );
  }
}

class RollIn extends StatefulWidget {
  const RollIn(this.text, {super.key, required this.style, this.textAlign = TextAlign.left});

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  State<RollIn> createState() => _RollInState();
}

class _RollInState extends State<RollIn> with SingleTickerProviderStateMixin {
  static const _run = Duration(milliseconds: 1150);

  AnimationController? _c;

  @override
  void initState() {
    super.initState();
    if (!widget.text.contains(RegExp('[1-9]'))) return;
    _c = AnimationController(vsync: this, duration: _run)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final c = _c;
    if (c == null || c.isAnimating || c.isCompleted) return;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    reduce || !RiseScope.animates(context) ? c.value = 1 : c.forward();
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _c;
    if (c == null || c.isCompleted) {
      return RollingText(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
        countsDown: false,
        duration: const Duration(milliseconds: 620),
      );
    }
    final chars = widget.text.characters.toList();
    final digits = [
      for (var i = 0; i < chars.length; i++)
        if (_isDigit(chars[i])) i,
    ];
    final total = int.parse(digits.map((i) => chars[i]).join());
    final scaler = MediaQuery.textScalerOf(context);
    final line = scaler.scale(widget.style.fontSize ?? 14) * (widget.style.height ?? 1.2);
    final cell = digitCell(widget.style, scaler);
    return Semantics(
      label: widget.text,
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: c,
        builder: (context, _) {
          final count = total * Curves.easeOutCubic.transform(c.value);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < chars.length; i++)
                if (!_isDigit(chars[i]))
                  SizedBox(
                    height: line,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [Text(chars[i], style: widget.style, textHeightBehavior: _tight)],
                    ),
                  )
                else
                  _wheel(count, digits.length - 1 - digits.indexOf(i), line, cell),
            ],
          );
        },
      ),
    );
  }

  Widget _wheel(double count, int place, double line, double cell) {
    final scaled = count / math.pow(10, place);
    final whole = scaled.floor();
    var pos = whole.toDouble();
    if (place == 0) {
      pos = scaled;
    } else {
      final lower = count / math.pow(10, place - 1);
      if (lower.floor() % 10 == 9) pos += lower - lower.floor();
    }
    final low = pos.floor();
    final frac = pos - low;
    Widget digit(int v, double dy) => Transform.translate(
      offset: Offset(0, dy),
      child: Text('${v % 10}', style: widget.style, textHeightBehavior: _tight),
    );
    return Opacity(
      opacity: place == 0 ? 1 : scaled.clamp(0.0, 1.0),
      child: ClipRect(
        child: SizedBox(
          width: cell,
          height: line,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [digit(low, -frac * line), if (frac > 0.001) digit(low + 1, (1 - frac) * line)],
          ),
        ),
      ),
    );
  }

  static bool _isDigit(String c) => c.length == 1 && c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
}

const _tight = TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false);
