import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../widgets/exercise_art.dart';
import '../widgets/routine_folder.dart';
import '../widgets/ui_kit.dart';

const _pageW = 595.28;
const _pageH = 841.89;
const _margin = 40.0;
const _bottom = _pageH - 58;
const _scale = 2.5;
const _contentW = _pageW - 2 * _margin;

const _ink = Color(0xFF1A1713);
const _sub = Color(0xFF5F574F);
const _faint = Color(0xFF8A8179);
const _line = Color(0xFFE9E4DE);
const _soft = Color(0xFFF6F3EF);
const _accent = Color(0xFF9E4E27);
const _paper = Color(0xFFFFFFFF);
const _zebra = Color(0x80F6F3EF);

typedef _Op = void Function(Canvas c);

Future<void> sharePlanPdf(List<Routine> routines, {bool week = false}) async {
  if (routines.isEmpty) return;
  try {
    final bytes = await buildPlanPdf(routines, week: week);
    final dir = await getTemporaryDirectory();
    final name = week ? 'plan' : _slug(fit.routineTitle(routines.first));
    final file = File('${dir.path}/gymmane-${name.isEmpty ? 'plan' : name}.pdf');
    await file.writeAsBytes(bytes);
    final title = week ? sentenceCase(t.weeklyPlan) : fit.routineTitle(routines.first);
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path, mimeType: 'application/pdf')],
      subject: title,
    ));
  } catch (_) {}
}

String _slug(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

Future<Uint8List> buildPlanPdf(List<Routine> routines, {bool week = false, DateTime? now}) async {
  final runner = await _loadImage('assets/img/runner.png');
  final arts = <String, ExerciseArtData>{};
  for (final r in routines) {
    for (final id in r.exerciseIds) {
      final slug = fit.exerciseById(id)?.art ?? '';
      if (slug.isEmpty || arts.containsKey(slug)) continue;
      try {
        arts[slug] = await loadExerciseArt(slug, still: true);
      } catch (_) {}
    }
  }
  final doc = _PlanDoc(runner, arts, rtl: const {'ar', 'fa'}.contains(appLanguage));
  doc.lay(routines, week: week, now: now ?? DateTime.now());
  final pages = <(int, int, Uint8List)>[];
  for (var i = 0; i < doc.pages.length; i++) {
    final w = (_pageW * _scale).round(), h = (_pageH * _scale).round();
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)..scale(_scale);
    doc.paintPage(canvas, i);
    final picture = recorder.endRecording();
    final image = await picture.toImage(w, h);
    picture.dispose();
    final raw = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    if (raw == null) continue;
    final rgba = raw.buffer.asUint8List();
    pages.add((w, h, await Isolate.run(() => _deflateRgb(rgba))));
  }
  doc.dispose();
  runner.dispose();
  final title = week ? sentenceCase(t.weeklyPlan) : fit.routineTitle(routines.first);
  return _writePdf(pages, title, now ?? DateTime.now());
}

Uint8List _deflateRgb(Uint8List rgba) {
  final rgb = Uint8List(rgba.length ~/ 4 * 3);
  for (var i = 0, j = 0; i < rgba.length; i += 4, j += 3) {
    rgb[j] = rgba[i];
    rgb[j + 1] = rgba[i + 1];
    rgb[j + 2] = rgba[i + 2];
  }
  return Uint8List.fromList(zlib.encode(rgb));
}

Future<ui.Image> _loadImage(String asset) async {
  final data = await rootBundle.load(asset);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  codec.dispose();
  return frame.image;
}

class _PlanDoc {
  _PlanDoc(this.runner, this.arts, {required this.rtl});

  final ui.Image runner;
  final Map<String, ExerciseArtData> arts;
  final bool rtl;
  final pages = <List<_Op>>[];
  final _painters = <TextPainter>[];
  double _y = _margin;
  (int, double)? _chainFrom;

  TextDirection get _dir => rtl ? TextDirection.rtl : TextDirection.ltr;

  double _x(double left, double width) => rtl ? _pageW - left - width : left;

