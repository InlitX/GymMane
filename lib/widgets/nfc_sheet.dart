import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../screens/start_sheet.dart';
import '../services/nfc_tags.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'exercise_media.dart';
import 'glass.dart';
import 'svg_icon.dart';
import 'ui_kit.dart';

void showNfcSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _NfcSheet(),
  );
}

DateTime? _lastTag;

void openTodayFromTag(BuildContext context) {
  if (!fit.nfcTag || !fit.onboarded || _TodaySheetState.open != null) return;
  final now = DateTime.now();
  final last = _lastTag;
  if (last != null && now.difference(last) < const Duration(milliseconds: 1500)) return;
  _lastTag = now;
  final s = fit.session;
  if (s != null && !s.complete) {
    if (fit.sessionParked) {
      HapticFeedback.mediumImpact();
      fit.stepBackIntoSession();
    }
    return;
  }
  HapticFeedback.mediumImpact();
  if (!fit.restingToday && _todayRoutines().isEmpty) {
    showStartSheet(context);
    return;
  }
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _TodaySheet(),
  );
}

List<Routine> _todayRoutines() => [
      for (final r in fit.routinesOn(DateTime.now()))
        if (r.exerciseIds.isNotEmpty) r,
    ];

class _Sticker extends StatelessWidget {
  const _Sticker({required this.size, this.badge, this.dim = false});

  final double size;
  final Widget? badge;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(clipBehavior: Clip.none, children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: dim ? 0.4 : 1,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF0C4A6), Color(0xFFD9A184), Color(0xFFB07A5C)],
              ),
              border: Border.all(color: const Color(0xFFFFE6D4).withValues(alpha: 0.7), width: 1.2),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 18, offset: const Offset(0, 10)),
              ],
            ),
            child: Stack(children: [
              Positioned.fill(
                child: ClipOval(
                  child: CustomPaint(painter: _ShinePainter()),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(size * 0.17),
                  child: Image.asset('assets/img/runner.png',
                      color: const Color(0xFF1C1411), colorBlendMode: BlendMode.srcIn, fit: BoxFit.contain),
                ),
              ),
            ]),
          ),
        ),
        if (badge != null)
          PositionedDirectional(
            end: -2,
            top: -2,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: gc.bgRaised, width: 3)),
              child: badge,
            ),
          ),
      ]),
    );
  }
}

class _ShinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withValues(alpha: 0.38), Colors.white.withValues(alpha: 0)],
        stops: const [0, 0.55],
      ).createShader(Offset.zero & size);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width * 0.72, 0)
        ..lineTo(0, size.height * 0.72)
        ..close(),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Waves extends StatelessWidget {
  const _Waves({required this.color, this.size = 34, this.flip = false});

  final Color color;
  final double size;
  final bool flip;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flip,
      child: CustomPaint(size: Size(size, size), painter: _WavesPainter(color)),
    );
  }
}

class _WavesPainter extends CustomPainter {
  _WavesPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(0, size.height / 2);
    for (var i = 0; i < 3; i++) {
      final r = size.width * (0.38 + i * 0.3);
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r),
        -math.pi / 4,
        math.pi / 2,
        false,
        Paint()
          ..color = color.withValues(alpha: 0.85 - i * 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WavesPainter old) => old.color != color;
}

const double _phoneRatio = 147.6 / 71.6;

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.width, required this.child, this.back = false});

  final double width;
  final Widget child;
  final bool back;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final w = width;
    final h = w * _phoneRatio;
    final band = w * 0.028;
    final radius = w * 0.165;
    final inset = back ? 0.0 : w * 0.022;
    Widget key(double top, double len, {bool right = false}) => Positioned(
          top: top,
          left: right ? null : -w * 0.018,
          right: right ? -w * 0.018 : null,
          child: Container(
            width: w * 0.022,
            height: len,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * 0.01),
              gradient: const LinearGradient(colors: [Color(0xFF5A5652), Color(0xFF2A2826)]),
            ),
          ),
        );
    return SizedBox(
      width: w,
      height: h,
      child: Stack(clipBehavior: Clip.none, children: [
        key(h * 0.19, h * 0.06, right: back),
        key(h * 0.28, h * 0.1, right: back),
        key(h * 0.4, h * 0.1, right: back),
        key(h * 0.3, h * 0.15, right: !back),
        Container(
          width: w,
          height: h,
          padding: EdgeInsets.all(band),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8E8A85), Color(0xFF3A3734), Color(0xFF1F1D1B), Color(0xFF5C5853)],
              stops: [0, 0.3, 0.7, 1],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 22, offset: const Offset(0, 8)),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(inset),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius - band),
              color: back ? null : Colors.black,
              gradient: back
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2A2725), Color(0xFF1B1918), Color(0xFF141312)],
                    )
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius - band - inset),
              child: back ? child : ColoredBox(color: gc.bg, child: child),
            ),
          ),
        ),
      ]),
    );
  }
}

