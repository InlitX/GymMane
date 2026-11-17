import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../services/watch_link.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

const _kGuideUrl = 'https://github.com/InlitX/GymMane/blob/main/WEAR.md';

void showWatchSheet(BuildContext context) {
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _WatchSheet(),
  );
}

class _WatchSheet extends StatefulWidget {
  const _WatchSheet();

  @override
  State<_WatchSheet> createState() => _WatchSheetState();
}

class _WatchSheetState extends State<_WatchSheet> {
  @override
  void initState() {
    super.initState();
    WatchLink.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
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
              child: ListenableBuilder(
                listenable: WatchLink.instance,
                builder: (context, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _body(context, gc, WatchLink.instance),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _body(BuildContext context, GymColors gc, WatchLink link) {
    return [
      SheetTitle(t.watchTitle, subtitle: t.watchSubtitle),
      const SizedBox(height: 18),
      const _Hero(),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Semantics(
            button: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => launchUrl(Uri.parse(_kGuideUrl), mode: LaunchMode.externalApplication),
              child: _Point(
                  icon: PhosphorIconsRegular.downloadSimple,
                  title: t.watchPoint1,
                  body: t.watchPoint1Body,
                  trailing: PhosphorIconsRegular.arrowUpRight),
            ),
          ),
          _Point(icon: PhosphorIconsRegular.bluetooth, title: t.watchPoint2, body: t.watchPoint2Body),
          _Point(icon: PhosphorIconsRegular.arrowsClockwise, title: t.watchPoint3, body: t.watchPoint3Body),
        ]),
      ),
      const SizedBox(height: 12),
      Semantics(
        toggled: link.on,
        child: Pressable(
          onTap: () {
            HapticFeedback.selectionClick();
            link.setOn(!link.on);
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 58),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.watchUse, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 3),
                  Text(t.watchUseHint,
                      style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                ]),
              ),
              const SizedBox(width: 12),
              TinySwitch(on: link.on),
            ]),
          ),
        ),
      ),
      if (link.on) ...[
        const SizedBox(height: 16),
        Text(_status(link),
            textAlign: TextAlign.center,
            style: AppTheme.f(12.5,
                weight: FontWeight.w600,
                color: link.lastOk == false && !link.busy ? gc.danger : gc.textSecondary,
                height: 1.4)),
        const SizedBox(height: 14),
        if (!link.enabled)
          PrimaryButton(label: t.watchTurnOnBluetooth, onTap: link.openSettings)
        else
          PrimaryButton(
            label: link.busy ? t.watchSearching : t.watchSyncNow,
            onTap: link.busy ? null : () => link.exchange(manual: true),
          ),
      ],
      const SizedBox(height: 12),
      Text(t.watchTip,
          textAlign: TextAlign.center,
          style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
    ];
  }

  String _status(WatchLink link) {
    if (!link.enabled) return t.watchBluetoothOff;
    if (link.busy) return t.watchSearchingHint;
    if (link.lastOk == false) return t.watchNotFound;
    final at = link.at;
    if (at == null) return t.watchNever;
    final when = '${t.shortDate(at)} · ${t.clockTime(at)}';
    return link.peer.isEmpty ? t.watchLast(when) : t.watchLastWith(link.peer, when);
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    Widget disc(IconData icon) => Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
          child: Icon(icon, size: 28, color: gc.text),
        );
    return ExcludeSemantics(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        disc(PhosphorIconsRegular.deviceMobile),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(PhosphorIconsBold.arrowsLeftRight, size: 18, color: gc.accent),
        ),
        disc(PhosphorIconsRegular.watch),
      ]),
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.title, required this.body, this.trailing});

  final IconData icon;
  final String title;
  final String body;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 19, color: gc.textSecondary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTheme.f(14, weight: FontWeight.w600, color: gc.text)),
            const SizedBox(height: 3),
            Text(body, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
          ]),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(trailing, size: 16, color: gc.textTertiary),
          ),
        ],
      ]),
    );
  }
}
