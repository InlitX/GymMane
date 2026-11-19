import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/recovery.dart';
import '../services/beeper.dart';
import '../services/screen_awake.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/glass.dart';
import '../widgets/ui_kit.dart';

bool get _sound => fit.alarmStyle != 'vibrate';

String clockOf(int sec) => '${sec ~/ 60}:${(sec % 60).toString().padLeft(2, '0')}';

String recoveryPhaseName(String kind) => switch (kind) {
      'heat' => t.recoveryHeat,
      'cold' => t.recoveryCold,
      _ => t.recoveryRest,
    };

class RecoveryTip extends StatelessWidget {
  const RecoveryTip({super.key, this.extra});

  final String? extra;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: gc.bgRaised2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gc.warn.withValues(alpha: 0.5)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(PhosphorIconsRegular.info, size: 16, color: gc.warn),
          const SizedBox(width: 8),
          Expanded(child: Text(t.recoveryTipTitle, style: AppTheme.f(14, weight: FontWeight.w800, color: gc.text))),
        ]),
        const SizedBox(height: 6),
        Text(extra == null ? t.recoveryTipBody : '$extra ${t.recoveryTipBody}',
            style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
            onPressed: fit.seeRecoveryTip,
            child: Text(t.recoveryTipOk, style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
          ),
        ),
      ]),
    );
  }
}

class FeelPicker extends StatelessWidget {
  const FeelPicker({super.key, required this.value, required this.onChanged});

  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(t.recoveryFeel, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
      const SizedBox(height: 10),
      Row(children: [
        for (var i = 1; i <= 5; i++) ...[
          if (i > 1) const SizedBox(width: 8),
          Expanded(
            child: Semantics(
              button: true,
              selected: value == i,
              label: '$i',
              child: Pressable(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onChanged(value == i ? null : i);
                },
                scale: 0.94,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: value == i ? gc.text : gc.bgRaised2,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text('$i',
                      style: AppTheme.f(16, weight: FontWeight.w800, color: value == i ? gc.bg : gc.textSecondary)),
                ),
              ),
            ),
          ),
        ],
      ]),
      const SizedBox(height: 6),
      Row(children: [
        Text(t.recoveryFeelLow, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
        const Spacer(),
        Text(t.recoveryFeelHigh, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
      ]),
    ]);
  }
}

class _Ring extends CustomPainter {
  _Ring(this.progress, this.track, this.color);

  final double progress;
  final Color track;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(r, 0, math.pi * 2, false, p..color = track);
    if (progress > 0) canvas.drawArc(r, -math.pi / 2, math.pi * 2 * progress.clamp(0.0, 1.0), false, p..color = color);
  }

  @override
  bool shouldRepaint(_Ring o) => o.progress != progress || o.color != color || o.track != track;
}

class GuidedTimer extends StatefulWidget {
  const GuidedTimer({super.key, required this.kind, required this.plan, required this.onFinish});

  final String kind;
  final List<(String, int)> plan;
  final void Function(({int heat, int cold, int rest, int rounds}) done) onFinish;

  @override
  State<GuidedTimer> createState() => _GuidedTimerState();
}

class _GuidedTimerState extends State<GuidedTimer> {
  late final DateTime _start = DateTime.now();
  Duration _paused = Duration.zero;
  DateTime? _pausedAt;
  Timer? _tick;
  int _shownPhase = 0;
  int _shownLeft = -1;
  int _skip = 0;

  int get _total => widget.plan.fold(0, (a, p) => a + p.$2);

  int get _elapsed {
    final now = _pausedAt ?? DateTime.now();
    return now.difference(_start).inSeconds - _paused.inSeconds + _skip;
  }

  bool get _openEnd => widget.kind == 'cold';

  @override
  void initState() {
    super.initState();
    ScreenAwake.keepOn(true);
    Beeper.instance.go(sound: _sound);
    _tick = Timer.periodic(const Duration(milliseconds: 200), (_) => _onTick());
  }

  @override
  void dispose() {
    _tick?.cancel();
    ScreenAwake.keepOn(fit.session != null && fit.keepScreenOn);
    super.dispose();
  }

