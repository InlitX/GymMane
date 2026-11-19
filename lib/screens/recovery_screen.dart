import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../app/desktop.dart';
import '../l10n/l10n.dart';
import '../models/recovery.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/recovery_art.dart';
import '../widgets/rolling_text.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/ui_kit.dart';
import 'recovery_player.dart';

export 'recovery_player.dart' show showBreathSheet;

String recoveryKindName(String kind) => switch (kind) {
      'sauna' => t.recoveryKindSauna,
      'cold' => t.recoveryKindCold,
      'contrast' => t.recoveryKindContrast,
      _ => t.recoveryKindBreath,
    };

String recoveryKindDesc(String kind) => switch (kind) {
      'sauna' => t.recoveryDescSauna,
      'cold' => t.recoveryDescCold,
      'contrast' => t.recoveryDescContrast,
      _ => t.recoveryDescBreath,
    };

String _minutes(int sec) => sec < 60 ? clockOf(sec) : '${(sec / 60).round()} min';

String _temp(double c) => fit.isLb ? '${(c * 9 / 5 + 32).round()} °F' : '${c.round()} °C';

String recoveryDetail(RecoveryEntry e) {
  final parts = <String>[
    if (e.kind == 'contrast') ...[
      '${_minutes(e.sec)} ${t.recoveryHeat.toLowerCase()}',
      '${_minutes(e.coldSec)} ${t.recoveryCold.toLowerCase()}',
    ] else if (e.kind == 'cold')
      clockOf(e.sec)
    else
      _minutes(e.sec),
    if (e.tempC != null) _temp(e.tempC!),
    if (e.rounds > 1) t.recoveryRoundsCount(e.rounds),
    if (e.pattern case final p?) breathName(p),
    if (e.bestHold > 0) t.recoveryBestHold(clockOf(e.bestHold)),
    if (e.feel case final f?) '$f/5',
  ];
  return parts.join(' · ');
}

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final wide = DesktopScope.of(context);
    final recent = fit.recoveryRecent;
    return SafeArea(
      bottom: false,
      child: RiseScope(
        id: 'recovery',
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: wide ? const EdgeInsets.fromLTRB(32, 30, 32, 48) : const EdgeInsets.fromLTRB(20, 12, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScreenHeader(title: t.recoveryTitle, onBack: fit.popRoute, titleSize: 22),
              const SizedBox(height: 18),
              const Rise(index: 0, child: _WeekCard()),
              const SizedBox(height: 26),
              Rise(index: 1, child: SectionLabel(t.recoveryLog)),
              const SizedBox(height: 12),
              Rise(
                index: 2,
                child: LayoutBuilder(builder: (context, box) {
                  final cols = box.maxWidth >= 640 ? 4 : 2;
                  const gap = 12.0;
                  final w = (box.maxWidth - gap * (cols - 1)) / cols;
                  return Wrap(spacing: gap, runSpacing: gap, children: [
                    for (final kind in kRecoveryKinds) SizedBox(width: w, child: _KindCard(kind)),
                  ]);
                }),
              ),
              const SizedBox(height: 12),
              const Rise(index: 3, child: _MobilityRow()),
              const SizedBox(height: 26),
              Rise(index: 4, child: SectionLabel(t.recoveryRecent)),
              const SizedBox(height: 8),
              if (recent.isEmpty)
                Rise(
                  index: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(t.recoveryEmpty,
                        style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                  ),
                )
              else
                Rise(
                  index: 5,
                  child: SoftCard(
                    radius: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    child: Column(children: [for (final e in recent.take(30)) _RecentRow(e)]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard();

  Future<void> _goal(BuildContext context, bool heat) async {
    final v = await askNumber(context,
        title: heat ? t.recoveryGoalHeat : t.recoveryGoalCold,
        initial: '${heat ? fit.heatGoalMin : fit.coldGoalMin}',
        decimal: false);
    if (v == null) return;
    heat ? fit.setRecoveryGoals(heat: v.round()) : fit.setRecoveryGoals(cold: v.round());
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final week = fit.recoveryWeek;
    final days = fit.recoveryWeekDays;
    final top = days.fold(0, math.max);
    final today = DateTime.now().difference(fit.weekStartDate).inDays;
    final bestCold = fit.bestColdSec;
    final bestHold = fit.bestHoldSec;

    Widget bar(double value, double goal) => ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: SizedBox(
            height: 5,
            width: double.infinity,
            child: ColoredBox(
              color: gc.bgRaised2,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: FractionallySizedBox(
                  widthFactor: goal <= 0 ? 0 : (value / goal).clamp(0.0, 1.0),
                  heightFactor: 1,
                  child: ColoredBox(color: gc.text),
                ),
              ),
            ),
          ),
        );

    Widget goalBlock({required bool heat, required int sec, required double size}) {
      final goal = heat ? fit.heatGoalMin : fit.coldGoalMin;
      final min = (sec / 60).round();
      return Semantics(
        button: true,
        label: heat ? t.recoveryGoalHeat : t.recoveryGoalCold,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _goal(context, heat),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text((heat ? t.recoveryHeat : t.recoveryCold).toUpperCase(),
                style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
            const SizedBox(height: 4),
            Ltr(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  RollingText('$min', style: AppTheme.f(size, weight: FontWeight.w800, color: gc.text, height: 1)),
                  const SizedBox(width: 5),
                  Text('min', style: AppTheme.f(size * 0.36, weight: FontWeight.w700, color: gc.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            bar(sec / 60, goal.toDouble()),
            const SizedBox(height: 5),
            FitText(t.recoveryOfGoal(goal), style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
          ]),
        ),
      );
    }

    return SoftCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(flex: 3, child: goalBlock(heat: true, sec: week.heat, size: 44)),
          const SizedBox(width: 22),
          Expanded(flex: 2, child: goalBlock(heat: false, sec: week.cold, size: 30)),
        ]),
        const SizedBox(height: 18),
        SizedBox(
          height: 52,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            for (var i = 0; i < 7; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    width: 8,
                    height: days[i] == 0 ? 4 : 6 + 24 * days[i] / math.max(1, top),
                    decoration: BoxDecoration(
                      color: days[i] == 0 ? gc.bgRaised2 : (i == today ? gc.text : gc.text.withValues(alpha: 0.45)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(t.weekdayInitial((fit.weekStartDay - 1 + i) % 7 + 1),
                      style: AppTheme.f(10.5, weight: FontWeight.w700, color: i == today ? gc.text : gc.textTertiary)),
                ]),
              ),
            ],
          ]),
        ),
        if (week.breath > 0 || bestCold > 0 || bestHold > 0) ...[
          const SizedBox(height: 14),
          Text(
            [
              if (week.breath > 0) '${t.recoveryKindBreath}: ${_minutes(week.breath)}',
              if (bestCold > 0) t.recoveryBestCold(clockOf(bestCold)),
              if (bestHold > 0) t.recoveryBestHold(clockOf(bestHold)),
            ].join(' · '),
            style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary, height: 1.4),
          ),
        ],
      ]),
    );
  }
}

