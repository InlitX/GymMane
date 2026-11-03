import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/circuit.dart';
import '../models/exercise.dart';
import '../services/beeper.dart';
import '../services/exercise_match.dart';
import '../services/screen_awake.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/dialogs.dart';
import '../widgets/exercise_media.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/rolling_text.dart';
import '../widgets/ruler_picker.dart';
import '../widgets/timer_panel.dart' show clockLabel;
import '../widgets/ui_kit.dart';

String _secs(int s) => s < 60 ? '$s s' : clockLabel(s);

class CircuitSection extends StatelessWidget {
  const CircuitSection({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final label = AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 4),
        child: Row(children: [
          Expanded(child: Text(t.circuits.toUpperCase(), style: label)),
          if (fit.circuits.isNotEmpty)
            RoundAction(
              label: t.newCircuit,
              size: 32,
              onTap: () => showCircuitEditor(context),
              child: Icon(PhosphorIconsBold.plus, size: 14, color: gc.text),
            ),
        ]),
      ),
      const SizedBox(height: 12),
      if (fit.circuits.isEmpty)
        Pressable(
          scale: 0.98,
          onTap: () => showCircuitEditor(context),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(13)),
                child: Icon(PhosphorIconsRegular.timer, size: 19, color: gc.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.newCircuit, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                  const SizedBox(height: 2),
                  Text(t.circuitsHint, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                ]),
              ),
              Icon(PhosphorIconsBold.plus, size: 15, color: gc.textTertiary),
            ]),
          ),
        )
      else
        for (final c in fit.circuits) ...[
          _CircuitCard(circuit: c),
          const SizedBox(height: 10),
        ],
    ]);
  }
}

class _CircuitCard extends StatelessWidget {
  const _CircuitCard({required this.circuit});

