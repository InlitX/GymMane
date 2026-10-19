import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/program_templates.dart';
import '../l10n/l10n.dart';
import '../models/live_session.dart';
import '../models/workout.dart';
import '../services/screen_awake.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/timer_panel.dart';
import '../widgets/ui_kit.dart' show sentenceCase;

class WearRotary {
  WearRotary._();

  static const _channel = MethodChannel('gymmane/rotary');
  static final List<ScrollController> _stack = [];
  static VoidCallback? onTurn;

  static void init() {
    _channel.setMethodCallHandler((call) async {
      if (call.method != 'scroll') return;
      turn((call.arguments as num).toDouble());
    });
  }

  static void turn(double delta) {
    onTurn?.call();
    final c = _stack.isEmpty ? null : _stack.last;
    if (c == null || !c.hasClients) return;
    final p = c.position;
    c.jumpTo((p.pixels + delta).clamp(p.minScrollExtent, p.maxScrollExtent));
  }

  static void attach(ScrollController c) => _stack.add(c);

  static void detach(ScrollController c) => _stack.remove(c);
}

String _cap(String s) {
  final out = sentenceCase(s);
  final i = out.indexOf(RegExp(r'\p{L}', unicode: true));
  if (i <= 0) return out;
  return out.substring(0, i) + out[i].toUpperCase() + out.substring(i + 1);
}

class WearShell extends StatefulWidget {
  const WearShell({super.key});

  @override
  State<WearShell> createState() => _WearShellState();
}

class _WearShellState extends State<WearShell> with WidgetsBindingObserver {
  static const idleAfter = Duration(seconds: 15);

  Timer? _idle;
  bool _dim = false;
  int _restTick = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WearRotary.init();
    WearRotary.onTurn = _wake;
    fit.refreshAlarmPermission();
    fit.addListener(_onFit);
    _restTick = fit.restDoneTick;
    _arm();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    WearRotary.onTurn = null;
    fit.removeListener(_onFit);
    _idle?.cancel();
    ScreenAwake.dim(false);
    super.dispose();
  }

  bool get _canDim => fit.isSessionActive && fit.keepScreenOn && !fit.sessionPaused;

  void _onFit() {
    if (fit.restDoneTick != _restTick) {
      _restTick = fit.restDoneTick;
      _wake();
      return;
    }
    if (!_canDim) {
      _idle?.cancel();
      if (_dim) _setDim(false);
    } else if (_idle?.isActive != true && !_dim) {
      _arm();
    }
  }

  void _wake() {
    if (_dim) _setDim(false);
    _arm();
  }

  void _arm() {
    _idle?.cancel();
    if (!_canDim) return;
    _idle = Timer(idleAfter, () {
      if (mounted && _canDim) _setDim(true);
    });
  }

  void _setDim(bool on) {
    ScreenAwake.dim(on);
    if (mounted) setState(() => _dim = on);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      fit.persistNow();
    }
    if (state == AppLifecycleState.resumed) {
      fit.syncRest();
      _wake();
    }
  }

  Future<void> _back() async {
    switch (fit.route) {
      case 'session':
        if (fit.isSessionComplete) {
          fit.saveAndExit();
        } else {
          fit.parkSession();
        }
      case 'routines':
      case 'settings':
        fit.popRoute();
      default:
        await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([fit, fit.clock]),
      builder: (context, _) {
        final gc = context.gc;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (_dim) {
              _wake();
              return;
            }
            if (!didPop) _back();
          },
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) => _wake(),
            child: Scaffold(
              backgroundColor: gc.bg,
              body: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: KeyedSubtree(key: ValueKey(fit.route), child: _screen()),
                    ),
                  ),
                  const Positioned(top: 0, left: 0, right: 0, child: WearClock()),
                  if (_dim) Positioned.fill(child: WearDim(onWake: _wake)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _screen() {
    switch (fit.route) {
      case 'session':
        return WearSession();
      case 'routines':
        return WearRoutines();
      case 'settings':
        return WearSettings();
      default:
        return WearHome();
    }
  }
}

class WearClock extends StatefulWidget {
  const WearClock({super.key, this.color});

