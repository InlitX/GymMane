import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/gym_pass.dart';
import '../state/fit_state.dart';
import '../theme/app_theme.dart';
import 'routine_folder.dart';

const double kPassRatio = 1.586;

Barcode barcodeFor(PassFormat f) => switch (f) {
      PassFormat.qr => Barcode.qrCode(errorCorrectLevel: BarcodeQRCorrectionLevel.medium),
      PassFormat.code128 => Barcode.code128(),
      PassFormat.ean13 => Barcode.ean13(),
      PassFormat.ean8 => Barcode.ean8(),
      PassFormat.upca => Barcode.upcA(),
      PassFormat.code39 => Barcode.code39(),
      PassFormat.itf => Barcode.itf(),
      PassFormat.dataMatrix => Barcode.dataMatrix(),
      PassFormat.pdf417 => Barcode.pdf417(),
      PassFormat.aztec => Barcode.aztec(),
    };

String passFormatLabel(PassFormat f) => switch (f) {
      PassFormat.qr => 'QR',
      PassFormat.code128 => 'Code 128',
      PassFormat.ean13 => 'EAN-13',
      PassFormat.ean8 => 'EAN-8',
      PassFormat.upca => 'UPC-A',
      PassFormat.code39 => 'Code 39',
      PassFormat.itf => 'ITF',
      PassFormat.dataMatrix => 'Data Matrix',
      PassFormat.pdf417 => 'PDF417',
      PassFormat.aztec => 'Aztec',
    };

bool passCodeValid(PassFormat f, String code) => code.isNotEmpty && barcodeFor(f).isValid(code);

Color passHue(int hue) => kFolderHues[hue.abs() % kFolderHues.length];

class PassCode extends StatelessWidget {
  const PassCode({super.key, required this.code, required this.format, this.caption = true});

  final String code;
  final PassFormat format;
  final bool caption;

  @override
  Widget build(BuildContext context) {
    final square = const {PassFormat.qr, PassFormat.dataMatrix, PassFormat.aztec}.contains(format);
    final bars = CustomPaint(painter: _CodePainter(code, format, MediaQuery.devicePixelRatioOf(context)));
    if (square) return AspectRatio(aspectRatio: 1, child: bars);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: bars),
        if (caption) ...[
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(code,
                maxLines: 1,
                style: AppTheme.f(13, weight: FontWeight.w700, color: Colors.black, letterSpacing: 2.2)
                    .copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
          ),
        ],
      ],
    );
  }
}

class _CodePainter extends CustomPainter {
  _CodePainter(this.code, this.format, this.ratio);

  final String code;
  final PassFormat format;
  final double ratio;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final Iterable<BarcodeElement> parts;
    try {
      parts = barcodeFor(format).make(code, width: size.width, height: size.height);
    } catch (_) {
      return;
    }
    double snap(double v) => (v * ratio).roundToDouble() / ratio;
    final paint = Paint()
      ..color = Colors.black
      ..isAntiAlias = false;
    for (final e in parts) {
      if (e is BarcodeBar && e.black) {
        canvas.drawRect(
          Rect.fromLTRB(snap(e.left), snap(e.top), snap(e.left + e.width), snap(e.top + e.height)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_CodePainter old) => old.code != code || old.format != format || old.ratio != ratio;
}

class GymPassCard extends StatelessWidget {
  const GymPassCard({super.key, required this.pass, this.hero = true});

  final GymPass pass;
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final hue = passHue(pass.hue);
    final soft = Color.lerp(hue, Colors.white, 0.25)!;
    final member = pass.member.isNotEmpty ? pass.member : fit.displayName;
    final card = AspectRatio(
      aspectRatio: kPassRatio,
      child: LayoutBuilder(builder: (context, box) {
        final w = box.maxWidth;
        final pad = w * 0.062;
        final radius = w * 0.058;
        final eyebrow = FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(t.gymPass.toUpperCase(),
              maxLines: 1,
              style: AppTheme.f(w * 0.028, weight: FontWeight.w800, color: soft, letterSpacing: w * 0.004)),
        );
        final name = Text(pass.name.isEmpty ? '—' : pass.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(w * 0.058, weight: FontWeight.w800, color: Colors.white, height: 1.12, letterSpacing: -0.2));
        final who = Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(t.gymPassMember.toUpperCase(),
              style: AppTheme.f(w * 0.024,
                  weight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.42), letterSpacing: w * 0.004)),
          SizedBox(height: w * 0.008),
          Text(member,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(w * 0.04, weight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.9))),
        ]);
        final panel = Container(
          padding: EdgeInsets.all(w * 0.026),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(w * 0.032)),
          child: PassCode(code: pass.code, format: pass.format, caption: false),
        );
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 26, offset: const Offset(0, 12)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(children: [
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF232327), Color(0xFF141416), Color(0xFF0E0E10)],
                      stops: [0, 0.55, 1],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(-1.05, -1.15),
                      radius: 1.1,
                      colors: [hue.withValues(alpha: 0.30), hue.withValues(alpha: 0.06), Colors.transparent],
                      stops: const [0, 0.45, 1],
                    ),
                  ),
                ),
              ),
              Positioned.fill(child: CustomPaint(painter: _Guilloche(Colors.white.withValues(alpha: 0.035)))),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(pad),
                child: pass.square
                    ? Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            eyebrow,
                            SizedBox(height: w * 0.022),
                            name,
                            const Spacer(),
                            who,
                          ]),
                        ),
                        SizedBox(width: pad * 0.7),
                        panel,
                      ])
                    : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              eyebrow,
                              SizedBox(height: w * 0.018),
                              name,
                            ]),
                          ),
                          SizedBox(width: pad * 0.6),
                          who,
                        ]),
                        const Spacer(),
                        SizedBox(height: w * 0.25, child: panel),
                      ]),
              ),
            ]),
          ),
        );
      }),
    );
    if (!hero) return card;
    return Hero(tag: 'pass-${pass.id}', child: Material(type: MaterialType.transparency, child: card));
  }
}

class _Guilloche extends CustomPainter {
  const _Guilloche(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width * 1.02, size.height * 1.1);
    for (var r = size.width * 0.18; r < size.width * 1.1; r += size.width * 0.034) {
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(_Guilloche old) => old.color != color;
}
