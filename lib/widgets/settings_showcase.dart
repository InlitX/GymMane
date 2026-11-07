import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/gym_pass.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';
import 'charts.dart';
import 'gym_pass_card.dart';
import 'medal.dart';

class _Collage extends StatelessWidget {
  const _Collage({required this.columns, this.offset = Offset.zero});

  final List<Widget> columns;
  static const height = 380.0;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return ShowcaseFrame(
      height: height,
      child: ExcludeSemantics(
      child: IgnorePointer(
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: ColoredBox(
              color: gc.bgRaised,
              child: OverflowBox(
                maxWidth: 1000,
                maxHeight: 1000,
                child: Transform.translate(
                  offset: offset,
                  child: Transform.rotate(
                    angle: -0.16,
                    child: Transform.scale(
                      scale: 0.66,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < columns.length; i++) ...[
                            if (i > 0) const SizedBox(width: 10),
                            columns[i],
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class ShowcaseFrame extends StatelessWidget {
  const ShowcaseFrame({super.key, required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      RepaintBoundary(child: SizedBox(height: height, child: child));
}

Widget _lift(Widget child, {double radius = 24}) => DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: child,
    );

Widget _stack(double top, List<Widget> items) => Padding(
      padding: EdgeInsets.only(top: top),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          items[i],
        ],
      ]),
    );

class _Tile extends StatelessWidget {
  const _Tile({required this.w, required this.h, required this.child, this.pad = 16});

  final double w;
  final double h;
  final Widget child;
  final double pad;

  @override
  Widget build(BuildContext context) => _lift(Container(
        width: w,
        height: h,
        padding: EdgeInsets.all(pad),
        decoration: BoxDecoration(color: context.gc.bgRaised2, borderRadius: BorderRadius.circular(24)),
        child: MediaQuery.withNoTextScaling(child: child),
      ));
}

Widget _kicker(GymColors gc, String text) => Text(text.toUpperCase(),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

Widget _big(GymColors gc, String text, {double size = 30, Color? color}) =>
    Text(text, maxLines: 1, style: AppTheme.f(size, weight: FontWeight.w800, color: color ?? gc.text, height: 1.05));

Widget _iconTile(GymColors gc, IconData icon, String value, String label, Color tone, {double h = 120}) => _Tile(
      w: 150,
      h: h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 24, color: tone),
        const Spacer(),
        _big(gc, value, size: 24),
        if (label.isNotEmpty) _kicker(gc, label),
      ]),
    );

const _sample = 'Aa';

String _letter(int weekday) => t.weekdayShort(weekday).characters.first.toUpperCase();

class _Ring extends StatelessWidget {
  const _Ring({required this.value, required this.color, required this.child, this.size = 110});

  final double value;
  final Color color;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 9,
              strokeCap: StrokeCap.round,
              color: color,
              backgroundColor: context.gc.bgRaised,
            ),
          ),
          child,
        ]),
      );
}

class AlertsShowcase extends StatelessWidget {
  const AlertsShowcase({super.key});