class _PhoneBack extends StatelessWidget {
  const _PhoneBack({required this.width, required this.dim});

  final double width;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final w = width;
    Widget lens(double d) => Container(
          width: d,
          height: d,
          padding: EdgeInsets.all(d * 0.09),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFB9B4AE), Color(0xFF4A4642), Color(0xFF8A857F)],
            ),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: d * 0.2, offset: Offset(0, d * 0.08))],
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment(-0.35, -0.35),
                radius: 0.9,
                colors: [Color(0xFF3B4A66), Color(0xFF141A26), Color(0xFF020203)],
                stops: [0, 0.45, 1],
              ),
            ),
            child: Align(
              alignment: const Alignment(-0.38, -0.42),
              child: Container(
                width: d * 0.16,
                height: d * 0.16,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.55)),
              ),
            ),
          ),
        );
    final module = w * 0.4;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: dim ? 0.5 : 1,
      child: _PhoneFrame(
        width: w,
        back: true,
        child: Stack(children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(0.6, 0.2),
                  colors: [Colors.white.withValues(alpha: 0.09), Colors.white.withValues(alpha: 0)],
                ),
              ),
            ),
          ),
          Positioned(
            left: w * 0.06,
            top: w * 0.06,
            child: Container(
              width: module,
              height: module,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(module * 0.28),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3A3633), Color(0xFF221F1D)],
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14), width: 0.8),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 3))],
              ),
              child: Stack(children: [
                Positioned(left: module * 0.08, top: module * 0.08, child: lens(module * 0.44)),
                Positioned(right: module * 0.08, bottom: module * 0.08, child: lens(module * 0.44)),
                Positioned(
                  right: module * 0.15,
                  top: module * 0.15,
                  child: Container(
                    width: module * 0.15,
                    height: module * 0.15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(colors: [Color(0xFFFFF4DA), Color(0xFFCDB98F)]),
                    ),
                  ),
                ),
                Positioned(
                  left: module * 0.2,
                  bottom: module * 0.2,
                  child: Container(
                    width: module * 0.05,
                    height: module * 0.05,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0C0B0A)),
                  ),
                ),
              ]),
            ),
          ),
          Center(
            child: Image.asset('assets/img/runner.png',
                height: w * 0.3, color: Colors.white.withValues(alpha: 0.2), colorBlendMode: BlendMode.srcIn),
          ),
        ]),
      ),
    );
  }
}

class _NfcTag extends StatelessWidget {
  const _NfcTag();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: gc.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gc.accent.withValues(alpha: 0.45)),
      ),
      child: Text('NFC', style: AppTheme.f(10, weight: FontWeight.w800, color: gc.accent, letterSpacing: 1.2)),
    );
  }
}