  final Color? color;

  @override
  State<WearClock> createState() => _WearClockState();
}

class _WearClockState extends State<WearClock> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  void _schedule() {
    final now = DateTime.now();
    _timer = Timer(Duration(seconds: 60 - now.second), () {
      if (!mounted) return;
      setState(() {});
      _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final size = MediaQuery.sizeOf(context);
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.045),
        child: Center(
          child: Text(
            TimeOfDay.now().format(context),
            style: AppTheme.f(12, weight: FontWeight.w700, color: widget.color ?? gc.textSecondary),
          ),
        ),
      ),
    );
  }
}

class WearPage extends StatefulWidget {
  const WearPage({super.key, required this.children});

  final List<Widget> children;

  @override
  State<WearPage> createState() => _WearPageState();
}

class _WearPageState extends State<WearPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WearRotary.attach(_scroll);
  }

  @override
  void dispose() {
    WearRotary.detach(_scroll);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final side = box.maxWidth * 0.1;
        return ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (r) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x00000000), Color(0xFF000000), Color(0xFF000000), Color(0x00000000)],
            stops: [0.08, 0.2, 0.84, 0.98],
          ).createShader(r),
          child: ListView(
            controller: _scroll,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(side, box.maxHeight * 0.17, side, box.maxHeight * 0.24),
            children: [for (final c in widget.children) _EdgeScale(child: c)],
          ),
        );
      },
    );
  }
}

class _EdgeScale extends StatefulWidget {
  const _EdgeScale({required this.child});

  final Widget child;

  @override
  State<_EdgeScale> createState() => _EdgeScaleState();
}

class _EdgeScaleState extends State<_EdgeScale> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  double _depth() {
    final box = context.findRenderObject() as RenderBox?;
    final viewport = Scrollable.maybeOf(context)?.context.findRenderObject() as RenderBox?;
    if (box == null || viewport == null || !box.hasSize || !box.attached || !viewport.hasSize) return 0;
    final top = box.localToGlobal(Offset.zero, ancestor: viewport).dy;
    final half = viewport.size.height / 2;
    if (half <= 0) return 0;
    final d = ((top + box.size.height / 2 - half).abs() / half).clamp(0.0, 1.0);
    return Curves.easeIn.transform(((d - 0.4) / 0.6).clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    final position = Scrollable.maybeOf(context)?.position;
    if (position == null) return widget.child;
    return AnimatedBuilder(
      animation: position,
      child: widget.child,
      builder: (context, child) {
        final t = _depth();
        return Transform.scale(scale: 1 - 0.22 * t, child: child);
      },
    );
  }
}

class WearHome extends StatelessWidget {
  const WearHome({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final live = fit.session != null && !fit.session!.complete;
    final planned = fit.todayRoutine;
    final canStart = planned != null && planned.exerciseIds.isNotEmpty;
    return WearPage(
      children: [
        Center(
          child: _WeekRing(gc: gc, done: fit.daysDoneThisWeek, goal: fit.weeklyTarget),
        ),
        const SizedBox(height: 8),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(PhosphorIconsFill.fire, size: 14, color: gc.accent),
              const SizedBox(width: 4),
              Text(
                '${fit.currentStreak}',
                style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text),
              ),
              const SizedBox(width: 4),
              Text(
                t.daysUnit(fit.currentStreak),
                style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        WearButton(
          label: live ? t.continueBtn : t.startWorkout,
          icon: PhosphorIconsFill.play,
          filled: true,
          onTap: () {
            if (live) {
              fit.resumeSession();
            } else if (canStart) {
              fit.startRoutine(planned);
              fit.endCountdown();
            } else {
              fit.goRoutines();
            }
          },
        ),
        if (canStart && !live) ...[
          const SizedBox(height: 4),
          Center(
            child: Text(
              planned.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
            ),
          ),
        ],
        const SizedBox(height: 8),
        WearButton(label: t.routines, icon: PhosphorIconsRegular.listBullets, onTap: fit.goRoutines),
        const SizedBox(height: 8),
        WearButton(
          label: t.settings,
          icon: PhosphorIconsRegular.gearSix,
          onTap: () => fit.pushRoute('settings'),
        ),
      ],
    );
  }
}

class _WeekRing extends StatelessWidget {
  const _WeekRing({required this.gc, required this.done, required this.goal});

