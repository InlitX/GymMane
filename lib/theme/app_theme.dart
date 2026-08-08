import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String disp = 'Oswald';
  static const String sans = 'IBM Plex Sans';

  static ThemeData get dark => _build(Brightness.dark, GymColors.dark);
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
