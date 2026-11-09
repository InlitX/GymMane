import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

class HomeCardsPanel extends StatelessWidget {
  const HomeCardsPanel({super.key, required this.onSteps});

  final VoidCallback onSteps;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final rows = <(String, bool, VoidCallback)>[
      (t.homeCardFocus, fit.showFocus, fit.toggleFocusCard),
      if (fit.stepsAvailable) (t.homeCardSteps, fit.stepsOn, onSteps),
      (t.homeCardWeek, fit.showWeekStats, fit.toggleWeekStats),
      (t.homeCardRoutines, fit.showRoutineRow, fit.toggleRoutineRow),
      (t.homeCardRecommended, fit.showRecommended, fit.toggleRecommended),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 14, 14),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(28)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2),
            child: Text(t.homeCardsTitle,
                style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.3)),
          ),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 11,
                child: Column(children: [
                  for (final (i, (label, on, tap)) in rows.indexed) ...[
                    if (i > 0) const SizedBox(height: 8),
                    Pressable(
                      scale: 0.97,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        tap();
                      },
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 46),
                        padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                        child: Row(children: [
                          Expanded(
                            child: Text(label,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.f(13.5, weight: FontWeight.w700, color: on ? gc.text : gc.textSecondary)),
                          ),
                          const SizedBox(width: 6),
                          TinySwitch(on: on),
                        ]),
                      ),
                    ),
                  ],
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(flex: 8, child: SizedBox(height: rows.length * 54.0 - 8, child: _HomeSketch(gc: gc))),
            ]),
          const SizedBox(height: 8),
          Pressable(
            scale: 0.97,
            onTap: () {
              HapticFeedback.selectionClick();
              _showOrderSheet(context);
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 46),
              padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 12, 8),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                Expanded(
                  child: Text(t.homeOrderRow,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text)),
                ),
                const SizedBox(width: 6),
                Icon(PhosphorIconsRegular.arrowsDownUp, size: 17, color: gc.textSecondary),
              ]),
            ),
          ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
        child: Text(t.homeCardsHint, style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary)),
      ),
    ]);
  }
}

String _blockLabel(String id) => switch (id) {
      'weekdays' => t.homeOrderWeekdays,
      'steps' => t.homeCardSteps,
      'week' => t.homeCardWeek,
      'routines' => t.homeCardRoutines,
      'activity' => titleCase(t.activityLabel),
      'recommended' => t.homeCardRecommended,
      'folders' => t.homeOrderFolders,
      _ => titleCase(t.nutrition),
    };

void _showOrderSheet(BuildContext context) {
  final gc = context.gc;
  var order = [
    for (final id in fit.homeOrderShown)
      if ((id != 'nutrition' || fit.nutritionBeta) && (id != 'steps' || (fit.stepsOn && fit.stepsAvailable))) id,
  ];
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheet) => StatefulBuilder(
      builder: (sheet, setSheet) => AppSheet(children: [
        SheetTitle(t.homeOrderRow, subtitle: t.homeOrderHint),
        const SizedBox(height: 16),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          proxyDecorator: (child, _, _) => Material(color: Colors.transparent, child: child),
          onReorder: (from, to) {
            HapticFeedback.selectionClick();
            final next = [...order];
            next.insert(to > from ? to - 1 : to, next.removeAt(from));
            setSheet(() => order = next);
            fit.setHomeOrder([...next, for (final id in fit.homeOrderShown) if (!next.contains(id)) id]);
          },
          children: [
            for (final (i, id) in order.indexed)
              Container(
                key: ValueKey(id),
                margin: const EdgeInsets.only(bottom: 8),
                constraints: const BoxConstraints(minHeight: 52),
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 4, 8),
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  Expanded(
                    child: Text(_blockLabel(id),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                  ),
                  ReorderableDragStartListener(
                    index: i,
                    child: SizedBox(
                      width: 48,
                      height: 44,
                      child: Icon(PhosphorIconsRegular.dotsSixVertical, size: 18, color: gc.textTertiary),
                    ),
                  ),
                ]),
              ),
          ],
        ),
      ]),
    ),
  );
}

class _HomeSketch extends StatelessWidget {
  const _HomeSketch({required this.gc});

  final GymColors gc;