  void _onTick() {
    if (!mounted || _pausedAt != null) return;
    final e = _elapsed;
    final at = recoveryPhaseAt(widget.plan, e);
    if (at.index != _shownPhase) {
      _shownPhase = at.index;
      HapticFeedback.heavyImpact();
      Beeper.instance.go(sound: _sound);
      if (at.index >= widget.plan.length && !_openEnd) {
        _finish();
        return;
      }
    } else if (at.index < widget.plan.length && at.left != _shownLeft && at.left <= 3 && at.left > 0) {
      Beeper.instance.tick(sound: _sound);
    }
    _shownLeft = at.left;
    setState(() {});
  }

  void _togglePause() {
    HapticFeedback.selectionClick();
    setState(() {
      if (_pausedAt == null) {
        _pausedAt = DateTime.now();
      } else {
        _paused += DateTime.now().difference(_pausedAt!);
        _pausedAt = null;
      }
    });
  }

  void _next() {
    final at = recoveryPhaseAt(widget.plan, _elapsed);
    if (at.index >= widget.plan.length) return;
    HapticFeedback.selectionClick();
    setState(() => _skip += at.left);
    _onTick();
  }

  void _finish() {
    _tick?.cancel();
    widget.onFinish(recoveryDone(widget.plan, math.max(0, _elapsed)));
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final e = math.max(0, _elapsed);
    final at = recoveryPhaseAt(widget.plan, e);
    final over = at.index >= widget.plan.length;
    final phase = over ? widget.plan.last : widget.plan[at.index];
    final progress = over ? 1.0 : at.into / math.max(1, phase.$2);
    final rounds = widget.plan.where((p) => p.$1 == 'heat').length;
    final round = widget.plan.take(math.min(at.index + 1, widget.plan.length)).where((p) => p.$1 == 'heat').length;
    final tone = switch (phase.$1) {
      'heat' => gc.accent,
      'cold' => gc.info,
      _ => gc.textSecondary,
    };
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 6),
      Center(
        child: SizedBox(
          width: 236,
          height: 236,
          child: CustomPaint(
            painter: _Ring(progress, gc.bgRaised2, gc.text),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(over ? t.recoveryOvertime.toUpperCase() : recoveryPhaseName(phase.$1).toUpperCase(),
                    style: AppTheme.f(12, weight: FontWeight.w800, color: tone, letterSpacing: 1.6)),
                const SizedBox(height: 4),
                Ltr(
                  child: Text(over ? '+${clockOf(at.into)}' : clockOf(at.left),
                      style: AppTheme.f(50, weight: FontWeight.w800, color: gc.text, height: 1.05)),
                ),
                if (rounds > 1) ...[
                  const SizedBox(height: 6),
                  Text(t.recoveryRoundOf(math.max(1, round), rounds),
                      style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
                ],
              ]),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Center(
        child: Ltr(
          child: Text(over ? clockOf(e) : '${clockOf(e)} / ${clockOf(_total)}',
              style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textTertiary)),
        ),
      ),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(
          child: PrimaryButton(
            label: _pausedAt == null ? t.recoveryPause : t.recoveryResume,
            onTap: _togglePause,
            bg: gc.bgRaised2,
            fg: gc.text,
          ),
        ),
        if (!over && at.index < widget.plan.length - 1) ...[
          const SizedBox(width: 10),
          Expanded(child: PrimaryButton(label: t.recoveryNext, onTap: _next, bg: gc.bgRaised2, fg: gc.text)),
        ],
      ]),
      const SizedBox(height: 10),
      PrimaryButton(label: t.recoveryFinish, onTap: _finish),
    ]);
  }
}

Future<void> showBreathSheet(BuildContext context) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _BreathSheet(),
    );

class _BreathSheet extends StatefulWidget {
  const _BreathSheet();

  @override
  State<_BreathSheet> createState() => _BreathSheetState();
}

enum _Step { idle, paced, fast, hold, recover, done }

class _BreathSheetState extends State<_BreathSheet> with SingleTickerProviderStateMixin {
  static const _lengths = [2, 5, 10];
  static const _breaths = 30;
  static const _breathMs = 3200;
  static const _recoverSec = 15;
  static const _rounds = 3;