  final GymColors gc;
  final int done;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final pct = goal <= 0 ? 0.0 : (done / goal).clamp(0.0, 1.0);
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: _RingPainter(track: gc.bgRaised2, fill: gc.accent, pct: pct),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$done/$goal',
                style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text),
              ),
              Text(
                t.thisWeek,
                style: AppTheme.f(9, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.track, required this.fill, required this.pct});

  final Color track;
  final Color fill;
  final double pct;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 7.0;
    final rect = Offset.zero & size;
    final r = rect.deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(r, 0, math.pi * 2, false, paint..color = track);
    if (pct > 0) {
      canvas.drawArc(r, -math.pi / 2, math.pi * 2 * pct, false, paint..color = fill);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.pct != pct || old.track != track || old.fill != fill;
}

class WearButton extends StatelessWidget {
  const WearButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = false,
    this.height = 48,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;
  final double height;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final enabled = onTap != null;
    final bg = filled ? (color ?? gc.accent) : gc.bgRaised;
    final fg = filled ? gc.bg : gc.text;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: Opacity(
          opacity: enabled ? 1 : 0.35,
          child: Container(
            height: height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[Icon(icon, size: 15, color: fg), const SizedBox(width: 7)],
                  Text(
                    _cap(label),
                    maxLines: 1,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: fg),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WearIconButton extends StatelessWidget {
  const WearIconButton({super.key, required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Opacity(
          opacity: onTap == null ? 0.3 : 1,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
            child: Icon(icon, size: 18, color: gc.text),
          ),
        ),
      ),
    );
  }
}

Widget _heading(GymColors gc, String text) => Center(
  child: Text(
    text.toUpperCase(),
    style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 1.6),
  ),
);

class WearRoutines extends StatelessWidget {
  const WearRoutines({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final planned = fit.todayRoutine;
    final list = [...fit.routines]
      ..sort((a, b) => (a.id == planned?.id ? 0 : 1) - (b.id == planned?.id ? 0 : 1));
    return WearPage(
      children: [
        _heading(gc, t.routines),
        const SizedBox(height: 10),
        if (list.isEmpty) ...[
          Center(
            child: Text(
              t.templates,
              textAlign: TextAlign.center,
              style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary),
            ),
          ),
          const SizedBox(height: 8),
          for (final p in kProgramTemplates)
            _row(gc, p.name, t.perWeek(p.days.length), PhosphorIconsBold.plus, false, () {
              fit.applyTemplate(p);
            }),
        ],
        for (final r in list)
          _row(
            gc,
            r.name,
            t.exerciseCount(r.exerciseIds.length),
            PhosphorIconsFill.play,
            r.id == planned?.id,
            r.exerciseIds.isEmpty
                ? null
                : () {
                    fit.startRoutine(r);
                    fit.endCountdown();
                  },
          ),
      ],
    );
  }

