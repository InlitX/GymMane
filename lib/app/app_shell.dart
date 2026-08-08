import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../screens/about_screen.dart';
import '../screens/exercise_detail_screen.dart';
import '../screens/exercises_screen.dart';
import '../screens/home_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/routine_edit_screen.dart';
import '../screens/routines_screen.dart';
import '../screens/session_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tool_detail_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/train_screen.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fit.refreshAlarmPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      fit.persistNow();
    }
    // al volver de los ajustes del sistema el permiso puede haber cambiado
    if (state == AppLifecycleState.resumed) fit.refreshAlarmPermission();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fit,
      builder: (context, _) {
        if (!fit.onboarded) return const OnboardingScreen();

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (fit.isSessionActive) {
              if (await _confirmDiscard(context)) fit.discardSession();
              return;
            }
            if (fit.isSessionComplete) {
              fit.saveAndExit();
              return;
            }
            if (!fit.handleBack()) await SystemNavigator.pop();
          },
          child: Scaffold(
            backgroundColor: context.gc.bg,
            body: Stack(
              children: [
                Positioned.fill(child: AppBackground(pattern: fit.bgPattern)),
                Positioned.fill(child: _animatedScreen()),
                if (fit.showNav)
                  Positioned(left: 18, right: 18, bottom: 18, child: _NavBar()),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _confirmDiscard(BuildContext context) async {
    final gc = context.gc;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: gc.bgRaised,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.discardTitle, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text)),
        content: Text(t.discardBody,
            style: AppTheme.s(13, color: gc.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(t.keepTraining, style: AppTheme.s(14, color: gc.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            child: Text(t.discard, style: AppTheme.s(14, weight: FontWeight.w700, color: gc.accent)),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  Widget _animatedScreen() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.018),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slide, child: child),
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        children: <Widget>[
          for (final c in previousChildren) Positioned.fill(child: c),
          if (currentChild != null) Positioned.fill(child: currentChild),
        ],
      ),
      child: KeyedSubtree(key: ValueKey(fit.route), child: _screen()),
    );
  }

  Widget _screen() {
    switch (fit.route) {
      case 'progress':
        return ProgressScreen();
      case 'train':
        return TrainScreen();
      case 'session':
        return SessionScreen();
      case 'exercises':
        return ExercisesScreen();
      case 'exercise-detail':
        return ExerciseDetailScreen();
      case 'tools':
        return ToolsScreen();
      case 'tools-detail':
        return ToolDetailScreen();
      case 'settings':
        return SettingsScreen();
      case 'about':
        return AboutScreen();
      case 'routines':
        return RoutinesScreen();
      case 'routine-edit':
        return RoutineEditScreen();
      case 'home':
      default:
        return HomeScreen();
    }
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar();

  static const _iw = 58.0;
  static const _fabW = 54.0;
  static const _routes = ['home', 'progress', 'exercises', 'settings'];

  int get _selectedIndex {
    final i = _routes.indexOf(fit.route);
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;

    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: const Color(0x59000000), blurRadius: 32, offset: const Offset(0, 12))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final gap = ((w - 4 * _iw - _fabW) / 4).clamp(0.0, 40.0);

            double slotX(int i) {
              switch (i) {
                case 0:
                  return 0;
                case 1:
                  return _iw + gap;
                case 2:
                  return 2 * _iw + 3 * gap + _fabW;
                default:
                  return 3 * _iw + 4 * gap + _fabW;
              }
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 340),
                  curve: Curves.easeOutCubic,
                  left: slotX(_selectedIndex),
                  top: 10,
                  bottom: 10,
                  width: _iw,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: gc.bgRaised2,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _item(context, 0, PhosphorIconsRegular.house, PhosphorIconsFill.house, t.home, fit.goHome),
                    _item(context, 1, PhosphorIconsRegular.chartLineUp, PhosphorIconsFill.chartLineUp, t.progress, fit.goProgress),
                    _fab(context),
                    _item(context, 2, PhosphorIconsRegular.barbell, PhosphorIconsFill.barbell, t.exercises, fit.goExercises),
                    _item(context, 3, PhosphorIconsRegular.gearSix, PhosphorIconsFill.gearSix, t.settings, fit.goSettings),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _item(BuildContext context, int index, IconData icon, IconData iconFill, String label, VoidCallback onTap) {
    final gc = context.gc;
    final selected = _selectedIndex == index;
    final color = selected ? gc.text : gc.textTertiary;
    const dur = Duration(milliseconds: 300);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: _iw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: selected ? 1 : 0, end: selected ? 1 : 0),
              duration: dur,
              curve: Curves.easeOut,
              builder: (context, t, _) => Icon(
                selected ? iconFill : icon,
                size: 22,
                color: Color.lerp(gc.textTertiary, gc.text, t),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedDefaultTextStyle(
                  duration: dur,
                  curve: Curves.easeOut,
                  style: AppTheme.s(9.5, weight: FontWeight.w600, color: color, letterSpacing: 0.2),
                  child: Text(label, maxLines: 1, softWrap: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    final gc = context.gc;
    return GestureDetector(
      onTap: fit.startWorkout,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gc.accent, gc.brass],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: gc.accent.withValues(alpha: 0.45), blurRadius: 18, offset: const Offset(0, 6)),
          ],
        ),
        child: Icon(PhosphorIconsFill.play, size: 24, color: gc.bg),
      ),
    );
  }
}