  TextStyle _st(double size, {FontWeight weight = FontWeight.w600, Color color = _ink, double spacing = 0, double? height}) =>
      TextStyle(
        fontFamily: 'Nunito',
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: spacing,
        height: height,
      );

  TextPainter _measure(String text, TextStyle style, double width,
      {int maxLines = 1, TextAlign align = TextAlign.start, bool ltr = false}) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ltr ? TextDirection.ltr : _dir,
      textAlign: align,
      maxLines: maxLines,
      ellipsis: '…',
    )..layout(minWidth: width, maxWidth: width);
    _painters.add(tp);
    return tp;
  }

  void _add(_Op op) => pages.last.add(op);

  double _text(String text, TextStyle style, double left, double top, double width,
      {int maxLines = 1, TextAlign align = TextAlign.start, bool ltr = false}) {
    final tp = _measure(text, style, width, maxLines: maxLines, align: align, ltr: ltr);
    final x = _x(left, width);
    _add((c) => tp.paint(c, Offset(x, top)));
    return tp.height;
  }

  void _rect(double left, double top, double width, double height, Color color, {double radius = 0}) {
    final r = RRect.fromRectAndRadius(Rect.fromLTWH(_x(left, width), top, width, height), Radius.circular(radius));
    _add((c) => c.drawRRect(r, Paint()..color = color));
  }

  void _newPage() {
    pages.add([]);
    _y = _margin;
  }

  void _room(double h, {VoidCallback? onBreak}) {
    if (_y + h <= _bottom) return;
    _newPage();
    onBreak?.call();
  }

  void lay(List<Routine> routines, {required bool week, required DateTime now}) {
    _newPage();
    _header(routines, week: week, now: now);
    if (week) {
      if (fit.rotation && fit.rotationRoutines.isNotEmpty) {
        _rotation(fit.rotationSteps);
      } else {
        _week();
      }
    }
    for (final r in routines) {
      _routine(r, head: week);
    }
  }

  void _header(List<Routine> routines, {required bool week, required DateTime now}) {
    final logo = Rect.fromLTWH(_x(_margin, 26), _y, 26, 26);
    _add((c) => _logo(c, logo));
    _text('GymMane', _st(14, weight: FontWeight.w900), _margin + 34, _y + 4, 140);
    final who = [if (fit.profile.name.trim().isNotEmpty) fit.profile.name.trim(), t.shortDateYear(now)].join(' · ');
    _text(who, _st(9, color: _faint), _pageW - _margin - 220, _y + 8, 220, align: TextAlign.end);
    _y += 50;
    _y += _text(t.pdfKicker, _st(8.5, weight: FontWeight.w800, color: _accent, spacing: 1.8), _margin, _y, _contentW);
    _y += 4;
    final title = week ? sentenceCase(t.weeklyPlan) : fit.routineTitle(routines.first);
    _y += _text(title, _st(30, weight: FontWeight.w900, height: 1.1), _margin, _y, _contentW, maxLines: 2);
    final days = week ? const <String>[] : [for (final d in _weekdays) if (fit.plannedOn(d, routines.first.id)) t.weekdayShort(d)];
    final sub = [if (!week && routines.first.group.isNotEmpty) routines.first.group, if (days.isNotEmpty) days.join(', ')];
    if (sub.isNotEmpty) {
      _y += 2;
      _y += _text(sub.join(' · '), _st(11, color: _sub), _margin, _y, _contentW);
    }
    _y += 16;
    final exercises = routines.fold<int>(0, (n, r) => n + r.exerciseIds.length);
    final sets = routines.fold<int>(0, (n, r) => n + _setsOf(r));
    final trainDays = week
        ? _weekdays.where((d) => fit.planIdsOn(d).isNotEmpty).length
        : _weekdays.where((d) => fit.plannedOn(d, routines.first.id)).length;
    final minutes = routines.isEmpty ? 0 : (routines.fold<int>(0, (n, r) => n + _minutesOf(r)) / routines.length / 5).round() * 5;
    final stats = <(String, String)>[
      if (trainDays > 0) ('$trainDays', t.pdfStatDays),
      if (week) ('${routines.length}', t.routines),
      ('$exercises', t.exercisesCaps),
      ('$sets', t.setsCaps),
      if (minutes > 0) ('$minutes', t.pdfStatMinutes),
    ];
    const gap = 8.0, h = 52.0;
    final w = (_contentW - gap * (stats.length - 1)) / stats.length;
    for (var i = 0; i < stats.length; i++) {
      final left = _margin + i * (w + gap);
      _rect(left, _y, w, h, _soft, radius: 12);
      _text(stats[i].$1, _st(19, weight: FontWeight.w900), left + 12, _y + 9, w - 24,
          ltr: true, align: rtl ? TextAlign.right : TextAlign.left);
      _text(stats[i].$2, _st(7, weight: FontWeight.w800, color: _faint, spacing: 1), left + 12, _y + 34, w - 24);
    }
    _y += h + 22;
  }

  int _setsOf(Routine r) => r.exerciseIds.fold<int>(0, (m, id) => m + fit.routineSets(r, id));

  int _minutesOf(Routine r) {
    var sec = 0;
    for (final id in r.exerciseIds) {
      final sets = fit.routineSets(r, id);
      final planned = fit.plannedSets(r, id).where((p) => p.kind != SetKind.warmup);
      final work = planned.map((p) => p.sec ?? 0).fold<int>(0, math.max);
      sec += sets * (work > 0 ? work : 40);
      if (!fit.chainsToNext(r, id)) sec += math.max(0, sets - 1) * (fit.routineRest(r.id, id) ?? fit.restFor(id)) + 90;
    }
    return ((sec / 60) / 5).round() * 5;
  }

  List<int> get _weekdays => [for (var i = 0; i < 7; i++) (fit.weekStartDay - 1 + i) % 7 + 1];

  void _week() {
    const gap = 6.0;
    final cellW = (_contentW - gap * 6) / 7;
    final cells = <(int, List<Routine>)>[
      for (final d in _weekdays) (d, [for (final id in fit.planIdsOn(d)) ?fit.routines.where((r) => r.id == id).firstOrNull]),
    ];
    var height = 0.0;
    final names = <List<TextPainter>>[];
    for (final (_, list) in cells) {
      final ps = [
        for (final r in list.take(3)) _measure(fit.routineTitle(r), _st(9.5, weight: FontWeight.w800), cellW - 20, maxLines: 2),
      ];
      names.add(ps);
      final h = ps.isEmpty ? 14.0 : ps.fold<double>(0, (s, p) => s + p.height + 9);
      height = math.max(height, h);
    }
    height += 34;
    for (var i = 0; i < cells.length; i++) {
      final (day, list) = cells[i];
      final left = _margin + i * (cellW + gap);
      final top = _y;
      _rect(left, top, cellW, height, list.isEmpty ? _paper : _soft, radius: 10);
      if (list.isEmpty) {
        final box = RRect.fromRectAndRadius(Rect.fromLTWH(_x(left, cellW), top, cellW, height), const Radius.circular(10));
        _add((c) => c.drawRRect(
            box.deflate(0.4),
            Paint()
              ..color = _line
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.8));
      }
      _text(t.weekdayShort(day).toUpperCase(), _st(8, weight: FontWeight.w800, color: list.isEmpty ? _faint : _accent, spacing: 1.2),
          left + 7, top + 9, cellW - 14);
      var y = top + 25;
      if (list.isEmpty) {
        _text(t.restDayShort, _st(9, weight: FontWeight.w600, color: _faint), left + 7, y, cellW - 14, maxLines: 2);
      }
      for (var k = 0; k < names[i].length; k++) {
        final r = list[k];
        _rect(left + 7, y + 1, 3, names[i][k].height - 2, folderHue(r), radius: 1.5);
        final tp = names[i][k];
        final at = Offset(_x(left + 13, cellW - 20), y);
        _add((c) => tp.paint(c, at));
        y += tp.height + 9;
      }
    }
    _y += height + 26;
  }

  void _rotation(List<String> list) {
    _y += _text(t.planRotation.toUpperCase(), _st(8, weight: FontWeight.w800, color: _accent, spacing: 1.4), _margin, _y, _contentW);
    _y += 8;
    var x = 0.0;
    const h = 26.0;
    for (var i = 0; i < list.length; i++) {
      final routine = fit.routineById(list[i]);
      final label = '${i + 1}  ${routine == null ? t.restDayShort : fit.routineTitle(routine)}';
      final w = math.min(160.0, _textWidth(label, _st(10, weight: FontWeight.w800))) + 24;
      final arrow = i < list.length - 1 ? 18.0 : 0.0;
      if (x + w > _contentW) {
        x = 0;
        _y += h + 8;
      }
      _rect(_margin + x, _y, w, h, _soft, radius: 13);
      _rect(_margin + x + 9, _y + 9, 8, 8, routine == null ? _faint : folderHue(routine), radius: 4);
      final fitted = _measure(label, _st(10, weight: FontWeight.w800), w - 24);
      final at = Offset(_x(_margin + x + 20, w - 24), _y + (h - fitted.height) / 2);
      _add((c) => fitted.paint(c, at));
      if (arrow > 0) {
        final ax = _margin + x + w + 4;
        final ay = _y + h / 2;
        final from = Offset(_x(ax, 0), ay), to = Offset(_x(ax + 10, 0), ay);
        _add((c) {
          final p = Paint()
            ..color = _faint
            ..strokeWidth = 1.2
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke;
          c.drawLine(from, to, p);
          final back = rtl ? 3.5 : -3.5;
          c.drawLine(to, to.translate(back, -3), p);
          c.drawLine(to, to.translate(back, 3), p);
        });
      }
      x += w + arrow + 4;
    }
    _y += h + 28;
  }

  double _textWidth(String s, TextStyle st) {
    final tp = TextPainter(text: TextSpan(text: s, style: st), textDirection: _dir)..layout();
    final w = tp.width;
    tp.dispose();
    return w;
  }

  static const _cThumb = 0.0, _cName = 46.0;
  static const _cSets = _contentW - 232, _cReps = _contentW - 186, _cWeight = _contentW - 122, _cRest = _contentW - 56;
  static const _wSets = 40.0, _wReps = 60.0, _wWeight = 62.0, _wRest = 56.0;

  void _routine(Routine r, {bool head = true}) {
    final days = [for (final d in _weekdays) if (fit.plannedOn(d, r.id)) t.weekdayShort(d)];
    _room(120);
    _index++;
    if (head) _routineHead(r, days);
    _tableHead();
    final ids = r.exerciseIds;
    for (var i = 0; i < ids.length; i++) {
      final ex = fit.exerciseById(ids[i]);
      if (ex == null) continue;
      final row = _rowHeight(r, ex);
      _room(row, onBreak: () {
        _routineHead(r, days, again: true);
        _tableHead();
      });
      _row(r, ex, i, row);
    }
    _chainFrom = null;
    _y += 24;
  }

  int _index = 0;

  void _routineHead(Routine r, List<String> days, {bool again = false}) {
    final top = _y;
    final badge = again ? 18.0 : 24.0;
    _rect(_margin - 1, top + (again ? 0 : 1), badge, badge, folderHue(r), radius: badge / 2);
    _text('$_index', _st(again ? 9 : 11.5, weight: FontWeight.w900), _margin - 1, top + (again ? 2.5 : 5), badge,
        align: TextAlign.center, ltr: true);
    final title = again ? '${fit.routineTitle(r)} ·  ${t.exerciseCount(r.exerciseIds.length)}' : fit.routineTitle(r);
    final h = _text(title, _st(again ? 12 : 17, weight: FontWeight.w900), _margin + badge + 9, top, _contentW - 150 - badge);
    if (days.isNotEmpty) {
      _text(days.join(' · ').toUpperCase(), _st(8.5, weight: FontWeight.w800, color: _accent, spacing: 1.1),
          _pageW - _margin - 140, top + (again ? 3 : 6), 140, align: TextAlign.end);
    }
    _y = top + h + 2;
    if (!again) {
      final minutes = _minutesOf(r);
      final meta = [
        if (r.group.isNotEmpty) r.group,
        t.exerciseCount(r.exerciseIds.length),
        t.setsThisWeek(_setsOf(r)),
        if (minutes > 0) t.pdfMinutes(minutes),
      ].join(' · ');
      _y += _text(meta, _st(10, color: _sub), _margin + badge + 9, _y, _contentW - badge - 9);
    }
    _y += 12;
  }

  void _tableHead() {
    final st = _st(7.5, weight: FontWeight.w800, color: _faint, spacing: 0.8);
    _text(t.exercisesCaps, st, _margin + _cName, _y, _cSets - _cName - 8);
    _text(t.setsCaps, st, _margin + _cSets, _y, _wSets, align: TextAlign.center);
    _text(t.repsCol, st, _margin + _cReps, _y, _wReps, align: TextAlign.center);
    _text(t.weightCol(fit.units).replaceAll(RegExp(r'\s*\(.*\)'), ''), st, _margin + _cWeight, _y, _wWeight, align: TextAlign.center);
    _text(t.rest, st, _margin + _cRest, _y, _wRest, align: TextAlign.center);
    _y += 14;
    _rect(_margin, _y, _contentW, 0.8, _line);
    _y += 1;
  }

  String _detail(Routine r, Exercise ex) {
    final warm = fit.plannedSets(r, ex.id).where((p) => p.kind == SetKind.warmup).length;
    return [
      t.muscle(ex.primary),
      if (fit.isEachSide(ex.id)) t.eachSide,
      if (warm > 0) '+$warm ${t.setTypeWarmup.toLowerCase()}',
    ].join(' · ');
  }

  double _rowHeight(Routine r, Exercise ex) {
    final name = _measure(exerciseName(ex), _st(11.5, weight: FontWeight.w800), _cSets - _cName - 8, maxLines: 2);
    final detail = _measure(_detail(r, ex), _st(9, color: _sub), _cSets - _cName - 8);
    return math.max(46.0, name.height + detail.height + 18);
  }

  (String, String) _amounts(Routine r, Exercise ex) {
    final planned = fit.plannedSets(r, ex.id).where((p) => p.kind != SetKind.warmup).toList();
    String spread(List<String> v) {
      if (v.isEmpty) return '—';
      final unique = v.toSet();
      if (unique.length == 1) return v.first;
      return v.length <= 4 ? v.join(' · ') : '${v.first}–${v.last}';
    }

    final timed = fit.isTimed(ex.id);
    final reps = spread([
      for (final p in planned)
        if (p.km != null)
          '${fmt(p.km!)} km'
        else if (timed && p.sec != null)
          durationLabel(p.sec!)
        else if (p.reps != null)
          '${p.reps}',
    ]);
    final kgs = [for (final p in planned) if (p.weightKg != null && p.weightKg! > 0) p.weightKg!];
    String weight;
    if (kgs.isEmpty) {
      weight = '—';
    } else {
      final lo = kgs.reduce(math.min), hi = kgs.reduce(math.max);
      String n(double kg) => fmt((fit.toDisplayWeight(kg) * 10).round() / 10);
      weight = lo == hi ? '${n(lo)} ${fit.units}' : '${n(lo)}–${n(hi)} ${fit.units}';
    }
    return (reps, weight);
  }

  void _row(Routine r, Exercise ex, int index, double height) {
    final top = _y;
    final mid = top + height / 2;
    if (index.isOdd) _rect(_margin + _cName - 8, top, _contentW - _cName + 8, height, _zebra, radius: 8);
    _rect(_margin + _cThumb, mid - 18, 36, 36, _soft, radius: 9);
    final art = arts[ex.art];
    final box = Rect.fromLTWH(_x(_margin + _cThumb, 36), mid - 18, 36, 36).deflate(4);
    if (art != null) {
      _add((c) => _drawArt(c, art, box));
    } else if (exerciseName(ex).isNotEmpty) {
      _text(String.fromCharCode(exerciseName(ex).runes.first).toUpperCase(), _st(14, weight: FontWeight.w900, color: _faint),
          _margin + _cThumb, mid - 10, 36, align: TextAlign.center);
    }
    final nameW = _cSets - _cName - 8;
    final name = _measure(exerciseName(ex), _st(11.5, weight: FontWeight.w800), nameW, maxLines: 2);
    final detail = _measure(_detail(r, ex), _st(9, color: _sub), nameW);
    final ny = mid - (name.height + detail.height + 2) / 2;
    final nx = _x(_margin + _cName, nameW);
    _add((c) {
      name.paint(c, Offset(nx, ny));
      detail.paint(c, Offset(nx, ny + name.height + 2));
    });
    final (reps, weight) = _amounts(r, ex);
    final chained = fit.chainsToNext(r, ex.id);
    final rest = fit.routineRest(r.id, ex.id) ?? fit.restFor(ex.id);
    final value = _st(11, weight: FontWeight.w800);
    final count = fit.routineSets(r, ex.id);
    _text('$count', _st(13, weight: FontWeight.w900), _margin + _cSets, mid - 13, _wSets, align: TextAlign.center);
    final dots = math.min(count, 6);
    const dot = 4.6, step = 6.4;
    final dx = _margin + _cSets + (_wSets - (dots * step - (step - dot))) / 2;
    for (var k = 0; k < dots; k++) {
      final o = Rect.fromLTWH(_x(dx + k * step, dot), mid + 6, dot, dot);
      _add((c) => c.drawOval(
          o,
          Paint()
            ..color = _faint
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.7));
    }
    _text(reps, value, _margin + _cReps, mid - 8, _wReps, align: TextAlign.center, ltr: true);
    _text(weight, value, _margin + _cWeight, mid - 8, _wWeight, align: TextAlign.center, ltr: true);
    _text(
        chained
            ? t.superset
            : rest <= 0
                ? t.restOff
                : durationLabel(rest),
        chained ? _st(8.5, weight: FontWeight.w800, color: _accent) : value,
        _margin + _cRest,
        mid - (chained ? 6 : 8),
        _wRest,
        align: TextAlign.center);
    final from = _chainFrom;
    if (from != null && from.$1 == pages.length) {
      final x = _x(_margin - 12, 0);
      final a = Offset(x, from.$2), b = Offset(x, mid);
      _add((c) => c.drawLine(
          a,
          b,
          Paint()
            ..color = _accent
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round));
    }
    _chainFrom = chained ? (pages.length, mid) : null;
    _y += height;
    _rect(_margin + _cName, _y, _contentW - _cName, 0.6, _line);
    _y += 1;
  }

  void _drawArt(Canvas c, ExerciseArtData art, Rect box) {
    final b = art.bounds;
    if (b.width <= 0 || b.height <= 0) return;
    final k = math.min(box.width / b.width, box.height / b.height);
    c.save();
    c.translate(box.center.dx - b.center.dx * k, box.center.dy - b.center.dy * k);
    c.scale(k);
    c.drawPath(art.frames.first, Paint()..color = _ink);
    c.restore();
  }

  void _logo(Canvas c, Rect r) {
    c.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(r.width * 0.24)), Paint()..color = const Color(0xFF0B0B0B));
    final src = Rect.fromLTWH(0, 0, runner.width.toDouble(), runner.height.toDouble());
    final h = r.height * 0.72;
    final w = h * src.width / src.height;
    final dst = Rect.fromCenter(center: r.center, width: w, height: h);
    c.saveLayer(dst, Paint());
    c.drawImageRect(runner, src, dst, Paint()..filterQuality = FilterQuality.high);
    c.drawRect(
        dst,
        Paint()
          ..blendMode = BlendMode.srcIn
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEBC1A3), Color(0xFFB98A6E)],
          ).createShader(dst));
    c.restore();
  }

  void paintPage(Canvas c, int index) {
    c.drawRect(const Rect.fromLTWH(0, 0, _pageW, _pageH), Paint()..color = _paper);
    final src = Rect.fromLTWH(0, 0, runner.width.toDouble(), runner.height.toDouble());
    const h = 470.0;
    final w = h * src.width / src.height;
    c.save();
    c.translate(_pageW / 2, _pageH / 2 + 30);
    c.rotate(-0.12);
    c.drawImageRect(
        runner,
        src,
        Rect.fromCenter(center: Offset.zero, width: w, height: h),
        Paint()
          ..filterQuality = FilterQuality.high
          ..colorFilter = ColorFilter.mode(_accent.withValues(alpha: 0.045), BlendMode.srcIn));
    c.restore();
    for (final op in pages[index]) {
      op(c);
    }
    _footer(c, index);
  }

  void _footer(Canvas c, int index) {
    const y = _pageH - 36;
    c.drawRect(const Rect.fromLTWH(_margin, y - 10, _contentW, 0.6), Paint()..color = _line);
    _logo(c, Rect.fromLTWH(_x(_margin, 12), y - 1, 12, 12));
    final brand = TextPainter(
      text: TextSpan(children: [
        TextSpan(text: 'GymMane', style: _st(8.5, weight: FontWeight.w900)),
        TextSpan(text: '  ·  ${t.pdfFooter}', style: _st(8, color: _faint)),
      ]),
      textDirection: _dir,
      maxLines: 1,
      ellipsis: '…',
    )..layout(minWidth: _contentW - 80, maxWidth: _contentW - 80);
    brand.paint(c, Offset(_x(_margin + 18, _contentW - 80), y));
    final page = TextPainter(
      text: TextSpan(text: '${index + 1} / ${pages.length}', style: _st(8.5, weight: FontWeight.w700, color: _faint)),
      textDirection: TextDirection.ltr,
      textAlign: rtl ? TextAlign.left : TextAlign.right,
    )..layout(minWidth: 60, maxWidth: 60);
    page.paint(c, Offset(_x(_pageW - _margin - 60, 60), y));
    brand.dispose();
    page.dispose();
  }

  void dispose() {
    for (final p in _painters) {
      p.dispose();
    }
  }
}