  final Circuit circuit;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final c = circuit;
    final names = [
      for (final s in c.steps)
        if (fit.exerciseById(s.exerciseId) case final ex?) exerciseName(ex),
    ];
    return Pressable(
      scale: 0.98,
      onTap: () => showCircuitEditor(context, circuit: c),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
              const SizedBox(height: 3),
              Text(t.circuitSummary(c.steps.length, c.rounds, clockLabel(c.totalSeconds)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textSecondary)),
              if (names.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(names.join(' · '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.35)),
              ],
            ]),
          ),
          const SizedBox(width: 10),
          Semantics(
            button: true,
            label: t.circuitStart,
            child: Pressable(
              scale: 0.9,
              onTap: c.steps.isEmpty ? null : () => startCircuit(context, c),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                child: Icon(PhosphorIconsFill.play, size: 18, color: gc.onEmber),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<void> showCircuitEditor(BuildContext context, {Circuit? circuit}) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CircuitEditor(circuit: circuit),
    );

class _CircuitEditor extends StatefulWidget {
  const _CircuitEditor({this.circuit});

  final Circuit? circuit;

  @override
  State<_CircuitEditor> createState() => _CircuitEditorState();
}

class _CircuitEditorState extends State<_CircuitEditor> {
  late final Circuit _c = widget.circuit == null ? fit.newCircuit() : fit.copyCircuit(widget.circuit!);
  late final TextEditingController _name = TextEditingController(text: _c.name);
  final List<int> _keys = [];
  int _nextKey = 0;

  bool get _isNew => widget.circuit == null;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _c.steps.length; i++) {
      _keys.add(_nextKey++);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _save() {
    if (_c.steps.isEmpty) {
      HapticFeedback.heavyImpact();
      showNotchToast(context, t.circuitNoSteps, icon: PhosphorIconsFill.warningCircle, accent: context.gc.warn);
      return;
    }
    _c.name = _name.text;
    fit.saveCircuit(_c);
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final ok = await askConfirm(context,
        title: t.circuitDeleteTitle(_c.name.isEmpty ? t.circuitDefaultName : _c.name),
        body: t.circuitDeleteBody,
        confirmLabel: t.delete,
        danger: true);
    if (!ok || !mounted) return;
    fit.deleteCircuit(_c.id);
    Navigator.of(context).pop();
  }

  Future<void> _add() async {
    final id = await pickCircuitExercise(context);
    if (id == null || !mounted) return;
    final last = _c.steps.isEmpty ? null : _c.steps.last;
    setState(() {
      _c.steps.add(CircuitStep(id, work: last?.work ?? 40, rest: last?.rest ?? 15));
      _keys.add(_nextKey++);
    });
  }

  Future<void> _seconds(String title, int value, int min, ValueChanged<int> set, {bool allowZero = false}) async {
    final v = await askRuler(context,
        title: title,
        value: value.clamp(min, 600).toDouble(),
        min: min.toDouble(),
        max: 600,
        step: 5,
        majorEvery: 6,
        format: (v) => _secs(v.round()),
        tickLabel: (v) => _secs(v.round()),
        clearLabel: allowZero ? t.noRestTimer : null);
    if (v == null || !mounted) return;
    setState(() => set(v.isNaN ? 0 : v.round()));
  }

  Widget _chip(GymColors gc, String label, String value, Color tone, VoidCallback onTap) => Pressable(
        scale: 0.95,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: tone.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(100)),
          child: Text('$label $value', style: AppTheme.f(12, weight: FontWeight.w700, color: tone)),
        ),
      );

  Widget _stepRow(GymColors gc, int i) {
    final step = _c.steps[i];
    final ex = fit.exerciseById(step.exerciseId);
    final last = i == _c.steps.length - 1;
    return Container(
      key: ValueKey(_keys[i]),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        ReorderableDragStartListener(
          index: i,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 18, color: gc.textTertiary),
          ),
        ),
        const SizedBox(width: 4),
        if (ex != null) SizedBox(width: 44, height: 44, child: ExerciseMedia(ex: ex, height: 44, radius: 12, bordered: false)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ex == null ? step.exerciseId : exerciseName(ex),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, height: 1.25)),
            const SizedBox(height: 7),
            Wrap(spacing: 6, runSpacing: 6, children: [
              _chip(gc, t.circuitWork, _secs(step.work), gc.accent,
                  () => _seconds(t.circuitWork, step.work, 5, (v) => step.work = v)),
              if (!last)
                _chip(gc, t.circuitRest, step.rest == 0 ? '0 s' : _secs(step.rest), gc.sage,
                    () => _seconds(t.circuitRest, step.rest, 5, (v) => step.rest = v, allowZero: true)),
            ]),
          ]),
        ),
        Semantics(
          button: true,
          label: t.planDuplicate,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _c.steps.insert(i + 1, step.copy());
                _keys.insert(i + 1, _nextKey++);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIconsRegular.copy, size: 17, color: gc.textSecondary),
            ),
          ),
        ),
        Semantics(
          button: true,
          label: t.delete,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _c.steps.removeAt(i);
                _keys.removeAt(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIconsRegular.x, size: 16, color: gc.textTertiary),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _setting(GymColors gc, String label, Widget control) => Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Expanded(child: Text(label, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text))),
          control,
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.92,
        decoration: sheetDecoration(gc),
        child: Column(children: [
          const SizedBox(height: 10),
          const SheetHandle(),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              buildDefaultDragHandles: false,
              proxyDecorator: (child, _, _) => Material(color: Colors.transparent, child: child),
              header: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SheetTitle(_isNew ? t.newCircuit : t.editCircuit),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                  child: TextField(
                    controller: _name,
                    maxLength: 60,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: gc.accent,
                    style: AppTheme.f(16, weight: FontWeight.w700, color: gc.text),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: t.circuitNameHint,
                      hintStyle: AppTheme.f(16, weight: FontWeight.w600, color: gc.textTertiary),
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _setting(
                  gc,
                  t.circuitRounds,
                  StepperControl(
                    value: '${_c.rounds}',
                    onDec: () => setState(() => _c.rounds = math.max(1, _c.rounds - 1)),
                    onInc: () => setState(() => _c.rounds = math.min(50, _c.rounds + 1)),
                    minWidth: 34,
                  ),
                ),
                if (_c.rounds > 1) ...[
                  const SizedBox(height: 8),
                  Pressable(
                    scale: 0.98,
                    onTap: () =>
                        _seconds(t.circuitRoundRest, _c.roundRest, 5, (v) => _c.roundRest = v, allowZero: true),
                    child: _setting(
                      gc,
                      t.circuitRoundRest,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Text(_c.roundRest == 0 ? t.noRestTimer : _secs(_c.roundRest),
                            style: AppTheme.f(14, weight: FontWeight.w700, color: gc.sage)),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                if (_c.steps.isEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 14),
                    child: Text(t.circuitEmpty,
                        textAlign: TextAlign.center,
                        style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                  ),
              ]),
              footer: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(height: 2),
                GhostButton(label: t.circuitAdd, icon: PhosphorIconsBold.plus, onTap: _add),
                if (_c.steps.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: Text(t.circuitSummary(_c.steps.length, _c.rounds, clockLabel(_c.totalSeconds)),
                        style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
                  ),
                ],
              ]),
              itemCount: _c.steps.length,
              onReorder: (from, to) => setState(() {
                if (to > from) to--;
                final s = _c.steps.removeAt(from);
                final k = _keys.removeAt(from);
                _c.steps.insert(to, s);
                _keys.insert(to, k);
              }),
              itemBuilder: (_, i) => _stepRow(gc, i),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 20, 12 + MediaQuery.paddingOf(context).bottom),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              PrimaryButton(label: t.save, onTap: _save, height: 52),
              if (!_isNew)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _delete,
                  child: SizedBox(
                    height: 46,
                    child: Center(
                      child: Text(t.delete, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.danger)),
                    ),
                  ),
                ),
            ]),
          ),
        ]),
      ),
    );
  }
}