  Widget _note(GymColors gc,
          {required IconData icon,
          required Color tone,
          required String title,
          required String body,
          String when = '',
          Widget? extra}) =>
      _lift(Container(
        width: 330,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(color: tone.withValues(alpha: 0.18), shape: BoxShape.circle),
              child: Icon(icon, size: 12, color: tone),
            ),
            const SizedBox(width: 8),
            Text('GymMane', style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
            if (when.isNotEmpty)
              Flexible(
                child: Text(' · $when',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
              ),
          ]),
          const SizedBox(height: 10),
          Text(title,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
          const SizedBox(height: 3),
          Text(body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
          ?extra,
        ]),
      ));

  Widget _pill(GymColors gc, String label, {bool strong = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: strong ? gc.text : gc.bgRaised, borderRadius: BorderRadius.circular(100)),
        child: Text(label, style: AppTheme.f(12.5, weight: FontWeight.w800, color: strong ? gc.bg : gc.text)),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final bell = _Tile(
      w: 150,
      h: 170,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(PhosphorIconsRegular.bellRinging, size: 44, color: gc.sage),
        const Spacer(),
        _big(gc, '18:30'),
        const SizedBox(height: 4),
        _kicker(gc, '${_letter(1)} · ${_letter(3)} · ${_letter(5)}'),
      ]),
    );
    final sound = _Tile(
      w: 150,
      h: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(PhosphorIconsRegular.speakerHigh, size: 30, color: gc.text),
        const Spacer(),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (final (i, v) in const [0.3, 0.6, 1.0, 0.7, 0.45, 0.85, 0.5, 0.3, 0.65, 0.4].indexed) ...[
            if (i > 0) const SizedBox(width: 5),
            Container(
              width: 6,
              height: 36 * v,
              decoration: BoxDecoration(color: i < 6 ? gc.accent : gc.bgRaised, borderRadius: BorderRadius.circular(3)),
            ),
          ],
        ]),
      ]),
    );
    final vibrate = _Tile(
      w: 150,
      h: 110,
      child: Center(child: Icon(PhosphorIconsRegular.vibrate, size: 48, color: gc.textSecondary)),
    );
    final live = _note(
      gc,
      icon: PhosphorIconsFill.barbell,
      tone: gc.accent,
      title: t.catalogName('EIeI8Vf', 'Barbell Bench Press'),
      body: '${t.liveSet(3, 4)} · 80 kg × 8',
      when: t.liveChannel,
      extra: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Row(children: [
            _pill(gc, t.liveDoneSet, strong: true),
            const SizedBox(width: 8),
            _pill(gc, t.liveSkipRest),
          ]),
        ),
      ),
    );
    final restNote = _note(gc,
        icon: PhosphorIconsFill.timer, tone: gc.accent, title: t.restOverTitle, body: t.restOverBody, when: t.noteToday);
    final island = _lift(
      Container(
        width: 330,
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: gc.sage.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: Icon(PhosphorIconsFill.checkCircle, size: 22, color: gc.sage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(t.notifTrainBody,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w700, color: Colors.white)),
          ),
        ]),
      ),
      radius: 100,
    );
    final timer = _Tile(
      w: 150,
      h: 190,
      child: Center(
        child: _Ring(
          value: 0.62,
          color: gc.accent,
          size: 112,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _big(gc, '1:24', size: 28),
            const SizedBox(height: 2),
            Text(t.liveResting, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.accent)),
          ]),
        ),
      ),
    );
    final supp = _Tile(
      w: 150,
      h: 140,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(PhosphorIconsRegular.pill, size: 26, color: gc.brass),
          const Spacer(),
          Text('10:00', style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
        ]),
        const Spacer(),
        Text(t.suppCreatine, maxLines: 1, style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text)),
        Text('5 g', style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textTertiary)),
      ]),
    );
    final fast = _Tile(
      w: 150,
      h: 110,
      child: Row(children: [
        Icon(PhosphorIconsRegular.hourglassMedium, size: 30, color: gc.sage),
        const SizedBox(width: 10),
        _big(gc, '16 h', size: 26),
      ]),
    );
    return _Collage(
      offset: const Offset(22, -8),
      columns: [
        _stack(20, [bell, sound, vibrate, _iconTile(gc, PhosphorIconsRegular.bellSlash, '22:00', '', gc.textSecondary),
            _iconTile(gc, PhosphorIconsRegular.alarm, '7:00', '', gc.accent)]),
        _stack(0, [
          restNote,
          live,
          island,
          _note(gc,
              icon: PhosphorIconsFill.camera,
              tone: gc.info,
              title: t.notifPhotoTitle,
              body: t.notifPhotoBody(14),
              when: '9:00'),
          _Tile(
            w: 330,
            h: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              for (final (icon, on) in [
                (PhosphorIconsRegular.speakerSlash, false),
                (PhosphorIconsRegular.vibrate, true),
                (PhosphorIconsRegular.speakerHigh, false),
              ])
                Container(
                  width: 82,
                  height: 56,
                  decoration: BoxDecoration(color: on ? gc.text : gc.bgRaised, borderRadius: BorderRadius.circular(100)),
                  child: Icon(icon, size: 24, color: on ? gc.bg : gc.textSecondary),
                ),
            ]),
          ),
          _Tile(
            w: 330,
            h: 104,
            child: Row(children: [
              Icon(PhosphorIconsRegular.bellSimpleRinging, size: 26, color: gc.sage),
              const SizedBox(width: 14),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  for (var d = 1; d <= 7; d++)
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const {1, 3, 5}.contains(d) ? gc.sage.withValues(alpha: 0.22) : gc.bgRaised,
                      ),
                      child: Text(_letter(d),
                          style: AppTheme.f(11.5,
                              weight: FontWeight.w800, color: const {1, 3, 5}.contains(d) ? gc.sage : gc.textTertiary)),
                    ),
                ]),
              ),
            ]),
          ),
        ]),
        _stack(40, [timer, supp, fast, _iconTile(gc, PhosphorIconsRegular.ruler, '14', t.notifMeasureTitle, gc.warn),
            _iconTile(gc, PhosphorIconsRegular.drop, '1,5 L', '', gc.info)]),
      ],
    );
  }
}

