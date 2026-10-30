import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../screens/about_screen.dart';
import '../screens/ai_plan_screen.dart';
import '../screens/compare_screen.dart';
import '../screens/exercise_detail_screen.dart';
import '../screens/exercises_screen.dart';
import '../screens/gym_pass_screen.dart';
import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/measures_screen.dart';
import '../screens/note_edit_screen.dart';
import '../screens/notes_screen.dart';
import '../screens/nutrition_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/places_screen.dart';
import '../screens/plan_import_sheet.dart';
import '../screens/progress_screen.dart';
import '../screens/routine_edit_screen.dart';
import '../screens/routines_screen.dart';
import '../screens/session_screen.dart';
import '../screens/start_sheet.dart';
import '../screens/awards_screen.dart';
import '../screens/moments_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/timeline_screen.dart';
import '../screens/tool_detail_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/train_screen.dart';
import '../services/auto_backup.dart';
import '../services/device_kind.dart';
import '../services/health_steps.dart';
import '../services/incoming_share.dart';
import '../services/nutrition_widgets.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/award_celebration.dart';
import '../widgets/dialogs.dart';
import '../widgets/steps_card.dart';
import '../widgets/glass.dart';
import '../widgets/health_cards.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/start_countdown.dart';
import '../widgets/ui_kit.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static const _blurTop = {
    'home',
    'progress',
    'session',
    'about',
    'ai-plan',
    'exercise-detail',
    'measures',
    'routines',
    'tools',
    'tools-detail',
    'health',
    'nutrition',
  };

  static const _pillSpace = 68.0;
  static const _firstAwardWait = Duration(milliseconds: 4000);
  static const _nextAwardWait = Duration(milliseconds: 6000);

  String _lastRoute = fit.route;
  int _lastDepth = fit.routeDepth;
  bool _sideways = false;
  bool _forward = true;
  AwardId? _celebrating;
  bool _celebratedOne = false;
  Timer? _awardWait;
  String? _incoming;
  late final AnimationController _collapse;
  bool _collapsed = false;
  int _restTick = fit.restDoneTick;
  final _snap = SnapshotController();
  final _blurSnap = SnapshotController();
  bool _changedUnder = false;

  @override
  void initState() {
    super.initState();
    _collapse = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
    WidgetsBinding.instance.addObserver(this);
    glassOpen.addListener(_syncSnap);
    glassShown.addListener(_syncSnap);
    sheetRecede.addListener(_syncBlurSnap);
    fit.addListener(_fitChanged);
    fit.refreshAlarmPermission();
    fit.addListener(_queueCelebration);
    fit.addListener(_offerIncoming);
    fit.addListener(_restOver);
    _queueCelebration();
    IncomingShare.listen(_receive);
    NutritionWidgets.listenOpen(_openFromWidget);
    HealthSteps.listen(_showStepsInfo);
    fit.refreshSteps();
    fit.refreshHealth();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final text = await IncomingShare.take();
      if (text != null) _receive(text);
      await NutritionWidgets.takePending();
      final open = await NutritionWidgets.takeOpen();
      if (open != null) _openFromWidget(open);
      if (await HealthSteps.takeUsage()) _showStepsInfo();
      await _offerLiteMode();
    });
  }

  void _openFromWidget(String route) {
    if (!mounted || !fit.onboarded || route != 'nutrition' || fit.isSessionActive) return;
    if (fit.route != 'nutrition') fit.goNutrition();
  }

  void _showStepsInfo() {
    if (!mounted || !fit.onboarded) return;
    showStepsSheet(context);
  }

  void _receive(String text) {
    _incoming = text;
    _offerIncoming();
  }

  void _offerIncoming() {
    final text = _incoming;
    if (text == null || !mounted || !fit.onboarded || fit.isSessionActive) return;
    _incoming = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (fit.isMealPlanText(text)) {
        final n = fit.importMealPlans(text);
        if (n > 0) {
          fit.setNutritionBeta(true);
          fit.goNutrition();
        }
        showMealPlanImportResult(context, n);
        return;
      }
      showPlanImportSheet(context, text: text);
    });
  }

  void _restOver() {
    if (fit.restDoneTick == _restTick) return;
    _restTick = fit.restDoneTick;
    final s = fit.session;
    final ex = fit.currentExercise;
    if (!mounted || s == null || ex == null) return;
    final done = ex.sets.where((st) => st.done).length;
    final next = done < ex.sets.length ? t.liveSet(done + 1, ex.sets.length) : t.liveAllDone;
    showNotchToast(
      context,
      t.restOverTitle,
      subtitle: '${t.catalogName(ex.id, ex.name)} · $next',
      icon: PhosphorIconsFill.timer,
      accent: context.gc.sage,
      sound: false,
    );
  }

  Future<void> _offerLiteMode() async {
    if (fit.lowEndAsked || !fit.blurOn || !fit.onboarded) return;
    if (!await DeviceKind.isLowEnd() || !mounted) return;
    fit.markLowEndAsked();
    final off = await askConfirm(
      context,
      title: t.lowEndTitle,
      body: t.lowEndBody,
      cancelLabel: t.lowEndKeep,
      confirmLabel: t.lowEndOff,
    );
    if (off) fit.setBlur(false);
  }

  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final y = n.metrics.pixels;
    final next = y > 44 ? true : (y < 16 ? false : _collapsed);
    if (next != _collapsed) {
      _collapsed = next;
      next ? _collapse.forward() : _collapse.reverse();
    }
    return false;
  }

  void _fitChanged() {
    if (_snap.allowSnapshotting) _changedUnder = true;
    _syncSnap();
  }

  void _syncSnap() => scheduleMicrotask(() {
        if (!mounted) return;
        final on = fit.route == 'nutrition' && (glassOpen.value > 0 || (glassShown.value > 0 && !_changedUnder));
        if (on == _snap.allowSnapshotting) return;
        _changedUnder = false;
        _snap.allowSnapshotting = on;
      });

  void _syncBlurSnap() => scheduleMicrotask(() {
        if (!mounted) return;
        final on = blurEffects && sheetRecede.value >= 0.999;
        if (on != _blurSnap.allowSnapshotting) _blurSnap.allowSnapshotting = on;
      });

  @override
  void dispose() {
    sheetRecede.removeListener(_syncBlurSnap);
    _blurSnap.dispose();
    glassOpen.removeListener(_syncSnap);
    glassShown.removeListener(_syncSnap);
    fit.removeListener(_fitChanged);
    _snap.dispose();
    _collapse.dispose();
    fit.removeListener(_restOver);
    fit.removeListener(_offerIncoming);
    fit.removeListener(_queueCelebration);
    _awardWait?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _queueCelebration() {
    if (fit.nextCelebration == null) {
      _celebratedOne = false;
      return;
    }
    if (_celebrating != null || _awardWait != null || fit.route == 'session') return;
    _awardWait = Timer(_celebratedOne ? _nextAwardWait : _firstAwardWait, () {
      _awardWait = null;
      final next = fit.nextCelebration;
      if (!mounted || next == null || fit.route == 'session') return;
      setState(() => _celebrating = next);
    });
  }

  void _closeCelebration() {
    setState(() => _celebrating = null);
    _celebratedOne = true;
    fit.celebrationShown();
  }

  @override
  void didChangePlatformBrightness() => fit.systemBrightnessChanged();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      fit.persistNow();
    }
    if (state == AppLifecycleState.paused) AutoBackup.instance.onLeave();
    if (state == AppLifecycleState.resumed) {
      fit.rollNutritionDay();
      NutritionWidgets.takePending();
      fit.refreshAlarmPermission();
      fit.syncRest();
      fit.refreshWidgets();
      fit.refreshSteps();
      fit.refreshHealth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fit,
      builder: (context, _) {
        if (!fit.onboarded) return const OnboardingScreen();
        final parked = fit.sessionParked && fit.showNav;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (fit.isSessionActive && fit.sessionLocked) {
              HapticFeedback.mediumImpact();
              return;
            }
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
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: fit.dark ? _overlayDark : _overlayLight,
            child: ColoredBox(
              color: fit.dark ? const Color(0xFF16161A) : const Color(0xFF3A3A3E),
              child: ValueListenableBuilder<double>(
              valueListenable: sheetRecede,
              child: RepaintBoundary(
              child: BackdropGroup(
              child: Stack(
              children: [
                Positioned.fill(
                  child: SnapshotWidget(
                    controller: _snap,
                    mode: SnapshotMode.permissive,
                    autoresize: true,
                    child: Stack(children: [
                      Positioned.fill(child: ColoredBox(color: context.gc.bg)),
                      Positioned.fill(
                        child: AppBackground(
                          pattern: fit.bgPattern,
                          photo: fit.bgPhotoPath,
                          dim: fit.bgDim,
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Padding(
                          padding: EdgeInsets.only(
                              bottom: (MediaQuery.viewInsetsOf(context).bottom > 0
                                      ? 0
                                      : MediaQuery.viewPaddingOf(context).bottom) +
                                  (parked ? _pillSpace : 0)),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: _onScroll,
                            child: RepaintBoundary(child: _animatedScreen()),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: _blurTop.contains(fit.route)
                      ? _CollapsedBar(progress: _collapse, title: _compactTitle())
                      : const SizedBox.shrink(),
                ),
                if (fit.showNav)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: EdgeBlur(
                        top: false, height: 128 + MediaQuery.viewPaddingOf(context).bottom + (parked ? _pillSpace : 0)),
                  ),
                if (fit.showNav && MediaQuery.viewInsetsOf(context).bottom < 60) ...[
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 18 + MediaQuery.viewPaddingOf(context).bottom,
                    child: RepaintBoundary(
                      child: Directionality(textDirection: TextDirection.ltr, child: _NavBar()),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 18 + _NavBarState.height + 10 + MediaQuery.viewPaddingOf(context).bottom,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 320),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, a) => FadeTransition(
                        opacity: a,
                        child: SlideTransition(
                          position: Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(a),
                          child: child,
                        ),
                      ),
                      child: parked ? const _ParkedPill() : const SizedBox(width: double.infinity),
                    ),
                  ),
                ],
                if (fit.countdownUntil != null && fit.session != null)
                  Positioned.fill(
                    child: StartCountdown(key: ValueKey(fit.countdownUntil), until: fit.countdownUntil!),
                  ),
                if (fit.route != 'session' && _celebrating != null)
                  Positioned.fill(
                    child: AwardCelebration(
                      key: ValueKey(_celebrating),
                      id: _celebrating!,
                      onClose: _closeCelebration,
                    ),
                  ),
              ],
              ),
            ),
            ),
              builder: (context, p, app) => Transform.scale(
                scale: 1 - 0.08 * p,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32 * p),
                  clipBehavior: p > 0.001 ? Clip.antiAlias : Clip.none,
                  child: SnapshotWidget(
                    controller: _blurSnap,
                    mode: SnapshotMode.permissive,
                    child: ImageFiltered(
                      enabled: blurEffects && p > 0.01,
                      imageFilter: ui.ImageFilter.blur(sigmaX: 2.5 * p, sigmaY: 2.5 * p),
                      child: app,
                    ),
                  ),
                ),
              ),
            ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _confirmDiscard(BuildContext context) => askConfirm(
        context,
        title: t.discardTitle,
        body: t.discardBody,
        cancelLabel: t.keepTraining,
        confirmLabel: t.discard,
      );

  Widget _animatedScreen() {
    final route = fit.route;
    if (route != _lastRoute) {
      _collapsed = false;
      _collapse.value = 0;
      final from = _NavBarState._routes.indexOf(_lastRoute);
      final to = _NavBarState._routes.indexOf(route);
      _sideways = from >= 0 && to >= 0;
      _forward = _sideways ? to > from : fit.routeDepth >= _lastDepth;
      _lastRoute = route;
      _lastDepth = fit.routeDepth;
    }
    final sideways = _sideways;
    final dir = _forward ? 1.0 : -1.0;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 380),
      switchInCurve: const Interval(0.3, 1, curve: Curves.easeOutCubic),
      switchOutCurve: const Interval(0.7, 1, curve: Curves.easeInCubic),
      transitionBuilder: (child, animation) {
        final incoming = (child.key as ValueKey?)?.value == fit.route;
        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (_, inner) {
            final v = animation.value.clamp(0.0, 1.0);
            final away = 1 - v;
            final shift = sideways
                ? Offset((incoming ? 26 : -18) * dir * away, 0)
                : Offset(0, incoming ? 22 * dir * away : -8 * dir * away);
            return Opacity(
              opacity: v,
              child: Transform.translate(
                offset: shift,
                child: Transform.scale(
                  scale: incoming ? 1 + 0.03 * away : 1 - 0.04 * away,
                  child: RepaintBoundary(child: inner),
                ),
              ),
            );
          },
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        children: <Widget>[
          for (final c in previousChildren) Positioned.fill(key: c.key, child: c),
          if (currentChild != null) Positioned.fill(key: currentChild.key, child: currentChild),
        ],
      ),
      child: KeyedSubtree(key: ValueKey(fit.route), child: _screen()),
    );
  }

  String? _compactTitle() => switch (fit.route) {
        'home' => t.longDate(DateTime.now()),
        'progress' => t.progress,
        'exercises' => t.exercises,
        'preferences' => t.settings,
        'routines' => t.routines,
        'tools' => t.tools,
        'measures' => t.measures,
        'awards' => t.awardsTitle,
        'about' => t.about,
        'health' => t.healthTitle,
        'nutrition' => t.nutrition,
        _ when fit.route.startsWith('preferences/') => SettingsScreen.sectionTitleOf(fit.route.substring(12)),
        _ => null,
      };

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
        return ProfileScreen();
      case 'preferences':
        return SettingsScreen();
      case 'moments':
        return MomentsScreen();
      case 'awards':
        return AwardsScreen();
      case 'passes':
        return GymPassScreen();
      case 'about':
        return AboutScreen();
      case 'routines':
        return RoutinesScreen();
      case 'ai-plan':
        return AiPlanScreen();
      case 'routine-edit':
        return RoutineEditScreen(key: ValueKey(fit.activeRoutineId));
      case 'measures':
        return MeasuresScreen();
      case 'places':
        return PlacesScreen();
      case 'timeline':
        return TimelineScreen();
      case 'compare':
        return CompareScreen();
      case 'notes':
        return NotesScreen();
      case 'history':
        return HistoryScreen();
      case 'nutrition':
        return NutritionScreen();
      case 'health':
        return const HealthScreen();
      case 'note-edit':
        return NoteEditScreen(key: ValueKey(fit.editingNoteId ?? 'new'));
      case 'home':
      default:
        if (fit.route.startsWith('preferences/')) {
          return SettingsScreen(key: ValueKey(fit.route), section: fit.route.substring(12));
        }
        return HomeScreen();
    }
  }
}