  Widget _row(GymColors gc, String title, String detail, IconData icon, bool today, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Semantics(
        button: true,
        enabled: onTap != null,
        label: title,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap();
                },
          child: Opacity(
            opacity: onTap == null ? 0.4 : 1,
            child: Container(
              constraints: const BoxConstraints(minHeight: 52),
              padding: const EdgeInsets.fromLTRB(16, 8, 14, 8),
              decoration: BoxDecoration(
                color: gc.bgRaised,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: today ? gc.accent : Colors.transparent, width: 1.4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text),
                        ),
                        Text(
                          detail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Icon(icon, size: 14, color: today ? gc.accent : gc.textTertiary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WearSettings extends StatelessWidget {
  const WearSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return WearPage(
      children: [
        _heading(gc, t.settings),
        const SizedBox(height: 12),
        _label(gc, t.unitsLabel),
        Row(
          children: [
            for (final u in const ['kg', 'lb']) ...[
              if (u == 'lb') const SizedBox(width: 6),
              Expanded(
                child: WearButton(label: u, height: 42, filled: fit.units == u, onTap: () => fit.setUnits(u)),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        _label(gc, t.restTimer),
        _WearStepper(
          value: durationLabel(fit.restSeconds),
          onDec: () => fit.setRestSeconds(fit.restSeconds - 15),
          onInc: () => fit.setRestSeconds(fit.restSeconds + 15),
        ),
        const SizedBox(height: 12),
        _label(gc, t.weeklyGoal),
        _WearStepper(
          value: '${fit.profile.weeklyGoal}',
          onDec: fit.profile.weeklyGoal > 1 ? () => fit.updateProfile(weeklyGoalDelta: -1) : null,
          onInc: fit.profile.weeklyGoal < 7 ? () => fit.updateProfile(weeklyGoalDelta: 1) : null,
        ),
        const SizedBox(height: 12),
        Semantics(
          toggled: fit.keepScreenOn,
          button: true,
          label: t.keepScreenOn,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: fit.toggleKeepScreenOn,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      t.keepScreenOn,
                      maxLines: 3,
                      style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.text, height: 1.2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _Switch(on: fit.keepScreenOn),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(GymColors gc, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Center(
      child: Text(
        _cap(text),
        style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
      ),
    ),
  );
}

class _Switch extends StatelessWidget {
  const _Switch({required this.on});

  final bool on;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 38,
      height: 22,
      padding: const EdgeInsets.all(3),
      alignment: on ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: on ? gc.accent : gc.bgRaised2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(color: on ? gc.bg : gc.textTertiary, shape: BoxShape.circle),
      ),
    );
  }
}

class _WearStepper extends StatelessWidget {
  const _WearStepper({required this.value, required this.onDec, required this.onInc, this.label});

  final String value;
  final String? label;
  final VoidCallback? onDec;
  final VoidCallback? onInc;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget b(IconData icon, String semantic, VoidCallback? onTap) => Semantics(
      button: true,
      enabled: onTap != null,
      label: semantic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap();
              },
        child: Opacity(
          opacity: onTap == null ? 0.3 : 1,
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: gc.text),
          ),
        ),
      ),
    );
    return Row(
      children: [
        b(PhosphorIconsBold.minus, t.decrease, onDec),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  maxLines: 1,
                  style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text, height: 1.1),
                ),
              ),
              if (label != null)
                Text(
                  label!,
                  maxLines: 1,
                  style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 0.8),
                ),
            ],
          ),
        ),
        b(PhosphorIconsBold.plus, t.increase, onInc),
      ],
    );
  }
}