class _ScreenPreview extends StatelessWidget {
  const _ScreenPreview({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final s = width / 140;
    final resting = fit.restingToday;
    final list = _todayRoutines();
    final pending = fit.pendingRoutinesOn(DateTime.now()).where((r) => r.exerciseIds.isNotEmpty).toList();
    final routine = pending.isNotEmpty ? pending.first : (list.isEmpty ? null : list.last);
    final exercises = routine == null || resting ? const <Exercise>[] : fit.routineExercises(routine).take(3).toList();
    final bar = gc.text.withValues(alpha: 0.14);
    final faint = gc.text.withValues(alpha: 0.08);
    Widget line(double w, double h, Color c) =>
        Container(width: w, height: h, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(h)));
    return Padding(
      padding: EdgeInsets.fromLTRB(11 * s, 9 * s, 11 * s, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
            width: 34 * s,
            height: 9 * s,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6 * s)),
          ),
        ),
        SizedBox(height: 13 * s),
        Container(
          padding: EdgeInsets.all(10 * s),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(14 * s)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              if (resting) ...[
                Icon(PhosphorIconsFill.bed, size: 9 * s, color: gc.sage),
                SizedBox(width: 4 * s),
              ],
              line(34 * s, 4 * s, faint),
            ]),
            SizedBox(height: 7 * s),
            line(62 * s, 9 * s, bar),
            SizedBox(height: 5 * s),
            line(40 * s, 4 * s, faint),
            SizedBox(height: 10 * s),
            Container(
              height: 20 * s,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: resting ? gc.bgRaised2 : gc.text,
                borderRadius: BorderRadius.circular(10 * s),
              ),
              child: Icon(PhosphorIconsFill.play, size: 8 * s, color: resting ? gc.text : gc.bg),
            ),
          ]),
        ),
        SizedBox(height: 8 * s),
        for (var i = 0; i < 3; i++)
          Container(
            margin: EdgeInsets.only(bottom: 5 * s),
            padding: EdgeInsets.all(5 * s),
            decoration: BoxDecoration(
              color: resting ? gc.bgRaised.withValues(alpha: 0.6) : gc.bgRaised,
              borderRadius: BorderRadius.circular(10 * s),
            ),
            child: Row(children: [
              SizedBox(
                width: 18 * s,
                height: 18 * s,
                child: i < exercises.length
                    ? ExerciseMedia(ex: exercises[i], height: 18 * s, radius: 5 * s, bordered: false)
                    : DecoratedBox(
                        decoration: BoxDecoration(color: faint, borderRadius: BorderRadius.circular(5 * s)),
                      ),
              ),
              SizedBox(width: 7 * s),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: line([46.0, 58.0, 38.0][i] * s, 5 * s, i < exercises.length ? bar : faint),
                ),
              ),
            ]),
          ),
      ]),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      height: 214,
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(builder: (context, box) {
        const phone = 132.0;
        final left = (box.maxWidth - phone) / 2 - 34;
        return Stack(clipBehavior: Clip.hardEdge, children: [
          Positioned(
            left: left,
            top: 24,
            child: const _PhoneFrame(width: phone, child: _ScreenPreview(width: phone * 0.9)),
          ),
          Positioned(
            left: left + phone + 16,
            top: 54,
            child: const _NfcTag(),
          ),
          Positioned(
            left: left + phone + 12,
            top: 92,
            child: _Waves(color: gc.accent, size: 30, flip: true),
          ),
          Positioned(
            left: left + phone + 48,
            top: 76,
            child: const _Sticker(size: 64),
          ),
        ]);
      }),
    );
  }
}

enum _Step { intro, checking, off, waiting, done, failed }

class _NfcSheet extends StatefulWidget {
  const _NfcSheet();

  @override
  State<_NfcSheet> createState() => _NfcSheetState();
}

