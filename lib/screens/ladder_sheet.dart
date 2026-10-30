import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/exercise_media.dart';
import '../widgets/glass.dart';
import '../widgets/ui_kit.dart';

Future<void> showLadderSheet(BuildContext context, String routineId, Exercise ex) => showAppSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LadderSheet(routineId: routineId, ex: ex),
    );

class _LadderSheet extends StatefulWidget {
  const _LadderSheet({required this.routineId, required this.ex});

  final String routineId;
  final Exercise ex;

  @override
  State<_LadderSheet> createState() => _LadderSheetState();
}

class _LadderSheetState extends State<_LadderSheet> {
  late final Routine? _routine = fit.routineById(widget.routineId);
  late List<String> _steps = [
    ...?fit.ladderIn(_routine, widget.ex.id) ?? fit.builtInLadder(widget.ex.id),
  ];
  late bool _own = fit.ladderIn(_routine, widget.ex.id) != null;

  @override
  void initState() {
    super.initState();
    if (_steps.isEmpty) _steps = [widget.ex.id];
  }

  void _commit(List<String> next) {
    HapticFeedback.selectionClick();
    setState(() {
      _steps = next;
      _own = true;
    });
    fit.setLadder(widget.routineId, widget.ex.id, next);
  }

  Future<void> _add() async {
    final picked = await _pickStep(context, widget.ex, _steps);
    if (picked == null || !mounted) return;
    _commit([..._steps, picked.id]);
  }

  void _clear() {
    HapticFeedback.selectionClick();
    fit.setLadder(widget.routineId, widget.ex.id, const []);
    setState(() {
      _steps = [...fit.builtInLadder(widget.ex.id) ?? [widget.ex.id]];
      _own = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final current = _steps.indexOf(widget.ex.id);
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 18),
          Row(children: [
            Icon(PhosphorIconsFill.stairs, size: 17, color: gc.sage),
            const SizedBox(width: 8),
            Expanded(child: Text(t.ladderTitle, style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text))),
          ]),
          const SizedBox(height: 6),
          Text(_own || _steps.length < 2 ? t.ladderHint : t.ladderBuiltIn,
              style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
          const SizedBox(height: 14),
          Flexible(
            child: ReorderableListView.builder(
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              itemCount: _steps.length,
              proxyDecorator: (child, _, _) => Material(color: Colors.transparent, child: child),
              onReorder: (from, to) {
                final next = [..._steps];
                if (to > from) to -= 1;
                next.insert(to, next.removeAt(from));
                _commit(next);
              },
              itemBuilder: (context, i) => _row(gc, i, current),
            ),
          ),
          const SizedBox(height: 10),
          GhostButton(label: t.ladderAdd, icon: PhosphorIconsRegular.plus, onTap: _add),
          if (_own)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _clear,
              child: Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(t.ladderClear, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.accent)),
              ),
            )
          else
            const SizedBox(height: 12),
          PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Widget _row(GymColors gc, int i, int current) {
    final id = _steps[i];
    final ex = fit.exerciseById(id);
    final here = id == widget.ex.id;
    final passed = i < current;
    return Padding(
      key: ValueKey(id),
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 4, 8),
        decoration: BoxDecoration(
          color: here ? gc.sageSoft : gc.bgRaised2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: here ? gc.sage : (passed ? gc.mutedFill : gc.bgRaised),
              shape: BoxShape.circle,
            ),
            child: passed
                ? Icon(PhosphorIconsBold.check, size: 11, color: gc.textSecondary)
                : Text('${i + 1}',
                    style: AppTheme.f(11, weight: FontWeight.w800, color: here ? gc.onEmber : gc.textSecondary)),
          ),
          const SizedBox(width: 10),
          if (ex != null) ...[
            SizedBox(width: 38, child: ExerciseMedia(ex: ex, height: 38, radius: 9)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ex == null ? id : exerciseName(ex),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(13.5, weight: here ? FontWeight.w800 : FontWeight.w600, color: gc.text)),
              if (here) ...[
                const SizedBox(height: 2),
                Text(t.ladderInRoutine.toUpperCase(),
                    style: AppTheme.f(9.5, weight: FontWeight.w700, color: gc.sage, letterSpacing: 1)),
              ],
            ]),
          ),
          if (!here)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _commit([..._steps]..removeAt(i)),
              child: SizedBox(
                width: 36,
                height: 40,
                child: Icon(PhosphorIconsRegular.x, size: 15, color: gc.textTertiary),
              ),
            ),
          ReorderableDragStartListener(
            index: i,
            child: SizedBox(
              width: 36,
              height: 40,
              child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 18, color: gc.textTertiary),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<Exercise?> _pickStep(BuildContext context, Exercise base, List<String> taken) {
  final search = TextEditingController();
  return showAppSheet<Exercise>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheet).bottom),
      child: StatefulBuilder(builder: (sheet, setSheet) {
        final gc = sheet.gc;
        final q = search.text.trim();
        final list = [
          for (final e in q.isEmpty
              ? fit.allExercises.where((e) => e.primary == base.primary && !fit.isArchived(e.id))
              : fit.trainSearchResults(q))
            if (!taken.contains(e.id)) e,
        ];
        return Container(
          padding: sheetPad(sheet),
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.82),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              Text(t.ladderPick, style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 12),
              SearchField(
                controller: search,
                hint: t.searchExercises,
                color: gc.bgRaised2,
                onChanged: (_) => setSheet(() {}),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final e = list[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Pressable(
                        scale: 0.98,
                        onTap: () => Navigator.of(sheet).pop(e),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
                          child: Row(children: [
                            SizedBox(width: 40, child: ExerciseMedia(ex: e, height: 40, radius: 9)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(exerciseName(e),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text)),
                            ),
                            Icon(PhosphorIconsRegular.plus, size: 15, color: gc.textSecondary),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}
