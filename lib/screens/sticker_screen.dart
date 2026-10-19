import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../services/gallery.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/ui_kit.dart';

Future<void> showStickerEditor(BuildContext context, LoggedSession session, {int prs = 0}) =>
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 340),
        reverseTransitionDuration: const Duration(milliseconds: 240),
        pageBuilder: (_, _, _) => StickerEditor(session: session, prs: prs),
        transitionsBuilder: (_, animation, _, child) {
          final a = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: a,
            child: SlideTransition(
              position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(a),
              child: child,
            ),
          );
        },
      ),
    );

class StickerEditor extends StatefulWidget {
  const StickerEditor({super.key, required this.session, this.prs = 0});

  final LoggedSession session;
  final int prs;

  @override
  State<StickerEditor> createState() => _StickerEditorState();
}

class _StickerEditorState extends State<StickerEditor> {
  static const _base = 360.0;

  final _canvas = GlobalKey();
  File? _photo;
  bool _streak = false;
  bool _date = true;
  int _layout = 0;
  int _swatch = 0;
  Offset _pos = const Offset(0.5, 0.68);
  double _scale = 1;
  double _turn = 0;
  double _startScale = 1;
  double _startTurn = 0;
  bool _busy = false;

  List<Color> _swatches(GymColors gc) => [
    Colors.white,
    const Color(0xFF111111),
    gc.accent,
    gc.brass,
    gc.sage,
    const Color(0xFFE8E1D7),
  ];

  Future<void> _pick(ImageSource source) async {
    try {
      final shot = await ImagePicker().pickImage(
        source: source,
        maxWidth: 2160,
        maxHeight: 3840,
        imageQuality: 92,
      );
      if (shot == null || !mounted) return;
      setState(() => _photo = File(shot.path));
    } catch (_) {}
  }

  Future<Uint8List?> _render() async {
    final boundary = _canvas.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(pixelRatio: 1080 / boundary.size.width);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return data?.buffer.asUint8List();
  }

