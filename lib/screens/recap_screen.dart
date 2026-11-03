import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../catalog/awards.dart';
import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../services/food_library.dart';
import '../services/health_metrics.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/body_map.dart';
import '../widgets/exercise_media.dart';
import '../widgets/exercise_preview.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/medal.dart';
import '../widgets/medal_shelf.dart';
import '../widgets/name_ticker.dart';
import '../widgets/nutrition_art.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/ui_kit.dart';

const double kRecapAvatar = 150;

double recapAvatarY(Size size) => size.height * 0.4;

Future<void> openRecap(BuildContext context) async {
  if (fit.nutritionBeta && !FoodLibrary.ready) await FoodLibrary.load();
  if (!context.mounted) return;
  await Navigator.of(context).push(PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 380),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => const RecapScreen(),
      transitionsBuilder: (_, a, _, child) =>
          FadeTransition(opacity: CurvedAnimation(parent: a, curve: Curves.easeOut), child: child),
    ));
}

enum _Page { hello, workouts, time, volume, peak, lift, fresh, muscle, records, medals, cardio, steps, sleep, food, habit, share }

TextStyle _num(double size, Color color) => AppTheme.f(size,
        weight: FontWeight.w900, color: color, letterSpacing: -size * 0.045, height: 1)
    .copyWith(fontFeatures: const [ui.FontFeature.tabularFigures()]);

class StoryRings extends StatefulWidget {
  const StoryRings({super.key, required this.size, required this.color, this.ring = true});

  final double size;
  final Color color;
  final bool ring;

  @override
  State<StoryRings> createState() => _StoryRingsState();
}

class _StoryRingsState extends State<StoryRings> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1250))..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = widget.size + 200;
    return IgnorePointer(
      child: SizedBox(
        width: box,
        height: box,
        child: RepaintBoundary(
          child: CustomPaint(painter: _RingsPainter(_c, widget.size, widget.color, widget.ring)),
        ),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  _RingsPainter(this.a, this.size, this.color, this.ring) : super(repaint: a);

  final Animation<double> a;
  final double size;
  final Color color;
  final bool ring;

  @override
  void paint(Canvas canvas, Size box) {
    final c = box.center(Offset.zero);
    final base = size / 2 + 7;
    for (var i = 0; i < 2; i++) {
      final start = i * 0.24;
      final v = ((a.value - start) / (1 - start)).clamp(0.0, 1.0);
      if (v <= 0 || v >= 1) continue;
      final e = Curves.easeOutCubic.transform(v);
      canvas.drawCircle(
        c,
        base + 58 * e,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4 * (1 - e) + 0.5
          ..color = color.withValues(alpha: (1 - v) * (i == 0 ? 0.4 : 0.22)),
      );
    }
    if (ring) {
      final show = Curves.easeOut.transform((a.value / 0.35).clamp(0.0, 1.0));
      canvas.drawCircle(
        c,
        base,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..color = color.withValues(alpha: 0.5 * show),
      );
    }
  }

  @override
  bool shouldRepaint(_RingsPainter old) => old.size != size || old.color != color || old.ring != ring;
}

class _Count extends StatelessWidget {
  const _Count(this.value, {required this.style, this.format, this.delay = 0, this.duration = 1500});

  final double value;
  final TextStyle style;
  final String Function(double v)? format;
  final int delay;
  final int duration;

  @override
  Widget build(BuildContext context) {
    final total = delay + duration;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutExpo),
      builder: (_, v, _) => Text(format?.call(v) ?? '${v.round()}', style: style),
    );
  }
}

class _Enter extends StatelessWidget {
  const _Enter({required this.child, this.delay = 0, this.from = 18});

  final Widget child;
  final int delay;
  final double from;

  @override
  Widget build(BuildContext context) {
    final total = delay + 520;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutCubic),
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, from * (1 - v)), child: child),
      ),
      child: child,
    );
  }
}

class _Pop extends StatelessWidget {
  const _Pop({required this.child, this.delay = 0});

  final Widget child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final total = delay + 560;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutBack),
      builder: (_, v, child) => Opacity(
        opacity: v.clamp(0.0, 1.0),
        child: Transform.scale(scale: 0.4 + 0.6 * v, child: child),
      ),
      child: child,
    );
  }
}

class RecapScreen extends StatefulWidget {
  const RecapScreen({super.key});

  @override
  State<RecapScreen> createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  late final MonthRecap _recap = fit.recapFor(fit.recapMonth);
  late final MonthRecap _prev = fit.recapFor(DateTime(_recap.month.year, _recap.month.month - 1));
  late final Exercise? _lift = _recap.lift == null ? null : fit.exerciseById(_recap.lift!.id);
  late final _extras = recapExtras(_recap);
  late final List<String> _wall = recapWallIds(_recap);
  late final List<_Page> _pages = [
    _Page.hello,
    if (!_recap.empty) ...[
      _Page.workouts,
      _Page.time,
      if (_recap.volumeKg > 0) _Page.volume,
      if (_extras.peak != null) _Page.peak,
      if (_lift != null) _Page.lift,
      if (_extras.fresh.isNotEmpty) _Page.fresh,
      if (_recap.topMuscle != null) _Page.muscle,
      _Page.records,
      if (_extras.medals.isNotEmpty) _Page.medals,
      if (_extras.cardio != null) _Page.cardio,
      if (_extras.steps != null) _Page.steps,
      if (_extras.sleep != null) _Page.sleep,
      if (_extras.food != null) _Page.food,
      if (_recap.favDay != null) _Page.habit,
      _Page.share,
    ],
  ];
  final _cards = [GlobalKey(), GlobalKey(), GlobalKey()];
  final _variants = PageController(viewportFraction: 0.8);
  final _pager = PageController();
  int _variant = 0;
  int _at = 0;
  double _pulled = 0;
  bool _busy = false;

  String get _month => t.monthInline(_recap.month.month);
  String get _prevMonth => t.monthInline(_prev.month.month);

  @override
  void dispose() {
    _variants.dispose();
    _pager.dispose();
    super.dispose();
  }

  void _go(int to) {
    if (to < 0 || to >= _pages.length || !_pager.hasClients) return;
    _pager.animateToPage(to, duration: const Duration(milliseconds: 420), curve: Curves.easeOutCubic);
  }

  void _tap(TapUpDetails d, double width) {
    final page = _pages[_at];
    if (page == _Page.share || (page == _Page.hello && _recap.empty)) return;
    final at = _pager.hasClients ? (_pager.page ?? _at.toDouble()).round() : _at;
    _go(d.localPosition.dx < width * 0.3 ? at - 1 : at + 1);
  }

  bool _scrolled(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    if (n is ScrollStartNotification) _pulled = 0;
    if (n is OverscrollNotification && n.dragDetails != null && n.overscroll < 0 && _at == 0) {
      _pulled -= n.overscroll;
      if (_pulled > 60) {
        _pulled = -double.infinity;
        Navigator.of(context).maybePop();
      }
    }
    return false;
  }

  void _openExercise(Exercise ex) => showExercisePreview(context, ex);

  String _tickerText(_Page page) => switch (page) {
        _Page.hello => fit.displayName,
        _Page.workouts => t.recapTickWorkouts,
        _Page.time => t.recapTickTime,
        _Page.volume => t.recapTickVolume,
        _Page.peak => t.recapTickPeak,
        _Page.lift => _lift == null ? '' : exerciseName(_lift),
        _Page.fresh => t.recapTickFresh,
        _Page.muscle => muscleLabel(_recap.topMuscle ?? ''),
        _Page.records => t.recapTickRecords,
        _Page.medals => t.recapTickMedals,
        _Page.cardio => 'Cardio',
        _Page.steps => t.recapTickSteps,
        _Page.sleep => t.recapTickSleep,
        _Page.food => t.recapTickFood,
        _Page.habit => t.weekday(_recap.favDay ?? 1),
        _Page.share => 'GymMane',
      };