Future<String?> pickCircuitExercise(BuildContext context) => showAppSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ExercisePick(),
    );

class _ExercisePick extends StatefulWidget {
  const _ExercisePick();

  @override
  State<_ExercisePick> createState() => _ExercisePickState();
}

class _ExercisePickState extends State<_ExercisePick> {
  final TextEditingController _q = TextEditingController();

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  List<Exercise> get _results {
    final all = fit.allExercises;
    if (_q.text.trim().isNotEmpty) return all.where(exerciseSearch(_q.text)).take(60).toList();
    final timed = [for (final e in all) if (fit.modeOf(e.id) == 'time') e];
    final rest = [for (final e in all) if (fit.modeOf(e.id) != 'time') e];
    return [...timed, ...rest].take(60).toList();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final results = _results;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.78,
        padding: sheetPad(context, bottom: 16),
        decoration: sheetDecoration(gc),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(t.circuitPickExercise),
          const SizedBox(height: 14),
          SearchField(
            controller: _q,
            hint: t.searchAllExercises,
            color: gc.bgRaised2,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, i) {
                final ex = results[i];
                return Pressable(
                  scale: 0.98,
                  onTap: () => Navigator.of(context).pop(ex.id),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(children: [
                      SizedBox(width: 46, height: 46, child: ExerciseMedia(ex: ex, height: 46, radius: 13, bordered: false)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(exerciseName(ex),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
                      ),
                      if (fit.modeOf(ex.id) == 'time')
                        Icon(PhosphorIconsRegular.timer, size: 15, color: gc.textTertiary),
                    ]),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

enum _Kind { ready, work, rest, roundRest }

class _Phase {
  const _Phase(this.kind, this.step, this.round, this.seconds);

  final _Kind kind;
  final int step;
  final int round;
  final int seconds;
}

List<_Phase> _phasesOf(Circuit c) {
  final out = <_Phase>[const _Phase(_Kind.ready, 0, 1, 5)];
  for (var r = 1; r <= c.rounds; r++) {
    for (var i = 0; i < c.steps.length; i++) {
      out.add(_Phase(_Kind.work, i, r, c.steps[i].work));
      if (i < c.steps.length - 1 && c.steps[i].rest > 0) out.add(_Phase(_Kind.rest, i + 1, r, c.steps[i].rest));
    }
    if (r < c.rounds && c.roundRest > 0) out.add(_Phase(_Kind.roundRest, 0, r + 1, c.roundRest));
  }
  return out;
}

Future<void> startCircuit(BuildContext context, Circuit c) async {
  if (c.steps.isEmpty) return;
  HapticFeedback.mediumImpact();
  ScreenAwake.keepOn(true);
  await Navigator.of(context).push(PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, _, _) => _CircuitPlayer(circuit: fit.copyCircuit(c)),
    transitionsBuilder: (_, animation, _, child) {
      final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curve,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.06), end: Offset.zero).animate(curve),
          child: child,
        ),
      );
    },
  ));
  if (!fit.keepScreenOn || !fit.isSessionActive) ScreenAwake.keepOn(false);
}

