import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/ui_kit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _page = PageController();
  late final TextEditingController _name = TextEditingController();
  int _index = 0;
  static const _last = 4;

  @override
  void dispose() {
    _page.dispose();
    _name.dispose();
    super.dispose();
  }

  void _go(int i) {
    setState(() => _index = i);
    _page.animateToPage(i, duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic);
  }

  void _finish() {
    final typed = _name.text.trim();
    if (typed.isNotEmpty) fit.updateProfile(name: typed);
    fit.completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Scaffold(
      backgroundColor: gc.bg,
      body: Stack(
        children: [
          Positioned.fill(child: _Glow(gc)),
          const Positioned.fill(child: AppBackground(pattern: 'dots')),
          SafeArea(
            child: Column(
              children: [
                _topBar(gc),
                Expanded(
                  child: PageView(
                    controller: _page,
                    onPageChanged: (i) => setState(() => _index = i),
                    children: [
                      _welcome(gc),
                      _nameStep(gc),
                      _bodyStep(gc),
                      _goalStep(gc),
                      _unitsStep(gc),
                    ],
                  ),
                ),
                _bottomBar(gc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar(GymColors gc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            for (int i = 0; i <= _last; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                margin: const EdgeInsets.only(right: 6),
                width: i == _index ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i <= _index ? gc.ember : gc.bgRaised2,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ]),
          Semantics(
            button: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _finish,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(t.skip2, style: AppTheme.s(13, color: gc.textTertiary)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(GymColors gc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          if (_index > 0)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _go(_index - 1),
                child: SizedBox(
                  height: 52,
                  child: Center(
                    child: Text(t.back,
                        style: AppTheme.d(13, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 1)),
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: PrimaryButton(
              label: _index == _last ? t.welcomeStart : t.next,
              onTap: () => _index == _last ? _finish() : _go(_index + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _step(
    GymColors gc, {
    required int step,
    required IconData icon,
    required String title,
    required String why,
    required Widget child,
  }) {
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _badge(gc, icon),
              const SizedBox(height: 20),
              Text(t.onbStep(step, _last),
                  style: AppTheme.d(11, weight: FontWeight.w600, color: gc.brass, letterSpacing: 3)),
              const SizedBox(height: 8),
              Text(title, style: AppTheme.d(30, weight: FontWeight.w700, color: gc.text, height: 1.1)),
              const SizedBox(height: 8),
              Text(why, style: AppTheme.s(14, color: gc.textSecondary, height: 1.4)),
              const SizedBox(height: 28),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(GymColors gc, IconData icon) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: gc.emberSoft,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gc.border),
          ),
          child: Icon(icon, size: 26, color: gc.ember),
        ),
      );

  Widget _welcome(GymColors gc) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset('assets/img/runner.png',
                height: 200, opacity: const AlwaysStoppedAnimation(0.85)),
          ),
          const SizedBox(height: 28),
          Text(t.welcomeKicker,
              style: AppTheme.d(12, weight: FontWeight.w600, color: gc.brass, letterSpacing: 3)),
          const SizedBox(height: 6),
          Text('GYMMANE', style: AppTheme.d(46, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text(t.welcomeBlurb, style: AppTheme.s(15, color: gc.textSecondary, height: 1.45)),
          const SizedBox(height: 26),
          _promise(gc, PhosphorIconsRegular.wifiSlash, t.fullyOffline),
          const SizedBox(height: 10),
          _promise(gc, PhosphorIconsRegular.sealCheck, t.freeForever),
          const SizedBox(height: 10),
          _promise(gc, PhosphorIconsRegular.lockKey, t.yoursToTake),
        ],
      ),
    );
  }

  Widget _promise(GymColors gc, IconData icon, String label) => Row(
        children: [
          Icon(icon, size: 17, color: gc.sage),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
          ),
        ],
      );

  Widget _nameStep(GymColors gc) {
    return _step(
      gc,
      step: 1,
      icon: PhosphorIconsRegular.user,
      title: t.onbNameTitle,
      why: t.onbNameWhy,
      child: TextField(
        controller: _name,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        style: AppTheme.d(22, weight: FontWeight.w600, color: gc.text),
        cursorColor: gc.accent,
        onSubmitted: (_) => _go(2),
        decoration: InputDecoration(
          hintText: t.onbNameHint,
          hintStyle: AppTheme.d(22, weight: FontWeight.w600, color: gc.textTertiary),
          filled: true,
          fillColor: gc.bgRaised,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _bodyStep(GymColors gc) {
    final p = fit.profile;
    return _step(
      gc,
      step: 2,
      icon: PhosphorIconsRegular.ruler,
      title: t.onbBodyTitle,
      why: t.onbBodyWhy,
      child: Column(children: [
        _row(gc, t.sexLabel, SegToggle([
          SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
          SegOption(t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
        ])),
        const SizedBox(height: 12),
        _stepper(gc, t.ageLabel, '${p.age}', () => fit.updateProfile(ageDelta: -1), () => fit.updateProfile(ageDelta: 1)),
        const SizedBox(height: 12),
        _stepper(gc, t.heightLabel, '${fmt(p.heightCm)} cm', () => fit.updateProfile(heightDelta: -1),
            () => fit.updateProfile(heightDelta: 1)),
        const SizedBox(height: 12),
        _stepper(gc, t.weightLabel, fit.weightLabel(p.weightKg),
            () => fit.updateProfile(weightDelta: -fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)),
            () => fit.updateProfile(weightDelta: fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
      ]),
    );
  }

  Widget _goalStep(GymColors gc) {
    return _step(
      gc,
      step: 3,
      icon: PhosphorIconsRegular.target,
      title: t.onbGoalTitle,
      why: t.onbGoalWhy,
      child: Column(
        children: [
          Text(t.perWeek(fit.profile.weeklyGoal),
              style: AppTheme.d(28, weight: FontWeight.w700, color: gc.text)),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (int n = 2; n <= 7; n++)
                Pill(
                  label: '$n×',
                  bg: fit.profile.weeklyGoal == n ? gc.ember : gc.bgRaised2,
                  fg: fit.profile.weeklyGoal == n ? gc.onEmber : gc.textSecondary,
                  onTap: () => _up(() => fit.updateProfile(weeklyGoalDelta: n - fit.profile.weeklyGoal)),
                  hPad: 18,
                  vPad: 12,
                  fontSize: 15,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _unitsStep(GymColors gc) {
    return _step(
      gc,
      step: 4,
      icon: PhosphorIconsRegular.scales,
      title: t.onbUnitsTitle,
      why: t.autofills,
      child: Row(
        children: [
          for (final u in const ['kg', 'lb'])
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _up(() => fit.setUnits(u)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    height: 90,
                    decoration: BoxDecoration(
                      color: fit.units == u ? gc.ember : gc.bgRaised,
                      border: Border.all(color: fit.units == u ? gc.ember : gc.border),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.center,
                    child: Text(u,
                        style: AppTheme.d(30,
                            weight: FontWeight.w700, color: fit.units == u ? gc.onEmber : gc.text)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _up(VoidCallback action) {
    action();
    setState(() {});
  }

  Widget _row(GymColors gc, String label, Widget control) => SoftCard(
        radius: 14,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.s(13, weight: FontWeight.w600, color: gc.textSecondary)),
            control,
          ],
        ),
      );

  Widget _stepper(GymColors gc, String label, String value, VoidCallback dec, VoidCallback inc) => _row(
        gc,
        label,
        StepperControl(
          value: value,
          minWidth: 74,
          btnSize: 34,
          gap: 12,
          fontSize: 15,
          onDec: () => _up(dec),
          onInc: () => _up(inc),
        ),
      );
}

class _Glow extends StatelessWidget {
  const _Glow(this.gc);

  final GymColors gc;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.9, -0.85),
              radius: 1.1,
              colors: [gc.ember.withValues(alpha: 0.16), gc.bg.withValues(alpha: 0)],
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.9, 0.9),
                radius: 1.0,
                colors: [gc.brass.withValues(alpha: 0.08), gc.bg.withValues(alpha: 0)],
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      );
}