  Future<void> _share() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final boundary = _cards[_variant].currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 1080 / boundary.size.width);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (data == null) return;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/gymmane-${_recap.month.year}-${_recap.month.month}-$_variant.png');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      if (!mounted) return;
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], subject: 'GymMane'));
    } catch (_) {
      if (mounted) {
        showNotchToast(context, t.shareFailed, icon: PhosphorIconsFill.warningCircle, accent: context.gc.warn);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final pad = MediaQuery.paddingOf(context);
    final size = MediaQuery.sizeOf(context);
    final page = _pages[_at];
    return Scaffold(
      backgroundColor: gc.bg,
      body: Stack(children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 520),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _backdrop(gc, page),
          ),
        ),
        Positioned.fill(
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrolled,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (d) => _tap(d, size.width),
              child: PageView.builder(
                controller: _pager,
                scrollDirection: Axis.vertical,
                physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
                itemCount: _pages.length,
                onPageChanged: (i) {
                  HapticFeedback.selectionClick();
                  setState(() => _at = i);
                },
                itemBuilder: (context, i) => AnimatedBuilder(
                  animation: _pager,
                  child: _slot(gc, size, pad, _pages[i]),
                  builder: (context, child) {
                    final at = _pager.hasClients && _pager.position.haveDimensions
                        ? _pager.page ?? _at.toDouble()
                        : _at.toDouble();
                    final d = (at - i).abs().clamp(0.0, 1.0);
                    return Opacity(
                      opacity: 1 - Curves.easeIn.transform(d) * 0.9,
                      child: Transform.scale(scale: 1 - 0.06 * d, child: child),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 14,
          top: pad.top + 8,
          child: Row(children: [
            Expanded(
              child: Text(t.monthYear(_recap.month).toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(10.5, weight: FontWeight.w800, color: gc.textTertiary, letterSpacing: 1.6)),
            ),
            _CloseButton(onTap: () => Navigator.of(context).maybePop()),
          ]),
        ),
        if (_pages.length > 1)
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: IgnorePointer(child: Center(child: _rail(gc))),
          ),
      ]),
    );
  }

  Widget _backdrop(GymColors gc, _Page page) {
    if (page == _Page.lift && _wall.isNotEmpty) return _ExerciseWall(key: const ValueKey('wall'), ids: _wall);
    final text = _tickerText(page);
    return NameTicker(
      key: ValueKey('$text$page'),
      text: text,
      color: gc.text.withValues(alpha: 0.06),
      rows: 0,
    );
  }

  Widget _slot(GymColors gc, Size size, EdgeInsets pad, _Page page) {
    if (page == _Page.hello) return Stack(children: _hello(gc, size));
    final side = page == _Page.share ? 0.0 : 24.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(side, pad.top + 60, page == _Page.share ? 0 : 34, pad.bottom + 24),
      child: _page(gc, page, gc.accent),
    );
  }

  Widget _rail(GymColors gc) => Column(mainAxisSize: MainAxisSize.min, children: [
        for (var i = 0; i < _pages.length; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(vertical: 3),
            width: 4,
            height: i == _at ? 22 : 6,
            decoration: BoxDecoration(
              color: i == _at ? gc.text : (i < _at ? gc.textSecondary : gc.bgRaised2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ]);

  Widget _kicker(String text, Color tone) => _Enter(
        child: Text(text.toUpperCase(), style: AppTheme.f(11, weight: FontWeight.w800, color: tone, letterSpacing: 1.8)),
      );

  Widget _line(GymColors gc, String text, {Color? color, int delay = 900}) => _Enter(
        delay: delay,
        child: Text(text, style: AppTheme.f(16, weight: FontWeight.w600, color: color ?? gc.textSecondary, height: 1.4)),
      );

  Widget _bigRow(List<Widget> parts) => FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: parts),
      );

  Widget _unit(String text, double size, Color tone) => Padding(
        padding: const EdgeInsets.only(left: 6, right: 14),
        child: Text(text, style: AppTheme.f(size * 0.3, weight: FontWeight.w800, color: tone)),
      );

  Widget _bottom(List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      );

  Widget _versus(GymColors gc, Color tone, double now, double before, String Function(double) say) {
    if (_prev.empty) return const SizedBox.shrink();
    final diff = now - before;
    final up = diff > 0.0001;
    final same = diff.abs() <= 0.0001;
    return _Enter(
      delay: 1200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(same ? PhosphorIconsBold.equals : (up ? PhosphorIconsBold.arrowUp : PhosphorIconsBold.arrowDown),
              size: 12, color: tone),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              same
                  ? t.recapSameAs(_prevMonth)
                  : (up ? t.recapMoreThan(say(diff.abs()), _prevMonth) : t.recapLessThan(say(diff.abs()), _prevMonth)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(12.5, weight: FontWeight.w800, color: tone),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _page(GymColors gc, _Page page, Color tone) => switch (page) {
        _Page.hello => const SizedBox.shrink(),
        _Page.workouts => _WorkoutsPage(
            recap: _recap,
            tone: tone,
            kicker: _kicker(t.recapWorkoutsKicker, tone),
            versus: _versus(gc, tone, _recap.workouts.toDouble(), _prev.workouts.toDouble(), (v) => '${v.round()}'),
            notes: [
              if (_extras.streak >= 2) t.recapStreak(_extras.streak),
              if (_extras.yearAgo > 0) t.recapYearAgo(_extras.yearAgo),
            ],
          ),
        _Page.time => _time(gc, tone),
        _Page.volume => _volume(gc, tone),
        _Page.peak => _peakPage(gc, tone),
        _Page.lift => _liftPage(gc, tone),
        _Page.fresh => _freshPage(gc, tone),
        _Page.muscle => _muscle(gc, tone),
        _Page.records => _records(gc, tone),
        _Page.medals => _medals(gc, tone),
        _Page.cardio => _cardio(gc, tone),
        _Page.steps => _stepsPage(gc, tone),
        _Page.sleep => _sleepPage(gc, tone),
        _Page.food => _food(gc, tone),
        _Page.habit => _habit(gc, tone),
        _Page.share => _sharePage(gc, tone),
      };

  List<Widget> _hello(GymColors gc, Size size) {
    final first = fit.displayName.split(' ').first;
    final y = recapAvatarY(size);
    return [
      Positioned(
        left: (size.width - kRecapAvatar - 200) / 2,
        top: y - (kRecapAvatar + 200) / 2,
        child: const StoryRings(size: kRecapAvatar, color: Colors.white),
      ),
      Positioned(
        left: (size.width - kRecapAvatar) / 2,
        top: y - kRecapAvatar / 2,
        child: const ProfileAvatar(size: kRecapAvatar),
      ),
      Positioned(
        left: 28,
        right: 28,
        top: y + kRecapAvatar / 2 + 34,
        child: Column(children: [
          _Enter(
            delay: 200,
            child: Text(t.recapHi(first),
                textAlign: TextAlign.center,
                style: AppTheme.f(40, weight: FontWeight.w900, color: gc.text, letterSpacing: -1.2)),
          ),
          const SizedBox(height: 10),
          _Enter(
            delay: 420,
            child: Text(_recap.empty ? t.recapEmpty(_month) : t.recapReady(_month),
                textAlign: TextAlign.center,
                style: AppTheme.f(16, weight: FontWeight.w600, color: gc.textSecondary, height: 1.4)),
          ),
          const SizedBox(height: 28),
          _Enter(
            delay: 650,
            child: SizedBox(
              width: 200,
              child: _recap.empty
                  ? PrimaryButton(label: t.recapClose, onTap: () => Navigator.of(context).maybePop())
                  : PrimaryButton(label: t.recapGo, onTap: () => _go(1)),
            ),
          ),
        ]),
      ),
    ];
  }

  Widget _time(GymColors gc, Color tone) {
    final h = _recap.seconds ~/ 3600;
    final m = (_recap.seconds % 3600) ~/ 60;
    final mins = _recap.sessionMinutes;
    final top = mins.fold(1, math.max);
    final longest = _recap.longest;
    return _bottom([
      _kicker(t.recapTimeKicker, tone),
      const SizedBox(height: 6),
      _bigRow([
        if (h > 0) ...[
          _Count(h.toDouble(), style: _num(112, gc.text)),
          _unit('h', 112, tone),
        ],
        _Count(m.toDouble(), style: _num(112, gc.text), delay: h > 0 ? 350 : 0),
        _unit('min', 112, tone),
      ]),
      const SizedBox(height: 14),
      _versus(gc, tone, _recap.seconds / 3600, _prev.seconds / 3600, (v) => '${fmt((v * 10).round() / 10)} h'),
      const SizedBox(height: 22),
      SizedBox(
        height: 96,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (var i = 0; i < mins.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: mins[i] / top),
                duration: Duration(milliseconds: 700 + i * 45),
                curve: Interval(math.min(0.7, i * 45 / (700 + i * 45)), 1, curve: Curves.easeOutBack),
                builder: (_, v, _) => Container(
                  height: 6 + 88 * v.clamp(0.0, 1.08),
                  decoration: BoxDecoration(
                    color: mins[i] == top ? gc.text : gc.text.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ]),
      ),
      const SizedBox(height: 18),
      _line(gc, t.recapAvg(_recap.avgMinutes), color: gc.text),
      if (longest != null && longest.durationSec > 0) ...[
        const SizedBox(height: 4),
        _line(gc, t.recapLongest('${longest.durationSec ~/ 60} min', t.shortDate(longest.day)), delay: 1100),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _volume(GymColors gc, Color tone) {
    final cars = (_recap.volumeKg / 1500).floor();
    final shown = math.min(cars, 14);
    final top = _recap.topExercise == null ? null : fit.exerciseById(_recap.topExercise!);
    return _bottom([
      _kicker(t.recapVolumeKicker, tone),
      const SizedBox(height: 6),
      _bigRow([
        _Count(_recap.volumeKg, style: _num(112, gc.text), format: fit.volumeValue, duration: 1800),
        _unit(fit.volumeUnit, 112, tone),
      ]),
      const SizedBox(height: 14),
      _versus(gc, tone, _recap.volumeKg, _prev.volumeKg, fit.volumeLabel),
      const SizedBox(height: 24),
      if (shown > 0) ...[
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (var i = 0; i < shown; i++)
            _Pop(delay: 700 + i * 90, child: Icon(PhosphorIconsFill.car, size: 26, color: gc.text)),
        ]),
        const SizedBox(height: 12),
        _line(gc, t.recapCars(cars, groupedInt(cars)), color: gc.text, delay: 1300),
      ],
      if (top != null) ...[
        const SizedBox(height: 4),
        _line(gc, t.recapTop(exerciseName(top), fit.volumeLabel(_recap.topExerciseKg)), delay: 1500),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _chip(GymColors gc, Widget value, String label, int delay) => Expanded(
        child: _Enter(
          delay: delay,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FittedBox(fit: BoxFit.scaleDown, alignment: AlignmentDirectional.centerStart, child: value),
            const SizedBox(height: 4),
            Text(label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(9.5, weight: FontWeight.w800, color: gc.textTertiary, letterSpacing: 1.2)),
          ]),
        ),
      );

  Widget _peakPage(GymColors gc, Color tone) {
    final s = _extras.peak!;
    final exs = [for (final e in s.exercises) ?fit.exerciseById(e.id)];
    final name = s.name?.trim() ?? '';
    return _bottom([
      _kicker(t.recapPeakKicker, tone),
      const SizedBox(height: 6),
      _Enter(
        delay: 100,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(t.shortDate(s.day),
              style: AppTheme.f(80, weight: FontWeight.w900, color: gc.text, letterSpacing: -3, height: 1)),
        ),
      ),
      const SizedBox(height: 6),
      _Enter(
        delay: 250,
        child: Text(name.isEmpty ? t.weekday(s.day.weekday) : '${t.weekday(s.day.weekday)} · $name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(20, weight: FontWeight.w800, color: gc.textSecondary)),
      ),
      const SizedBox(height: 26),
      Row(children: [
        _chip(gc, _Count(s.volume, style: _num(34, gc.text), delay: 350, format: fit.volumeValue),
            '${t.statLifted} · ${fit.volumeUnit}', 350),
        _chip(gc, _Count((s.durationSec ~/ 60).toDouble(), style: _num(34, gc.text), delay: 500), '${t.duration} · min',
            500),
        _chip(gc, _Count(s.setCount.toDouble(), style: _num(34, gc.text), delay: 650), t.setsCaps, 650),
      ]),
      if (exs.isNotEmpty) ...[
        const SizedBox(height: 22),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final (i, ex) in exs.take(6).indexed)
            _Pop(
              delay: 800 + i * 90,
              child: Pressable(
                onTap: () => _openExercise(ex),
                child: SizedBox(width: 48, child: ExerciseMedia(ex: ex, height: 48, radius: 12, bordered: false)),
              ),
            ),
        ]),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _freshPage(GymColors gc, Color tone) {
    final exs = [for (final id in _extras.fresh) ?fit.exerciseById(id)];
    final shown = exs.take(6).toList();
    return _bottom([
      _kicker(t.recapFreshKicker, tone),
      const SizedBox(height: 6),
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        _Count(exs.length.toDouble(), style: _num(112, gc.text), duration: 900),
        const SizedBox(width: 10),
        Flexible(
          child: Text(t.recapFresh(exs.length),
              maxLines: 2,
              style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.6, height: 1.05)),
        ),
      ]),
      const SizedBox(height: 22),
      LayoutBuilder(builder: (context, box) {
        final tile = (box.maxWidth - 20) / 3;
        return Wrap(spacing: 10, runSpacing: 14, children: [
          for (final (i, ex) in shown.indexed)
            _Pop(
              delay: 400 + i * 110,
              child: Pressable(
                onTap: () => _openExercise(ex),
                child: SizedBox(
                  width: tile,
                  child: Column(children: [
                    ExerciseMedia(ex: ex, height: tile, radius: 18, bordered: false),
                    const SizedBox(height: 6),
                    Text(exerciseName(ex),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary, height: 1.2)),
                  ]),
                ),
              ),
            ),
        ]);
      }),
      if (exs.length > shown.length) ...[
        const SizedBox(height: 10),
        _line(gc, t.recapMedalsMore(exs.length - shown.length), delay: 1200),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _liftPage(GymColors gc, Color tone) {
    final ex = _lift!;
    final l = _recap.lift!;
    final rest = [
      for (final r in _recap.topLifts.where((r) => r.id != l.id).take(4))
        if (fit.exerciseById(r.id) case final e?) (ex: e, sets: r.sets),
    ];
    Widget chip(Widget value, String label, int delay) => _chip(gc, value, label, delay);
    return _bottom([
      _kicker(t.recapLiftKicker, tone),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        _Pop(
          child: Pressable(
            onTap: () => _openExercise(ex),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                border: Border.all(color: gc.border, width: 1.5),
              ),
              child: SizedBox(width: 170, child: ExerciseMedia(ex: ex, height: 170, radius: 26, live: true)),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _Enter(
            delay: 150,
            child: Text(exerciseName(ex),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(24, weight: FontWeight.w900, color: gc.text, letterSpacing: -0.6, height: 1.05)),
          ),
        ),
      ]),
      const SizedBox(height: 18),
      Row(children: [
        chip(_Count(l.sets.toDouble(), style: _num(34, gc.text), delay: 300), t.setsCaps, 300),
        if (l.bestKg > 0)
          chip(
              _Count(l.bestKg,
                  style: _num(34, gc.text), delay: 450, format: (v) => fit.weightLabel(v).split(' ').first),
              '${t.recapBest} · ${fit.units}',
              450),
        chip(_Count(l.times.toDouble(), style: _num(34, gc.text), delay: 600), t.recapTimes, 600),
      ]),
      if (rest.isNotEmpty) ...[
        const SizedBox(height: 20),
        _Enter(
          delay: 750,
          child: Text(t.recapLiftRest.toUpperCase(),
              style: AppTheme.f(10, weight: FontWeight.w800, color: gc.textTertiary, letterSpacing: 1.6)),
        ),
        const SizedBox(height: 10),
        for (final (i, r) in rest.indexed)
          _Enter(
            delay: 850 + i * 120,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openExercise(r.ex),
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: [
                SizedBox(width: 20, child: Text('${i + 2}', style: _num(18, tone).copyWith(letterSpacing: 0))),
                const SizedBox(width: 8),
                SizedBox(width: 38, child: ExerciseMedia(ex: r.ex, height: 38, radius: 10, bordered: false)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(exerciseName(r.ex),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                ),
                const SizedBox(width: 10),
                Text(t.setCount(r.sets), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
              ]),
            ),
            ),
          ),
      ],
      const SizedBox(height: 16),
    ]);
  }

  Widget _muscle(GymColors gc, Color tone) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Spacer(),
      Center(
        child: _Enter(
          from: 30,
          child: LayoutBuilder(
            builder: (context, box) => BodyHeatArt(gc: gc, intensity: _recap.heat, width: math.min(box.maxWidth, 320)),
          ),
        ),
      ),
      const SizedBox(height: 30),
      _kicker(t.recapMuscleKicker, tone),
      const SizedBox(height: 6),
      _Enter(
        delay: 200,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(muscleLabel(_recap.topMuscle ?? ''),
              style: AppTheme.f(56, weight: FontWeight.w900, color: gc.text, letterSpacing: -2, height: 1)),
        ),
      ),
      const SizedBox(height: 10),
      _Count(_recap.topMuscleSets.toDouble(),
          style: AppTheme.f(16, weight: FontWeight.w700, color: tone),
          delay: 500,
          format: (v) => t.setCount(v.round())),
      if (_extras.forgot case final m?) ...[
        const SizedBox(height: 6),
        _line(gc, t.recapForgot(muscleLabel(m)), delay: 1000),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _records(GymColors gc, Color tone) {
    final list = _recap.records.take(4).toList();
    return _bottom([
      _kicker(t.recapRecordsKicker, tone),
      const SizedBox(height: 6),
      _Count(_recap.records.length.toDouble(), style: _num(112, gc.text), duration: 900),
      const SizedBox(height: 18),
      if (list.isEmpty)
        _line(gc, t.recapNoRecords(_recap.sets))
      else
        for (final (i, r) in list.indexed)
          _Enter(
            delay: 500 + i * 180,
            child: Pressable(
              onTap: fit.exerciseById(r.id) == null ? null : () => _openExercise(fit.exerciseById(r.id)!),
              child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                Icon(PhosphorIconsRegular.trophy, size: 18, color: gc.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(fit.exerciseById(r.id) == null ? r.id : exerciseName(fit.exerciseById(r.id)!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
                ),
                const SizedBox(width: 10),
                _Count(r.kg,
                    style: _num(18, gc.text).copyWith(letterSpacing: 0), delay: 600 + i * 180, format: fit.weightLabel),
              ]),
            ),
            ),
          ),
      const SizedBox(height: 30),
    ]);
  }

  Widget _medals(GymColors gc, Color tone) {
    final won = _extras.medals;
    final shown = won.take(9).toList();
    return _bottom([
      _kicker(t.recapMedalsKicker, tone),
      const SizedBox(height: 6),
      _Count(won.length.toDouble(), style: _num(112, gc.text), duration: 900),
      const SizedBox(height: 22),
      Wrap(spacing: 14, runSpacing: 14, children: [
        for (final (i, id) in shown.indexed)
          _Pop(
            delay: 400 + i * 120,
            child: Pressable(
              onTap: () => showMedalSheet(context, id),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
              Medal(id: id, size: 74),
              const SizedBox(height: 6),
              SizedBox(
                width: 80,
                child: Text(awardName(id),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textSecondary, height: 1.2)),
              ),
            ]),
            ),
          ),
      ]),
      if (won.length > shown.length) ...[
        const SizedBox(height: 10),
        _line(gc, t.recapMedalsMore(won.length - shown.length), delay: 1400),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _cardio(GymColors gc, Color tone) {
    final c = _extras.cardio!;
    final top = c.topId == null ? null : fit.exerciseById(c.topId!);
    return _bottom([
      _kicker(t.recapCardioKicker, tone),
      const SizedBox(height: 6),
      if (c.km > 0)
        _bigRow([
          _Count(c.km, style: _num(112, gc.text), format: fit.distanceValue, duration: 1700),
          _unit(fit.distanceUnit, 112, tone),
        ])
      else
        _bigRow([
          _Count(c.sec / 60, style: _num(112, gc.text)),
          _unit('min', 112, tone),
        ]),
      const SizedBox(height: 22),
      _Route(progress: 1, color: gc.text, track: gc.bgRaised2),
      const SizedBox(height: 22),
      if (c.km > 0) _line(gc, t.recapCardioTime(c.sec ~/ 60, c.count), color: gc.text),
      if (c.km <= 0) _line(gc, t.recapCardioCount(c.count), color: gc.text),
      if (top != null) ...[
        const SizedBox(height: 4),
        _line(gc, t.recapCardioTop(exerciseName(top)), delay: 1100),
      ],
      const SizedBox(height: 30),
    ]);
  }

  Widget _stepsPage(GymColors gc, Color tone) {
    final s = _extras.steps!;
    final group = MaterialLocalizations.of(context);
    return _bottom([
      _kicker(t.recapStepsKicker, tone),
      const SizedBox(height: 6),
      _bigRow([
        _Count(s.total.toDouble(),
            style: _num(96, gc.text), format: (v) => group.formatDecimal(v.round()), duration: 1800),
      ]),
      Text(t.recapStepsWord, style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.6)),
      const SizedBox(height: 24),
      _MonthChart(values: s.perDay, avg: s.avg, month: _recap.month, tone: gc.text, label: gc.textTertiary),
      const SizedBox(height: 18),
      _line(gc, t.recapStepsAvg(group.formatDecimal(s.avg)), color: gc.text),
      const SizedBox(height: 4),
      _line(gc, t.recapStepsBest(group.formatDecimal(s.best), t.shortDate(s.bestDay)), delay: 1100),
      const SizedBox(height: 30),
    ]);
  }

  Widget _sleepPage(GymColors gc, Color tone) {
    final s = _extras.sleep!;
    return _bottom([
      _kicker(t.recapSleepKicker, tone),
      const SizedBox(height: 6),
      _bigRow([
        _Count((s.avg ~/ 60).toDouble(), style: _num(112, gc.text)),
        _unit('h', 112, tone),
        _Count((s.avg % 60).toDouble(), style: _num(112, gc.text), delay: 300),
        _unit('min', 112, tone),
      ]),
      Text(t.recapSleepAvg, style: AppTheme.f(20, weight: FontWeight.w800, color: gc.textSecondary)),
      const SizedBox(height: 24),
      _MonthChart(values: s.perNight, avg: s.avg, month: _recap.month, tone: gc.text, label: gc.textTertiary),
      const SizedBox(height: 18),
      _line(gc, t.recapSleepBest('${s.best ~/ 60} h ${s.best % 60} min', t.shortDate(s.bestDay)), color: gc.text),
      const SizedBox(height: 30),
    ]);
  }

  Widget _food(GymColors gc, Color tone) {
    final f = _extras.food!;
    final star = f.star;
    final rest = f.top.where((e) => e.name != star).take(3).toList();
    final group = MaterialLocalizations.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: LayoutBuilder(
          builder: (context, box) {
            final size = math.min(250.0, math.min(box.maxWidth, box.maxHeight) - 16);
            if (size < 120 || f.top.isEmpty) return const SizedBox.shrink();
            return Center(
              child: _Enter(
                from: 26,
                child: FoodPlate(
                  size: size,
                  items: [for (final e in f.top) (e.photo, e.name)],
                  wrap: (i, child) => _Enter(delay: 260 + i * 140, from: -24, child: child),
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 18),
      _kicker(star == null ? t.recapFoodKicker : t.recapFoodStarKicker, tone),
      const SizedBox(height: 8),
      if (star != null) ...[
        _Enter(
          delay: 150,
          child: Text(star,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(40, weight: FontWeight.w900, color: gc.text, letterSpacing: -1.2, height: 1.02)),
        ),
        const SizedBox(height: 6),
        _Enter(
          delay: 260,
          child: Text(t.recapFoodStarDays(f.starTimes),
              style: AppTheme.f(18, weight: FontWeight.w800, color: gc.textSecondary)),
        ),
      ] else ...[
        _bigRow([
          _Count(f.protein.toDouble(), style: _num(96, gc.text)),
          _unit('g', 96, tone),
        ]),
        Text(t.recapFoodProtein(f.goal), style: AppTheme.f(18, weight: FontWeight.w800, color: gc.textSecondary)),
      ],
      const SizedBox(height: 22),
      Row(children: [
        if (star != null)
          _chip(gc, _Count(f.protein.toDouble(), style: _num(30, gc.text), delay: 400), t.recapFoodProteinLabel, 400),
        _chip(gc, Text('${f.hit}/${f.days}', style: _num(30, gc.text)), t.recapFoodGoalDays, 550),
        if (f.water > 0)
          _chip(gc, Text(fit.waterValue(f.water), style: _num(30, gc.text)), '${t.recapFoodWaterLabel} · ${fit.waterUnit}',
              700)
        else
          _chip(gc, Text(group.formatDecimal(fit.energyOf(f.kcal)), style: _num(30, gc.text)),
              '${fit.energyUnit} · ${t.recapAvgLabel}', 700),
      ]),
      if (rest.isNotEmpty) ...[
        const SizedBox(height: 18),
        for (final (i, r) in rest.indexed)
          _Enter(
            delay: 850 + i * 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: [
                FoodSticker(photo: r.photo, name: r.name, size: 38, tilt: false, shadow: false),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(r.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                ),
                const SizedBox(width: 10),
                Text(t.recapFoodTimes(r.days), style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
              ]),
            ),
          ),
      ],
      const SizedBox(height: 24),
    ]);
  }

  Widget _habit(GymColors gc, Color tone) {
    final start = _recap.usualStart;
    final days = _recap.weekdays;
    final top = days.fold(1, math.max);
    final order = [for (var i = 0; i < 7; i++) (fit.weekStartDay - 1 + i) % 7 + 1];
    return _bottom([
      _kicker(t.recapHabitKicker, tone),
      const SizedBox(height: 6),
      _Enter(
        delay: 100,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(t.weekday(_recap.favDay ?? 1),
              style: AppTheme.f(72, weight: FontWeight.w900, color: gc.text, letterSpacing: -3, height: 1)),
        ),
      ),
      const SizedBox(height: 26),
      SizedBox(
        height: 120,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          for (final (i, d) in order.indexed) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: days[d - 1] / top),
                  duration: Duration(milliseconds: 800 + i * 70),
                  curve: Interval(i * 70 / (800 + i * 70), 1, curve: Curves.easeOutBack),
                  builder: (_, v, _) => Container(
                    height: 6 + 84 * v.clamp(0.0, 1.08),
                    decoration: BoxDecoration(
                      color: d == _recap.favDay ? gc.text : gc.text.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(t.weekdayInitial(d),
                    style: AppTheme.f(12, weight: FontWeight.w800, color: d == _recap.favDay ? gc.text : gc.textTertiary)),
              ]),
            ),
          ],
        ]),
      ),
      const SizedBox(height: 18),
      if (start != null)
        _line(
            gc,
            t.recapHabitStart(MaterialLocalizations.of(context).formatTimeOfDay(
                TimeOfDay(hour: start ~/ 60, minute: start % 60),
                alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context))),
            color: gc.text),
      const SizedBox(height: 30),
    ]);
  }

  Widget _sharePage(GymColors gc, Color tone) {
    final names = [t.recapCardSummary, t.recapCardCalendar, t.recapCardLift];
    return Column(children: [
      _kicker(t.recapShareKicker, tone),
      const SizedBox(height: 14),
      Expanded(
        child: PageView.builder(
          controller: _variants,
          itemCount: 3,
          onPageChanged: (i) {
            HapticFeedback.selectionClick();
            setState(() => _variant = i);
          },
          itemBuilder: (context, i) => AnimatedScale(
            scale: i == _variant ? 1 : 0.9,
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            child: Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: gc.text.withValues(alpha: 0.14)),
                  ),
                  child: FittedBox(
                    child: RepaintBoundary(
                      key: _cards[i],
                      child: RecapCard(recap: _recap, variant: i),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 14),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(names[_variant],
            key: ValueKey(_variant), style: AppTheme.f(13, weight: FontWeight.w800, color: gc.textSecondary)),
      ),
      const SizedBox(height: 8),
      Row(mainAxisSize: MainAxisSize.min, children: [
        for (var i = 0; i < 3; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == _variant ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == _variant ? gc.text : gc.bgRaised2,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ]),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: PrimaryButton(label: t.recapShare, onTap: _share),
      ),
    ]);
  }
}