  Widget _bar(double w, double h, Color color) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(h)),
      );

  Widget _box(double h, {Widget? child, Color? color, EdgeInsets? pad}) => Container(
        height: h,
        padding: pad ?? const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: color ?? gc.bgRaised, borderRadius: BorderRadius.circular(10)),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final soft = gc.text.withValues(alpha: 0.22);
    final blocks = <(bool, Widget)>[
      (
        fit.showFocus,
        _box(58,
            color: gc.bgRaised2.withValues(alpha: 1),
            pad: const EdgeInsets.fromLTRB(9, 10, 9, 9),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _bar(46, 6, gc.text.withValues(alpha: 0.7)),
              const SizedBox(height: 5),
              _bar(30, 4, soft),
              const Spacer(),
              _bar(double.infinity, 11, gc.text),
            ])),
      ),
      (
        true,
        _box(26,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < 7; i++)
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: i > 2 && i < 6 ? gc.text : gc.bgRaised2),
                ),
            ])),
      ),
      (
        fit.stepsOn && fit.stepsAvailable,
        _box(32,
            pad: const EdgeInsets.fromLTRB(9, 7, 9, 7),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _bar(24, 6, gc.text.withValues(alpha: 0.75)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: SizedBox(
                      height: 4,
                      child: Row(children: [
                        Expanded(flex: 6, child: ColoredBox(color: gc.text.withValues(alpha: 0.8))),
                        Expanded(flex: 4, child: ColoredBox(color: gc.bgRaised2)),
                      ]),
                    ),
                  ),
                ]),
              ),
              const SizedBox(width: 10),
              for (final h in const [8.0, 12.0, 10.0, 16.0, 6.0]) ...[
                _bar(3, h, gc.text.withValues(alpha: 0.7)),
                const SizedBox(width: 3),
              ],
            ])),
      ),
      (
        fit.showWeekStats,
        _box(28,
            child: Row(children: [
              for (final w in [18.0, 12.0, 10.0]) ...[_bar(w, 6, gc.text.withValues(alpha: 0.6)), const SizedBox(width: 7)],
              const Spacer(),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: gc.accent, width: 2)),
              ),
            ])),
      ),
      (
        fit.showRoutineRow,
        Row(children: [
          for (final c in const [Color(0xFF8FB4DE), Color(0xFFDE9FB4)]) ...[
            if (c == const Color(0xFFDE9FB4)) const SizedBox(width: 6),
            Expanded(
              child: _box(34,
                  pad: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: _bar(double.infinity, 7, c.withValues(alpha: 0.75)),
                  )),
            ),
          ],
        ]),
      ),
      (
        true,
        _box(40,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var r = 0; r < 3; r++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    for (var c = 0; c < 9; c++)
                      Container(
                        width: 7,
                        height: 6,
                        decoration: BoxDecoration(
                          color: (r + c) % 3 == 0 ? gc.accent.withValues(alpha: 0.4 + c * 0.06) : gc.bgRaised2,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                  ]),
                ),
            ])),
      ),
      (
        fit.showRecommended,
        Row(children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) const SizedBox(width: 5),
            Expanded(child: _box(30)),
          ],
        ]),
      ),
    ];
    final extra = <String, (bool, Widget)>{
      'folders': (
        true,
        Row(children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) const SizedBox(width: 5),
            Expanded(child: _box(26, pad: const EdgeInsets.fromLTRB(5, 6, 5, 0), child: Align(
              alignment: Alignment.topCenter,
              child: _bar(double.infinity, 5, soft),
            ))),
          ],
        ]),
      ),
      'nutrition': (
        fit.nutritionBeta,
        _box(32,
            pad: const EdgeInsets.fromLTRB(9, 7, 9, 7),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
              _bar(30, 6, gc.text.withValues(alpha: 0.6)),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: SizedBox(
                  height: 4,
                  child: Row(children: [
                    Expanded(flex: 5, child: ColoredBox(color: gc.sage)),
                    const SizedBox(width: 2),
                    Expanded(flex: 3, child: ColoredBox(color: gc.accent)),
                    const SizedBox(width: 2),
                    Expanded(flex: 2, child: ColoredBox(color: gc.text.withValues(alpha: 0.35))),
                  ]),
                ),
              ),
            ])),
      ),
    };
    final byId = <String, (bool, Widget)>{
      'weekdays': blocks[1],
      'steps': blocks[2],
      'week': blocks[3],
      'routines': blocks[4],
      'activity': blocks[5],
      'recommended': blocks[6],
      ...extra,
    };
    final shown = [
      blocks[0],
      for (final id in fit.homeOrderShown) ?byId[id],
    ];
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: gc.bg,
          padding: const EdgeInsets.fromLTRB(9, 12, 9, 0),
          child: Stack(children: [
            OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Align(alignment: Alignment.centerLeft, child: _bar(40, 5, soft)),
                const SizedBox(height: 9),
                for (final (on, child) in shown)
                  AnimatedSize(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: on
                        ? Padding(padding: const EdgeInsets.only(bottom: 6), child: child)
                        : const SizedBox(width: double.infinity),
                  ),
              ]),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 36,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [gc.bg.withValues(alpha: 0), gc.bg],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