class HomeExtrasShowcase extends StatelessWidget {
  const HomeExtrasShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    const pass = GymPass(id: 'demo', name: 'GymMane Fit', code: 'GYMMANE-2026-0042', hue: 0);
    final steps = _Tile(
      w: 150,
      h: 170,
      child: Center(
        child: _Ring(
          value: 0.78,
          color: gc.sage,
          size: 112,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(PhosphorIconsRegular.footprints, size: 18, color: gc.sage),
            _big(gc, '6 240', size: 22),
            Text(t.homeCardSteps, style: AppTheme.f(11, weight: FontWeight.w600, color: gc.textTertiary)),
          ]),
        ),
      ),
    );
    final level = _Tile(
      w: 150,
      h: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(PhosphorIconsRegular.medal, size: 22, color: gc.accent),
          const Spacer(),
          _big(gc, '7'),
        ]),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 7,
            child: Row(children: [
              Expanded(
                flex: 64,
                child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(colors: [gc.accent, gc.brass]))),
              ),
              Expanded(flex: 36, child: ColoredBox(color: gc.bgRaised)),
            ]),
          ),
        ),
      ]),
    );
    final medal = _Tile(w: 150, h: 150, child: Center(child: Medal(id: AwardId.values[1], size: 96)));
    final medalLocked = _Tile(w: 150, h: 150, child: Center(child: Medal(id: AwardId.values[6], size: 96, locked: true)));
    final passCard = SizedBox(width: 330, child: _lift(const GymPassCard(pass: pass, hero: false), radius: 22));
    final heart = _Tile(
      w: 330,
      h: 130,
      pad: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [
          Positioned.fill(
            top: 34,
            child: CustomPaint(
              painter: _Pulse(
                const [64, 62, 63, 60, 61, 59, 60, 57, 58, 56, 58],
                line: gc.accent,
                grid: gc.text.withValues(alpha: 0.06),
                dotRing: gc.bgRaised2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(children: [
              Icon(PhosphorIconsFill.heart, size: 16, color: gc.accent),
              const SizedBox(width: 6),
              Expanded(child: _kicker(gc, t.healthRestingHr)),
              Ltr(child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                _big(gc, '56', size: 26),
                const SizedBox(width: 3),
                Text(t.healthBpm, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
              ])),
            ]),
          ),
        ]),
      ),
    );
    final week = _Tile(
      w: 330,
      h: 96,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (var d = 1; d <= 7; d++)
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(_letter(d), style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary)),
            const SizedBox(height: 6),
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: const {1, 3, 4, 6}.contains(d) ? gc.text : gc.bgRaised),
              child: const {1, 3, 4, 6}.contains(d) ? Icon(PhosphorIconsBold.check, size: 14, color: gc.bg) : null,
            ),
          ]),
      ]),
    );
    final streak = _Tile(
      w: 150,
      h: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(PhosphorIconsFill.flame, size: 24, color: gc.accent),
        const Spacer(),
        _big(gc, '12'),
        _kicker(gc, t.streakCaps),
      ]),
    );
    final sleep = _Tile(
      w: 150,
      h: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(PhosphorIconsRegular.moonStars, size: 24, color: gc.warn),
        const Spacer(),
        _big(gc, '7:42'),
        _kicker(gc, t.unitHours),
      ]),
    );
    return _Collage(
      offset: const Offset(22, -8),
      columns: [
        _stack(20, [steps, level, medal, _iconTile(gc, PhosphorIconsRegular.fire, '520', 'kcal', gc.accent),
            _iconTile(gc, PhosphorIconsRegular.scales, '78,4', 'kg', gc.textSecondary)]),
        _stack(0, [
          passCard,
          heart,
          week,
          _Tile(
            w: 330,
            h: 120,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              for (final i in [2, 3, 4, 5]) Medal(id: AwardId.values[i], size: 70, locked: i == 5),
            ]),
          ),
          _Tile(
            w: 330,
            h: 120,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              for (final (i, v) in const [0.45, 0.8, 0.3, 1.0, 0.0, 0.65, 0.0].indexed) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      height: 8 + 62 * v,
                      decoration: BoxDecoration(
                        color: v == 0 ? gc.bgRaised : (i == 3 ? gc.accent : gc.text.withValues(alpha: 0.55)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(_letter(i + 1), style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary)),
                  ]),
                ),
              ],
            ]),
          ),
        ]),
        _stack(40, [streak, sleep, medalLocked, _iconTile(gc, PhosphorIconsRegular.path, '4,2', 'km', gc.sage),
            _iconTile(gc, PhosphorIconsRegular.trophy, '3', '', gc.brass)]),
      ],
    );
  }
}