class _NfcSheetState extends State<_NfcSheet> with WidgetsBindingObserver {
  _Step _step = _Step.intro;
  String _error = '';
  int _shake = 0;
  StreamSubscription<String>? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sub = NfcTags.written.listen(_onWritten);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    NfcTags.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _step == _Step.off) _start();
  }

  Future<void> _start() async {
    setState(() => _step = _Step.checking);
    final s = await NfcTags.state();
    if (!mounted) return;
    if (!s.enabled) {
      setState(() => _step = _Step.off);
      return;
    }
    final ok = await NfcTags.write();
    if (!mounted) return;
    setState(() => _step = ok ? _Step.waiting : _Step.off);
  }

  void _back() {
    NfcTags.cancel();
    setState(() => _step = _Step.intro);
  }

  void _onWritten(String outcome) {
    if (!mounted || (_step != _Step.waiting && _step != _Step.failed)) return;
    if (outcome == 'ok') {
      HapticFeedback.mediumImpact();
      fit.setNfcTag(true);
      setState(() => _step = _Step.done);
      return;
    }
    HapticFeedback.heavyImpact();
    setState(() {
      _step = _Step.failed;
      _shake++;
      _error = switch (outcome) {
        'locked' => t.nfcErrLocked,
        'small' => t.nfcErrSmall,
        'unsupported' => t.nfcErrUnsupported,
        _ => t.nfcErrLost,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final intro = _step == _Step.intro;
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.92),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 420),
                  layoutBuilder: (current, previous) => Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ...previous.map((w) => Positioned(left: 0, right: 0, top: 0, child: w)),
                      ?current,
                    ],
                  ),
                  transitionBuilder: (child, anim) {
                    final incoming = child.key == ValueKey(intro);
                    final v = CurvedAnimation(
                      parent: anim,
                      curve: incoming
                          ? const Interval(0.4, 1, curve: Curves.easeOutCubic)
                          : const Interval(0.6, 1, curve: Curves.easeInCubic),
                    );
                    return AnimatedBuilder(
                      animation: v,
                      builder: (context, child) => Opacity(
                        opacity: v.value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - v.value) * (incoming ? 14 : -8)),
                          child: child,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: Column(
                    key: ValueKey(intro),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: intro ? _intro(context, gc) : _writing(context, gc),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _intro(BuildContext context, GymColors gc) {
    return [
      SheetTitle(t.nfcTitle, subtitle: t.nfcSubtitle),
      const SizedBox(height: 18),
      const _Hero(),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          _Point(icon: PhosphorIconsRegular.calendarCheck, title: t.nfcPoint1, body: t.nfcPoint1Body),
          _Point(icon: PhosphorIconsRegular.bed, title: t.nfcPoint2, body: t.nfcPoint2Body),
          _Point(icon: PhosphorIconsRegular.arrowsClockwise, title: t.nfcPoint3, body: t.nfcPoint3Body),
        ]),
      ),
      const SizedBox(height: 12),
      AnimatedBuilder(
        animation: fit,
        builder: (context, _) => Semantics(
          toggled: fit.nfcTag,
          child: Pressable(
            onTap: () {
              HapticFeedback.selectionClick();
              fit.setNfcTag(!fit.nfcTag);
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 58),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.nfcUse, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                    const SizedBox(height: 3),
                    Text(t.nfcUseHint,
                        style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                  ]),
                ),
                const SizedBox(width: 12),
                TinySwitch(on: fit.nfcTag),
              ]),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      PrimaryButton(label: t.nfcWrite, onTap: _start),
      const SizedBox(height: 10),
      Text(t.nfcTip,
          textAlign: TextAlign.center,
          style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
    ];
  }

  List<Widget> _writing(BuildContext context, GymColors gc) {
    final (title, body) = switch (_step) {
      _Step.off => (t.nfcOffTitle, t.nfcOffBody),
      _Step.done => (t.nfcDoneTitle, t.nfcDoneBody),
      _Step.failed => (t.nfcFailTitle, _error),
      _ => (t.nfcWaitTitle, t.nfcWaitBody),
    };
    return [
      const SizedBox(height: 6),
      Center(child: _WritePicture(step: _step, shake: _shake)),
      const SizedBox(height: 24),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Column(
          key: ValueKey(_step == _Step.checking ? _Step.waiting : _step),
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: AppTheme.f(20, weight: FontWeight.w800, color: gc.text, height: 1.2)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(body,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      ...switch (_step) {
        _Step.off => [
            PrimaryButton(label: t.nfcOpenSettings, onTap: NfcTags.openSettings),
            _TextAction(label: t.cancel, onTap: _back),
          ],
        _Step.done => [PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop())],
        _Step.failed => [
            PrimaryButton(label: t.nfcRetry, onTap: _start),
            _TextAction(label: t.cancel, onTap: _back),
          ],
        _ => [_TextAction(label: t.cancel, onTap: _back)],
      },
    ];
  }
}

class _TextAction extends StatelessWidget {
  const _TextAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          child: Text(label, style: AppTheme.f(14, weight: FontWeight.w600, color: context.gc.textSecondary)),
        ),
      ),
    );
  }
}

class _WritePicture extends StatelessWidget {
  const _WritePicture({required this.step, required this.shake});

  final _Step step;
  final int shake;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final done = step == _Step.done;
    final failed = step == _Step.failed;
    final off = step == _Step.off;
    const phone = 120.0;
    const box = Size(264, 268);
    const sticker = 62.0;
    final phoneLeft = (box.width - phone) / 2;
    const phoneTop = 4.0;
    final center = Offset(phoneLeft + phone / 2 - sticker / 2, phoneTop + phone * _phoneRatio / 2 - sticker / 2);
    final away = Offset(phoneLeft + phone + 14, phoneTop + phone * 1.32);
    final at = done ? center : away;
    final badge = done
        ? _badge(gc.sage, PhosphorIconsBold.check, gc)
        : failed
            ? _badge(gc.danger, PhosphorIconsBold.x, gc)
            : null;
    return SizedBox(
      width: box.width,
      height: box.height,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(left: phoneLeft, top: phoneTop, child: _PhoneBack(width: phone, dim: off)),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: done || off ? 0 : 1,
          child: Stack(children: [
            Positioned(
              left: phoneLeft + phone - 8,
              top: phoneTop + phone * 1.18,
              child: Transform.rotate(angle: -math.pi * 0.2, child: _Waves(color: gc.accent, size: 28, flip: true)),
            ),
            Positioned(
              left: phoneLeft + phone + 10,
              top: phoneTop + phone * 0.98,
              child: const _NfcTag(),
            ),
          ]),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 520),
          curve: done ? Curves.easeOutBack : Curves.easeOutCubic,
          left: at.dx,
          top: at.dy,
          child: TweenAnimationBuilder<double>(
            key: ValueKey(shake),
            tween: Tween(begin: shake == 0 ? 1 : 0, end: 1),
            duration: const Duration(milliseconds: 420),
            builder: (context, v, child) =>
                Transform.translate(offset: Offset(math.sin(v * math.pi * 5) * (1 - v) * 10, 0), child: child),
            child: _Sticker(size: sticker, dim: off, badge: badge),
          ),
        ),
      ]),
    );
  }

  Widget _badge(Color color, IconData icon, GymColors gc) => Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, size: 12, color: Colors.white),
      );
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 19, color: gc.textSecondary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
            const SizedBox(height: 3),
            Text(body, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
          ]),
        ),
      ]),
    );
  }
}

