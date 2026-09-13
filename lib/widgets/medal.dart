import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../catalog/awards.dart';
import '../catalog/medal_look.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_theme.dart';

const double _restTilt = 0.13;

class Medal extends StatelessWidget {
  const Medal({super.key, required this.id, required this.size, this.locked = false});

  final AwardId id;
  final double size;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      locked ? medalOffAsset(id) : medalAsset(id),
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
    );
  }
}

Future<ui.FragmentProgram>? _programOnce;
final Map<int, Future<ui.Image>> _iconCache = {};

Future<ui.Image> _iconImage(IconData icon) {
  return _iconCache.putIfAbsent(icon.codePoint, () async {
    const px = 384.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: px * 0.84,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: const Color(0xFFFFFFFF),
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset((px - painter.width) / 2, (px - painter.height) / 2));
    return recorder.endRecording().toImage(px.toInt(), px.toInt());
  });
}

Future<ui.Image> _backImage(String? handle, String title, String? date) {
  const px = 448.0;
  const width = px * 0.76;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  TextPainter paint(String text, double size, FontWeight weight, double spacing) => TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: AppTheme.round,
            fontSize: size,
            fontWeight: weight,
            letterSpacing: spacing,
            color: const Color(0xFFFFFFFF),
            height: 1.12,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: width);

  final lines = <(TextPainter, double)>[
    if (handle != null) (paint('@$handle', px * 0.055, FontWeight.w600, 0.5), px * 0.055),
    (paint(title.toUpperCase(), px * 0.072, FontWeight.w700, 1.6), px * 0.05),
    if (date != null) (paint(date, px * 0.062, FontWeight.w600, 0.2), px * 0.075),
    (paint('GYMMANE', px * 0.046, FontWeight.w700, 3.2), 0),
  ];

  var total = 0.0;
  for (final (tp, gap) in lines) {
    total += tp.height + gap;
  }
  var y = (px - total) / 2;
  for (final (tp, gap) in lines) {
    tp.paint(canvas, Offset((px - tp.width) / 2, y));
    y += tp.height + gap;
  }
  return recorder.endRecording().toImage(px.toInt(), px.toInt());
}

class MedalSpin extends StatefulWidget {
  const MedalSpin({
    super.key,
    required this.id,
    required this.size,
    this.locked = false,
    this.spinIn = false,
    this.faceFront = false,
  });

  final AwardId id;
  final double size;
  final bool locked;
  final bool spinIn;
  final bool faceFront;

  @override
  State<MedalSpin> createState() => _MedalSpinState();
}

class _MedalSpinState extends State<MedalSpin> with SingleTickerProviderStateMixin {
  final _pose = _Pose();
  late final Ticker _ticker = createTicker(_tick);
  ui.FragmentShader? _shader;
  ui.Image? _icon;
  ui.Image? _back;
  Duration _last = Duration.zero;
  double _yaw = 0;
  double _yawVel = 0;
  double _tilt = _restTilt;
  double _tiltVel = 0;
  double _time = 0;
  bool _held = false;
  bool _landed = true;
  int _face = 0;

  @override
  void initState() {
    super.initState();
    if (widget.spinIn) {
      _yaw = -math.pi * 2;
      _yawVel = 13;
      _landed = false;
    }
    _ticker.start();
    _load();
  }