class LookShowcase extends StatelessWidget {
  const LookShowcase({super.key});

  static final _levels = [
    for (var i = 0; i < 7 * 16; i++) const [0, 2, 0, 3, 1, 4, 0, 0, 2, 3, 0, 1, 4, 2][(i * 5 + i ~/ 7) % 14],
  ];

  static Widget _blob(Color c, double size) =>
      Container(width: size, height: size, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, now.day - now.weekday + 1 - 7 * 15);
    Widget swatch(GymColors c) => Container(
          width: 34,
          height: 60,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: c.bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: gc.border),
          ),
          child: Column(children: [
            Container(height: 14, decoration: BoxDecoration(color: c.bgRaised, borderRadius: BorderRadius.circular(4))),
            const Spacer(),
            Container(height: 8, decoration: BoxDecoration(color: c.accent, borderRadius: BorderRadius.circular(4))),
          ]),
        );
    final themes = _Tile(
      w: 150,
      h: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          swatch(GymColors.dark),
          swatch(GymColors.amoled),
          swatch(GymColors.light),
        ]),
        const Spacer(),
        _kicker(gc, t.theme),
      ]),
    );
    final units = _Tile(
      w: 150,
      h: 110,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: gc.text, borderRadius: BorderRadius.circular(100)),
              child: Text('kg', style: AppTheme.f(16, weight: FontWeight.w800, color: gc.bg)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('lb', style: AppTheme.f(16, weight: FontWeight.w700, color: gc.textSecondary)),
            ),
          ]),
        ),
      ),
    );
    final text = _Tile(
      w: 150,
      h: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final (size, tone) in [(17.0, gc.textTertiary), (26.0, gc.textSecondary), (37.0, gc.text)])
            Text(_sample, style: AppTheme.f(size, weight: FontWeight.w800, color: tone, height: 1)),
        ],
      ),
    );
    final heat = _lift(Container(
      width: 330,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(24)),
      child: Heatmap(levels: _levels, firstDay: first, labels: true),
    ));
    final languages = _Tile(
      w: 330,
      h: 104,
      child: Wrap(spacing: 8, runSpacing: 8, children: [
        for (final w in const ['Hola', 'Hello', 'Bonjour', 'Hallo', 'Ciao', 'Olá', 'Привет', '你好', 'مرحبا'])
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
            child: Text(w,
                style: AppTheme.f(13, weight: FontWeight.w700, color: w == 'Hola' ? gc.accent : gc.textSecondary)),
          ),
      ]),
    );
    final weekStart = _Tile(
      w: 330,
      h: 84,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (var d = 1; d <= 7; d++)
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: d == 1 ? gc.accent : gc.bgRaised),
            child: Text(_letter(d),
                style: AppTheme.f(12.5, weight: FontWeight.w800, color: d == 1 ? gc.onEmber : gc.textSecondary)),
          ),
      ]),
    );
    final dots = _Tile(
      w: 150,
      h: 150,
      pad: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CustomPaint(painter: _Dots(gc.text.withValues(alpha: 0.18)), child: const SizedBox.expand()),
      ),
    );
    final blur = _Tile(
      w: 150,
      h: 130,
      pad: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Stack(children: [
                Positioned(left: 20, top: 18, child: _blob(gc.accent, 70)),
                Positioned(right: 16, bottom: 10, child: _blob(gc.info, 60)),
              ]),
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: Container(
              height: 26,
              decoration:
                  BoxDecoration(color: gc.text.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(100)),
            ),
          ),
        ]),
      ),
    );
    final motion = _Tile(
      w: 150,
      h: 110,
      child: Center(child: Icon(PhosphorIconsRegular.waveSine, size: 48, color: gc.textSecondary)),
    );
    return _Collage(
      offset: const Offset(22, -8),
      columns: [
        _stack(20, [themes, units, text, _iconTile(gc, PhosphorIconsRegular.translate, 'A文', '', gc.accent),
            _iconTile(gc, PhosphorIconsRegular.clock, '18:30', '24 h', gc.textSecondary)]),
        _stack(0, [
          heat,
          languages,
          weekStart,
          _Tile(
            w: 330,
            h: 110,
            child: Row(children: [
              Icon(PhosphorIconsRegular.calendarDots, size: 26, color: gc.textSecondary),
              const SizedBox(width: 14),
              _big(gc, '12', size: 28),
              const SizedBox(width: 6),
              Expanded(child: _kicker(gc, t.heatRangeSetting)),
            ]),
          ),
          _Tile(
            w: 330,
            h: 120,
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ColoredBox(
                    color: gc.bg,
                    child: CustomPaint(painter: _Dots(gc.text.withValues(alpha: 0.25)), child: const SizedBox.expand()),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(decoration: BoxDecoration(color: gc.bg, borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [gc.accent.withValues(alpha: 0.7), gc.info.withValues(alpha: 0.5), gc.bg],
                    ),
                  ),
                  child: Icon(PhosphorIconsRegular.image, size: 22, color: Colors.white.withValues(alpha: 0.8)),
                ),
              ),
            ]),
          ),
        ]),
        _stack(40, [dots, blur, motion, _iconTile(gc, PhosphorIconsRegular.sunHorizon, '', t.lightTheme, gc.warn),
            _iconTile(gc, PhosphorIconsRegular.moon, '', t.darkTheme, gc.textSecondary)]),
      ],
    );
  }
}