typedef RecapExtras = ({
  ({double km, int sec, int count, String? topId})? cardio,
  ({int total, int avg, int best, DateTime bestDay, List<int> perDay})? steps,
  ({int avg, int best, DateTime bestDay, List<int> perNight})? sleep,
  ({
    int days,
    int kcal,
    int protein,
    int goal,
    int hit,
    List<({String name, String photo, int days})> top,
    String? star,
    int starTimes,
    int water,
  })? food,
  List<AwardId> medals,
  LoggedSession? peak,
  List<String> fresh,
  int streak,
  int yearAgo,
  String? forgot,
});

List<String> recapWallIds(MonthRecap recap) {
  final ids = <String>[...recap.exerciseIds.where((id) => fit.exerciseById(id) != null)];
  if (ids.length < 8) {
    for (final s in fit.sessions.reversed) {
      if (!s.day.isBefore(recap.month)) continue;
      for (final e in s.exercises) {
        if (!ids.contains(e.id) && fit.exerciseById(e.id) != null) ids.add(e.id);
      }
      if (ids.length >= 12) break;
    }
  }
  if (ids.isNotEmpty && ids.length < 10) {
    final muscles = {for (final id in ids) fit.exerciseById(id)!.primary};
    for (final e in fit.allExercises) {
      if (ids.length >= 10) break;
      if (e.art.isNotEmpty && muscles.contains(e.primary) && !ids.contains(e.id)) ids.add(e.id);
    }
  }
  return ids;
}

