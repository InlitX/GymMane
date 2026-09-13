import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

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

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _page = PageController();
  late final TextEditingController _name = TextEditingController();
  late final AnimationController _reveal = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 680),
  )..forward();
  int _index = 0;
  static const _last = 4;

  @override
  void dispose() {
    _page.dispose();
    _name.dispose();
    _reveal.dispose();
    super.dispose();
  }

  void _go(int i) {
    _page.animateToPage(i, duration: const Duration(milliseconds: 340), curve: Curves.easeOutCubic);
  }

  void _onPage(int i) {
    setState(() => _index = i);
    _reveal.forward(from: 0);
  }

  void _finish() {
    final typed = _name.text.trim();
    if (typed.isNotEmpty) fit.updateProfile(name: typed);
    fit.completeOnboarding();
  }

  Widget _in(int order, Widget child) {
    return AnimatedBuilder(
      animation: _reveal,
      builder: (context, kid) {
        final v = Curves.easeOutCubic
            .transform(((_reveal.value - 0.08 * order) / 0.6).clamp(0.0, 1.0));
        return Opacity(
          opacity: v,
          child: Transform.translate(offset: Offset(0, 20 * (1 - v)), child: kid),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Scaffold(
      backgroundColor: gc.bg,
      resizeToAvoidBottomInset: false,
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
                    onPageChanged: _onPage,
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
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                for (int i = 0; i <= _last; i++)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.only(right: 6),
                      height: 3,
                      decoration: BoxDecoration(
                        color: i <= _index ? gc.text : gc.bgRaised2,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _finish,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(t.skip2,
                  style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textTertiary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar(GymColors gc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
      child: Row(
        children: [
          if (_index > 0)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _go(_index - 1),
              child: Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
                child: Icon(PhosphorIconsBold.arrowLeft, size: 18, color: gc.textSecondary),
              ),
            ),
          Expanded(
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
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _in(0, _badge(gc, icon)),
              const SizedBox(height: 22),
              _in(
                1,
                Text(t.onbStep(step, _last).toUpperCase(),
                    style: AppTheme.f(10.5,
                        weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.6)),
              ),
              const SizedBox(height: 9),
              _in(
                2,
                Text(title,
                    style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text, height: 1.12)),
              ),
              const SizedBox(height: 10),
              _in(
                3,
                Text(why,
                    style: AppTheme.f(13.5,
                        weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
              ),
              const SizedBox(height: 26),
              _in(4, child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(GymColors gc, IconData icon) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, size: 24, color: gc.textSecondary),
        ),
      );

  Widget _welcome(GymColors gc) {
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _in(
                0,
                Center(
                  child: Image.asset('assets/img/runner.png',
                      height: 218, opacity: const AlwaysStoppedAnimation(0.9)),
                ),
              ),
              const SizedBox(height: 30),
              _in(
                1,
                Text(t.welcomeKicker.toUpperCase(),
                    style: AppTheme.f(10.5,
                        weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.6)),
              ),
              const SizedBox(height: 8),
              _in(
                2,
                Text('GymMane',
                    style: AppTheme.f(44, weight: FontWeight.w800, color: gc.text, height: 1)),
              ),
              const SizedBox(height: 12),
              _in(
                3,
                Text(t.welcomeBlurb,
                    style: AppTheme.f(14.5,
                        weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
              ),
              const SizedBox(height: 26),
              _in(
                4,
                SoftCard(
                  radius: 22,
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                  child: Column(
                    children: [
                      _promise(gc, PhosphorIconsRegular.wifiSlash, t.fullyOffline),
                      const SizedBox(height: 14),
                      _promise(gc, PhosphorIconsRegular.sealCheck, t.freeForever),
                      const SizedBox(height: 14),
                      _promise(gc, PhosphorIconsRegular.lockKey, t.yoursToTake),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promise(GymColors gc, IconData icon, String label) => Row(
        children: [
          Icon(icon, size: 17, color: gc.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: AppTheme.f(13, weight: FontWeight.w600, color: gc.text)),
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
        textInputAction: TextInputAction.done,
        style: AppTheme.f(20, weight: FontWeight.w700, color: gc.text),
        cursorColor: gc.accent,
        onSubmitted: (_) => _go(2),
        decoration: InputDecoration(
          hintText: t.onbNameHint,
          hintStyle: AppTheme.f(20, weight: FontWeight.w700, color: gc.textTertiary),
          filled: true,
          fillColor: gc.bgRaised,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
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
      child: SoftCard(
        radius: 22,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          children: [
            _row(gc, t.sexLabel, SegToggle([
              SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
              SegOption(
                  t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
            ])),
            _divider(gc),
            _stepperRow(gc, t.ageLabel, '${p.age}', () => fit.updateProfile(ageDelta: -1),
                () => fit.updateProfile(ageDelta: 1)),
            _divider(gc),
            _stepperRow(gc, t.heightLabel, '${fmt(p.heightCm)} cm',
                () => fit.updateProfile(heightDelta: -1), () => fit.updateProfile(heightDelta: 1)),
            _divider(gc),
            _stepperRow(
                gc,
                t.weightLabel,
                fit.weightLabel(p.weightKg),
                () => fit.updateProfile(weightDelta: -fit.fromDisplayWeight(fit.isLb ? 1 : 0.5)),
                () => fit.updateProfile(weightDelta: fit.fromDisplayWeight(fit.isLb ? 1 : 0.5))),
          ],
        ),
      ),
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
              style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            alignment: WrapAlignment.center,
            children: [
              for (int n = 2; n <= 7; n++)
                Pill(
                  label: '$n×',
                  bg: fit.profile.weeklyGoal == n ? gc.ember : gc.bgRaised,
                  fg: fit.profile.weeklyGoal == n ? gc.onEmber : gc.textSecondary,
                  onTap: () =>
                      _up(() => fit.updateProfile(weeklyGoalDelta: n - fit.profile.weeklyGoal)),
                  hPad: 20,
                  vPad: 13,
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
                padding: EdgeInsets.only(right: u == 'kg' ? 12 : 0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _up(() => fit.setUnits(u)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    height: 96,
                    decoration: BoxDecoration(
                      color: fit.units == u ? gc.ember : gc.bgRaised,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: Text(u,
                        style: AppTheme.f(28,
                            weight: FontWeight.w800,
                            color: fit.units == u ? gc.onEmber : gc.text)),
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

  Widget _divider(GymColors gc) => Container(height: 1, color: gc.bgRaised2);

  Widget _row(GymColors gc, String label, Widget control) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
            control,
          ],
        ),
      );

  Widget _stepperRow(
          GymColors gc, String label, String value, VoidCallback dec, VoidCallback inc) =>
      _row(
        gc,
        label,
        StepperControl(
          value: value,
          minWidth: 78,
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
              colors: [gc.ember.withValues(alpha: 0.12), gc.bg.withValues(alpha: 0)],
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.9, 0.9),
                radius: 1.0,
                colors: [gc.brass.withValues(alpha: 0.07), gc.bg.withValues(alpha: 0)],
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      );
}