class _KindCard extends StatelessWidget {
  const _KindCard(this.kind);

  final String kind;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final scale = MediaQuery.textScalerOf(context).scale(1);
    return Semantics(
      button: true,
      label: recoveryKindName(kind),
      child: Pressable(
        onTap: () => kind == 'breath' ? showBreathSheet(context) : showRecoverySheet(context, kind),
        scale: 0.96,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 58, child: RecoveryArt(kind)),
            const SizedBox(height: 14),
            Text(recoveryKindName(kind),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 2),
            SizedBox(
              height: 31 * scale,
              child: Text(recoveryKindDesc(kind),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
            ),
          ]),
        ),
      ),
    );
  }
}

class _MobilityRow extends StatelessWidget {
  const _MobilityRow();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: t.recoveryMobility,
      child: Pressable(
        onTap: () {
          fit.clearExFilters();
          fit.setKindFilter('stretch');
          fit.goExercises();
        },
        scale: 0.97,
        child: Container(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
          child: Row(children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
              child: Icon(PhosphorIconsRegular.personSimpleTaiChi, size: 20, color: gc.text),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.recoveryMobility,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 2),
                Text(t.recoveryMobilityHint,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
              ]),
            ),
            Icon(PhosphorIconsRegular.caretRight, size: 16, color: gc.textTertiary),
          ]),
        ),
      ),
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow(this.e);

  final RecoveryEntry e;

  Future<void> _delete(BuildContext context) async {
    final ok = await askConfirm(context,
        title: t.recoveryDeleteTitle,
        body: '${recoveryKindName(e.kind)} · ${recoveryDetail(e)}',
        confirmLabel: t.delete,
        danger: true);
    if (ok) fit.removeRecovery(e.id);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      label: '${recoveryKindName(e.kind)}, ${recoveryDetail(e)}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _delete(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            SizedBox(width: 46, height: 38, child: FittedBox(child: RecoveryArt(e.kind, size: 36))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(recoveryKindName(e.kind),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                const SizedBox(height: 2),
                Text(recoveryDetail(e),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
              ]),
            ),
            const SizedBox(width: 10),
            Text(t.shortDate(e.date), style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
          ]),
        ),
      ),
    );
  }
}

Future<void> showRecoverySheet(BuildContext context, String kind) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RecoverySheet(kind: kind),
    );