RecapExtras recapExtras(MonthRecap recap) {
  final from = recap.month;
  final to = DateTime(from.year, from.month + 1);
  final today = DateTime.now();
  final days = [
    for (var d = from; d.isBefore(to) && !d.isAfter(today); d = DateTime(d.year, d.month, d.day + 1)) d,
  ];

  var km = 0.0;
  var sec = 0, count = 0;
  final byCardio = <String, int>{};
  for (final s in fit.sessions) {
    if (s.day.isBefore(from) || !s.day.isBefore(to)) continue;
    var any = false;
    for (final e in s.exercises) {
      if (!fit.isCardio(e.id)) continue;
      any = true;
      for (final st in e.sets) {
        km += st.km ?? 0;
        sec += st.sec ?? 0;
      }
      byCardio[e.id] = (byCardio[e.id] ?? 0) + 1;
    }
    if (any) count++;
  }
  String? topCardio;
  for (final e in byCardio.entries) {
    if (topCardio == null || e.value > byCardio[topCardio]!) topCardio = e.key;
  }

  ({int total, int avg, int best, DateTime bestDay, List<int> perDay})? steps;
  if (fit.stepsOn) {
    final perDay = [for (final d in days) fit.stepsOnDay(d)];
    final walked = perDay.where((n) => n > 0).toList();
    if (walked.length >= 3) {
      var best = 0;
      var bestDay = from;
      for (final (i, n) in perDay.indexed) {
        if (n > best) {
          best = n;
          bestDay = days[i];
        }
      }
      final total = walked.fold(0, (a, b) => a + b);
      steps = (total: total, avg: total ~/ walked.length, best: best, bestDay: bestDay, perDay: perDay);
    }
  }

  ({int avg, int best, DateTime bestDay, List<int> perNight})? sleep;
  if (fit.healthShown.contains(HealthMetric.sleep)) {
    final nights = [for (final d in days) (fit.healthOnDay(HealthMetric.sleep, d)?.first ?? 0).round()];
    final slept = nights.where((n) => n > 0).toList();
    if (slept.length >= 3) {
      var best = 0;
      var bestDay = from;
      for (final (i, n) in nights.indexed) {
        if (n > best) {
          best = n;
          bestDay = days[i];
        }
      }
      sleep = (avg: slept.fold(0, (a, b) => a + b) ~/ slept.length, best: best, bestDay: bestDay, perNight: nights);
    }
  }

  var logged = 0, hit = 0, waterDays = 0, water = 0;
  var kcal = 0.0, protein = 0.0;
  final foods = <String, int>{};
  final photos = <String, String>{};
  if (fit.nutritionBeta) {
    for (final d in days) {
      final entries = fit.entriesOn(d);
      final sips = fit.waterOn(d);
      if (sips > 0) {
        waterDays++;
        water += sips;
      }
      if (entries.isEmpty) continue;
      logged++;
      final m = fit.totalOn(d);
      kcal += m.kcal;
      protein += m.protein;
      final reached = m.protein >= fit.goalsFor(d).protein;
      if (reached) hit++;
      for (final e in entries) {
        if ((photos[e.name] ?? '').isEmpty) photos[e.name] = fit.photoForEntry(e);
      }
      for (final name in {for (final e in entries) e.name}) {
        foods[name] = (foods[name] ?? 0) + 1;
      }
    }
  }
  final favs = foods.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  final medals = !fit.gamification
      ? <AwardId>[]
      : [
          for (final id in AwardId.values)
            if (fit.awardWonAt(id) case final at? when !at.isBefore(from) && at.isBefore(to)) id,
        ];

  final inMonth = [for (final s in fit.sessions) if (!s.day.isBefore(from) && s.day.isBefore(to)) s];
  LoggedSession? peak;
  if (inMonth.length >= 3) {
    for (final s in inMonth) {
      if (s.volume > 0 && (peak == null || s.volume > peak.volume)) peak = s;
    }
  }

  final before = fit.sessions.any((s) => s.day.isBefore(from));
  final fresh = !before
      ? <String>[]
      : [
          for (final id in recap.exerciseIds)
            if (fit.exerciseById(id) != null && fit.exerciseHistory(id).every((h) => !h.date.isBefore(from))) id,
        ];

  final sorted = recap.days.toList()..sort();
  var streak = 0, run = 0;
  for (final (i, d) in sorted.indexed) {
    run = i > 0 && sorted[i - 1] == d - 1 ? run + 1 : 1;
    streak = math.max(streak, run);
  }

  final last = DateTime(from.year, from.month + 1, 0);
  final now = fit.muscleSetsBetween(from, last);
  final prevSets = fit.muscleSetsBetween(DateTime(from.year, from.month - 1), DateTime(from.year, from.month, 0));
  String? forgot;
  var forgotSets = 0.0;
  for (final e in prevSets.entries) {
    if (e.value >= 4 && (now[e.key] ?? 0) <= 0 && e.value > forgotSets) {
      forgotSets = e.value;
      forgot = e.key;
    }
  }

  return (
    cardio: count == 0 || (km <= 0 && sec <= 0) ? null : (km: km, sec: sec, count: count, topId: topCardio),
    steps: steps,
    sleep: sleep,
    food: logged < 1
        ? null
        : (
            days: logged,
            kcal: (kcal / logged).round(),
            protein: (protein / logged).round(),
            goal: fit.activeGoals.protein,
            hit: hit,
            top: [for (final e in favs.take(5)) (name: e.key, photo: photos[e.key] ?? '', days: e.value)],
            star: favs.isEmpty || favs.first.value < 2 ? null : favs.first.key,
            starTimes: favs.isEmpty ? 0 : favs.first.value,
            water: waterDays == 0 ? 0 : water ~/ waterDays,
          ),
    medals: medals,
    peak: peak,
    fresh: fresh,
    streak: streak,
    yearAgo: fit.recapFor(DateTime(from.year - 1, from.month)).workouts,
    forgot: forgot,
  );
}

