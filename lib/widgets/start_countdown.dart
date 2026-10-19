import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class StartCountdown extends StatefulWidget {
  const StartCountdown({super.key, required this.until});

  final DateTime until;

  @override
  State<StartCountdown> createState() => _StartCountdownState();
}

class _StartCountdownState extends State<StartCountdown> with TickerProviderStateMixin {
  late final AnimationController _beat = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  late final AnimationController _veil = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  )..forward();
  Timer? _tick;
  int _left = 0;
  bool _leaving = false;

  int get _remaining {
    final ms = widget.until.difference(DateTime.now()).inMilliseconds;
    return ms <= 0 ? 0 : (ms / 1000).ceil();
  }

  @override
  void initState() {
    super.initState();
    _left = _remaining;
    _step();
  }

  void _step() {
    if (!mounted) return;
    final left = _remaining;
    if (left <= 0) {
      _finish();
      return;
    }
    if (left != _left || _beat.value == 0) {
      _left = left;
      HapticFeedback.mediumImpact();
      _beat.forward(from: 0);
      setState(() {});
    }
    final ms = widget.until.difference(DateTime.now()).inMilliseconds % 1000;
    _tick = Timer(Duration(milliseconds: ms <= 0 ? 1000 : ms + 5), _step);
  }

  Future<void> _finish() async {
    if (_leaving) return;
    _leaving = true;
    _tick?.cancel();
    HapticFeedback.heavyImpact();
    await _veil.reverse();
    fit.endCountdown();
  }

  @override
  void dispose() {
    _tick?.cancel();
    _beat.dispose();
    _veil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final first = fit.currentExercise;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _finish,
      child: Material(
        type: MaterialType.transparency,
        child: AnimatedBuilder(
          animation: Listenable.merge([_beat, _veil]),
          builder: (context, _) {
            final veil = Curves.easeOut.transform(_veil.value);
            final b = _beat.value;
            final pop = Curves.easeOutBack.transform((b / 0.45).clamp(0.0, 1.0));
            final fade = b < 0.7 ? 1.0 : 1 - Curves.easeIn.transform((b - 0.7) / 0.3);
            return Stack(
              fit: StackFit.expand,
              children: [
                BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 22 * veil, sigmaY: 22 * veil),
                  child: ColoredBox(color: gc.bg.withValues(alpha: 0.72 * veil)),
                ),
                Opacity(
                  opacity: veil,
                  child: SafeArea(
                    child: Column(
                      children: [
                        const Spacer(flex: 3),
                        Text(
                          t.countdownReady.toUpperCase(),
                          style: AppTheme.f(
                            13,
                            weight: FontWeight.w800,
                            color: gc.textSecondary,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: Opacity(
                              opacity: fade.clamp(0.0, 1.0),
                              child: Transform.scale(
                                scale: 1.5 - 0.5 * pop,
                                child: Text(
                                  '$_left',
                                  style: AppTheme.f(170, weight: FontWeight.w900, color: gc.text, height: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        if (first != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              t.catalogName(first.id, first.name),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text),
                            ),
                          ),
                        const Spacer(flex: 4),
                        Text(
                          t.countdownSkip,
                          style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textTertiary),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