const _overlayBase = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarContrastEnforced: false,
  systemStatusBarContrastEnforced: false,
);

final _overlayDark = _overlayBase.copyWith(
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.light,
);

final _overlayLight = _overlayBase.copyWith(
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.dark,
);

class _CollapsedBar extends StatelessWidget {
  const _CollapsedBar({required this.progress, required this.title});

  final Animation<double> progress;
  final String? title;

  static const _ease = Cubic(0.22, 1, 0.36, 1);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.viewPaddingOf(context).top;
    final blur = EdgeBlur(height: top + 64, sigma: 14);
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        final p = _ease.transform(progress.value.clamp(0.0, 1.0));
        if (p <= 0.001) return const SizedBox.shrink();
        final soft = math.sin(p * math.pi) * 7;
        return IgnorePointer(
          child: Stack(
            children: [
              p >= 0.999 ? blur : Opacity(opacity: p, child: blur),
              if (title != null)
                Positioned(
                  left: 72,
                  right: 72,
                  top: top + 14,
                  child: Opacity(
                    opacity: p,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - p)),
                      child: Transform.scale(
                        scale: 1.22 - 0.22 * p,
                        child: ImageFiltered(
                          enabled: soft > 0.3,
                          imageFilter: ui.ImageFilter.blur(sigmaX: soft, sigmaY: soft),
                          child: Text(
                            titleCase(title!),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(15.5, weight: FontWeight.w800, color: context.gc.text, letterSpacing: -0.2)
                                .copyWith(decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ParkedPill extends StatelessWidget {
  const _ParkedPill();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final ex = fit.currentExercise;
    return Pressable(
      onTap: fit.stepBackIntoSession,
      scale: 0.97,
      child: Semantics(
        button: true,
        label: t.resumeWorkout,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 24, offset: Offset(0, 10))],
          ),
          child: GlassSurface(
            radius: 22,
            blur: 16,
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Material(
              type: MaterialType.transparency,
              child: Row(children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.paused,
                        style: AppTheme.f(10.5,
                            weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
                    const SizedBox(height: 2),
                    Text(ex == null ? '' : t.catalogName(ex.id, ex.name),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ValueListenableBuilder<int>(
                valueListenable: fit.clock,
                builder: (_, _, _) =>
                    Text(fit.elapsedLabel, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.textSecondary)),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: gc.ember, shape: BoxShape.circle),
                child: Icon(PhosphorIconsFill.play, size: 16, color: gc.onEmber),
              ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatefulWidget {
  const _NavBar();

  @override
  State<_NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<_NavBar> {
  static const height = 68.0;
  static const _iw = 58.0;
  static const _fabW = 48.0;
  static const _routes = ['home', 'progress', 'exercises', 'settings'];

  double? _dragX;
  int? _hover;
  int? _pressed;
  double _slotW = 0;
  double _gap = 0;

  int get _selectedIndex {
    if (_hover != null) return _hover!;
    final i = _routes.indexOf(fit.route);
    return i < 0 ? 0 : i;
  }

  double _slotX(int i) => switch (i) {
        0 => 0,
        1 => _iw + _gap,
        2 => 2 * _iw + 3 * _gap + _fabW,
        _ => 3 * _iw + 4 * _gap + _fabW,
      };

  void _go(int i) => [fit.goHome, fit.goProgress, fit.goExercises, fit.goSettings][i]();

  int _nearest(double x) {
    var best = 0;
    for (var i = 1; i < 4; i++) {
      if ((_slotX(i) + _iw / 2 - x).abs() < (_slotX(best) + _iw / 2 - x).abs()) best = i;
    }
    return best;
  }

  void _dragTo(double x) {
    final near = _nearest(x);
    if (near != _hover) HapticFeedback.selectionClick();
    setState(() {
      _dragX = x.clamp(_iw / 2, _slotW - _iw / 2);
      _hover = near;
    });
  }

  void _dragEnd() {
    final target = _hover;
    setState(() {
      _dragX = null;
      _hover = null;
    });
    if (target != null && target != _routes.indexOf(fit.route)) _go(target);
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(height: height, child: _bar(context, height));
  }

  Widget _bar(BuildContext context, double h) {
    final gc = context.gc;
    return LayoutBuilder(
        builder: (context, c) {
          _slotW = c.maxWidth - 28;
          _gap = ((_slotW - 4 * _iw - _fabW) / 4).clamp(0.0, 40.0);
          final drag = _dragX;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(h / 2),
                    boxShadow: [
                      BoxShadow(color: const Color(0x66000000), blurRadius: 28, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: GlassSurface(
                    radius: h / 2,
                    blur: 30,
                    tint: fit.dark ? const Color(0xFF131313).withValues(alpha: 0.72) : null,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                top: 0,
                bottom: 0,
                child: _LiquidPill(
                  left: _slotX(_selectedIndex) - _gap * 0.2,
                  dragLeft: drag == null ? null : drag - _iw / 2 - _gap * 0.2,
                  width: _iw + _gap * 0.4,
                  color: gc.text.withValues(alpha: fit.dark ? 0.13 : 0.08),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragStart: (d) {
                    final fab = 2 * _iw + 2 * _gap + _fabW / 2;
                    if ((d.localPosition.dx - fab).abs() < _fabW / 2 + 4) return;
                    HapticFeedback.selectionClick();
                    _dragTo(d.localPosition.dx);
                  },
                  onHorizontalDragUpdate: (d) {
                    if (_dragX != null) _dragTo(d.localPosition.dx);
                  },
                  onHorizontalDragEnd: (_) {
                    if (_dragX != null) _dragEnd();
                  },
                  onHorizontalDragCancel: () {
                    if (_dragX != null) _dragEnd();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _item(context, 0, PhosphorIconsRegular.house, PhosphorIconsFill.house, t.home, fit.goHome),
                      _item(context, 1, PhosphorIconsRegular.chartLineUp, PhosphorIconsFill.chartLineUp, t.progress,
                          fit.goProgress),
                      _fab(context),
                      _item(context, 2, PhosphorIconsRegular.barbell, PhosphorIconsFill.barbell, t.exercises,
                          fit.goExercises),
                      _item(context, 3, PhosphorIconsRegular.userCircle, PhosphorIconsFill.userCircle, t.profile.toUpperCase(),
                          fit.goSettings),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
  }

  Widget _item(BuildContext context, int index, IconData icon, IconData iconFill, String label, VoidCallback onTap) {
    final gc = context.gc;
    final selected = _selectedIndex == index;
    final lifted = selected && _dragX != null;
    final pressed = _pressed == index && _dragX == null;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        onTapDown: (_) => setState(() => _pressed = index),
        onTapUp: (_) => setState(() => _pressed = null),
        onTapCancel: () => setState(() => _pressed = null),
        onLongPressStart: (d) {
          HapticFeedback.mediumImpact();
          _dragTo(_slotX(index) + d.localPosition.dx);
        },
        onLongPressMoveUpdate: (d) => _dragTo(_slotX(index) + d.localPosition.dx),
        onLongPressEnd: (_) => _dragEnd(),
        onLongPressCancel: () {
          if (_dragX != null) _dragEnd();
        },
        child: AnimatedScale(
          scale: pressed ? 0.85 : (lifted ? 1.08 : 1),
          duration: Duration(milliseconds: pressed ? 110 : 340),
          curve: pressed ? Curves.easeOut : Curves.easeOutBack,
          child: SizedBox(
            width: _iw,
            height: height,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: selected ? 1 : 0, end: selected ? 1 : 0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              builder: (context, v, _) => Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(opacity: 0.7 * (1 - v), child: Icon(icon, size: 24, color: gc.text)),
                  Opacity(opacity: v, child: Icon(iconFill, size: 24, color: gc.text)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _play(BuildContext context) {
    if (fit.sessionParked) {
      fit.stepBackIntoSession();
      return;
    }
    final planned = fit.todayRoutine;
    if (planned != null && planned.exerciseIds.isNotEmpty) {
      fit.startRoutine(planned);
      return;
    }
    showStartSheet(context);
  }

  Widget _fab(BuildContext context) {
    final gc = context.gc;
    return GestureDetector(
      onTap: () => _play(context),
      onLongPress: () => showStartSheet(context),
      child: Container(
        width: _fabW,
        height: _fabW,
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
        child: Icon(PhosphorIconsFill.play, size: 21, color: gc.bg),
      ),
    );
  }
}

class _LiquidPill extends StatefulWidget {
  const _LiquidPill({required this.left, required this.width, required this.color, this.dragLeft});

  final double left;
  final double? dragLeft;
  final double width;
  final Color color;

  @override
  State<_LiquidPill> createState() => _LiquidPillState();
}

class _LiquidPillState extends State<_LiquidPill> with TickerProviderStateMixin {
  late final AnimationController _move =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 460), value: 1);
  late final AnimationController _lift = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
    reverseDuration: const Duration(milliseconds: 380),
  );
  late double _from = widget.left;
  late double _shown = widget.left;

  @override
  void didUpdateWidget(_LiquidPill old) {
    super.didUpdateWidget(old);
    final dragging = widget.dragLeft != null;
    if (dragging != (old.dragLeft != null)) {
      dragging ? _lift.forward() : _lift.reverse();
    }
    if (dragging) return;
    if (old.left == widget.left && old.dragLeft == null) return;
    _from = _shown;
    _move.forward(from: 0);
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static const _liftCurve = Cubic(0.3, 1.25, 0.5, 1);

  @override
  void dispose() {
    _move.dispose();
    _lift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_move, _lift]),
      builder: (context, _) {
        final lift = _liftCurve.transform(_lift.value.clamp(0.0, 1.0));
        final double l, r;
        var squash = 1.0;
        final drag = widget.dragLeft;
        if (drag != null) {
          l = drag;
          r = drag + widget.width;
        } else {
          final t = _move.value;
          final to = widget.left;
          final right = to >= _from;
          final lead = const Cubic(0.2, 1.35, 0.35, 1).transform(t);
          final trail = const Cubic(0.45, 0, 0.2, 1).transform(t);
          l = _lerp(_from, to, right ? trail : lead);
          r = _lerp(_from + widget.width, to + widget.width, right ? lead : trail);
          squash = 1 - 0.14 * (1 - (2 * t - 1).abs()) * (to == _from ? 0 : 1);
        }
        _shown = l;
        final base = Color.lerp(widget.color, widget.color.withValues(alpha: (widget.color.a * 2.4).clamp(0.0, 1.0)), lift)!;
        final grow = 6 * lift;
        final inset = 10 + 8 * (1 - squash) - 5 * lift;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: l - grow,
              width: r - l + 2 * grow,
              top: inset,
              bottom: inset,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.16 * lift), width: 1),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.alphaBlend(Colors.white.withValues(alpha: 0.12 * lift), base),
                      base,
                    ],
                  ),
                  boxShadow: lift <= 0
                      ? null
                      : [BoxShadow(color: Colors.black.withValues(alpha: 0.28 * lift), blurRadius: 22, offset: const Offset(0, 8))],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