class _Field {
  _Field(this.id, this.label, this.value, this.lo, this.hi, this.step, this.major, {this.on = true});

  final String id;
  final String label;
  double value;
  final double lo;
  final double hi;
  final double step;
  final int major;
  bool on;
}

enum _Mode { setup, running, done }

class _RecoverySheet extends StatefulWidget {
  const _RecoverySheet({required this.kind});

  final String kind;

  @override
  State<_RecoverySheet> createState() => _RecoverySheetState();
}

class _RecoverySheetState extends State<_RecoverySheet> {
  final _note = TextEditingController();
  late final List<_Field> _fields = _build();
  var _active = 0;
  var _mode = _Mode.setup;
  int? _feel;
  String? _savedId;
  ({int heat, int cold, int rest, int rounds})? _done;

  String get _kind => widget.kind;

  double _toShown(double c) => fit.isLb ? c * 9 / 5 + 32 : c;

  double _fromShown(double v) => fit.isLb ? (v - 32) * 5 / 9 : v;

  List<_Field> _build() {
    final last = fit.lastRecovery(_kind);
    final lb = fit.isLb;
    final cold = _kind == 'cold';
    return [
      if (cold)
        _Field('min', t.recoveryGoal, ((last?.sec ?? 120) / 60 * 2).roundToDouble() / 2, 0.5, 15, 0.5, 2)
      else
        _Field('min', _kind == 'contrast' ? t.recoveryHeat : t.recoveryMinutes,
            ((last?.sec ?? 900) / 60 / math.max(1, last?.rounds ?? 1)).roundToDouble().clamp(1, 60), 0, 60, 1, 5),
      if (_kind == 'contrast')
        _Field('cold', t.recoveryCold, ((last?.coldSec ?? 180) / 60 / math.max(1, last?.rounds ?? 1) * 2).roundToDouble() / 2,
            0.5, 15, 0.5, 2),
      if (_kind == 'sauna')
        _Field('rest', t.recoveryRest,
            (last == null || last.restSec == 0 ? 5.0 : (last.restSec / 60 / math.max(1, last.rounds - 1)).roundToDouble()).clamp(0, 30),
            0, 30, 1, 5),
      if (_kind != 'contrast')
        _Field(
          'temp',
          t.recoveryTemp,
          _toShown(last?.tempC ?? (cold ? 10 : 80)).roundToDouble(),
          cold ? (lb ? 32 : 0) : (lb ? 104 : 40),
          cold ? (lb ? 68 : 20) : (lb ? 230 : 110),
          1,
          lb ? 10 : 5,
          on: last?.tempC != null,
        ),
      if (_kind != 'cold')
        _Field('rounds', t.recoveryRounds, (last?.rounds ?? (_kind == 'contrast' ? 3 : 2)).toDouble().clamp(1, 10), 1, 10, 1, 1),
    ];
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  _Field? _byId(String id) {
    for (final f in _fields) {
      if (f.id == id) return f;
    }
    return null;
  }

  int _sec(String id) => ((_byId(id)?.value ?? 0) * 60).round();

  int get _rounds => (_byId('rounds')?.value ?? 1).round();

  List<(String, int)> get _plan => recoveryPlan(_kind,
      heat: math.max(30, _sec('min')), cold: math.max(30, _sec('cold')), rest: _sec('rest'), rounds: _rounds);

  double? get _tempC {
    final temp = _byId('temp');
    if (temp == null || !temp.on) return null;
    return (_fromShown(temp.value) * 10).round() / 10;
  }

  String _show(_Field f) => f.step < 1 ? clockOf((f.value * 60).round()) : '${f.value.round()}';

  String _unit(_Field f) => switch (f.id) {
        'temp' => fit.isLb ? '°F' : '°C',
        'rounds' => '',
        _ => f.step < 1 ? '' : 'min',
      };

  void _logNow() {
    final rounds = _kind == 'cold' ? 1 : _rounds;
    _savedId = fit
        .addRecovery(
          kind: _kind,
          sec: math.max(1, _sec('min')) * (_kind == 'cold' ? 1 : rounds),
          coldSec: _sec('cold') * rounds,
          restSec: _kind == 'sauna' ? _sec('rest') * (rounds - 1) : 0,
          tempC: _tempC,
          rounds: rounds,
          feel: _feel,
          note: _note.text,
        )
        .id;
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
  }

  void _startTimer() {
    fit.seeRecoveryTip();
    FocusScope.of(context).unfocus();
    HapticFeedback.mediumImpact();
    setState(() => _mode = _Mode.running);
  }

  void _finished(({int heat, int cold, int rest, int rounds}) done) {
    final sec = _kind == 'cold' ? done.cold : done.heat;
    if (sec >= 10) {
      _savedId = fit
          .addRecovery(
            kind: _kind,
            sec: sec,
            coldSec: _kind == 'contrast' ? done.cold : 0,
            restSec: done.rest,
            tempC: _tempC,
            rounds: done.rounds,
            note: _note.text,
          )
          .id;
    }
    setState(() {
      _done = done;
      _mode = _Mode.done;
    });
  }

  Widget _tile(GymColors gc, int i) {
    final f = _fields[i];
    final on = i == _active;
    final unit = _unit(f);
    final value = unit.isEmpty ? _show(f) : '${_show(f)} $unit';
    return Semantics(
      button: true,
      selected: on,
      label: f.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            _active = i;
            f.on = true;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          decoration: BoxDecoration(
            color: on ? gc.bgRaised2 : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: on ? gc.accent.withValues(alpha: 0.5) : gc.border.withValues(alpha: 0.6)),
          ),
          child: Column(children: [
            FitText(f.label.toUpperCase(),
                style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1)),
            const SizedBox(height: 4),
            SizedBox(
              height: 28,
              child: Center(
                child: f.on
                    ? Ltr(child: FitText(value, style: AppTheme.f(20, weight: FontWeight.w800, color: on ? gc.text : gc.textSecondary)))
                    : Text(t.recoveryAdd, style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.accent)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _setup(GymColors gc) {
    final f = _fields[_active];
    final best = fit.bestColdSec;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (!fit.recoveryTipSeen) ...[
        const RecoveryTip(),
        const SizedBox(height: 14),
      ],
      Row(children: [
        for (var i = 0; i < _fields.length; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Expanded(child: _tile(gc, i)),
        ],
      ]),
      const SizedBox(height: 14),
      RulerPicker(
        key: ValueKey('$_active'),
        value: f.value.clamp(f.lo, f.hi),
        min: f.lo,
        max: f.hi,
        step: f.step,
        majorEvery: f.major,
        label: (v) => f.step < 1 ? '${v.round()}' : '${v.round()}',
        onChanged: (v) => setState(() {
          f.value = v;
          f.on = true;
        }),
      ),
      if (_kind == 'cold' && best > 0) ...[
        const SizedBox(height: 6),
        Center(
          child: Text(t.recoveryBestCold(clockOf(best)),
              style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
        ),
      ],
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: _note,
          maxLength: 200,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: gc.accent,
          style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: t.recoveryNoteHint,
            hintStyle: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.textTertiary),
            counterText: '',
          ),
        ),
      ),
      const SizedBox(height: 16),
      PrimaryButton(label: t.recoveryStart, onTap: _startTimer),
      const SizedBox(height: 4),
      Center(
        child: TextButton(
          onPressed: _logNow,
          child: Text(t.recoveryJustLog, style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.textSecondary)),
        ),
      ),
    ]);
  }

  Widget _summary(GymColors gc) {
    final d = _done!;
    final parts = [
      if (d.heat > 0) '${t.recoveryHeat} ${clockOf(d.heat)}',
      if (d.cold > 0) '${t.recoveryCold} ${clockOf(d.cold)}',
      if (d.rounds > 1) t.recoveryRoundsCount(d.rounds),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 10),
      Center(child: SizedBox(height: 86, child: RecoveryArt(_kind, size: 86))),
      const SizedBox(height: 16),
      Center(child: Text(t.breathDone, style: AppTheme.f(24, weight: FontWeight.w800, color: gc.text))),
      const SizedBox(height: 6),
      Center(
        child: Text(parts.join(' · '),
            textAlign: TextAlign.center, style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.textSecondary)),
      ),
      const SizedBox(height: 22),
      FeelPicker(
        value: _feel,
        onChanged: (v) {
          setState(() => _feel = v);
          if (_savedId != null) fit.setRecoveryFeel(_savedId!, v);
        },
      ),
      const SizedBox(height: 18),
      PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final body = switch (_mode) {
      _Mode.setup => _setup(gc),
      _Mode.running => GuidedTimer(kind: _kind, plan: _plan, onFinish: _finished),
      _Mode.done => _summary(gc),
    };
    return PopScope(
      canPop: _mode != _Mode.running,
      child: Container(
        decoration: sheetDecoration(gc),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SheetHandle(margin: const EdgeInsets.symmetric(vertical: 12)),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Row(children: [
                    SizedBox(width: 60, height: 44, child: FittedBox(child: RecoveryArt(_kind, size: 42))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(recoveryKindName(_kind),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
                        Text(recoveryKindDesc(_kind),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary)),
                      ]),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: KeyedSubtree(key: ValueKey(_mode), child: body),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