class WearSession extends StatelessWidget {
  const WearSession({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return fit.isSessionComplete ? _complete(gc) : _active(gc);
  }

  Widget _active(GymColors gc) {
    final s = fit.session!;
    final ex = fit.currentExercise;
    final exIdx = s.currentIndex;
    final repsOnly = ex != null && fit.isRepsOnly(ex.id);
    final mode = ex == null ? '' : fit.modeOf(ex.id);
    final pending = ex == null ? -1 : ex.sets.indexWhere((st) => !st.done);
    final resting = s.restRemaining != null;
    final holding = fit.holding && fit.holdEx == exIdx;

    return WearPage(
      children: [
        Center(
          child: Semantics(
            button: true,
            label: fit.sessionPaused ? t.resumeWorkout : t.pauseWorkout,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: fit.toggleSessionPause,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${exIdx + 1}/${s.exercises.length}',
                      style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary),
                    ),
                    Container(
                      width: 3,
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(color: gc.textTertiary, shape: BoxShape.circle),
                    ),
                    Icon(
                      fit.sessionPaused ? PhosphorIconsFill.play : PhosphorIconsFill.pause,
                      size: 10,
                      color: fit.sessionPaused ? gc.warn : gc.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      fit.elapsedLabel,
                      style: AppTheme.f(
                        12,
                        weight: FontWeight.w700,
                        color: fit.sessionPaused ? gc.warn : gc.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _WearStage(
          index: exIdx,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (fit.inSuperset)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(PhosphorIconsBold.link, size: 11, color: gc.brass),
                    const SizedBox(width: 4),
                    Text(
                      t.superset,
                      style: AppTheme.f(11, weight: FontWeight.w700, color: gc.brass),
                    ),
                  ],
                ),
              Text(
                ex == null ? '' : t.catalogName(ex.id, ex.name),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text, height: 1.15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (holding) ...[
          _holdCard(gc),
          const SizedBox(height: 8),
        ] else if (resting) ...[
          _restCard(gc, s),
          const SizedBox(height: 8),
        ],
        if (ex != null && pending >= 0) ...[
          Center(
            child: Text(
              _pendingLabel(ex.sets[pending], mode, repsOnly),
              maxLines: 1,
              style: AppTheme.f(15, weight: FontWeight.w800, color: gc.textSecondary),
            ),
          ),
          const SizedBox(height: 6),
        ],
        _mainAction(gc, ex, exIdx, s.exercises.length, pending),
        const SizedBox(height: 10),
        if (ex != null && pending >= 0) ..._editors(gc, ex, exIdx, pending, mode, repsOnly),
        const SizedBox(height: 4),
        if (ex != null)
          for (int j = 0; j < ex.sets.length; j++) _setRow(gc, exIdx, j, ex.sets[j], repsOnly, j == pending),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: WearIconButton(
                icon: PhosphorIconsBold.caretLeft,
                label: t.back,
                onTap: exIdx > 0 ? fit.prevExercise : null,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: WearIconButton(
                icon: PhosphorIconsBold.caretRight,
                label: t.nextExercise,
                onTap: exIdx < s.exercises.length - 1 ? fit.nextExercise : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _textAction(gc, t.addSet, () => fit.addSet(exIdx)),
        _textAction(gc, t.finishSession, fit.finishSession),
      ],
    );
  }

  String _pendingLabel(SessionSet set, String mode, bool repsOnly) {
    if (mode == 'cardio' || mode == 'time') return fit.loggedSetLabel(set.logged);
    if (repsOnly) return '${set.reps}';
    return '${set.reps} × ${fit.weightValue(set.weight)} ${fit.units}';
  }

  List<Widget> _editors(
    GymColors gc,
    SessionExercise ex,
    int exIdx,
    int pending,
    String mode,
    bool repsOnly,
  ) {
    final set = ex.sets[pending];
    final steppers = switch (mode) {
      'cardio' => [
        _WearStepper(
          label: fit.distanceUnit.toUpperCase(),
          value: fit.distanceValue(set.km ?? 0),
          onDec: () => fit.bumpSessionDistance(exIdx, pending, -1),
          onInc: () => fit.bumpSessionDistance(exIdx, pending, 1),
        ),
        _WearStepper(
          label: t.timeCol,
          value: durationLabel(set.sec ?? 0),
          onDec: () => fit.bumpSessionSeconds(exIdx, pending, -60),
          onInc: () => fit.bumpSessionSeconds(exIdx, pending, 60),
        ),
      ],
      'time' => [
        _WearStepper(
          label: t.timeCol,
          value: durationLabel(set.sec ?? 0),
          onDec: () => fit.bumpSessionSeconds(exIdx, pending, -15),
          onInc: () => fit.bumpSessionSeconds(exIdx, pending, 15),
        ),
      ],
      _ => [
        _WearStepper(
          label: t.repsCol,
          value: '${set.reps}',
          onDec: () => fit.bumpSessionReps(exIdx, pending, -1),
          onInc: () => fit.bumpSessionReps(exIdx, pending, 1),
        ),
        if (!repsOnly)
          _WearStepper(
            label: fit.units.toUpperCase(),
            value: fit.weightValue(set.weight),
            onDec: () => fit.bumpSessionWeight(exIdx, pending, -1),
            onInc: () => fit.bumpSessionWeight(exIdx, pending, 1),
          ),
      ],
    };
    return [
      for (final s in steppers) ...[s, const SizedBox(height: 6)],
      const SizedBox(height: 4),
    ];
  }

  Widget _restCard(GymColors gc, WorkoutSession s) {
    final left = s.restRemaining ?? 0;
    final total = fit.restTotal <= 0 ? 1 : fit.restTotal;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Text(
            _cap(t.rest),
            style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary),
          ),
          Text(
            clockLabel(left),
            style: AppTheme.f(32, weight: FontWeight.w800, color: gc.text, height: 1.1),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: (1 - left / total).clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: gc.bgRaised2,
              valueColor: AlwaysStoppedAnimation(gc.accent),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _tiny(gc, '−15', () => fit.nudgeRest(-15))),
              const SizedBox(width: 4),
              Expanded(child: _tiny(gc, _cap(t.skip), fit.skipRest, strong: true)),
              const SizedBox(width: 4),
              Expanded(child: _tiny(gc, '+15', () => fit.nudgeRest(15))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _holdCard(GymColors gc) {
    final lead = fit.holdLead;
    final left = fit.holdRemaining ?? 0;
    final total = fit.holdTotal <= 0 ? 1 : fit.holdTotal;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Text(
            _cap(
              lead > 0
                  ? (fit.switchingSides ? t.switchSides : t.getReady)
                  : fit.holdSides > 1
                  ? t.sideOfTwo('${fit.holdSide + 1}')
                  : t.timeCol,
            ),
            style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary),
          ),
          Text(
            lead > 0 ? '$lead' : durationLabel(left),
            style: AppTheme.f(
              32,
              weight: FontWeight.w800,
              color: lead > 0 ? gc.accent : gc.text,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: lead > 0 ? 0 : 1 - left / total,
              minHeight: 4,
              backgroundColor: gc.bgRaised2,
              valueColor: AlwaysStoppedAnimation(gc.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tiny(GymColors gc, String label, VoidCallback onTap, {bool strong = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: strong ? gc.bgRaised2 : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: gc.border),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: AppTheme.f(12, weight: FontWeight.w700, color: gc.text),
          ),
        ),
      ),
    );
  }

  Widget _setRow(GymColors gc, int exIdx, int j, SessionSet st, bool repsOnly, bool current) {
    final load = st.sec != null || st.km != null
        ? fit.loggedSetLabel(st.logged)
        : repsOnly
        ? '${st.reps}'
        : '${st.reps} × ${fit.weightValue(st.weight)}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Semantics(
        button: true,
        checked: st.done,
        label: t.markSet(j + 1),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.selectionClick();
            fit.toggleSet(exIdx, j);
          },
          child: Container(
            height: 44,
            padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
            decoration: BoxDecoration(
              color: st.done ? gc.sageSoft : gc.bgRaised,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: current ? gc.accent : Colors.transparent, width: 1.4),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    st.kind == SetKind.warmup ? 'W' : '${j + 1}',
                    style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary),
                  ),
                ),
                Expanded(
                  child: Text(
                    load,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text),
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: st.done ? gc.sage : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: st.done ? gc.sage : gc.textTertiary, width: 1.6),
                  ),
                  child: st.done ? const Icon(PhosphorIconsBold.check, size: 12, color: Colors.white) : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainAction(GymColors gc, SessionExercise? ex, int exIdx, int total, int pending) {
    if (pending >= 0 && ex != null && fit.isTimed(ex.id)) {
      if (fit.holding && fit.holdEx == exIdx) {
        return WearButton(
          label: t.stopLabel,
          icon: PhosphorIconsFill.stop,
          filled: true,
          onTap: fit.stopHold,
        );
      }
      return WearButton(
        label: t.startHold(fit.holdLength(ex.id, ex.sets[pending].sec ?? 30)),
        icon: PhosphorIconsFill.play,
        filled: true,
        onTap: () => fit.startHold(exIdx, pending),
      );
    }
    if (pending >= 0) {
      return WearButton(
        label: t.setDone,
        icon: PhosphorIconsBold.check,
        filled: true,
        onTap: () => fit.toggleSet(exIdx, pending),
      );
    }
    if (fit.pendingAfter(exIdx) != null) {
      return WearButton(
        label: t.nextExercise,
        icon: PhosphorIconsBold.caretRight,
        filled: true,
        onTap: fit.goNextPending,
      );
    }
    if (exIdx < total - 1) {
      return WearButton(
        label: t.nextExercise,
        icon: PhosphorIconsBold.caretRight,
        filled: true,
        onTap: fit.nextExercise,
      );
    }
    return WearButton(
      label: t.finishSession,
      icon: PhosphorIconsBold.flagCheckered,
      filled: true,
      onTap: fit.finishSession,
    );
  }

  Widget _textAction(GymColors gc, String label, VoidCallback onTap) => Semantics(
    button: true,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 44,
        child: Center(
          child: Text(
            _cap(label),
            style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary),
          ),
        ),
      ),
    ),
  );

  Widget _complete(GymColors gc) {
    final s = fit.session!;
    final prs = fit.gamification ? fit.summaryPrs : 0;
    return WearPage(
      children: [
        Center(child: Icon(PhosphorIconsFill.checkCircle, size: 28, color: gc.sage)),
        const SizedBox(height: 6),
        Center(
          child: Text(
            t.finishHeadline(prs: prs, streak: fit.currentStreak, goalHit: fit.goalPct >= 100),
            textAlign: TextAlign.center,
            style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text, height: 1.15),
          ),
        ),
        const SizedBox(height: 12),
        _stat(gc, t.duration, fit.summaryDurationLabel),
        _stat(gc, t.setsCaps, '${s.summarySets ?? 0}'),
        _stat(gc, t.volume, fit.volumeLabel(fit.summaryVolumeKg)),
        const SizedBox(height: 10),
        WearButton(label: t.done, icon: PhosphorIconsBold.check, filled: true, onTap: fit.saveAndExit),
        const SizedBox(height: 8),
        WearButton(
          label: t.keepTraining,
          icon: PhosphorIconsBold.arrowCounterClockwise,
          onTap: fit.continueSession,
        ),
      ],
    );
  }

  Widget _stat(GymColors gc, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _cap(label),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary),
              ),
            ),
            Text(
              value,
              style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text),
            ),
          ],
        ),
      ),
    );
  }
}

