import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/share_cards.dart';
import '../widgets/ui_kit.dart';

Future<void> showShareSheet(BuildContext context, {ShareKind initial = ShareKind.streak}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ShareSheet(initial: initial),
    );

class _ShareSheet extends StatefulWidget {
  const _ShareSheet({required this.initial});

  final ShareKind initial;

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  final GlobalKey _card = GlobalKey();
  late ShareKind _kind = widget.initial;
  bool _busy = false;

  List<ShareKind> get _available => [
        ShareKind.streak,
        ShareKind.body,
        if (fit.comparePair != null) ShareKind.compare,
      ];

  String _label(ShareKind k) => switch (k) {
        ShareKind.streak => t.shareStreak,
        ShareKind.body => t.shareBody,
        ShareKind.compare => t.shareCompare,
      };

  Future<void> _share() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final boundary = _card.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (data == null) return;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/gymmane-${_kind.name}.png');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      if (!mounted) return;
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], subject: 'GymMane'));
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.shareFailed)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final kinds = _available;
    final kind = kinds.contains(_kind) ? _kind : kinds.first;

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      decoration: BoxDecoration(
        color: gc.bg,
        border: Border.all(color: gc.border),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHandle(color: gc.border, margin: const EdgeInsets.symmetric(vertical: 12)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(t.sharePick,
                        style: AppTheme.d(17, weight: FontWeight.w700, color: gc.text)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (final k in kinds)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Pill(
                        label: _label(k),
                        bg: k == kind ? gc.emberSoft : gc.bgRaised,
                        fg: k == kind ? gc.text : gc.textSecondary,
                        fontSize: 12.5,
                        onTap: () => setState(() => _kind = k),
                      ),
                    ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Center(
                  child: FittedBox(
                    child: RepaintBoundary(
                      key: _card,
                      child: ShareCard(kind: kind, gc: gc),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 6),
              child: Text(t.shareHint,
                  textAlign: TextAlign.center,
                  style: AppTheme.s(11.5, color: gc.textTertiary, height: 1.4)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
              child: PrimaryButton(label: t.share, height: 54, onTap: _share),
            ),
          ],
        ),
      ),
    );
  }
}