class _CircuitPlayer extends StatefulWidget {
  const _CircuitPlayer({required this.circuit});

  final Circuit circuit;

  @override
  State<_CircuitPlayer> createState() => _CircuitPlayerState();
}

class _CircuitPlayerState extends State<_CircuitPlayer> {
  late final List<_Phase> _phases = _phasesOf(widget.circuit);
  final Map<int, int> _done = {};
  final DateTime _start = DateTime.now();
  Timer? _timer;
  int _index = 0;
  DateTime _phaseStart = DateTime.now();
  int _pausedMs = 0;
  DateTime? _pausedAt;
  int _shownLeft = -1;
  bool _finished = false;
  Duration _total = Duration.zero;
  DateTime _touched = DateTime.now();

  bool get _dim =>
      !_paused && _phase.kind != _Kind.ready && DateTime.now().difference(_touched) > const Duration(seconds: 4);

  void _wake() {
    final was = _dim;
    _touched = DateTime.now();
    if (was) setState(() {});
  }

  Circuit get _c => widget.circuit;
  _Phase get _phase => _phases[_index];
  bool get _paused => _pausedAt != null;
  bool get _sound => fit.alarmStyle != 'vibrate';

  int get _elapsedMs {
    final now = _pausedAt ?? DateTime.now();
    return now.difference(_phaseStart).inMilliseconds - _pausedMs;
  }

