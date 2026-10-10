import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String disp = 'Nunito';
  static const String sans = 'Nunito';
  static const String round = 'Nunito';

  static ThemeData get dark => _build(Brightness.dark, GymColors.dark);
  static ThemeData get amoled => _build(Brightness.dark, GymColors.amoled);
  static ThemeData get light => _build(Brightness.light, GymColors.light);

  static ThemeData _build(Brightness brightness, GymColors gc) {
    final base = ThemeData(brightness: brightness, useMaterial3: true, fontFamily: sans);
    return base.copyWith(
      scaffoldBackgroundColor: gc.bg,
      colorScheme: base.colorScheme.copyWith(
        surface: gc.bgRaised,
        primary: gc.accent,
        onPrimary: gc.onEmber,
        onSurface: gc.text,
        error: const Color(0xFFE5563B),
      ),
      textTheme: base.textTheme.apply(
        fontFamily: sans,
        bodyColor: gc.text,
        displayColor: gc.text,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dividerColor: gc.border,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        hourMinuteColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accentSoft : gc.bgRaised2),
        hourMinuteTextColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accent : gc.text),
        dayPeriodColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accentSoft : Colors.transparent),
        dayPeriodTextColor: WidgetStateColor.resolveWith(
            (s) => s.contains(WidgetState.selected) ? gc.accent : gc.textSecondary),
        dayPeriodBorderSide: BorderSide(color: gc.border),
        helpTextStyle: TextStyle(
            fontFamily: sans, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: gc.textSecondary),
        entryModeIconColor: gc.textSecondary,
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: gc.textSecondary),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: gc.accent),
      ),
      extensions: [gc],
    );
  }

  static TextStyle d(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
    double? letterSpacing,
    double height = 1.0,
  }) =>
      TextStyle(
        fontFamily: disp,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle f(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
    double? letterSpacing,
    double height = 1.15,
  }) =>
      TextStyle(
        fontFamily: round,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle s(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    double height = 1.35,
  }) =>
      TextStyle(
        fontFamily: sans,
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
}
