import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../catalog/awards.dart';
import '../catalog/medal_look.dart';
import '../l10n/l10n.dart';
import '../services/gallery.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'medal.dart';
import 'profile_avatar.dart';
import 'ui_kit.dart';

const _confettiColors = [
  Color(0xFFFF4D6D),
  Color(0xFF4CC3FF),
  Color(0xFF57D68D),
  Color(0xFFFFC93C),
  Color(0xFFB06CFF),
  Color(0xFFFF8A3D),
  Color(0xFFF4F6FA),
];

class AwardCelebration extends StatefulWidget {
  const AwardCelebration({super.key, required this.id, required this.onClose});

  final AwardId id;
  final VoidCallback onClose;

  @override
  State<AwardCelebration> createState() => _AwardCelebrationState();
}

class _AwardCelebrationState extends State<AwardCelebration> with TickerProviderStateMixin {
  final _cardKey = GlobalKey();
  late final AnimationController _in = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();
  late final AnimationController _fall = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 5200),
  )..forward();
  late final List<_Bit> _bits = _seedBits(widget.id);
  bool _saving = false;
  String? _toast;

  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _in.dispose();
    _fall.dispose();
    super.dispose();
  }

  double _stagger(double start, double end) {
    final v = ((_in.value - start) / (end - start)).clamp(0.0, 1.0);
    return Curves.easeOutCubic.transform(v);
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    var message = t.shareFailed;
    try {
      final boundary = _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 3);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        if (data != null) {
          final stamp = DateTime.now().millisecondsSinceEpoch;
          final ok = await saveImageToGallery(
            data.buffer.asUint8List(),
            'gymmane-${widget.id.name}-$stamp.png',
          );
          if (ok) message = t.awardSaved;
        }
      }
    } catch (_) {
      message = t.shareFailed;
    }
    if (!mounted) return;
    HapticFeedback.lightImpact();
    setState(() {
      _saving = false;
      _toast = message;
    });
    await Future<void>.delayed(const Duration(milliseconds: 2600));
    if (mounted) setState(() => _toast = null);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final look = medalLook(widget.id);
    final glow = Color(0xFF000000 | look.metal.lip);
    final size = MediaQuery.sizeOf(context);
    final medal = math.min(math.min(size.width * 0.72, 300.0), size.height * 0.3);

    return AnimatedBuilder(
      animation: _in,
      builder: (context, _) {
        final scrim = Curves.easeOut.transform((_in.value * 2.2).clamp(0.0, 1.0));
        return Material(
          color: gc.pageBg.withValues(alpha: 0.95 * scrim),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -1400,
                top: 0,
                child: RepaintBoundary(
                  key: _cardKey,
                  child: _SaveCard(id: widget.id, gc: gc, bits: _bits),
                ),
              ),
              Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(painter: _ConfettiPainter(_fall, _bits)),
                ),
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(26, 12, 26, 22),
                    child: Column(
                      children: [
                        const Spacer(),
                        Transform.scale(
                          scale: 0.74 + 0.26 * _stagger(0, 0.55),
                          child: Opacity(
                            opacity: _stagger(0, 0.3),
                            child: SizedBox(
                              width: medal,
                              height: medal,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          glow.withValues(alpha: 0.30 * _stagger(0.1, 0.7)),
                                          glow.withValues(alpha: 0),
                                        ],
                                        stops: const [0.18, 0.74],
                                      ),
                                    ),
                                    child: const SizedBox.expand(),
                                  ),
                                  MedalSpin(
                                      id: widget.id, size: medal, spinIn: true, faceFront: true),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        _fade(
                          0.3,
                          0.65,
                          Text(
                            t.awardUnlocked.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: AppTheme.f(11.5,
                                weight: FontWeight.w700,
                                color: gc.textSecondary,
                                letterSpacing: 2.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _fade(
                          0.38,
                          0.75,
                          Text(
                            awardName(widget.id),
                            textAlign: TextAlign.center,
                            style: AppTheme.f(32, weight: FontWeight.w800, color: gc.text),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _fade(
                          0.46,
                          0.85,
                          Text(
                            awardLine(widget.id),
                            textAlign: TextAlign.center,
                            style: AppTheme.f(13.5,
                                weight: FontWeight.w500, color: gc.textSecondary, height: 1.45),
                          ),
                        ),
                        const Spacer(),
                        _fade(0.54, 0.95, _Signature(gc: gc, avatar: 34)),
                        const SizedBox(height: 26),
                        if (_toast != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Text(_toast!,
                                style: AppTheme.f(12.5,
                                    weight: FontWeight.w600, color: gc.textSecondary)),
                          ),
                        _fade(0.6, 1, PrimaryButton(label: t.awardNice, onTap: widget.onClose)),
                        const SizedBox(height: 4),
                        _fade(
                          0.68,
                          1,
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _saving ? null : _save,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                _saving ? '…' : t.awardSaveImage,
                                textAlign: TextAlign.center,
                                style: AppTheme.f(13.5,
                                    weight: FontWeight.w700, color: gc.textSecondary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _fade(double from, double to, Widget child) {
    final v = _stagger(from, to);
    return Opacity(
      opacity: v,
      child: Transform.translate(offset: Offset(0, 16 * (1 - v)), child: child),
    );
  }
}

class _SaveCard extends StatelessWidget {
  const _SaveCard({required this.id, required this.gc, required this.bits});

  final AwardId id;
  final GymColors gc;
  final List<_Bit> bits;

  @override
  Widget build(BuildContext context) {
    final at = fit.awardWonAt(id) ?? DateTime.now();
    return SizedBox(
      width: 360,
      height: 760,
      child: ColoredBox(
        color: gc.pageBg,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _ConfettiPainter(const AlwaysStoppedAnimation(0.4), bits),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
              child: Column(
                children: [
                  Text('GymMane', style: AppTheme.f(17, weight: FontWeight.w800, color: gc.text)),
                  const Spacer(),
                  Medal(id: id, size: 208),
                  const SizedBox(height: 36),
                  Text(t.awardUnlocked.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: AppTheme.f(10.5,
                          weight: FontWeight.w700, color: gc.textSecondary, letterSpacing: 2.4)),
                  const SizedBox(height: 10),
                  Text(awardName(id),
                      textAlign: TextAlign.center,
                      style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text)),
                  const SizedBox(height: 8),
                  Text(awardLine(id),
                      textAlign: TextAlign.center,
                      style: AppTheme.f(13,
                          weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                  const Spacer(),
                  _Signature(gc: gc, at: at),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Signature extends StatelessWidget {
  const _Signature({required this.gc, this.at, this.avatar = 40});

  final GymColors gc;
  final DateTime? at;
  final double avatar;

  @override
  Widget build(BuildContext context) {
    final date = at;
    return Column(
      children: [
        Container(width: 86, height: 1, color: gc.bgRaised2),
        SizedBox(height: avatar * 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileAvatar(size: avatar),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fit.displayName,
                    style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
                Text('@${fit.profileHandle}',
                    style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ),
          ],
        ),
        if (date != null) ...[
          const SizedBox(height: 16),
          Text(t.shortDateYear(date),
              style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
        ],
      ],
    );
  }
}

class _Bit {
  _Bit(this.x, this.delay, this.fall, this.sway, this.spin, this.w, this.h, this.color);

  final double x;
  final double delay;
  final double fall;
  final double sway;
  final double spin;
  final double w;
  final double h;
  final Color color;
}

List<_Bit> _seedBits(AwardId id) {
  final rnd = math.Random(id.index * 7717 + 13);
  return List.generate(84, (_) {
    final strip = rnd.nextDouble() < 0.35;
    return _Bit(
      rnd.nextDouble(),
      rnd.nextDouble() * 0.30,
      0.34 + rnd.nextDouble() * 0.12,
      (rnd.nextDouble() - 0.5) * 0.16,
      (rnd.nextDouble() - 0.5) * 15,
      strip ? 5 : 8 + rnd.nextDouble() * 4,
      strip ? 16 + rnd.nextDouble() * 8 : 8 + rnd.nextDouble() * 4,
      _confettiColors[rnd.nextInt(_confettiColors.length)],
    );
  });
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.t, this.bits) : super(repaint: t);

  final Animation<double> t;
  final List<_Bit> bits;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final b in bits) {
      final life = (t.value - b.delay) / b.fall;
      if (life <= 0 || life >= 1.2) continue;
      final y = -0.08 + life * 1.22;
      final x = b.x + math.sin(life * 5.4 + b.x * 9) * b.sway;
      final fade = life < 0.05
          ? life / 0.05
          : (life > 0.86 ? (1 - (life - 0.86) / 0.14).clamp(0.0, 1.0) : 1.0);
      paint.color = b.color.withValues(alpha: fade);
      canvas.save();
      canvas.translate(x * size.width, y * size.height);
      canvas.rotate(life * b.spin);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: b.w, height: b.h),
          const Radius.circular(1.6),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => false;
}