class _Dots extends CustomPainter {
  _Dots(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var y = 12.0; y < size.height; y += 18) {
      for (var x = 12.0; x < size.width; x += 18) {
        canvas.drawCircle(Offset(x, y), 1.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_Dots old) => old.color != color;
}

class _Pulse extends CustomPainter {
  _Pulse(this.values, {required this.line, required this.grid, required this.dotRing});

  final List<double> values;
  final Color line;
  final Color grid;
  final Color dotRing;

  @override
  void paint(Canvas canvas, Size size) {
    final lo = values.reduce((a, b) => a < b ? a : b) - 2;
    final hi = values.reduce((a, b) => a > b ? a : b) + 2;
    const left = 16.0, right = 24.0, top = 8.0, bottom = 14.0;
    final w = size.width - left - right, h = size.height - top - bottom;
    Offset at(int i) => Offset(left + w * i / (values.length - 1), top + h * (1 - (values[i] - lo) / (hi - lo)));
    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (var k = 0; k < 3; k++) {
      final y = top + h * k / 2;
      canvas.drawLine(Offset(left, y), Offset(size.width - right, y), gridPaint);
    }
    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < values.length; i++) {
      final p = at(i - 1), q = at(i);
      final mx = (p.dx + q.dx) / 2;
      path.cubicTo(mx, p.dy, mx, q.dy, q.dx, q.dy);
    }
    final area = Path.from(path)
      ..lineTo(at(values.length - 1).dx, size.height)
      ..lineTo(at(0).dx, size.height)
      ..close();
    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [line.withValues(alpha: 0.32), line.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    final end = at(values.length - 1);
    canvas.drawCircle(end, 9, Paint()..color = line.withValues(alpha: 0.22));
    canvas.drawCircle(end, 5.5, Paint()..color = line);
    canvas.drawCircle(end, 2.5, Paint()..color = dotRing);
  }

  @override
  bool shouldRepaint(_Pulse old) => old.line != line || old.grid != grid;
}