const _author = 'InlitX';
const _app = 'GymMane';
const _site = 'https://github.com/InlitX/GymMane';

String _two(int n) => n.toString().padLeft(2, '0');

String _pdfDate(DateTime d) {
  final off = d.timeZoneOffset;
  final sign = off.isNegative ? '-' : '+';
  return 'D:${d.year}${_two(d.month)}${_two(d.day)}${_two(d.hour)}${_two(d.minute)}${_two(d.second)}'
      "$sign${_two(off.inHours.abs())}'${_two(off.inMinutes.abs() % 60)}'";
}

String _isoDate(DateTime d) {
  final off = d.timeZoneOffset;
  final sign = off.isNegative ? '-' : '+';
  return '${d.toIso8601String().split('.').first}$sign${_two(off.inHours.abs())}:${_two(off.inMinutes.abs() % 60)}';
}

String _xml(String s) => s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');

String _xmp(String title, String subject, String keywords, String lang, DateTime now) => '''
<?xpacket begin="\u{FEFF}" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xmp="http://ns.adobe.com/xap/1.0/" xmlns:pdf="http://ns.adobe.com/pdf/1.3/">
<dc:title><rdf:Alt><rdf:li xml:lang="x-default">${_xml(title)}</rdf:li></rdf:Alt></dc:title>
<dc:creator><rdf:Seq><rdf:li>$_author</rdf:li></rdf:Seq></dc:creator>
<dc:description><rdf:Alt><rdf:li xml:lang="x-default">${_xml(subject)}</rdf:li></rdf:Alt></dc:description>
<dc:language><rdf:Bag><rdf:li>$lang</rdf:li></rdf:Bag></dc:language>
<dc:source>$_site</dc:source>
<xmp:CreatorTool>$_app</xmp:CreatorTool>
<xmp:CreateDate>${_isoDate(now)}</xmp:CreateDate>
<xmp:ModifyDate>${_isoDate(now)}</xmp:ModifyDate>
<pdf:Producer>$_app by $_author</pdf:Producer>
<pdf:Keywords>${_xml(keywords)}</pdf:Keywords>
</rdf:Description>
</rdf:RDF>
</x:xmpmeta>
<?xpacket end="w"?>''';

