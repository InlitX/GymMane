import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'liquid_notch.dart';
import 'ui_kit.dart';

AlertDialog appDialog(
  GymColors gc, {
  required Widget title,
  required Widget content,
  required List<Widget> actions,
}) =>
    AlertDialog(
      backgroundColor: gc.bgRaised,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      title: title,
      content: content,
      actions: actions,
    );

Widget dialogAction(String label, Color color, VoidCallback onPressed, {bool strong = true}) =>
    TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(titleCase(label),
          style: AppTheme.f(14,
              weight: strong ? FontWeight.w700 : FontWeight.w600, color: color)),
    );

Future<bool> askConfirm(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  String? cancelLabel,
  bool danger = false,
}) async {
  final gc = context.gc;
  final ok = await showAppDialog<bool>(
    context: context,
    builder: (dctx) => appDialog(
      gc,
      title: Text(title, style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
      content: Text(body,
          style: AppTheme.f(13.5,
              weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
      actions: [
        dialogAction(cancelLabel ?? t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(false),
            strong: false),
        dialogAction(confirmLabel, danger ? gc.danger : gc.accent, () => Navigator.of(dctx).pop(true)),
      ],
    ),
  );
  return ok ?? false;
}

Future<String?> askText(
  BuildContext context, {
  required String title,
  String initial = '',
  String hint = '',
}) async {
  final gc = context.gc;
  final controller = TextEditingController(text: initial)
    ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);
  final raw = await showAppDialog<String>(
    context: context,
    builder: (dctx) => appDialog(
      gc,
      title: Text(title, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        style: AppTheme.s(15, color: gc.text),
        cursorColor: gc.accent,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTheme.s(15, color: gc.textTertiary),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.border)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.accent)),
        ),
        onSubmitted: (v) => Navigator.of(dctx).pop(v),
      ),
      actions: [
        dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(), strong: false),
        dialogAction(t.save, gc.accent, () => Navigator.of(dctx).pop(controller.text)),
      ],
    ),
  );
  Future<void>.delayed(const Duration(milliseconds: 600), controller.dispose);
  final text = raw?.trim() ?? '';
  return text.isEmpty ? null : text;
}

Future<double?> askNumber(
  BuildContext context, {
  required String title,
  required String initial,
  required bool decimal,
}) async {
  final gc = context.gc;
  final controller = TextEditingController(text: initial)
    ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);

  final raw = await showAppDialog<String>(
    context: context,
    builder: (dctx) => appDialog(
      gc,
      title: Text(titleCase(title), style: AppTheme.f(19, weight: FontWeight.w800, color: gc.text)),
      content: TextField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        textAlign: TextAlign.center,
        style: AppTheme.f(34, weight: FontWeight.w800, color: gc.text, height: 1.1),
        cursorColor: gc.accent,
        onSubmitted: (v) => Navigator.of(dctx).pop(v),
        decoration: InputDecoration(
          filled: true,
          fillColor: gc.bgRaised2,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
      ),
      actions: [
        dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(), strong: false),
        dialogAction(t.set, gc.accent, () => Navigator.of(dctx).pop(controller.text)),
      ],
    ),
  );
  Future<void>.delayed(const Duration(milliseconds: 600), controller.dispose);

  return double.tryParse((raw ?? '').trim().replaceAll(',', '.'));
}

Future<NoteLink?> askLink(BuildContext context, {NoteLink? initial}) async {
  final gc = context.gc;
  final name = TextEditingController(text: initial?.name ?? '');
  final url = TextEditingController(text: initial?.url ?? '');
  bool bad = false;
  InputDecoration deco(String hint, {String? error}) => InputDecoration(
        hintText: hint,
        errorText: error,
        hintStyle: AppTheme.s(15, color: gc.textTertiary),
        errorStyle: AppTheme.s(12, color: gc.danger),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.border)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.accent)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.danger)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: gc.danger)),
      );
  final result = await showAppDialog<NoteLink>(
    context: context,
    builder: (dctx) => StatefulBuilder(
      builder: (dctx, setState) {
        void submit() {
          final uri = NoteLink.parse(url.text);
          if (uri == null) {
            setState(() => bad = true);
            return;
          }
          final label = name.text.trim();
          Navigator.of(dctx).pop(NoteLink(
            name: label.isEmpty ? uri.host.replaceFirst('www.', '') : label,
            url: uri.toString(),
          ));
        }

        return appDialog(
          gc,
          title: Text(initial == null ? t.noteLinkAdd : t.noteLinkEdit,
              style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                maxLength: 60,
                style: AppTheme.s(15, color: gc.text),
                cursorColor: gc.accent,
                decoration: deco(t.noteLinkNameHint).copyWith(counterText: ''),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: url,
                keyboardType: TextInputType.url,
                autocorrect: false,
                style: AppTheme.s(15, color: gc.text),
                cursorColor: gc.accent,
                decoration: deco(t.noteLinkUrlHint, error: bad ? t.noteLinkInvalid : null),
                onChanged: (_) {
                  if (bad) setState(() => bad = false);
                },
                onSubmitted: (_) => submit(),
              ),
            ],
          ),
          actions: [
            dialogAction(t.cancel, gc.textSecondary, () => Navigator.of(dctx).pop(), strong: false),
            dialogAction(t.save, gc.accent, submit),
          ],
        );
      },
    ),
  );
  Future<void>.delayed(const Duration(milliseconds: 600), () {
    name.dispose();
    url.dispose();
  });
  return result;
}

Future<void> openNoteLink(BuildContext context, NoteLink link) async {
  final uri = NoteLink.parse(link.url);
  var ok = false;
  if (uri != null) {
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ok = false;
    }
  }
  if (!ok && context.mounted) {
    showNotchToast(context, t.cantOpenLink, icon: PhosphorIconsFill.warningCircle, accent: context.gc.danger);
  }
}