  int get _leftMs => math.max(0, _phase.seconds * 1000 - _elapsedMs);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _tick());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    if (_finished || _paused) return;
    final left = (_leftMs / 1000).ceil();
    if (_leftMs <= 0) {
      if (_phase.kind == _Kind.work) _done[_index] = _phase.seconds;
      Beeper.instance.go(sound: _sound);
      HapticFeedback.mediumImpact();
      _go(_index + 1);
      return;
    }
    if (left != _shownLeft) {
      _shownLeft = left;
      if (left <= 3) Beeper.instance.tick(sound: _sound);
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void _go(int index) {
    if (index >= _phases.length) {
      _finish();
      return;
    }
    setState(() {
      _index = index;
      _phaseStart = DateTime.now();
      _pausedMs = 0;
      if (_pausedAt != null) _pausedAt = DateTime.now();
      _shownLeft = -1;
    });
  }

  void _skip() {
    HapticFeedback.selectionClick();
    if (_phase.kind == _Kind.work) {
      final did = (_elapsedMs / 1000).floor();
      if (did > 0) _done[_index] = did;
    }
    _go(_index + 1);
  }

  void _previous() {
    HapticFeedback.selectionClick();
    if (_elapsedMs > 2500 || _index == 0) {
      _done.remove(_index);
      _go(_index);
      return;
    }
    var i = _index - 1;
    while (i > 0 && _phases[i].kind == _Kind.ready) {
      i--;
    }
    _done.remove(i);
    _go(i);
  }

  void _togglePause() {
    HapticFeedback.selectionClick();
    setState(() {
      if (_pausedAt == null) {
        _pausedAt = DateTime.now();
      } else {
        _pausedMs += DateTime.now().difference(_pausedAt!).inMilliseconds;
        _pausedAt = null;
      }
    });
  }

  void _finish() {
    if (_finished) return;
    _timer?.cancel();
    final now = DateTime.now();
    final done = [for (final e in _done.entries) (step: _phases[e.key].step, seconds: e.value)];
    fit.logCircuit(_c, done, _start, now);
    HapticFeedback.heavyImpact();
    setState(() {
      _finished = true;
      _total = now.difference(_start);
    });
  }

  Future<void> _stop() async {
    if (_finished) {
      Navigator.of(context).pop();
      return;
    }
    final wasPaused = _paused;
    if (!wasPaused) _togglePause();
    final ok = await askConfirm(context,
        title: t.circuitStopTitle, body: t.circuitStopBody, confirmLabel: t.circuitStop, cancelLabel: t.circuitKeepGoing);
    if (!mounted) return;
    if (!ok) {
      if (!wasPaused) _togglePause();
      return;
    }
    if (_phase.kind == _Kind.work) {
      final did = (_elapsedMs / 1000).floor();
      if (did > 0) _done[_index] = did;
    }
    if (_done.isEmpty) {
      _timer?.cancel();
      Navigator.of(context).pop();
      return;
    }
    _finish();
  }

  int? get _nextWork {
    for (var i = _index + 1; i < _phases.length; i++) {
      if (_phases[i].kind == _Kind.work) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _stop();
      },
      child: Scaffold(
        backgroundColor: gc.bg,
        body: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => _wake(),
          child: SafeArea(child: _finished ? _doneView(gc) : _runView(gc)),
        ),
      ),
    );
  }

  Widget _runView(GymColors gc) {
    final phase = _phase;
    final working = phase.kind == _Kind.work;
    final tone = switch (phase.kind) {
      _Kind.work => gc.accent,
      _Kind.ready => gc.textSecondary,
      _ => gc.sage,
    };
    final label = switch (phase.kind) {
      _Kind.work => t.circuitWork,
      _Kind.ready => t.circuitGetReady,
      _Kind.rest => t.circuitRest,
      _Kind.roundRest => t.circuitRoundRest,
    };
    final step = _c.steps[phase.step];
    final ex = fit.exerciseById(step.exerciseId);
    final nextIdx = _nextWork;
    final nextEx = nextIdx == null ? null : fit.exerciseById(_c.steps[_phases[nextIdx].step].exerciseId);
    final left = (_leftMs / 1000).ceil();
    final part = phase.seconds <= 0 ? 0.0 : 1 - _leftMs / (phase.seconds * 1000);
    final dim = _dim;

    Widget fading(Widget child) => AnimatedOpacity(
          duration: Duration(milliseconds: dim ? 900 : 200),
          curve: Curves.easeOut,
          opacity: dim ? 0.3 : 1,
          child: child,
        );

    final top = fading(Column(children: [
      Row(children: [
        RoundAction(
          label: t.circuitStop,
          size: 42,
          onTap: _stop,
          child: Icon(PhosphorIconsBold.x, size: 16, color: gc.text),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(_c.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text)),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
          child: Text(t.circuitRoundOf(phase.round, _c.rounds),
              style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
        ),
      ]),
      const SizedBox(height: 18),
      _stepDots(gc, phase),
    ]));

    Widget clock(double size) => SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RingPainter(part: part.clamp(0.0, 1.0), color: tone, track: gc.bgRaised2, stroke: size * 0.05),
            child: Center(
              child: MediaQuery.withNoTextScaling(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: Text(label.toUpperCase(),
                        key: ValueKey(label),
                        style: AppTheme.f(math.max(11, size * 0.052),
                            weight: FontWeight.w800, color: tone, letterSpacing: 2.2)),
                  ),
                  Transform.translate(
                    offset: Offset(0, size * 0.012),
                    child: RollingText(left >= 60 ? clockLabel(left) : '$left',
                        countsDown: true,
                        textAlign: TextAlign.center,
                        style: AppTheme.d(size * (left >= 60 ? 0.24 : 0.34),
                            weight: FontWeight.w800, color: gc.text, height: 1.42)),
                  ),
                  SizedBox(height: size * 0.06),
                ]),
              ),
            ),
          ),
        );

    Widget card(double art) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          child: Container(
            key: ValueKey('${phase.kind}-${phase.step}'),
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(28)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if (ex != null)
                SizedBox(
                  height: art,
                  width: double.infinity,
                  child: ExerciseMedia(ex: ex, height: art, radius: 20, live: working, bordered: false),
                ),
              const SizedBox(height: 14),
              if (!working)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(t.circuitUpNext.toUpperCase(),
                      style: AppTheme.f(10.5, weight: FontWeight.w700, color: tone, letterSpacing: 1.4)),
                ),
              Text(ex == null ? '' : exerciseName(ex),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(21, weight: FontWeight.w800, color: gc.text, height: 1.2)),
              if (working) ...[
                const SizedBox(height: 5),
                Text(nextEx == null ? t.circuitFinishLine : t.circuitNext(exerciseName(nextEx)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textTertiary)),
              ],
            ]),
          ),
        );

    final controls = fading(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RoundAction(
        label: t.circuitPrevious,
        size: 56,
        onTap: _previous,
        child: Icon(PhosphorIconsFill.skipBack, size: 20, color: gc.text),
      ),
      const SizedBox(width: 26),
      Semantics(
        button: true,
        label: _paused ? t.liveResume : t.livePause,
        child: Pressable(
          scale: 0.92,
          onTap: _togglePause,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
            child: Icon(_paused ? PhosphorIconsFill.play : PhosphorIconsFill.pause, size: 30, color: gc.onEmber),
          ),
        ),
      ),
      const SizedBox(width: 26),
      RoundAction(
        label: t.skipShort,
        size: 56,
        onTap: _skip,
        child: Icon(PhosphorIconsFill.skipForward, size: 20, color: gc.text),
      ),
    ]));

    return LayoutBuilder(builder: (context, box) {
      if (box.maxWidth > box.maxHeight * 1.1) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          child: Column(children: [
            top,
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(builder: (context, area) {
                final ring = math.min(area.maxHeight - 8, area.maxWidth * 0.4);
                final art = (area.maxHeight - 110).clamp(70.0, 220.0);
                return Row(children: [
                  Expanded(child: Center(child: clock(ring))),
                  const SizedBox(width: 20),
                  Expanded(child: Center(child: SingleChildScrollView(child: card(art)))),
                ]);
              }),
            ),
            const SizedBox(height: 10),
            controls,
          ]),
        );
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(children: [
          top,
          Expanded(
            child: LayoutBuilder(builder: (context, area) {
              final h = area.maxHeight;
              final ring = math.min(area.maxWidth * 0.66, h * 0.44).clamp(150.0, 300.0);
              final art = (h - ring - 150).clamp(90.0, 230.0);
              return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                clock(ring),
                card(art),
              ]);
            }),
          ),
          const SizedBox(height: 12),
          controls,
        ]),
      );
    });
  }

  Widget _stepDots(GymColors gc, _Phase phase) {
    final n = _c.steps.length;
    final current = phase.kind == _Kind.work ? phase.step : -1;
    final upTo = phase.kind == _Kind.work ? phase.step : (phase.kind == _Kind.ready || phase.kind == _Kind.roundRest ? 0 : phase.step);
    return Row(children: [
      for (var i = 0; i < n; i++) ...[
        if (i > 0) const SizedBox(width: 5),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            height: 5,
            decoration: BoxDecoration(
              color: i == current
                  ? gc.accent
                  : i < upTo
                      ? gc.accent.withValues(alpha: 0.45)
                      : gc.bgRaised2,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    ]);
  }

  Widget _doneView(GymColors gc) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
        child: Column(children: [
          const Spacer(),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(color: gc.sage.withValues(alpha: 0.16), shape: BoxShape.circle),
            child: Icon(PhosphorIconsBold.check, size: 40, color: gc.sage),
          ),
          const SizedBox(height: 22),
          Text(t.circuitDone, style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text)),
          const SizedBox(height: 8),
          Text(t.circuitDoneBody(clockLabel(_total.inSeconds)),
              textAlign: TextAlign.center, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.textSecondary)),
          const SizedBox(height: 6),
          Text(_c.name, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textTertiary)),
          const Spacer(),
          PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop(), height: 52),
        ]),
      );
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.part, required this.color, required this.track, this.stroke = 12});

  final double part;
  final Color color;
  final Color track;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    canvas.drawArc(rect, 0, math.pi * 2, false,
        Paint()
          ..color = track
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke);
    if (part < 0.01) return;
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * part, false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = stroke);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.part != part || old.color != color || old.track != track || old.stroke != stroke;
}