Uint8List _writePdf(List<(int, int, Uint8List)> pages, String title, DateTime now) {
  final out = BytesBuilder(copy: false);
  final offsets = <int>[];
  void raw(List<int> b) => out.add(b);
  void w(String s) => raw(latin1.encode(s));
  void obj(int id, String dict, [Uint8List? stream]) {
    while (offsets.length < id) {
      offsets.add(0);
    }
    offsets[id - 1] = out.length;
    w('$id 0 obj\n$dict\n');
    if (stream != null) {
      w('stream\n');
      raw(stream);
      w('\nendstream\n');
    }
    w('endobj\n');
  }

  String utf16(String s) {
    final b = StringBuffer('<FEFF');
    for (final u in s.codeUnits) {
      b.write(u.toRadixString(16).padLeft(4, '0').toUpperCase());
    }
    b.write('>');
    return b.toString();
  }

  w('%PDF-1.4\n');
  raw([0x25, 0xE2, 0xE3, 0xCF, 0xD3, 0x0A]);
  final n = pages.length;
  final lang = intlLocale.replaceAll('_', '-');
  final subject = '${sentenceCase(t.pdfKicker)} · $_app';
  final keywords = '$_app, ${t.pdfKicker.toLowerCase()}';
  final date = _pdfDate(now);
  final xmp = Uint8List.fromList(utf8.encode(_xmp(title, subject, keywords, lang, now)));
  final kids = [for (var i = 0; i < n; i++) '${5 + i * 3} 0 R'].join(' ');
  obj(1, '<< /Type /Catalog /Pages 2 0 R /Metadata 4 0 R /Lang ($lang) /ViewerPreferences << /DisplayDocTitle true >> >>');
  obj(2, '<< /Type /Pages /Kids [$kids] /Count $n >>');
  obj(3,
      '<< /Title ${utf16(title)} /Author ${utf16(_author)} /Subject ${utf16(subject)} /Keywords ${utf16(keywords)} '
      '/Creator ${utf16('$_app · $_site')} /Producer ${utf16('$_app by $_author')} /CreationDate ($date) /ModDate ($date) >>');
  obj(4, '<< /Type /Metadata /Subtype /XML /Length ${xmp.length} >>', xmp);
  for (var i = 0; i < n; i++) {
    final (pw, ph, data) = pages[i];
    final page = 5 + i * 3, content = page + 1, image = page + 2;
    final draw = latin1.encode('q $_pageW 0 0 $_pageH 0 0 cm /Im0 Do Q');
    obj(page,
        '<< /Type /Page /Parent 2 0 R /MediaBox [0 0 $_pageW $_pageH] /Resources << /XObject << /Im0 $image 0 R >> >> /Contents $content 0 R >>');
    obj(content, '<< /Length ${draw.length} >>', Uint8List.fromList(draw));
    obj(image,
        '<< /Type /XObject /Subtype /Image /Width $pw /Height $ph /ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /FlateDecode /Length ${data.length} >>',
        data);
  }
  final xref = out.length;
  w('xref\n0 ${offsets.length + 1}\n0000000000 65535 f \n');
  for (final o in offsets) {
    w('${o.toString().padLeft(10, '0')} 00000 n \n');
  }
  w('trailer\n<< /Size ${offsets.length + 1} /Root 1 0 R /Info 3 0 R >>\nstartxref\n$xref\n%%EOF\n');
  return out.takeBytes();
}