  Future<void> _run(Future<void> Function(Uint8List png) job) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final png = await _render();
      if (png == null) throw StateError('render');
      await job(png);
    } catch (_) {
      if (mounted) {
        showNotchToast(
          context,
          t.shareFailed,
          icon: PhosphorIconsFill.warningCircle,
          accent: context.gc.warn,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() => _run((png) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/gymmane-sticker.png');
    await file.writeAsBytes(png, flush: true);
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], subject: 'GymMane'));
  });

  Future<void> _save() => _run((png) async {
    final ok = await saveImageToGallery(png, 'gymmane-${DateTime.now().millisecondsSinceEpoch}.png');
    if (!ok) throw StateError('save');
    HapticFeedback.lightImpact();
    if (mounted) {
      showNotchToast(context, t.stickerSaved, icon: PhosphorIconsFill.checkCircle, accent: context.gc.sage);
    }
  });

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final color = _swatches(gc)[_swatch];
    return Scaffold(
      backgroundColor: gc.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  RoundAction(
                    label: MaterialLocalizations.of(context).closeButtonLabel,
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(PhosphorIconsRegular.x, size: 18, color: gc.text),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.stickerHint,
                      maxLines: 2,
                      style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: LayoutBuilder(builder: (context, c) => _stage(gc, c.biggest, color)),
                    ),
                  ),
                ),
              ),
            ),
            _controls(gc),
          ],
        ),
      ),
    );
  }

  Widget _stage(GymColors gc, Size size, Color color) {
    final unit = size.width / _base;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleStart: (_) {
        _startScale = _scale;
        _startTurn = _turn;
      },
      onScaleUpdate: (d) => setState(() {
        _pos = Offset(
          (_pos.dx + d.focalPointDelta.dx / size.width).clamp(0.0, 1.0),
          (_pos.dy + d.focalPointDelta.dy / size.height).clamp(0.0, 1.0),
        );
        if (d.pointerCount > 1) {
          _scale = (_startScale * d.scale).clamp(0.45, 2.6);
          _turn = _startTurn + d.rotation;
        }
      }),
      onDoubleTap: () => setState(() => _turn = 0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_photo == null) CustomPaint(painter: _Checker(gc.bgRaised, gc.bgRaised2)),
          RepaintBoundary(
            key: _canvas,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_photo != null) Image.file(_photo!, fit: BoxFit.cover),
                Positioned(
                  left: _pos.dx * size.width,
                  top: _pos.dy * size.height,
                  child: FractionalTranslation(
                    translation: const Offset(-0.5, -0.5),
                    child: Transform.rotate(
                      angle: _turn,
                      child: Transform.scale(
                        scale: _scale * unit,
                        child: _Sticker(
                          session: widget.session,
                          prs: widget.prs,
                          streak: _streak,
                          layout: _layout,
                          showDate: _date,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controls(GymColors gc) {
    final swatches = _swatches(gc);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _chip(
                gc,
                PhosphorIconsRegular.image,
                t.stickerGallery,
                false,
                () => _pick(ImageSource.gallery),
              ),
              const SizedBox(width: 8),
              _chip(gc, PhosphorIconsRegular.camera, t.stickerCamera, false, () => _pick(ImageSource.camera)),
              const SizedBox(width: 8),
              _chip(
                gc,
                PhosphorIconsRegular.checkerboard,
                t.stickerNoPhoto,
                _photo == null,
                () => setState(() => _photo = null),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SegToggle([
                SegOption(t.stickerWorkout, !_streak, () => setState(() => _streak = false)),
                SegOption(t.stickerStreak, _streak, () => setState(() => _streak = true)),
              ]),
              const Spacer(),
              Pill(
                label: t.stickerDate,
                bg: _date ? gc.emberSoft : gc.bgRaised2,
                fg: _date ? gc.text : gc.textTertiary,
                fontSize: 12,
                onTap: () => setState(() => _date = !_date),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final (i, icon) in [
                PhosphorIconsRegular.rows,
                PhosphorIconsRegular.columns,
                PhosphorIconsRegular.textAa,
                PhosphorIconsRegular.squaresFour,
                PhosphorIconsRegular.listBullets,
                PhosphorIconsRegular.equals,
              ].indexed) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(child: _iconToggle(gc, icon, _layout == i, () => setState(() => _layout = i))),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final (i, c) in swatches.indexed)
                Pressable(
                  onTap: () => setState(() => _swatch = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 34,
                    height: 34,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: i == _swatch ? gc.text : Colors.transparent, width: 2),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(color: gc.border),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(label: t.save, height: 52, bg: gc.bgRaised2, fg: gc.text, onTap: _save),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(label: t.share, height: 52, onTap: _share),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(GymColors gc, IconData icon, String label, bool on, VoidCallback onTap) => Expanded(
    child: Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: on ? gc.emberSoft : gc.bgRaised2,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: on ? gc.text : gc.textSecondary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(12, weight: FontWeight.w700, color: on ? gc.text : gc.textSecondary),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _iconToggle(GymColors gc, IconData icon, bool on, VoidCallback onTap) => Pressable(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 38,
      decoration: BoxDecoration(
        color: on ? gc.emberSoft : gc.bgRaised2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 17, color: on ? gc.text : gc.textTertiary),
    ),
  );
}

class _Sticker extends StatelessWidget {
  const _Sticker({
    required this.session,
    required this.prs,
    required this.streak,
    required this.layout,
    required this.showDate,
    required this.color,
  });

  final LoggedSession session;
  final int prs;
  final bool streak;
  final int layout;
  final bool showDate;
  final Color color;

  bool get _light => color.computeLuminance() > 0.5;

  List<Shadow> get _shadow =>
      _light ? const [Shadow(color: Color(0x59000000), blurRadius: 12, offset: Offset(0, 1))] : const [];

  TextStyle _s(double size, FontWeight w, {double alpha = 1, double spacing = 0, double height = 1.05}) =>
      AppTheme.f(
        size,
        weight: w,
        color: color.withValues(alpha: alpha),
        letterSpacing: spacing,
        height: height,
      ).copyWith(shadows: _shadow, fontFeatures: const [ui.FontFeature.tabularFigures()]);

  String get _dateLine {
    final d = session.date;
    return '${t.longDate(d)} · ${DateFormat.Hm(intlLocale).format(d)}';
  }

  String get _duration => durationClock(session.durationSec);
  String get _volume => fit.volumeLabel(session.volume);
  String get _sets => '${session.setCount}';

  static const _widths = [230.0, 300.0, 260.0, 280.0, 280.0, 320.0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: _widths[layout.clamp(0, 5)], child: streak ? _streakBody() : _workoutBody());
  }

  Widget _mark({double size = 12}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'assets/img/runner.png',
        height: size + 5,
        color: color.withValues(alpha: 0.9),
        colorBlendMode: BlendMode.srcIn,
      ),
      const SizedBox(width: 5),
      Text('GymMane', style: _s(size, FontWeight.w900, alpha: 0.9, spacing: 0.2)),
    ],
  );

  Widget _kicker(String text) =>
      Text(text.toUpperCase(), style: _s(10.5, FontWeight.w800, alpha: 0.75, spacing: 2.2));

  Widget _date({TextAlign align = TextAlign.left}) =>
      Text(_dateLine, textAlign: align, style: _s(12, FontWeight.w600, alpha: 0.75, height: 1.2));

  Widget _stat(String label, String value, {double size = 30}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label.toUpperCase(), style: _s(9.5, FontWeight.w700, alpha: 0.7, spacing: 1.5)),
      const SizedBox(height: 2),
      Text(value, maxLines: 1, style: _s(size, FontWeight.w900)),
    ],
  );

  Widget _panel(Widget child) => Container(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
    decoration: BoxDecoration(
      color: (_light ? Colors.black : Colors.white).withValues(alpha: 0.34),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: color.withValues(alpha: 0.18)),
    ),
    child: child,
  );

  Widget _prs({TextAlign align = TextAlign.left}) =>
      Text(t.prCount(prs), textAlign: align, style: _s(12, FontWeight.w800, alpha: 0.9));

  Widget _workoutBody() {
    switch (layout) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerWorkout),
            if (showDate) ...[const SizedBox(height: 3), _date()],
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _stat(t.duration, _duration, size: 24)),
                Expanded(child: _stat(t.volume, _volume, size: 24)),
                Expanded(child: _stat(t.setsCaps, _sets, size: 24)),
              ],
            ),
            if (prs > 0) ...[const SizedBox(height: 10), _prs()],
            const SizedBox(height: 14),
            _mark(),
          ],
        );
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerWorkout),
            if (showDate) ...[const SizedBox(height: 3), _date(align: TextAlign.center)],
            const SizedBox(height: 6),
            FittedBox(child: Text(_volume, style: _s(64, FontWeight.w900, height: 1))),
            const SizedBox(height: 6),
            Text(
              '$_duration  ·  $_sets ${t.setsCaps.toLowerCase()}',
              style: _s(15, FontWeight.w700, alpha: 0.85),
            ),
            if (prs > 0) ...[const SizedBox(height: 6), _prs(align: TextAlign.center)],
            const SizedBox(height: 14),
            _mark(),
          ],
        );
      case 3:
        return _panel(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: _kicker(t.stickerWorkout)),
                  _mark(size: 11),
                ],
              ),
              if (showDate) ...[const SizedBox(height: 4), _date()],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _stat(t.duration, _duration, size: 26)),
                  Expanded(child: _stat(t.volume, _volume, size: 26)),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _stat(t.setsCaps, _sets, size: 26)),
                  Expanded(child: _stat(t.exercises, '${session.exercises.length}', size: 26)),
                ],
              ),
              if (prs > 0) ...[const SizedBox(height: 12), _prs()],
            ],
          ),
        );
      case 4:
        final shown = session.exercises.take(5).toList();
        final more = session.exercises.length - shown.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerWorkout),
            if (showDate) ...[const SizedBox(height: 3), _date()],
            const SizedBox(height: 12),
            for (final e in shown) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      t.catalogName(e.id, e.name),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _s(14, FontWeight.w800, height: 1.2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(_best(e), style: _s(12.5, FontWeight.w700, alpha: 0.8)),
                ],
              ),
              const SizedBox(height: 7),
            ],
            if (more > 0) ...[
              Text('+$more', style: _s(12, FontWeight.w700, alpha: 0.7)),
              const SizedBox(height: 7),
            ],
            Container(height: 1, color: color.withValues(alpha: 0.3)),
            const SizedBox(height: 9),
            Text(
              '$_duration  ·  $_volume  ·  $_sets ${t.setsCaps.toLowerCase()}',
              style: _s(12.5, FontWeight.w800, alpha: 0.9),
            ),
            const SizedBox(height: 12),
            _mark(),
          ],
        );
      case 5:
        final sep = Container(width: 1, height: 30, color: color.withValues(alpha: 0.35));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _mark(size: 11),
                if (showDate) ...[
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      _dateLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _s(11, FontWeight.w600, alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _stat(t.duration, _duration, size: 21)),
                sep,
                const SizedBox(width: 12),
                Expanded(child: _stat(t.volume, _volume, size: 21)),
                sep,
                const SizedBox(width: 12),
                Expanded(child: _stat(t.setsCaps, _sets, size: 21)),
              ],
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerWorkout),
            if (showDate) ...[const SizedBox(height: 3), _date()],
            const SizedBox(height: 16),
            _stat(t.duration, _duration, size: 34),
            const SizedBox(height: 12),
            _stat(t.volume, _volume, size: 34),
            const SizedBox(height: 12),
            _stat(t.setsCaps, _sets, size: 34),
            if (prs > 0) ...[const SizedBox(height: 12), _prs()],
            const SizedBox(height: 16),
            _mark(),
          ],
        );
    }
  }

  String _best(LoggedExercise e) {
    final sets = e.workingSets.isEmpty ? e.sets : e.workingSets;
    if (sets.isEmpty) return '';
    final top = sets.reduce((a, b) => a.weight * (a.reps + 1) >= b.weight * (b.reps + 1) ? a : b);
    if (top.weight > 0 && top.reps > 0 && (top.km ?? 0) <= 0) {
      return '${fit.weightLabel(top.weight)} × ${top.reps}';
    }
    return fit.loggedSetLabel(top);
  }

  Widget _streakBody() {
    final start = fit.weekStartDate;
    final trained = <int>{};
    for (final s in fit.sessions) {
      final d = DateTime(s.day.year, s.day.month, s.day.day).difference(start).inDays;
      if (d >= 0 && d < 7) trained.add(d);
    }
    final now = DateTime.now();
    final todayIdx = DateTime(now.year, now.month, now.day).difference(start).inDays;
    final days = fit.currentStreak;

    Widget week({double dot = 20, double gap = 4}) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 7; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: gap),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: dot,
                  height: dot,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: trained.contains(i) ? color : Colors.transparent,
                    border: Border.all(
                      color: color.withValues(alpha: i == todayIdx ? 0.95 : 0.4),
                      width: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  t.weekdayInitial(start.add(Duration(days: i)).weekday).toUpperCase(),
                  style: _s(9.5, FontWeight.w700, alpha: 0.7),
                ),
              ],
            ),
          ),
      ],
    );

    Widget big(double size) => Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(PhosphorIconsFill.fire, size: size * 0.7, color: color, shadows: _shadow),
        const SizedBox(width: 6),
        Text('$days', style: _s(size, FontWeight.w900, height: 1)),
      ],
    );

    final label = Text(t.shareStreakLabel, style: _s(10.5, FontWeight.w800, alpha: 0.75, spacing: 1.4));
    final weekCount = _stat(t.stickerWeek, '${trained.length}/7', size: 22);

    switch (layout) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerStreak),
            if (showDate) ...[const SizedBox(height: 3), _date()],
            const SizedBox(height: 10),
            Row(
              children: [
                big(46),
                const SizedBox(width: 12),
                Expanded(child: label),
              ],
            ),
            const SizedBox(height: 14),
            week(),
            const SizedBox(height: 14),
            _mark(),
          ],
        );
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerStreak),
            if (showDate) ...[const SizedBox(height: 3), _date(align: TextAlign.center)],
            const SizedBox(height: 8),
            Icon(PhosphorIconsFill.fire, size: 46, color: color, shadows: _shadow),
            Text('$days', style: _s(96, FontWeight.w900, height: 1)),
            label,
            const SizedBox(height: 16),
            _mark(),
          ],
        );
      case 3:
        return _panel(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: _kicker(t.stickerStreak)),
                  _mark(size: 11),
                ],
              ),
              if (showDate) ...[const SizedBox(height: 4), _date()],
              const SizedBox(height: 12),
              big(50),
              const SizedBox(height: 2),
              label,
              const SizedBox(height: 14),
              week(dot: 18, gap: 3.5),
            ],
          ),
        );
      case 4:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerWeek),
            if (showDate) ...[const SizedBox(height: 3), _date(align: TextAlign.center)],
            const SizedBox(height: 14),
            week(dot: 26, gap: 5),
            const SizedBox(height: 14),
            Text(t.streakDays(days), style: _s(13, FontWeight.w800, alpha: 0.9)),
            const SizedBox(height: 14),
            _mark(),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _mark(size: 11),
                if (showDate) ...[
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      t.longDate(session.day),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _s(11, FontWeight.w600, alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                big(30),
                const SizedBox(width: 10),
                Flexible(child: label),
                const SizedBox(width: 12),
                Container(width: 1, height: 26, color: color.withValues(alpha: 0.35)),
                const SizedBox(width: 12),
                weekCount,
              ],
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _kicker(t.stickerStreak),
            if (showDate) ...[const SizedBox(height: 3), _date()],
            const SizedBox(height: 12),
            big(64),
            const SizedBox(height: 2),
            label,
            const SizedBox(height: 16),
            week(dot: 18, gap: 3),
            const SizedBox(height: 16),
            _mark(),
          ],
        );
    }
  }
}

String durationClock(int sec) {
  final h = sec ~/ 3600, m = (sec % 3600) ~/ 60, s = sec % 60;
  final ss = s.toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$ss' : '$m:$ss';
}

class _Checker extends CustomPainter {
  _Checker(this.a, this.b);

  final Color a, b;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = a);
    final p = Paint()..color = b;
    const cell = 14.0;
    for (var y = 0; y * cell < size.height; y++) {
      for (var x = (y % 2); x * cell < size.width; x += 2) {
        canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), p);
      }
    }
  }

  @override
  bool shouldRepaint(_Checker old) => old.a != a || old.b != b;
}
