import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../catalog/body_art.dart';
import '../catalog/exercise_catalog.dart';
import '../app/desktop.dart';
import '../l10n/l10n.dart';
import '../services/device_kind.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/body_rulers.dart';
import '../widgets/body_map.dart';
import '../widgets/entrance.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/rolling_text.dart';
import '../widgets/speed_panel.dart';
import '../widgets/ui_kit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _page = PageController();
  late final TextEditingController _name = TextEditingController();
  final _at = ValueNotifier<int>(0);

  int get _index => _at.value;
  int get _last => _slow ? 7 : 6;
  final Map<String, Set<String>> _places = {};
  final _frames = <FrameTiming>[];
  bool _slow = false;
  bool _probing = false;
  bool _blur = false;
  bool _motion = false;
  bool _wide = false;

  @override
  void initState() {
    super.initState();
    if (fit.lowEndAsked || !fit.blurOn) return;
    DeviceKind.isLowEnd().then((low) {
      if (low) _markSlow();
    });
    _probing = true;
    SchedulerBinding.instance.addTimingsCallback(_timings);
  }

  void _timings(List<FrameTiming> list) {
    _frames.addAll(list);
    if (_frames.length < 45) return;
    _stopProbe();
    final heavy = _frames.where((f) => (f.buildDuration + f.rasterDuration).inMilliseconds > 24).length;
    if (heavy > _frames.length * 0.25) _markSlow();
  }

  void _stopProbe() {
    if (!_probing) return;
    _probing = false;
    SchedulerBinding.instance.removeTimingsCallback(_timings);
  }

  void _markSlow() {
    if (!mounted || _slow) return;
    _stopProbe();
    setState(() => _slow = true);
  }

  @override
  void dispose() {
    _stopProbe();
    _page.dispose();
    _at.dispose();
    _name.dispose();
    super.dispose();
  }

  void _go(int i) {
    _page.animateToPage(i, duration: const Duration(milliseconds: 340), curve: Curves.easeOutCubic);
  }

  void _onPage(int i) => _at.value = i;

  void _finish() {
    final typed = _name.text.trim();
    if (typed.isNotEmpty) fit.updateProfile(name: typed);
    String? first;
    for (final preset in kPlacePresets) {
      final gear = _places[preset];
      if (gear == null) continue;
      final id = fit.addPlace(t.placePresetName(preset), equipment: {...gear, 'Bodyweight'});
      if (id.isNotEmpty) first ??= id;
    }
    if (first != null && fit.activePlaceId != first) fit.setActivePlace(first);
    if (_slow) {
      fit.setPerfLevel(_blur ? 'balanced' : 'lite');
      fit.setBlur(_blur);
      fit.setCalmMotion(!_motion);
      fit.markLowEndAsked();
    }
    fit.completeOnboarding();
  }

  Widget _in(int order, Widget child) => Rise(index: order, child: child);

  Future<void> _pickPhoto() async {
    final source = await pickPhotoSource(context);
    if (source == null) return;
    final shot = await ImagePicker().pickImage(source: source, maxWidth: 512, maxHeight: 512, imageQuality: 80);
    if (shot == null) return;
    final bytes = await shot.readAsBytes();
    if (!mounted) return;
    HapticFeedback.lightImpact();
    setState(() => fit.setProfilePhoto(bytes));
  }

  Widget _photo(GymColors gc, {double size = 104}) {
    final bytes = fit.profile.photo.isEmpty ? null : fit.profilePhoto;
    final badge = size * 0.3;
    return Center(
      child: Semantics(
        button: true,
        label: bytes == null ? t.onbPhotoAdd : t.onbPhotoChange,
        child: Pressable(
          onTap: _pickPhoto,
          scale: 0.95,
          child: Column(children: [
            SizedBox(
              width: size,
              height: size,
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: size,
                  height: size,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: gc.border, width: 1.5),
                  ),
                  child: bytes == null
                      ? Icon(PhosphorIconsRegular.user, size: size * 0.4, color: gc.textTertiary)
                      : Image.memory(bytes, fit: BoxFit.cover, gaplessPlayback: true),
                ),
                Positioned(
                  right: size * 0.02,
                  bottom: size * 0.03,
                  child: Container(
                    width: badge,
                    height: badge,
                    decoration: BoxDecoration(
                      color: gc.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: gc.bg, width: 3),
                    ),
                    child: Icon(PhosphorIconsBold.camera, size: badge * 0.44, color: gc.onEmber),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Text(bytes == null ? t.onbPhotoAdd : t.onbPhotoChange,
                style: AppTheme.f(13, weight: FontWeight.w700, color: gc.accent)),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    _wide = DesktopScope.wideFor(MediaQuery.sizeOf(context).width);
    final content = Column(
      children: [
        ValueListenableBuilder<int>(valueListenable: _at, builder: (_, _, _) => _topBar(gc)),
        Expanded(
          child: RepaintBoundary(
            child: PageView(
              controller: _page,
              onPageChanged: _onPage,
              children: [
                for (final page in [
                  _welcome(gc),
                  _nameStep(gc),
                  _photoStep(gc),
                  _unitsStep(gc),
                  _bodyStep(gc),
                  _goalStep(gc),
                  _placeStep(gc),
                  if (_slow) _speedStep(gc),
                ])
                  RepaintBoundary(child: page),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<int>(valueListenable: _at, builder: (_, _, _) => _bottomBar(gc)),
      ],
    );
    return Scaffold(
      backgroundColor: gc.bg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(child: RepaintBoundary(child: _Glow(gc))),
          const Positioned.fill(child: RepaintBoundary(child: AppBackground(pattern: 'dots'))),
          SafeArea(
            child: _wide
                ? LayoutBuilder(
                    builder: (context, box) => Center(
                      child: Container(
                        width: math.min(1080, box.maxWidth - 64),
                        height: math.min(660, box.maxHeight - 48),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: gc.bg.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: content,
                      ),
                    ),
                  )
                : content,
          ),
        ],
      ),
    );
  }

  Widget _topBar(GymColors gc) {
    return Padding(
      padding: _wide ? const EdgeInsets.fromLTRB(44, 30, 36, 0) : const EdgeInsets.fromLTRB(24, 16, 16, 0),
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
                      margin: const EdgeInsetsDirectional.only(end: 6),
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
    final next = PrimaryButton(
      label: _index == _last
          ? t.welcomeStart
          : _index == 2 && fit.profile.photo.isEmpty
              ? t.onbPhotoLater
              : t.next,
      onTap: () => _index == _last ? _finish() : _go(_index + 1),
    );
    return Padding(
      padding: _wide ? const EdgeInsets.fromLTRB(44, 8, 44, 32) : const EdgeInsets.fromLTRB(24, 8, 24, 22),
      child: Row(
        children: [
          if (_index > 0)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _go(_index - 1),
              child: Container(
                width: 56,
                height: 56,
                margin: const EdgeInsetsDirectional.only(end: 12),
                decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
                child: Icon(PhosphorIconsBold.arrowLeft, size: 18, color: gc.textSecondary),
              ),
            ),
          if (_wide) ...[const Spacer(), SizedBox(width: 240, child: next)] else Expanded(child: next),
        ],
      ),
    );
  }

  Widget _step(
    GymColors gc, {
    required int step,
    required String title,
    required String why,
    required Widget child,
    Widget Function(double height)? hero,
  }) {
    if (_wide) return _split(gc, step: step, title: title, why: why, child: child, hero: hero);
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hero != null) ...[
                () {
                  final h = (box.maxHeight * 0.3).clamp(120.0, 250.0);
                  return _in(0, SizedBox(height: h, child: Center(child: hero(h))));
                }(),
                const SizedBox(height: 22),
              ],
              _in(0, Padding(padding: const EdgeInsetsDirectional.only(start: 4), child: _label(gc, t.onbStep(step, _last)))),
              const SizedBox(height: 10),
              _in(
                1,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(title,
                      style: AppTheme.f(30, weight: FontWeight.w800, color: gc.text, height: 1.12)),
                ),
              ),
              const SizedBox(height: 10),
              _in(
                2,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(why,
                      style: AppTheme.f(13.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.45)),
                ),
              ),
              const SizedBox(height: 26),
              _in(3, child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _split(
    GymColors gc, {
    required int step,
    required String title,
    required String why,
    required Widget child,
    Widget Function(double height)? hero,
  }) {
    return LayoutBuilder(
      builder: (context, box) {
        final h = (box.maxHeight * 0.34).clamp(150.0, 210.0);
        final heroBox = hero == null ? null : SizedBox(height: h, child: Center(child: hero(h)));
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 28, 4),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(44, 0, 36, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _in(0, _label(gc, t.onbStep(step, _last))),
                      const SizedBox(height: 14),
                      _in(1, Text(title, style: AppTheme.f(40, weight: FontWeight.w800, color: gc.text, height: 1.08))),
                      const SizedBox(height: 16),
                      _in(2, Text(why, style: AppTheme.f(15.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.55))),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: gc.bgRaised.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(28),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: box.maxHeight - 40 - 56),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 440),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (heroBox != null) ...[_in(0, heroBox), const SizedBox(height: 26)],
                              _in(3, child),
                            ],
                          ),
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

  Widget _label(GymColors gc, String text) => Text(text.toUpperCase(),
      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4));

  Widget _group(GymColors gc, List<Widget> rows) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              Divider(height: 1, thickness: 1, indent: 16, endIndent: 16, color: gc.border.withValues(alpha: 0.6)),
            rows[i],
          ],
        ],
      ),
    );
  }

  Widget _rowIcon(GymColors gc, IconData icon, {Color? color}) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: SizedBox(width: 22, child: Icon(icon, size: 19, color: color ?? gc.textSecondary)),
      );

  Widget _welcome(GymColors gc) {
    if (_wide) {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(44, 12, 24, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _in(0, Image.asset('assets/img/runner.png', height: 170, opacity: const AlwaysStoppedAnimation(0.9))),
                  const SizedBox(height: 22),
                  _in(1, _label(gc, t.welcomeKicker)),
                  const SizedBox(height: 8),
                  _in(2, Text('GymMane', style: AppTheme.f(52, weight: FontWeight.w800, color: gc.text, height: 1))),
                  const SizedBox(height: 12),
                  _in(3, Text(kIsWeb ? t.webWelcomeBlurb : t.welcomeBlurb,
                      style: AppTheme.f(15, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsetsDirectional.fromSTEB(0, 8, 28, 4),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: gc.bgRaised.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: _in(
                    4,
                    _group(gc, [
                      _promise(gc, PhosphorIconsRegular.gift, t.freeForever, t.freeForeverWhy),
                      kIsWeb
                          ? _promise(gc, PhosphorIconsRegular.hardDrives, t.webOwnServer, t.webOwnServerWhy)
                          : _promise(gc, PhosphorIconsRegular.wifiSlash, t.fullyOffline, t.fullyOfflineWhy),
                      _promise(gc, PhosphorIconsRegular.export, t.yoursToTake, t.yoursToTakeWhy),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.maxHeight - 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _in(
                0,
                Center(
                  child: Image.asset('assets/img/runner.png',
                      height: 196, opacity: const AlwaysStoppedAnimation(0.9)),
                ),
              ),
              const SizedBox(height: 26),
              _in(
                1,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(t.welcomeKicker.toUpperCase(),
                      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                ),
              ),
              const SizedBox(height: 8),
              _in(
                2,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text('GymMane',
                      style: AppTheme.f(44, weight: FontWeight.w800, color: gc.text, height: 1)),
                ),
              ),
              const SizedBox(height: 12),
              _in(
                3,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(kIsWeb ? t.webWelcomeBlurb : t.welcomeBlurb,
                      style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.5)),
                ),
              ),
              const SizedBox(height: 22),
              _in(
                4,
                _group(gc, [
                  _promise(gc, PhosphorIconsRegular.gift, t.freeForever, t.freeForeverWhy),
                  kIsWeb
                      ? _promise(gc, PhosphorIconsRegular.hardDrives, t.webOwnServer, t.webOwnServerWhy)
                      : _promise(gc, PhosphorIconsRegular.wifiSlash, t.fullyOffline, t.fullyOfflineWhy),
                  _promise(gc, PhosphorIconsRegular.export, t.yoursToTake, t.yoursToTakeWhy),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promise(GymColors gc, IconData icon, String title, String why) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 1), child: _rowIcon(gc, icon)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                  const SizedBox(height: 3),
                  Text(why,
                      style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _nameStep(GymColors gc) {
    return _step(
      gc,
      step: 1,
      title: t.onbNameTitle,
      why: t.onbNameWhy,
      hero: (h) => ValueListenableBuilder<TextEditingValue>(
        valueListenable: _name,
        builder: (context, value, _) {
          final name = value.text.trim();
          final avatar = h * 0.46;
          return Column(mainAxisSize: MainAxisSize.min, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              width: avatar,
              height: avatar,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: name.isEmpty ? gc.bgRaised : gc.ember,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, a) => ScaleTransition(scale: a, child: FadeTransition(opacity: a, child: child)),
                child: name.isEmpty
                    ? Icon(PhosphorIconsRegular.user, key: const ValueKey(''), size: avatar * 0.42, color: gc.textTertiary)
                    : Text(name.characters.first.toUpperCase(),
                        key: ValueKey(name.characters.first.toUpperCase()),
                        style: AppTheme.f(avatar * 0.44, weight: FontWeight.w800, color: gc.onEmber)),
              ),
            ),
            SizedBox(height: h * 0.08),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: name.isEmpty ? 0.35 : 1,
              child: Text(t.onbHello(name.isEmpty ? '…' : name),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text)),
            ),
          ]);
        },
      ),
      child: _group(gc, [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              _rowIcon(gc, PhosphorIconsRegular.userCircle),
              Expanded(
                child: TextField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  style: AppTheme.f(17, weight: FontWeight.w700, color: gc.text),
                  cursorColor: gc.accent,
                  onSubmitted: (_) => _go(2),
                  decoration: InputDecoration(
                    hintText: t.onbNameHint,
                    hintStyle: AppTheme.f(17, weight: FontWeight.w600, color: gc.textTertiary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _photoStep(GymColors gc) {
    return _step(
      gc,
      step: 2,
      title: t.onbPhotoTitle,
      why: t.onbPhotoWhy,
      hero: (h) => _photo(gc, size: h * 0.72),
      child: const SizedBox.shrink(),
    );
  }

  Widget _bodyStep(GymColors gc) {
    final p = fit.profile;
    return _step(
      gc,
      step: 4,
      title: t.onbBodyTitle,
      why: t.onbBodyWhy,
      hero: (h) {
        const view = Rect.fromLTRB(-4, -2, 234, 466);
        final art = bodyArtFor(p.sex);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 360),
          switchInCurve: Curves.easeOutCubic,
          transitionBuilder: (child, a) => FadeTransition(
            opacity: a,
            child: ScaleTransition(scale: Tween(begin: 0.94, end: 1.0).animate(a), child: child),
          ),
          child: SizedBox(
            key: ValueKey(art.id),
            height: h,
            width: h * view.width / view.height,
            child: CustomPaint(
              painter: BodyPainter(
                gc: gc,
                art: art,
                crop: view,
                token: 'onb${art.id}',
                color: (_) => Color.lerp(gc.bgRaised2, gc.accent, 0.78)!,
              ),
            ),
          ),
        );
      },
      child: _group(gc, [
        _bodyRow(
          gc,
          PhosphorIconsRegular.genderIntersex,
          t.sexLabel,
          SegToggle([
            SegOption(t.male, p.sex == 'male', () => _up(() => fit.updateProfile(sex: 'male'))),
            SegOption(t.female, p.sex == 'female', () => _up(() => fit.updateProfile(sex: 'female'))),
          ]),
        ),
        _valueRow(gc, PhosphorIconsRegular.cake, t.ageLabel, '${p.age}', editAge),
        _valueRow(gc, PhosphorIconsRegular.ruler, t.heightLabel, fit.heightLabel(p.heightCm), editHeight),
        _valueRow(gc, PhosphorIconsRegular.scales, t.weightLabel, fit.weightLabel(p.weightKg), editBodyWeight),
      ]),
    );
  }

  Widget _bodyRow(GymColors gc, IconData icon, String label, Widget control) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 58),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _rowIcon(gc, icon),
              Expanded(
                child: Text(sentenceCase(label),
                    style: AppTheme.f(14.5, weight: FontWeight.w500, color: gc.text)),
              ),
              const SizedBox(width: 12),
              control,
            ],
          ),
        ),
      );

  Widget _valueRow(GymColors gc, IconData icon, String label, String value,
      Future<void> Function(BuildContext) edit) {
    return Semantics(
      button: true,
      label: sentenceCase(label),
      value: value,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => edit(context).then((_) => _up(() {})),
        child: _bodyRow(
          gc,
          icon,
          label,
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(value, style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.text)),
            const SizedBox(width: 8),
            Icon(PhosphorIconsBold.caretRight, size: 13, color: gc.textTertiary),
          ]),
        ),
      ),
    );
  }

  Widget _goalStep(GymColors gc) {
    final goal = fit.profile.weeklyGoal;
    return _step(
      gc,
      step: 5,
      title: t.onbGoalTitle,
      why: t.onbGoalWhy,
      hero: (h) => SizedBox(
        width: h,
        height: h,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: goal.toDouble()),
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          builder: (context, lit, _) => CustomPaint(
            painter: _WeekRing(lit: lit, on: gc.ember, off: gc.bgRaised2),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                MediaQuery.withNoTextScaling(
                  child: RollingText('$goal',
                      style: AppTheme.d(h * 0.3, weight: FontWeight.w800, color: gc.text, height: 1.4)),
                ),
                SizedBox(
                  width: h * 0.58,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(t.perWeek(goal).replaceFirst('$goal', '').trim().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var n = 1; n <= 7; n++)
                  Semantics(
                    button: true,
                    selected: n == goal,
                    label: t.perWeek(n),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _up(() => fit.updateProfile(weeklyGoalDelta: n - goal)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: n <= goal ? gc.ember : gc.bgRaised2,
                          shape: BoxShape.circle,
                        ),
                        child: Text('$n',
                            style: AppTheme.f(13.5,
                                weight: FontWeight.w800, color: n <= goal ? gc.onEmber : gc.textTertiary)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _unitsStep(GymColors gc) {
    return _step(
      gc,
      step: 3,
      title: t.onbUnitsTitle,
      why: t.onbUnitsWhy,
      hero: (h) {
        final kg = fit.units == 'kg';
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Ltr(child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              MediaQuery.withNoTextScaling(
                child: RollingText(kg ? '100' : '225',
                    style: AppTheme.d(h * 0.42, weight: FontWeight.w800, color: gc.text, height: 1.4)),
              ),
              const SizedBox(width: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 240),
                child: Text(fit.units,
                    key: ValueKey(fit.units),
                    style: AppTheme.f(h * 0.15, weight: FontWeight.w800, color: gc.ember)),
              ),
            ],
          )),
        ]);
      },
      child: Row(
        children: [
          for (final u in const ['kg', 'lb']) ...[
            if (u == 'lb') const SizedBox(width: 12),
            Expanded(child: _unitTile(gc, u)),
          ],
        ],
      ),
    );
  }

  Widget _unitTile(GymColors gc, String u) {
    final on = fit.units == u;
    final sample = u == 'kg' ? '60 kg · 175 cm · 5 km' : '135 lb · 5′9″ · 3 mi';
    return Semantics(
      button: true,
      selected: on,
      label: u,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _up(() => fit.setUnits(u)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          height: 118,
          padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: on ? gc.ember : Colors.transparent, width: 1.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: on ? 1 : 0,
                    child: Icon(PhosphorIconsFill.checkCircle, size: 18, color: gc.ember),
                  ),
                ],
              ),
              const Spacer(),
              Text(u, style: AppTheme.f(30, weight: FontWeight.w800, color: on ? gc.ember : gc.text, height: 1)),
              const SizedBox(height: 6),
              Text(sample, style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textTertiary)),
            ],
          ),
        ),
      ),
    );
  }

  static const _placeIcons = {
    'gym': PhosphorIconsRegular.barbell,
    'home': PhosphorIconsRegular.house,
    'outdoors': PhosphorIconsRegular.tree,
  };

  Widget _speedStep(GymColors gc) {
    return _step(
      gc,
      step: 7,
      title: t.onbSpeedTitle,
      why: t.onbSpeedWhy,
      child: SpeedPanel(footer: t.onbSpeedLater, rows: [
        (t.blurSetting, t.onbSpeedBlurHint, _blur, () => setState(() => _blur = !_blur)),
        (t.onbSpeedMotion, t.onbSpeedMotionHint, _motion, () => setState(() => _motion = !_motion)),
      ]),
    );
  }

  Widget _placeStep(GymColors gc) {
    return _step(
      gc,
      step: 6,
      title: t.onbPlaceTitle,
      why: t.onbPlaceWhy,
      hero: (h) {
        final gear = <String>{'Bodyweight', for (final g in _places.values) ...g};
        final n = _places.isEmpty
            ? fit.allExercises.length
            : fit.allExercises.where((e) => gear.contains(e.equipment)).length;
        return Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            for (final preset in kPlacePresets)
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: h * 0.22,
                height: h * 0.22,
                decoration: BoxDecoration(
                  color: _places.containsKey(preset) ? gc.ember : gc.bgRaised,
                  borderRadius: BorderRadius.circular(h * 0.07),
                ),
                child: Icon(_placeIcons[preset],
                    size: h * 0.1, color: _places.containsKey(preset) ? gc.onEmber : gc.textTertiary),
              ),
          ]),
          SizedBox(height: h * 0.06),
          MediaQuery.withNoTextScaling(
            child: RollingText('$n', style: AppTheme.d(h * 0.28, weight: FontWeight.w800, color: gc.text, height: 1.4)),
          ),
          Text(t.onbPlaceHero.toUpperCase(),
              style: AppTheme.f(10, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.2)),
        ]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _group(gc, [for (final preset in kPlacePresets) _placeRow(gc, preset)]),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _places.isEmpty
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final preset in kPlacePresets)
                          if (_places[preset] case final gear?) ...[
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 4),
                              child: _label(
                                  gc,
                                  _places.length > 1
                                      ? '${t.placePresetName(preset)} · ${t.onbPlaceGear}'
                                      : t.onbPlaceGear),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final e in kFilterEquipment)
                                  if (e != 'Bodyweight')
                                    Pill(
                                      label: t.equipment(e),
                                      bg: gear.contains(e) ? gc.ember : gc.bgRaised,
                                      fg: gear.contains(e) ? gc.onEmber : gc.textSecondary,
                                      onTap: () => setState(() {
                                        if (!gear.remove(e)) gear.add(e);
                                      }),
                                      hPad: 14,
                                      vPad: 8,
                                      fontSize: 12.5,
                                    ),
                              ],
                            ),
                            const SizedBox(height: 18),
                          ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _placeRow(GymColors gc, String preset) {
    final on = _places.containsKey(preset);
    final gear = {...?(_places[preset] ?? kPlacePresetGear[preset]), 'Bodyweight'};
    final n = fit.allExercises.where((e) => gear.contains(e.equipment)).length;
    return Semantics(
      button: true,
      selected: on,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() {
          if (_places.remove(preset) == null) {
            _places[preset] = {...?kPlacePresetGear[preset]}..remove('Bodyweight');
          }
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              _rowIcon(gc, _placeIcons[preset]!, color: on ? gc.ember : null),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.placePresetName(preset),
                        style: AppTheme.f(14.5,
                            weight: on ? FontWeight.w800 : FontWeight.w600, color: on ? gc.ember : gc.text)),
                    const SizedBox(height: 2),
                    Text(t.exerciseCount(n),
                        style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: on ? 1 : 0,
                child: Icon(PhosphorIconsFill.checkCircle, size: 18, color: gc.ember),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _up(VoidCallback action) {
    action();
    setState(() {});
  }
}

class _WeekRing extends CustomPainter {
  _WeekRing({required this.lit, required this.on, required this.off});

  final double lit;
  final Color on;
  final Color off;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.07;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    const gap = 0.16;
    const sweep = math.pi * 2 / 7;
    for (var i = 0; i < 7; i++) {
      final fill = (lit - i).clamp(0.0, 1.0);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = Color.lerp(off, on, fill)!;
      canvas.drawArc(rect, -math.pi / 2 + i * sweep + gap / 2, sweep - gap, false, paint);
    }
  }

  @override
  bool shouldRepaint(_WeekRing old) => old.lit != lit || old.on != on || old.off != off;
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
