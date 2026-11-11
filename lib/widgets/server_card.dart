import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../services/server/server_link.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'liquid_notch.dart';
import 'ui_kit.dart';

const _guideUrl = 'https://github.com/InlitX/GymMane/blob/main/SELFHOST.md';

class ServerCard extends StatefulWidget {
  const ServerCard({super.key});

  @override
  State<ServerCard> createState() => _ServerCardState();
}

class _ServerCardState extends State<ServerCard> {
  Map<String, dynamic>? _info;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final info = await ServerLink.instance.info();
    if (mounted) setState(() => _info = info);
  }

  Map<String, dynamic> get _sync => (_info?['sync'] as Map?)?.cast<String, dynamic>() ?? const {};

  bool get _enabled => _sync['enabled'] == true;

  DateTime? get _lastImport => DateTime.tryParse(_sync['lastImport'] as String? ?? '')?.toLocal();

  String get _folder => _sync['folder'] as String? ?? '';

  int get _devices => (_sync['devices'] as List?)?.length ?? 0;

  String get _error => _sync['error'] as String? ?? '';

  Widget _folderBox(GymColors gc) => Container(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(PhosphorIconsRegular.folderSimple, size: 16, color: gc.textSecondary),
            const SizedBox(width: 8),
            Text(t.webPhoneFolder, style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
          ]),
          const SizedBox(height: 6),
          Ltr(
            child: SelectableText(_folder,
                style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.text, height: 1.35)),
          ),
          if (_error.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(t.webPhoneError(_error),
                style: AppTheme.f(12, weight: FontWeight.w600, color: gc.danger, height: 1.35)),
          ],
          const SizedBox(height: 6),
          Text(t.webPhoneFolderHow,
              style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary, height: 1.45)),
        ]),
      );

  Future<void> _scan() async {
    if (_busy) return;
    setState(() => _busy = true);
    final r = await ServerLink.instance.scanPhone();
    if (!mounted) return;
    setState(() => _busy = false);
    await _load();
    if (!mounted) return;
    final imported = r?['imported'] == true;
    showNotchToast(context, imported ? t.webPhoneImported : t.webPhoneNothing,
        icon: imported ? PhosphorIconsFill.checkCircle : PhosphorIconsFill.info,
        accent: imported ? context.gc.sage : context.gc.textSecondary);
  }

  Future<void> _export() async {
    if (_busy) return;
    setState(() => _busy = true);
    final r = await ServerLink.instance.exportForPhone();
    if (!mounted) return;
    setState(() => _busy = false);
    if (r?['exported'] != true) return;
    HapticFeedback.lightImpact();
    showNotchToast(context, t.webPhoneExportDone, icon: PhosphorIconsFill.fileZip, accent: context.gc.sage);
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final link = ServerLink.instance;
    final last = _lastImport;
    return ListenableBuilder(
      listenable: link,
      builder: (context, _) => Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: gc.bgRaised2, shape: BoxShape.circle),
              child: Icon(PhosphorIconsRegular.hardDrives, size: 18, color: gc.text),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.webServerTitle,
                    style: AppTheme.f(18, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.3)),
                const SizedBox(height: 3),
                Row(children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(color: link.online ? gc.sage : gc.warn, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 7),
                  Flexible(
                    child: Text(link.online ? t.webServerSaved : t.webServerOffline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
                  ),
                ]),
              ]),
            ),
          ]),
          const SizedBox(height: 18),
          if (!_enabled && _info != null) ...[
            Text(t.webPhoneOff, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text, height: 1.35)),
            const SizedBox(height: 6),
            Text(t.webPhoneOffHow,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
          ] else ...[
            Text(last == null ? t.webPhoneNone : t.webPhoneLast('${t.shortDate(last)} · ${t.clockTime(last)}'),
                style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(height: 3),
            Text(t.webPhoneDevices(_devices),
                style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
            const SizedBox(height: 8),
            Text(t.webPhoneHow, style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
            if (_folder.isNotEmpty) ...[
              const SizedBox(height: 14),
              _folderBox(gc),
            ],
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: _Action(
                  icon: PhosphorIconsBold.arrowsClockwise,
                  label: t.webPhoneScan,
                  busy: _busy,
                  onTap: _scan,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _Action(
                  icon: PhosphorIconsBold.deviceMobile,
                  label: t.webPhoneExport,
                  busy: _busy,
                  onTap: _export,
                ),
              ),
            ]),
          ],
          const SizedBox(height: 6),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: () => launchUrl(Uri.parse(_guideUrl), mode: LaunchMode.externalApplication),
              child: Text(t.webPhoneGuide, style: AppTheme.f(13, weight: FontWeight.w700, color: gc.accent)),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.busy, required this.onTap});

  final IconData icon;
  final String label;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: busy ? null : onTap,
      scale: 0.97,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: busy ? 0.5 : 1,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 14, color: gc.text),
            const SizedBox(width: 8),
            Flexible(
              child: Text(label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.text)),
            ),
          ]),
        ),
      ),
    );
  }
}
