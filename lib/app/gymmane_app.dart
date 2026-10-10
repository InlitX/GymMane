import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'app_shell.dart';

class GymManeApp extends StatefulWidget {
  const GymManeApp({super.key});

  static const maxTextScale = 1.15;

  @override
  State<GymManeApp> createState() => _GymManeAppState();
}

class _GymManeAppState extends State<GymManeApp> {
  var _look = (fit.themeMode, fit.locale, fit.themePref == 'amoled');

  @override
  void initState() {
    super.initState();
    fit.addListener(_watch);
  }

  @override
  void dispose() {
    fit.removeListener(_watch);
    super.dispose();
  }

  void _watch() {
    final look = (fit.themeMode, fit.locale, fit.themePref == 'amoled');
    if (look != _look) setState(() => _look = look);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GymMane',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: _look.$3 ? AppTheme.amoled : AppTheme.dark,
        themeMode: _look.$1,
        locale: _look.$2,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => MediaQuery.withClampedTextScaling(
          maxScaleFactor: GymManeApp.maxTextScale,
          child: _ButtonNavScrim(child: child!),
        ),
        home: const AppShell(),
    );
  }
}

class _ButtonNavScrim extends StatelessWidget {
  const _ButtonNavScrim({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bar = MediaQuery.viewPaddingOf(context).bottom;
    final buttons = MediaQuery.systemGestureInsetsOf(context).left == 0;
    return Stack(
      children: [
        child,
        if (buttons && bar > 0)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: bar,
            child: IgnorePointer(child: ColoredBox(color: context.gc.bg)),
          ),
      ],
    );
  }
}