  late String _mode = fit.lastRecovery('breath')?.pattern ?? kBreathPatterns.first.id;
  late int _minutes = () {
    final last = fit.lastRecovery('breath');
    if (last == null || last.pattern == 'retention') return 5;
    final m = (last.sec / 60).round();
    return _lengths.contains(m) ? m : 5;
  }();
  late final Ticker _ticker;
  _Step _step = _Step.idle;
  Duration _elapsed = Duration.zero;
  Duration _stepFrom = Duration.zero;
  int _round = 0;
  final List<int> _holds = [];
  String _phase = '';
  int? _feel;
  String? _savedId;

  bool get _retention => _mode == 'retention';

  BreathPattern get _pattern => kBreathPatterns.firstWhere((p) => p.id == _mode, orElse: () => kBreathPatterns.first);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    ScreenAwake.keepOn(fit.session != null && fit.keepScreenOn);
    super.dispose();
  }

  Duration get _inStep => _elapsed - _stepFrom;

  void _go(_Step step) {
    _step = step;
    _stepFrom = _elapsed;
    if (step != _Step.idle && step != _Step.done) {
      HapticFeedback.heavyImpact();
      Beeper.instance.go(sound: _sound);
    }
  }

  void _onTick(Duration d) {
    _elapsed = d;
    switch (_step) {
      case _Step.paced:
        if (d >= Duration(minutes: _minutes)) {
          _end();
          return;
        }
        final phase = _phaseAt(d).$1;
        if (phase != _phase) {
          _phase = phase;
          HapticFeedback.selectionClick();
        }
      case _Step.fast:
        if (_inStep.inMilliseconds >= _breaths * _breathMs) _go(_Step.hold);
      case _Step.recover:
        if (_inStep.inSeconds >= _recoverSec) {
          _round++;
          if (_round >= _rounds) {
            _end();
            return;
          }
          _go(_Step.fast);
        }
      default:
    }
    setState(() {});
  }

  (String, double, int) _phaseAt(Duration d) {
    final p = _pattern;
    final ms = d.inMilliseconds % (p.cycle * 1000);
    var at = 0;
    for (final (id, sec) in p.phases) {
      final len = sec * 1000;
      if (ms < at + len) {
        final into = ms - at;
        return (id, into / len, sec - into ~/ 1000);
      }
      at += len;
    }
    return ('in', 0, p.inhale);
  }

  double _scale(String phase, double p) {
    const lo = 0.56, hi = 1.0;
    final e = Curves.easeInOut.transform(p.clamp(0.0, 1.0));
    return switch (phase) {
      'in' => lo + (hi - lo) * e,
      'hold' => hi,
      'out' => hi - (hi - lo) * e,
      _ => lo,
    };
  }

  void _start() {
    if (_retention) fit.seeRecoveryTip();
    ScreenAwake.keepOn(true);
    setState(() {
      _elapsed = Duration.zero;
      _round = 0;
      _holds.clear();
      _phase = '';
      _feel = null;
      _savedId = null;
      _go(_retention ? _Step.fast : _Step.paced);
    });
    _ticker.start();
  }

  void _breatheAgain() {
    _holds.add(_inStep.inSeconds);
    setState(() => _go(_Step.recover));
  }

  void _end() {
    _ticker.stop();
    if (_step == _Step.hold) _holds.add(_inStep.inSeconds);
    final sec = _elapsed.inSeconds;
    if (sec >= 30) {
      _savedId = fit.addRecovery(kind: 'breath', sec: sec, pattern: _mode, holds: List.of(_holds)).id;
    }
    HapticFeedback.heavyImpact();
    setState(() => _step = sec >= 30 ? _Step.done : _Step.idle);
  }

  String _phaseLabel(String id) => switch (id) {
        'in' => t.breathIn,
        'hold' => t.breathHold,
        'out' => t.breathOut,
        _ => t.breathRest,
      };

  String _numbers(BreathPattern p) => [p.inhale, if (p.hold > 0) p.hold, p.exhale, if (p.rest > 0) p.rest].join('-');

  Widget _circle(GymColors gc, double scale, String title, String sub) => SizedBox(
        height: 250,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: 230,
            height: 230,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: gc.text.withValues(alpha: 0.12), width: 1.5),
            ),
          ),
          Transform.scale(
            scale: scale,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gc.text.withValues(alpha: 0.07),
                border: Border.all(color: gc.text.withValues(alpha: 0.55), width: 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Text(title,
                    key: ValueKey(title),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text, height: 1.15)),
              ),
              if (sub.isNotEmpty) ...[
                const SizedBox(height: 4),
                Ltr(child: Text(sub, style: AppTheme.f(15, weight: FontWeight.w700, color: gc.textSecondary))),
              ],
            ]),
          ),
        ]),
      );

  Widget _setup(GymColors gc) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegToggle([
              for (final p in kBreathPatterns) SegOption(breathName(p.id), p.id == _mode, () => setState(() => _mode = p.id)),
              SegOption(t.breathRetention, _retention, () => setState(() => _mode = 'retention')),
            ]),
          ),
        ),
        const SizedBox(height: 10),
        if (!_retention)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SegToggle([
              for (final m in _lengths) SegOption('$m min', m == _minutes, () => setState(() => _minutes = m)),
            ]),
          )
        else
          Text(t.breathRetentionHow(_breaths, _rounds),
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
        if (_retention && !fit.recoveryTipSeen) ...[
          const SizedBox(height: 12),
          RecoveryTip(extra: t.breathRetentionSafe),
        ],
      ]);

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final best = fit.bestHoldSec;
    Widget body;
    switch (_step) {
      case _Step.paced:
        final (phase, progress, left) = _phaseAt(_elapsed);
        final remaining = Duration(minutes: _minutes) - _elapsed;
        body = Column(children: [
          _circle(gc, _scale(phase, progress), _phaseLabel(phase), '$left'),
          Ltr(child: Text(clockOf(remaining.inSeconds + 1), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary))),
        ]);
      case _Step.fast:
        final ms = _inStep.inMilliseconds;
        final p = (ms % _breathMs) / _breathMs;
        final scale = p < 0.5 ? _scale('in', p * 2) : _scale('out', (p - 0.5) * 2);
        body = Column(children: [
          _circle(gc, scale, t.breathFast, '${math.min(_breaths, ms ~/ _breathMs + 1)} / $_breaths'),
          Text(t.recoveryRoundOf(_round + 1, _rounds), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary)),
        ]);
      case _Step.hold:
        body = Column(children: [
          _circle(gc, 0.56, t.breathHoldOut, clockOf(_inStep.inSeconds)),
          Text(best > 0 ? t.recoveryBestHold(clockOf(best)) : t.recoveryRoundOf(_round + 1, _rounds),
              style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary)),
        ]);
      case _Step.recover:
        body = Column(children: [
          _circle(gc, 1.0, t.breathRecover, '${_recoverSec - _inStep.inSeconds}'),
          Text(t.recoveryRoundOf(_round + 1, _rounds), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textTertiary)),
        ]);
      case _Step.done:
        body = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _circle(gc, 0.56, t.breathDone, _holds.isEmpty ? clockOf(_elapsed.inSeconds) : t.recoveryBestHold(clockOf(_holds.fold(0, math.max)))),
          FeelPicker(
            value: _feel,
            onChanged: (v) {
              setState(() => _feel = v);
              if (_savedId != null) fit.setRecoveryFeel(_savedId!, v);
            },
          ),
        ]);
      case _Step.idle:
        body = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _setup(gc),
          const SizedBox(height: 10),
          _circle(gc, 0.56, _retention ? t.breathRetention : _numbers(_pattern), ''),
        ]);
    }
    final running = _step != _Step.idle && _step != _Step.done;
    return AppSheet(children: [
      SheetTitle(t.recoveryKindBreath, subtitle: t.recoveryDescBreath),
      const SizedBox(height: 14),
      AnimatedSize(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: body,
      ),
      const SizedBox(height: 16),
      if (_step == _Step.hold) ...[
        PrimaryButton(label: t.breathRelease, onTap: _breatheAgain),
        const SizedBox(height: 10),
      ],
      if (running)
        PrimaryButton(label: t.recoveryFinish, onTap: _end, bg: gc.bgRaised2, fg: gc.text)
      else if (_step == _Step.done)
        PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop())
      else
        PrimaryButton(label: t.breathStart, onTap: _start),
    ]);
  }
}

String breathName(String id) => switch (id) {
      'box' => t.breathBox,
      'relax' => t.breathRelax,
      'retention' => t.breathRetention,
      _ => t.breathEven,
    };