  Future<void> _load() async {
    try {
      final program =
          await (_programOnce ??= ui.FragmentProgram.fromAsset('assets/shaders/medal.frag'));
      final icon = await _iconImage(medalLook(widget.id).icon);
      final at = fit.awardWonAt(widget.id);
      final back = await _backImage(
        fit.hasOwnIdentity ? fit.profileHandle : null,
        awardName(widget.id),
        at == null ? null : t.shortDateYear(at),
      );
      if (!mounted) return;
      setState(() {
        _shader = program.fragmentShader();
        _icon = icon;
        _back = back;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _ticker.dispose();
    _pose.dispose();
    _shader?.dispose();
    _back?.dispose();
    super.dispose();
  }

  double get _restAngle {
    final turn = widget.faceFront ? 2 * math.pi : math.pi;
    return (_yaw / turn).roundToDouble() * turn;
  }

  double _spring(double x, double target, double vel, double stiffness, double damping, double dt) {
    return vel + (-(x - target) * stiffness - vel * damping) * dt;
  }

  void _tick(Duration now) {
    final dt = ((now - _last).inMicroseconds / 1e6).clamp(0.0, 0.04);
    _last = now;
    if (dt == 0) return;
    _time += dt;

    if (!_held) {
      if (_yawVel.abs() > 5.5) {
        _yaw += _yawVel * dt;
        _yawVel *= math.exp(-dt / 1.9);
      } else {
        final rest = _restAngle;
        _yawVel = _spring(_yaw, rest, _yawVel, 78, 11.5, dt);
        _yaw += _yawVel * dt;
        if (!_landed && (_yaw - rest).abs() < 0.045 && _yawVel.abs() < 0.9) {
          _landed = true;
          HapticFeedback.lightImpact();
        }
      }
      _tiltVel = _spring(_tilt, _restTilt, _tiltVel, 96, 13, dt);
      _tilt += _tiltVel * dt;
      _clickAtFace();
    }
    if (_atRest) {
      _yaw = _restAngle;
      _yawVel = 0;
      _tilt = _restTilt;
      _tiltVel = 0;
      _ticker.stop();
    }
    _pose.set(_yaw, _tilt, _time);
  }

  bool get _atRest {
    final rest = _restAngle;
    return !_held &&
        _yawVel.abs() < 0.02 &&
        (_yaw - rest).abs() < 0.002 &&
        _tiltVel.abs() < 0.02 &&
        (_tilt - _restTilt).abs() < 0.002;
  }

  void _wake() {
    if (!_ticker.isTicking) _ticker.start();
  }

  void _clickAtFace() {
    final face = (_yaw / math.pi).round();
    if (face == _face) return;
    _face = face;
    if (_yawVel.abs() > 1.6 && _yawVel.abs() < 13) HapticFeedback.selectionClick();
  }

  void _flip() {
    _wake();
    _landed = false;
    _yawVel = _yawVel.abs() < 1.5 ? 8.2 : _yawVel + 4.5;
  }

  @override
  Widget build(BuildContext context) {
    final shader = _shader;
    final icon = _icon;
    final back = _back;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _flip,
      onPanStart: (_) {
        _wake();
        _held = true;
        _yawVel = 0;
        _tiltVel = 0;
        _landed = false;
      },
      onPanUpdate: (d) {
        _yaw += d.delta.dx * 0.017;
        _tilt = (_tilt - d.delta.dy * 0.011).clamp(-0.55, 0.62);
        _pose.set(_yaw, _tilt, _time);
      },
      onPanEnd: (d) {
        _held = false;
        _yawVel = (d.velocity.pixelsPerSecond.dx * 0.016).clamp(-22.0, 22.0);
        _tiltVel = (-d.velocity.pixelsPerSecond.dy * 0.010).clamp(-9.0, 9.0);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: shader == null || icon == null || back == null
            ? Center(child: Medal(id: widget.id, size: widget.size * 0.86, locked: widget.locked))
            : RepaintBoundary(
                child: CustomPaint(
                  painter: _MedalPainter(
                    shader: shader,
                    icon: icon,
                    back: back,
                    look: medalLook(widget.id),
                    pose: _pose,
                    locked: widget.locked,
                  ),
                ),
              ),
      ),
    );
  }
}

class _Pose extends ChangeNotifier {
  double yaw = 0;
  double tilt = _restTilt;
  double time = 0;

  void set(double y, double t, double tm) {
    yaw = y;
    tilt = t;
    time = tm;
    notifyListeners();
  }
}

class _MedalPainter extends CustomPainter {
  _MedalPainter({
    required this.shader,
    required this.icon,
    required this.back,
    required this.look,
    required this.pose,
    required this.locked,
  }) : super(repaint: pose);

  final ui.FragmentShader shader;
  final ui.Image icon;
  final ui.Image back;
  final MedalLook look;
  final _Pose pose;
  final bool locked;

  int _rgb(int hex, int at) {
    var i = at;
    for (final channel in [hex >> 16 & 255, hex >> 8 & 255, hex & 255]) {
      shader.setFloat(i++, math.pow(channel / 255, 2.2).toDouble());
    }
    return i;
  }

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, pose.yaw)
      ..setFloat(3, pose.tilt)
      ..setFloat(4, pose.time)
      ..setFloat(5, locked ? 1 : 0)
      ..setFloat(6, look.round ? 1 : 0)
      ..setFloat(7, look.gem == null ? 0 : 1)
      ..setFloat(8, look.gem == null ? 0.46 : 0.40);
    var i = _rgb(look.metal.base, 9);
    i = _rgb(look.metal.lip, i);
    i = _rgb(look.metal.plateTop, i);
    i = _rgb(look.metal.plateLow, i);
    i = _rgb(look.metal.ink, i);
    _rgb(look.gem ?? 0x84c4e8, i);
    shader.setImageSampler(0, icon);
    shader.setImageSampler(1, back);
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_MedalPainter old) =>
      old.shader != shader || old.icon != icon || old.locked != locked;
}
