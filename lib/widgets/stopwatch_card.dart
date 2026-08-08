import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class StopwatchCard extends StatefulWidget {
  const StopwatchCard({super.key});

  @override
  State<StopwatchCard> createState() => _StopwatchCardState();
}

class _StopwatchCardState extends State<StopwatchCard> {
  final Stopwatch _sw = Stopwatch();
  Timer? _ticker;

  void _toggle() {
    setState(() {
      if (_sw.isRunning) {
        _sw.stop();
        _ticker?.cancel();
      } else {
        _sw.start();
        _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) => setState(() {}));
      }
    });
  }

  void _reset() {
    setState(() {
      _sw
        ..stop()
        ..reset();
      _ticker?.cancel();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = _sw.elapsed.inSeconds;
    final label = '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
    final running = _sw.isRunning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: running ? gc.ember : gc.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(PhosphorIconsRegular.timer, size: 20, color: running ? gc.ember : gc.textSecondary),
          const SizedBox(width: 12),
          Text(label, style: AppTheme.d(28, weight: FontWeight.w700, color: gc.text)),
          const Spacer(),
          if (s > 0)
            GestureDetector(
              onTap: _reset,
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Text(t.reset,
                    style: AppTheme.s(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
              ),
            ),
          GestureDetector(
            onTap: _toggle,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: running ? gc.bgRaised2 : gc.ember, shape: BoxShape.circle),
              child: Icon(running ? PhosphorIconsFill.pause : PhosphorIconsFill.play,
                  size: 20, color: running ? gc.text : gc.onEmber),
            ),
          ),
        ],
      ),
    );
  }
}