class _TodaySheet extends StatefulWidget {
  const _TodaySheet();

  @override
  State<_TodaySheet> createState() => _TodaySheetState();
}

class _TodaySheetState extends State<_TodaySheet> {
  static _TodaySheetState? open;
  String? _picked;

  @override
  void initState() {
    super.initState();
    open = this;
  }

  @override
  void dispose() {
    if (open == this) open = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: fit, builder: (context, _) => _body(context));
  }

  Widget _body(BuildContext context) {
    final gc = context.gc;
    final now = DateTime.now();
    final resting = fit.restingToday;
    final routines = resting ? const <Routine>[] : _todayRoutines();
    final pendingIds = {for (final r in fit.pendingRoutinesOn(now)) r.id};
    Routine? routine;
    for (final r in routines) {
      if (r.id == _picked) routine = r;
    }
    routine ??= routines.where((r) => pendingIds.contains(r.id)).firstOrNull ?? routines.lastOrNull;
    final done = routine != null && !pendingIds.contains(routine.id);
    final next = resting && !fit.rotating ? fit.nextPlannedAfter(now) : null;
    final upcoming = resting ? next?.routine ?? fit.rotationUpcoming : null;
    final exercises = routine == null ? const <Exercise>[] : fit.routineExercises(routine);
    final title = resting ? t.restDayShort : (routine == null ? '' : fit.routineTitle(routine));
    final subtitle = resting
        ? [
            if (upcoming != null) t.rotationRestUpNext(fit.routineTitle(upcoming)),
            if (next != null) t.weekdayShort(next.day.weekday),
          ].join(' · ')
        : done
            ? t.routineDoneToday
            : t.exerciseCount(exercises.length);

    void start() {
      final nav = Navigator.of(context);
      final id = routine?.id;
      nav.pop();
      if (resting || id == null) {
        showStartSheet(context);
        return;
      }
      final fresh = fit.routines.where((r) => r.id == id).firstOrNull;
      if (fresh != null && fresh.exerciseIds.isNotEmpty) fit.startRoutine(fresh);
    }

    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.88),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          Row(children: [
            if (resting) ...[
              Icon(PhosphorIconsFill.bed, size: 14, color: gc.sage),
              const SizedBox(width: 7),
            ],
            Flexible(child: SectionLabel(resting ? t.weeklyPlan : t.todaysRoutine)),
          ]),
          const SizedBox(height: 8),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text, height: 1.1)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(subtitle, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
          ],
          if (routines.length > 1) ...[
            const SizedBox(height: 14),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final r in routines)
                Pill(
                  label: '${pendingIds.contains(r.id) ? '' : '✓ '}${fit.routineTitle(r)}',
                  bg: r.id == routine?.id ? gc.ember : gc.bgRaised2,
                  fg: r.id == routine?.id ? gc.onEmber : gc.textSecondary,
                  vPad: 7,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _picked = r.id);
                  },
                ),
            ]),
          ],
          if (resting) ...[
            const SizedBox(height: 14),
            Text(t.todayRestBody,
                style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
          ],
          if (exercises.isNotEmpty) ...[
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Column(children: [
                    for (var i = 0; i < exercises.length; i++) ...[
                      if (i > 0)
                        Container(
                          height: 1,
                          margin: const EdgeInsetsDirectional.only(start: 72),
                          color: gc.border.withValues(alpha: 0.6),
                        ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 16, 8),
                        child: Row(children: [
                          SizedBox(
                            width: 44,
                            child: ExerciseMedia(ex: exercises[i], height: 44, radius: 12, bordered: false),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(exerciseName(exercises[i]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                          ),
                        ]),
                      ),
                    ],
                  ]),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          PrimaryButton(
            label: resting
                ? t.trainAnyway
                : done
                    ? t.trainAgain
                    : t.startWorkout,
            icon: Ic.play,
            bg: resting || done ? gc.bgRaised2 : null,
            fg: resting || done ? gc.text : null,
            onTap: start,
          ),
          _TextAction(label: resting ? sentenceCase(t.done) : t.todayNotNow, onTap: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }
}
