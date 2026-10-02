import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../screens/about_screen.dart';
import '../screens/ai_plan_screen.dart';
import '../screens/compare_screen.dart';
import '../screens/exercise_detail_screen.dart';
import '../screens/exercises_screen.dart';
import '../screens/home_screen.dart';
import '../screens/measures_screen.dart';
import '../screens/note_edit_screen.dart';
import '../screens/notes_screen.dart';
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
import '../services/incoming_share.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/award_celebration.dart';
import '../widgets/dialogs.dart';
import '../widgets/glass.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/start_countdown.dart';
import '../widgets/ui_kit.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with WidgetsBindingObserver {
  static const _blurTop = {
    'home',
    'progress',
    'session',
    'about',
    'ai-plan',
    'awards',
    'exercise-detail',
    'measures',
    'routines',
    'preferences',
    'tools',
    'tools-detail',
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
  bool _scrolled = false;
  int _restTick = fit.restDoneTick;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fit.refreshAlarmPermission();
    fit.addListener(_queueCelebration);
    fit.addListener(_offerIncoming);
    fit.addListener(_restOver);
    _queueCelebration();
    IncomingShare.listen(_receive);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final text = await IncomingShare.take();
      if (text != null) _receive(text);
    });
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
      if (mounted) showPlanImportSheet(context, text: text);
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

  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final scrolled = n.metrics.pixels > 6;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
    return false;
  }

  @override
  void dispose() {
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
    if (state == AppLifecycleState.resumed) {
      fit.refreshAlarmPermission();
      fit.syncRest();
      fit.refreshWidgets();
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
            child: BackdropGroup(
              child: Stack(
              children: [
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
                        bottom: (MediaQuery.viewInsetsOf(context).bottom > 0 ? 0 : MediaQuery.viewPaddingOf(context).bottom) +
                            (parked ? _pillSpace : 0)),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _onScroll,
                      child: _animatedScreen(),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: AnimatedOpacity(
                    opacity: _scrolled && _blurTop.contains(fit.route) ? 1 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: EdgeBlur(height: MediaQuery.viewPaddingOf(context).top + 64, sigma: 14),
                  ),
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
                    left: 18,
                    right: 18,
                    bottom: 18 + MediaQuery.viewPaddingOf(context).bottom,
                    child: Directionality(textDirection: TextDirection.ltr, child: _NavBar()),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
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
      _scrolled = false;
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
            final blur = 10 * away;
            return Opacity(
              opacity: v,
              child: ImageFiltered(
                enabled: blur > 0.25,
                imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur, tileMode: TileMode.decal),
                child: Transform.translate(
                  offset: shift,
                  child: Transform.scale(scale: incoming ? 1 + 0.03 * away : 1 - 0.04 * away, child: inner),
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
      case 'note-edit':
        return NoteEditScreen(key: ValueKey(fit.editingNoteId ?? 'new'));
      case 'home':
      default:
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
  static const height = 74.0;
  static const _iw = 58.0;
  static const _fabW = 54.0;
  static const _routes = ['home', 'progress', 'exercises', 'settings'];

  double? _dragX;
  int? _hover;
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
    final gc = context.gc;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, c) {
          _slotW = c.maxWidth - 16;
          _gap = ((_slotW - 4 * _iw - _fabW) / 4).clamp(0.0, 40.0);
          final drag = _dragX;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(color: const Color(0x4D000000), blurRadius: 32, offset: const Offset(0, 12)),
                    ],
                  ),
                  child: const GlassSurface(radius: 28, blur: 16, child: SizedBox.expand()),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                top: 0,
                bottom: 0,
                child: _LiquidPill(
                  left: _slotX(_selectedIndex),
                  dragLeft: drag == null ? null : drag - _iw / 2,
                  width: _iw,
                  color: gc.text.withValues(alpha: fit.dark ? 0.1 : 0.07),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
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
      ),
    );
  }

  Widget _item(BuildContext context, int index, IconData icon, IconData iconFill, String label, VoidCallback onTap) {
    final gc = context.gc;
    final selected = _selectedIndex == index;
    final lifted = selected && _dragX != null;
    final color = selected ? gc.text : gc.textTertiary;
    const dur = Duration(milliseconds: 300);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
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
        scale: lifted ? 1.06 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
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
          final lead = Curves.easeOutCubic.transform(t);
          final trail = Curves.easeInOutCubic.transform(t);
          l = _lerp(_from, to, right ? trail : lead);
          r = _lerp(_from + widget.width, to + widget.width, right ? lead : trail);
          squash = 1 - 0.14 * (1 - (2 * t - 1).abs()) * (to == _from ? 0 : 1);
        }
        _shown = l;
        final base = Color.lerp(widget.color, widget.color.withValues(alpha: (widget.color.a * 2.4).clamp(0.0, 1.0)), lift)!;
        final grow = 6 * lift;
        final inset = 10 + 12 * (1 - squash) - 6 * lift;
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
                  borderRadius: BorderRadius.circular(24),
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