class WearDim extends StatelessWidget {
  const WearDim({super.key, required this.onWake});

  final VoidCallback onWake;

  @override
  Widget build(BuildContext context) {
    final s = fit.session;
    final ex = fit.currentExercise;
    final rest = s?.restRemaining;
    final pending = ex == null ? -1 : ex.sets.indexWhere((st) => !st.done);
    const dim = Color(0xFF8A8A8A);
    const faint = Color(0xFF5A5A5A);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onWake,
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            const Positioned(top: 0, left: 0, right: 0, child: WearClock(color: faint)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ex == null ? '' : t.catalogName(ex.id, ex.name),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(14, weight: FontWeight.w700, color: dim, height: 1.15),
                    ),
                    const SizedBox(height: 8),
                    if (rest != null)
                      Text(
                        clockLabel(rest),
                        style: AppTheme.f(40, weight: FontWeight.w800, color: dim, height: 1),
                      )
                    else if (ex != null && pending >= 0)
                      Text(
                        '${pending + 1}/${ex.sets.length}',
                        style: AppTheme.f(34, weight: FontWeight.w800, color: dim, height: 1),
                      ),
                    const SizedBox(height: 6),
                    Text(
                      fit.elapsedLabel,
                      style: AppTheme.f(12, weight: FontWeight.w600, color: faint),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WearStage extends StatefulWidget {
  const _WearStage({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<_WearStage> createState() => _WearStageState();
}

class _WearStageState extends State<_WearStage> {
  double _dir = 1;

  @override
  void didUpdateWidget(_WearStage old) {
    super.didUpdateWidget(old);
    if (old.index == widget.index) return;
    _dir = widget.index > old.index ? 1 : -1;
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.index;
    final dir = _dir;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: const Interval(0.3, 1, curve: Curves.easeOutCubic),
      switchOutCurve: const Interval(0.55, 1, curve: Curves.easeInCubic),
      transitionBuilder: (child, animation) {
        final incoming = (child.key as ValueKey?)?.value == current;
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(incoming ? 0.4 * dir : -0.4 * dir, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) =>
          Stack(alignment: Alignment.topCenter, children: [...previousChildren, ?currentChild]),
      child: KeyedSubtree(key: ValueKey(current), child: widget.child),
    );
  }
}
