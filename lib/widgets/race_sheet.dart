import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'rolling_text.dart';
import 'ui_kit.dart';

String _pct(double d) {
  final n = (d * 100).round();
  return '${n > 0 ? '+' : ''}$n %';
}

Color _tone(GymColors gc, double d) => (d * 100).round() > 0 ? gc.sage : gc.textSecondary;

IconData _icon(double d) {
  final n = (d * 100).round();
  if (n > 0) return PhosphorIconsBold.trendUp;
  if (n < 0) return PhosphorIconsBold.trendDown;
  return PhosphorIconsBold.equals;
}

class RaceChip extends StatelessWidget {
  const RaceChip({super.key, required this.delta, this.onTap});

  final double delta;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final tone = _tone(gc, delta);
    return Semantics(
      button: onTap != null,
      label: t.raceTitle,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(10)),
          child: Ltr(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(_icon(delta), size: 11, color: tone),
              const SizedBox(width: 4),
              RollingText(_pct(delta), style: AppTheme.f(11.5, weight: FontWeight.w700, color: tone)),
            ]),
          ),
        ),
      ),
    );
  }
}

void showRaceSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _RaceSheet(),
  );
}

class _RaceSheet extends StatelessWidget {
  const _RaceSheet();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fit,
      builder: (context, _) {
        final gc = context.gc;
        final last = fit.raceSession;
        final rows = fit.raceRows;
        final delta = fit.raceDelta;
        final now = rows.fold(0.0, (a, r) => a + r.now);
        final then = rows.fold(0.0, (a, r) => a + r.then);
        final head = delta == null
            ? t.raceEven
            : (delta * 100).round() > 0
                ? t.raceAhead
                : (delta * 100).round() < 0
                    ? t.raceBehind
                    : t.raceEven;
        return Container(
          padding: sheetPad(context),
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.86),
          decoration: sheetDecoration(gc),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              SheetTitle(t.raceTitle, subtitle: last == null ? null : t.raceSince(t.shortDate(last.date))),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(22)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SectionLabel(head),
                      const SizedBox(height: 8),
                      if (delta != null)
                        Ltr(
                          child: FitText(_pct(delta),
                              style: AppTheme.f(40, weight: FontWeight.w800, color: _tone(gc, delta), height: 1)),
                        ),
                    ]),
                  ),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    _pair(gc, t.raceToday, '${fit.weightValue(now)} ${fit.units}', gc.text),
                    const SizedBox(height: 6),
                    _pair(gc, t.raceThen, '${fit.weightValue(then)} ${fit.units}', gc.textSecondary),
                  ]),
                ]),
              ),
              const SizedBox(height: 14),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
                    clipBehavior: Clip.antiAlias,
                    child: Column(children: [
                      for (var i = 0; i < rows.length; i++) ...[
                        if (i > 0)
                          Container(
                            height: 1,
                            margin: const EdgeInsetsDirectional.only(start: 16),
                            color: gc.border.withValues(alpha: 0.6),
                          ),
                        _row(gc, rows[i]),
                      ],
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(t.raceHint,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
              const SizedBox(height: 16),
              PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
            ],
          ),
        );
      },
    );
  }

  Widget _pair(GymColors gc, String label, String value, Color color) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
      const SizedBox(width: 8),
      Ltr(child: Text(value, style: AppTheme.f(13.5, weight: FontWeight.w700, color: color))),
    ]);
  }

  Widget _row(GymColors gc, ({String id, String name, double now, double then}) r) {
    final d = r.then > 0 ? (r.now - r.then) / r.then : null;
    final ex = fit.exerciseById(r.id);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ex == null ? r.name : t.catalogName(ex.id, ex.name),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
              const SizedBox(height: 3),
              Ltr(
                child: Text('${fit.weightValue(r.now)} / ${fit.weightValue(r.then)} ${fit.units}',
                    style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
              ),
            ]),
          ),
          const SizedBox(width: 10),
          if (d != null)
            Ltr(
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(_icon(d), size: 12, color: _tone(gc, d)),
                const SizedBox(width: 4),
                Text(_pct(d), style: AppTheme.f(13, weight: FontWeight.w700, color: _tone(gc, d))),
              ]),
            ),
        ]),
      ),
    );
  }
}
