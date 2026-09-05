import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

AlertDialog appDialog(
  GymColors gc, {
  required Widget title,
  required Widget content,
  required List<Widget> actions,
}) =>
    AlertDialog(
      backgroundColor: gc.bgRaised,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: title,
      content: content,
      actions: actions,
    );

Widget dialogAction(String label, Color color, VoidCallback onPressed, {bool strong = true}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(label,
          style: AppTheme.s(14, weight: strong ? FontWeight.w700 : FontWeight.w400, color: color)),
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
      title: Text(title, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
      content: Text(body, style: AppTheme.s(13, color: gc.textSecondary)),
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
      title: Text(title, style: AppTheme.d(14, weight: FontWeight.w700, color: gc.text, letterSpacing: 2)),
      content: TextField(
        controller: controller,
        autofocus: true,
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        textAlign: TextAlign.center,
        style: AppTheme.d(32, weight: FontWeight.w700, color: gc.text),
        cursorColor: gc.accent,
        onSubmitted: (v) => Navigator.of(dctx).pop(v),
        decoration: InputDecoration(
          filled: true,
          fillColor: gc.bgRaised2,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
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
