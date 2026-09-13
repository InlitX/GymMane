import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
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
  final ok = await showDialog<bool>(
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

Future<double?> askNumber(
  BuildContext context, {
  required String title,
  required String initial,
  required bool decimal,
}) async {
  final gc = context.gc;
  final controller = TextEditingController(text: initial)
    ..selection = TextSelection(baseOffset: 0, extentOffset: initial.length);

  final raw = await showDialog<String>(
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
  controller.dispose();

  return double.tryParse((raw ?? '').trim().replaceAll(',', '.'));
}
