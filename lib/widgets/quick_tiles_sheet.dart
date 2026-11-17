import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/quick_tiles.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

void showQuickTilesSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _QuickTilesSheet(),
  );
}

class _QuickTilesSheet extends StatefulWidget {
  const _QuickTilesSheet();

  @override
  State<_QuickTilesSheet> createState() => _QuickTilesSheetState();
}

class _QuickTilesSheetState extends State<_QuickTilesSheet> {
  final Set<String> _added = {};

  Future<void> _add(String tile) async {
    HapticFeedback.selectionClick();
    final r = await QuickTiles.add(tile);
    if (!mounted) return;
    if (r == 'added' || r == 'already') setState(() => _added.add(tile));
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final pass = fit.quickPass;
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.92),
      decoration: sheetDecoration(gc),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SheetTitle(t.qsTitle, subtitle: t.qsSubtitle),
                  const SizedBox(height: 18),
                  _Tile(
                    icon: PhosphorIconsRegular.barbell,
                    title: t.qsToday,
                    body: t.qsTodayHint,
                    added: _added.contains('today'),
                    onAdd: QuickTiles.canAdd ? () => _add('today') : null,
                  ),
                  const SizedBox(height: 10),
                  _Tile(
                    icon: PhosphorIconsRegular.identificationCard,
                    title: pass?.name ?? t.qsPass,
                    body: pass == null ? t.qsPassNone : t.qsPassHint(pass.name),
                    added: _added.contains('pass'),
                    onAdd: QuickTiles.canAdd && pass != null ? () => _add('pass') : null,
                  ),
                  if (!QuickTiles.canAdd) ...[
                    const SizedBox(height: 14),
                    Text(t.qsManual,
                        textAlign: TextAlign.center,
                        style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, required this.body, required this.added, this.onAdd});

  final IconData icon;
  final String title;
  final String body;
  final bool added;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
          child: Icon(icon, size: 21, color: gc.text),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
            const SizedBox(height: 3),
            Text(body, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
          ]),
        ),
        if (onAdd != null || added) ...[
          const SizedBox(width: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: added
                ? Row(key: const ValueKey('done'), mainAxisSize: MainAxisSize.min, children: [
                    Icon(PhosphorIconsBold.check, size: 14, color: gc.sage),
                    const SizedBox(width: 4),
                    Text(t.qsAdded, style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.sage)),
                  ])
                : Pressable(
                    key: const ValueKey('add'),
                    onTap: onAdd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: gc.ember, borderRadius: BorderRadius.circular(100)),
                      child: Text(t.qsAdd, style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.onEmber)),
                    ),
                  ),
          ),
        ],
      ]),
    );
  }
}