class _ExerciseWall extends StatefulWidget {
  const _ExerciseWall({super.key, required this.ids});

  final List<String> ids;

  @override
  State<_ExerciseWall> createState() => _ExerciseWallState();
}

class _ExerciseWallState extends State<_ExerciseWall> with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker((e) => _clock.value = e.inMicroseconds / 1e6);
  final _clock = ValueNotifier<double>(0);
  late final List<Exercise> _exs = [for (final id in widget.ids) ?fit.exerciseById(id)];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final calm = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (!calm && !_ticker.isActive) _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    if (_exs.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(builder: (context, box) {
      const columns = 4;
      final tile = box.maxWidth / 3.2;
      const gap = 10.0;
      final span = tile + gap;
      final tall = box.maxHeight * 1.6;
      final perColumn = (tall / span).ceil() + 2;
      return ClipRect(
        child: Stack(children: [
          Positioned.fill(
            child: Transform.rotate(
              angle: -0.18,
              child: OverflowBox(
                maxWidth: box.maxWidth * 1.6,
                maxHeight: tall,
                child: RepaintBoundary(
                  child: ValueListenableBuilder<double>(
                    valueListenable: _clock,
                    builder: (_, time, _) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (var c = 0; c < columns; c++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: gap / 2),
                          child: SizedBox(
                            width: tile,
                            height: tall,
                            child: ClipRect(
                              child: OverflowBox(
                                alignment: Alignment.topCenter,
                                maxHeight: double.infinity,
                                child: Transform.translate(
                                  offset: Offset(0, -((time * (14 + c * 5) * (c.isEven ? 1 : -1)) % span) - span),
                                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                                    for (var i = 0; i < perColumn; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: gap),
                                        child: SizedBox(
                                          width: tile,
                                          child: ExerciseMedia(
                                            ex: _exs[(i * 3 + c) % _exs.length],
                                            height: tile,
                                            radius: 18,
                                            bordered: false,
                                          ),
                                        ),
                                      ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [gc.bg.withValues(alpha: 0.72), gc.bg.withValues(alpha: 0.7), gc.bg],
                  stops: const [0, 0.38, 0.62],
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}

class _MonthChart extends StatelessWidget {
  const _MonthChart({required this.values, required this.avg, required this.month, required this.tone, required this.label});

  final List<int> values;
  final int avg;
  final DateTime month;
  final Color tone;
  final Color label;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 128,
        width: double.infinity,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1300),
          builder: (_, v, _) => CustomPaint(
            painter: _MonthChartPainter(
              values: values,
              avg: avg,
              count: DateTime(month.year, month.month + 1, 0).day,
              tone: tone,
              label: label,
              progress: v,
              rtl: Directionality.of(context) == TextDirection.rtl,
              scale: MediaQuery.textScalerOf(context),
            ),
          ),
        ),
      );
}

class _MonthChartPainter extends CustomPainter {
  _MonthChartPainter({
    required this.values,
    required this.avg,
    required this.count,
    required this.tone,
    required this.label,
    required this.progress,
    required this.rtl,
    required this.scale,
  });

  final List<int> values;
  final int avg;
  final int count;
  final Color tone;
  final Color label;
  final double progress;
  final bool rtl;
  final TextScaler scale;

  @override
  void paint(Canvas canvas, Size size) {
    const labelH = 22.0;
    final h = size.height - labelH;
    final slot = size.width / count;
    final barW = math.min(10.0, slot * 0.58);
    final top = math.max(1, values.fold(0, math.max));
    double cx(int i) => rtl ? size.width - slot * (i + 0.5) : slot * (i + 0.5);
    final paint = Paint();
    for (var i = 0; i < count; i++) {
      final v = i < values.length ? values[i] : 0;
      final x = cx(i);
      if (v <= 0) {
        paint.color = tone.withValues(alpha: (i < values.length ? 0.22 : 0.1) * progress);
        canvas.drawCircle(Offset(x, h - 1.8), 1.8, paint);
        continue;
      }
      final local = Curves.easeOutCubic.transform(((progress * 1.5) - i / count * 0.5).clamp(0.0, 1.0));
      final bh = math.max(barW, h * v / top) * local;
      if (bh <= 0) continue;
      paint.color = v == top ? tone : tone.withValues(alpha: 0.3);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x - barW / 2, h - bh, barW, bh), Radius.circular(barW / 2)),
        paint,
      );
    }
    if (avg > 0) {
      final y = h - h * avg / top;
      final dash = Paint()
        ..color = tone.withValues(alpha: 0.4 * Curves.easeOut.transform(((progress - 0.5) * 2).clamp(0.0, 1.0)))
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round;
      for (var x = 0.0; x < size.width; x += 7) {
        canvas.drawLine(Offset(x, y), Offset(math.min(x + 3, size.width), y), dash);
      }
    }
    for (final d in {1, (count + 1) ~/ 2, count}) {
      final tp = TextPainter(
        text: TextSpan(text: '$d', style: AppTheme.f(10.5, weight: FontWeight.w800, color: label)),
        textDirection: TextDirection.ltr,
        textScaler: scale.clamp(maxScaleFactor: 1.3),
      )..layout();
      tp.paint(canvas, Offset((cx(d - 1) - tp.width / 2).clamp(0.0, size.width - tp.width), h + 8));
    }
  }

  @override
  bool shouldRepaint(_MonthChartPainter old) =>
      old.progress != progress || old.values != values || old.tone != tone || old.label != label || old.rtl != rtl;
}

class _Route extends StatelessWidget {
  const _Route({required this.progress, required this.color, required this.track});

  final double progress;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: const Duration(milliseconds: 1600),
        curve: Curves.easeInOutCubic,
        builder: (_, v, _) => SizedBox(
          height: 70,
          width: double.infinity,
          child: CustomPaint(painter: _RoutePainter(v, color, track)),
        ),
      );
}

class _RoutePainter extends CustomPainter {
  _RoutePainter(this.v, this.color, this.track);

  final double v;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size s) {
    final h = s.height;
    final path = Path()
      ..moveTo(4, h * 0.7)
      ..cubicTo(s.width * 0.18, h * 0.05, s.width * 0.32, h * 0.05, s.width * 0.45, h * 0.5)
      ..cubicTo(s.width * 0.58, h * 0.95, s.width * 0.74, h * 0.95, s.width * 0.84, h * 0.4)
      ..quadraticBezierTo(s.width * 0.92, h * 0.05, s.width - 4, h * 0.3);
    final base = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, base);
    final metric = path.computeMetrics().first;
    canvas.drawPath(metric.extractPath(0, metric.length * v), base..color = color);
    final tip = metric.getTangentForOffset(metric.length * v)?.position;
    if (tip != null) {
      canvas.drawCircle(tip, 9, Paint()..color = color);
      canvas.drawCircle(tip, 4, Paint()..color = track);
    }
  }

  @override
  bool shouldRepaint(_RoutePainter old) => old.v != v || old.color != color;
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.recapClose,
      child: Pressable(
        onTap: onTap,
        scale: 0.88,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(PhosphorIconsBold.x, size: 17, color: gc.text),
          ),
        ),
      ),
    );
  }
}

class _WorkoutsPage extends StatefulWidget {
  const _WorkoutsPage({
    required this.recap,
    required this.tone,
    required this.kicker,
    required this.versus,
    this.notes = const [],
  });

  final MonthRecap recap;
  final Color tone;
  final Widget kicker;
  final Widget versus;
  final List<String> notes;

  @override
  State<_WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<_WorkoutsPage> with SingleTickerProviderStateMixin {
  late final List<int> _days = widget.recap.days.toList()..sort();
  late final AnimationController _run;
  int _lit = 0;

  @override
  void initState() {
    super.initState();
    _run = AnimationController(vsync: this, duration: Duration(milliseconds: 500 + 90 * _days.length))
      ..addListener(() {
        final lit = (Curves.easeInOut.transform(_run.value) * _days.length).round();
        if (lit != _lit) {
          if (lit > _lit) HapticFeedback.selectionClick();
          setState(() => _lit = lit);
        }
      })
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) setState(() {});
      });
    Future<void>.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _run.forward();
    });
  }

  @override
  void dispose() {
    _run.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final m = widget.recap.month;
    final count = DateTime(m.year, m.month + 1, 0).day;
    final lead = (DateTime(m.year, m.month, 1).weekday - fit.weekStartDay + 7) % 7;
    final lit = {for (final d in _days.take(_lit)) d};
    final shown = (_lit / math.max(1, _days.length) * widget.recap.workouts).round();
    final order = [for (var i = 0; i < 7; i++) (fit.weekStartDay - 1 + i) % 7 + 1];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
      widget.kicker,
      const SizedBox(height: 6),
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Text('$shown', style: _num(112, gc.text)),
        const SizedBox(width: 10),
        Text(t.recapWorkouts(widget.recap.workouts),
            style: AppTheme.f(28, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.6)),
      ]),
      const SizedBox(height: 14),
      widget.versus,
      const SizedBox(height: 22),
      LayoutBuilder(builder: (context, box) {
        final cell = math.min(38.0, (box.maxWidth - 6 * 6) / 7);
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 6, children: [
            for (final d in order)
              SizedBox(
                width: cell,
                child: Text(t.weekdayInitial(d),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(10.5, weight: FontWeight.w800, color: gc.textTertiary)),
              ),
          ]),
          const SizedBox(height: 8),
          Wrap(spacing: 6, runSpacing: 6, children: [
            for (var i = 0; i < lead; i++) SizedBox(width: cell, height: cell),
            for (var d = 1; d <= count; d++)
              AnimatedScale(
                scale: lit.contains(d) ? 1 : 0.88,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: cell,
                  height: cell,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lit.contains(d) ? gc.ember : gc.bgRaised2,
                    shape: BoxShape.circle,
                    border: lit.contains(d) ? null : Border.all(color: gc.border.withValues(alpha: 0.7)),
                  ),
                  child: Text('$d',
                      style: AppTheme.f(cell * 0.34,
                          weight: FontWeight.w800, color: lit.contains(d) ? gc.onEmber : gc.textSecondary)),
                ),
              ),
          ]),
        ]);
      }),
      const SizedBox(height: 16),
      AnimatedOpacity(
        opacity: _run.isCompleted ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.recapDays(_days.length),
              style: AppTheme.f(16, weight: FontWeight.w600, color: gc.text, height: 1.4)),
          for (final note in widget.notes) ...[
            const SizedBox(height: 4),
            Text(note, style: AppTheme.f(16, weight: FontWeight.w600, color: gc.textSecondary, height: 1.4)),
          ],
        ]),
      ),
      const SizedBox(height: 30),
    ]);
  }
}


class RecapCard extends StatelessWidget {
  const RecapCard({super.key, required this.recap, this.variant = 0});

  final MonthRecap recap;
  final int variant;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = gc.accent;
    final lift = recap.lift == null ? null : fit.exerciseById(recap.lift!.id);
    final wall = variant == 2 ? recapWallIds(recap) : const <String>[];
    return SizedBox(
      width: 360,
      height: 640,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: ColoredBox(
          color: gc.bg,
          child: Stack(children: [
            if (wall.isNotEmpty)
              Positioned(left: 0, right: 0, top: 0, height: 440, child: _staticWall(wall, gc.bg))
            else
              Positioned(
                left: 0,
                right: 0,
                top: variant == 1 ? 130 : 70,
                height: 240,
                child: NameTicker(
                  text: switch (variant) {
                    1 => t.monthName(recap.month.month),
                    2 when lift != null => exerciseName(lift),
                    _ => fit.displayName,
                  },
                  color: gc.text.withValues(alpha: 0.06),
                  rows: 3,
                  size: 74,
                  running: false,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _header(gc, tone),
                const SizedBox(height: 18),
                Expanded(
                  child: switch (variant) {
                    1 => _calendar(gc, tone),
                    2 when lift != null => _lift(gc, tone, lift),
                    _ => _summary(gc, tone),
                  },
                ),
                const SizedBox(height: 18),
                Center(child: _mark(gc)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _staticWall(List<String> ids, Color bg) {
    final exs = [for (final id in ids) ?fit.exerciseById(id)];
    return Stack(fit: StackFit.expand, children: [
      Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 40,
      child: Opacity(
      opacity: 0.43,
      child: ClipRect(
        child: Transform.rotate(
          angle: -0.18,
          child: OverflowBox(
            maxWidth: 760,
            maxHeight: 760,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              for (var r = 0; r < 7; r++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    for (var c = 0; c < 7; c++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SizedBox(
                          width: 96,
                          child: ExerciseMedia(ex: exs[(r * 3 + c) % exs.length], height: 96, radius: 16, bordered: false),
                        ),
                      ),
                  ]),
                ),
            ]),
          ),
        ),
      ),
      ),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bg.withValues(alpha: 0), bg.withValues(alpha: 0.3), bg],
            stops: const [0, 0.45, 0.88],
          ),
        ),
      ),
    ]);
  }

  Widget _header(GymColors gc, Color tone) => Row(children: [
        const ProfileAvatar(size: 46),
        const SizedBox(width: 11),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(fit.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(18, weight: FontWeight.w900, color: gc.text, letterSpacing: -0.4)),
            Text('@${fit.profileHandle}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary)),
          ]),
        ),
        const SizedBox(width: 8),
        Text(t.monthYear(recap.month).toUpperCase(),
            style: AppTheme.f(9.5, weight: FontWeight.w800, color: tone, letterSpacing: 1.4)),
      ]);

  Widget _mark(GymColors gc) => Row(mainAxisSize: MainAxisSize.min, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset('assets/img/app_icon.png', width: 20, height: 20),
        ),
        const SizedBox(width: 7),
        Text('GymMane', style: AppTheme.f(14, weight: FontWeight.w900, color: gc.text, letterSpacing: -0.2, height: 1)),
      ]);

  Widget _stat(GymColors gc, String value, String unit, String label, {double size = 28, bool soft = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              Text(value, style: _num(size, soft ? gc.textSecondary : gc.text)),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 3),
                Text(unit, style: AppTheme.f(size * 0.4, weight: FontWeight.w800, color: gc.textSecondary)),
              ],
            ]),
          ),
          const SizedBox(height: 4),
          Text(label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(8.5, weight: FontWeight.w800, color: gc.textTertiary, letterSpacing: 1.1)),
        ],
      );

  (String, String) get _time {
    final h = recap.seconds ~/ 3600;
    final m = (recap.seconds % 3600) ~/ 60;
    return h > 0 ? ('$h', 'h') : ('$m', 'min');
  }

  Widget _summary(GymColors gc, Color tone) {
    final time = _time;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Text('${recap.workouts}', style: _num(80, gc.text)),
        const SizedBox(width: 8),
        Text(t.recapWorkouts(recap.workouts),
            style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.4)),
      ]),
      const SizedBox(height: 2),
      Text(t.recapDays(recap.days.length), style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.textSecondary)),
      const Spacer(),
      Center(child: BodyHeatArt(gc: gc, intensity: recap.heat, width: 220)),
      if (recap.topMuscle != null) ...[
        const SizedBox(height: 8),
        Center(
          child: Text('${t.recapMuscleKicker} · ${muscleLabel(recap.topMuscle!)}'.toUpperCase(),
              style: AppTheme.f(9.5, weight: FontWeight.w800, color: tone, letterSpacing: 1.3)),
        ),
      ],
      const Spacer(),
      Row(children: [
        Expanded(child: _stat(gc, time.$1, time.$2, t.duration, size: 34)),
        Expanded(child: _stat(gc, fit.volumeValue(recap.volumeKg), fit.volumeUnit, t.statLifted, size: 34)),
        Expanded(child: _stat(gc, '${recap.sets}', '', t.setsCaps, size: 34)),
      ]),
      const SizedBox(height: 14),
      Row(children: [
        Expanded(child: _stat(gc, '${recap.records.length}', '', t.prs, size: 22, soft: true)),
        Expanded(child: _stat(gc, '${recap.avgMinutes}', 'min', t.recapAvgLabel, size: 22, soft: true)),
        Expanded(
          child: _stat(gc, recap.favDay == null ? '–' : t.weekdayShort(recap.favDay!), '', t.recapFavLabel,
              size: 22, soft: true),
        ),
      ]),
    ]);
  }

  Widget _calendar(GymColors gc, Color tone) {
    final m = recap.month;
    final count = DateTime(m.year, m.month + 1, 0).day;
    final lead = (DateTime(m.year, m.month, 1).weekday - fit.weekStartDay + 7) % 7;
    final time = _time;
    final order = [for (var i = 0; i < 7; i++) (fit.weekStartDay - 1 + i) % 7 + 1];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t.monthName(m.month),
          style: AppTheme.f(56, weight: FontWeight.w900, color: gc.text, letterSpacing: -2.4, height: 1)),
      const SizedBox(height: 6),
      Text(t.recapCalendarLine(recap.workouts, recap.days.length),
          style: AppTheme.f(13.5, weight: FontWeight.w800, color: tone)),
      const SizedBox(height: 18),
      Row(children: [
        for (final d in order)
          Expanded(
            child: Center(
              child:
                  Text(t.weekdayInitial(d), style: AppTheme.f(10, weight: FontWeight.w800, color: gc.textTertiary)),
            ),
          ),
      ]),
      const SizedBox(height: 6),
      GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        padding: EdgeInsets.zero,
        children: [
          for (var i = 0; i < lead; i++) const SizedBox.shrink(),
          for (var d = 1; d <= count; d++)
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: recap.days.contains(d) ? gc.ember : gc.bgRaised2,
                shape: BoxShape.circle,
              ),
              child: Text('$d',
                  style: AppTheme.f(11.5,
                      weight: FontWeight.w800, color: recap.days.contains(d) ? gc.onEmber : gc.textSecondary)),
            ),
        ],
      ),
      const Spacer(),
      Row(children: [
        Expanded(child: _stat(gc, time.$1, time.$2, t.duration, size: 34)),
        Expanded(child: _stat(gc, fit.volumeValue(recap.volumeKg), fit.volumeUnit, t.statLifted, size: 34)),
        Expanded(
          child: _stat(gc, recap.favDay == null ? '–' : t.weekdayShort(recap.favDay!), '', t.recapFavLabel, size: 34),
        ),
      ]),
    ]);
  }

  Widget _lift(GymColors gc, Color tone, Exercise ex) {
    final l = recap.lift!;
    final heavy = l.bestKg > 0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Spacer(flex: 2),
      Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(27), border: Border.all(color: gc.border, width: 1.5)),
          child: SizedBox(width: 196, child: ExerciseMedia(ex: ex, height: 196, radius: 24)),
        ),
      ),
      const Spacer(flex: 3),
      Text(t.recapLiftKicker.toUpperCase(),
          style: AppTheme.f(10, weight: FontWeight.w800, color: tone, letterSpacing: 1.6)),
      const SizedBox(height: 6),
      Text(exerciseName(ex),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.f(28, weight: FontWeight.w900, color: gc.text, letterSpacing: -0.8, height: 1.05)),
      const SizedBox(height: 18),
      _stat(
        gc,
        heavy ? fit.weightLabel(l.bestKg).split(' ').first : '${l.sets}',
        heavy ? fit.units : '',
        heavy ? t.recapBest : t.setsCaps,
        size: 72,
      ),
      const SizedBox(height: 18),
      Row(children: [
        if (heavy) Expanded(child: _stat(gc, '${l.sets}', '', t.setsCaps, size: 26)),
        Expanded(child: _stat(gc, '${l.times}', '', t.recapTimes, size: 26)),
        Expanded(child: _stat(gc, fit.volumeValue(l.volumeKg), fit.volumeUnit, t.statLifted, size: 26)),
      ]),
    ]);
  }
}
