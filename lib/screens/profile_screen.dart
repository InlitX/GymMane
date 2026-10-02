import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/profile.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/medal_shelf.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/ui_kit.dart';
import 'settings_screen.dart';
import 'share_sheet.dart';

const List<String> kProfileBadges = ['gold', 'blue', 'green'];

Color badgeColor(String id) => switch (id) {
      'blue' => const Color(0xFF4A9EEB),
      'green' => const Color(0xFF54B979),
      _ => const Color(0xFFE8B84B),
    };

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _busy = false;

  Future<void> _pickBanner() async {
    if (_busy) return;
    final source = await pickPhotoSource(context);
    if (source == null) return;
    setState(() => _busy = true);
    try {
      final shot = await ImagePicker()
          .pickImage(source: source, maxWidth: 1600, maxHeight: 900, imageQuality: 82);
      if (shot == null) return;
      fit.setProfileBanner(await File(shot.path).readAsBytes());
    } catch (_) {
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _snapshot() async {
    if (_busy) return;
    final source = await pickPhotoSource(context);
    if (source == null) return;
    setState(() => _busy = true);
    try {
      if (source == ImageSource.gallery) {
        final shots = await ImagePicker()
            .pickMultiImage(maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
        for (final shot in shots) {
          await fit.addMoment(shot.path);
        }
        return;
      }
      final shot = await ImagePicker()
          .pickImage(source: source, maxWidth: 1440, maxHeight: 1920, imageQuality: 88);
      if (shot == null) return;
      await fit.addMoment(shot.path);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return RiseScope(
      id: 'profile',
      child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _ProfileHeader(
            gc: gc,
            top: MediaQuery.paddingOf(context).top,
            onBanner: _pickBanner,
            onEdit: () => showProfileSheet(context),
            onShare: () => showShareSheet(context),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
            child: Rise(index: 0, child: _stats(gc)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (fit.gamification) ...[
                  Rise(
                    index: 1,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      _heading(gc, t.awardsTitle, count: '${fit.awardCount}', onMore: fit.goAwards),
                      const SizedBox(height: 16),
                      const MedalShelf(size: 66),
                    ]),
                  ),
                  const SizedBox(height: 30),
                ],
                Rise(
                  index: 2,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    _heading(gc, t.snapshots,
                        count: fit.momentCount > 0 ? '${fit.momentCount}' : null,
                        onMore: fit.goMoments,
                        onAdd: fit.momentCount > 0 ? _snapshot : null),
                    const SizedBox(height: 16),
                    _photoCards(gc),
                  ]),
                ),
                const SizedBox(height: 30),
                Rise(
                  index: 3,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    _heading(gc, t.yearTitle),
                    const SizedBox(height: 16),
                    _year(gc),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _year(GymColors gc) {
    final months = fit.sessionsByMonth;
    final peak = months.fold(1, math.max);
    final thisMonth = DateTime.now().month;
    final best = fit.bestMonthThisYear;
    final lifted = fit.liftedSpanOf(fit.volumeThisYearKg);

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _yearStat(gc, '${fit.sessionsThisYear}', '', t.statWorkouts)),
              Expanded(child: _yearStat(gc, lifted.$1, lifted.$2, t.statLifted)),
              Expanded(
                child: _yearStat(gc, '${fit.monthsTrainedThisYear}', '/12', t.yearMonths),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 58,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var m = 1; m <= 12; m++) ...[
                  if (m > 1) const SizedBox(width: 5),
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: months[m - 1] / peak),
                      duration: Duration(milliseconds: 650 + m * 35),
                      curve: Curves.easeOutCubic,
                      builder: (context, v, _) => Container(
                        height: 6 + 52 * v,
                        decoration: BoxDecoration(
                          color: m == thisMonth
                              ? gc.ember
                              : (months[m - 1] > 0 ? gc.textTertiary : gc.bgRaised2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              for (var m = 1; m <= 12; m++) ...[
                if (m > 1) const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    t.monthInitial(m),
                    textAlign: TextAlign.center,
                    style: AppTheme.f(9.5,
                        weight: FontWeight.w600,
                        color: m == thisMonth ? gc.text : gc.textTertiary),
                  ),
                ),
              ],
            ],
          ),
          if (best > 0) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Text('${t.yearBestMonth} · ',
                    style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary)),
                Text(t.monthName(best),
                    style: AppTheme.f(12, weight: FontWeight.w700, color: gc.textSecondary)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _yearStat(GymColors gc, String value, String unit, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            RollIn(value, style: AppTheme.f(26, weight: FontWeight.w800, color: gc.text)),
            if (unit.isNotEmpty)
              Text(unit,
                  style: AppTheme.f(12.5, weight: FontWeight.w600, color: gc.textSecondary)),
          ],
        ),
        const SizedBox(height: 5),
        Text(label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.f(9.5,
                weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
      ],
    );
  }

  Widget _heading(GymColors gc, String title, {String? count, VoidCallback? onMore, VoidCallback? onAdd}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onMore,
      child: Row(
        children: [
          Text(title, style: AppTheme.f(21, color: gc.text)),
          if (count != null) ...[
            const SizedBox(width: 9),
            Text(count, style: AppTheme.f(17, weight: FontWeight.w600, color: gc.textTertiary)),
          ],
          const Spacer(),
          if (onAdd != null) ...[
            Semantics(
              button: true,
              label: t.snapNow,
              child: Pressable(
                onTap: onAdd,
                scale: 0.88,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
                  child: Icon(PhosphorIconsBold.plus, size: 15, color: gc.accent),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          if (onMore != null) Icon(PhosphorIconsBold.caretRight, size: 16, color: gc.textTertiary),
        ],
      ),
    );
  }

  Widget _stats(GymColors gc) {
    final items = <(String, String, String)>[
      (t.statWorkouts, '${fit.totalSessions}', ''),
      (t.statTrained, fit.trainedSpan.$1, fit.trainedSpan.$2),
      (t.statSets, '${fit.totalSets}', ''),
      (t.statLifted, fit.liftedSpan.$1, fit.liftedSpan.$2),
      (t.statStreak, '${fit.currentStreak}', t.statDays),
    ];
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 20),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 28),
        itemBuilder: (_, i) {
          final (label, value, unit) = items[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label.toUpperCase(),
                  style: AppTheme.f(10.5,
                      weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 0.9)),
              const SizedBox(height: 7),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  RollIn(value, style: AppTheme.f(23, weight: FontWeight.w800, color: gc.text)),
                  if (unit.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Text(unit,
                        style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary)),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  static const _turns = [-0.07, 0.05, -0.035, 0.065, -0.05];

  Widget _photoCards(GymColors gc) {
    final shots = fit.momentsNewest.take(4).map((m) => m.file).toList();
    const w = 104.0, h = 136.0;
    return Semantics(
      button: true,
      label: shots.isEmpty ? t.snapNow : t.photosCard,
      child: Pressable(
        onTap: shots.isEmpty ? _snapshot : fit.goMoments,
        scale: 0.97,
        child: SizedBox(
          height: h + 20,
          child: LayoutBuilder(builder: (context, box) {
            const n = 4;
            final step = math.min(w * 0.78, (box.maxWidth - w) / (n - 1));
            return Stack(
              clipBehavior: Clip.none,
              children: [
                for (var i = 0; i < n; i++)
                  Positioned(
                    left: i * step,
                    top: i.isOdd ? 14 : 6,
                    width: w,
                    height: h,
                    child: Transform.rotate(
                      angle: _turns[i % _turns.length],
                      child: i < shots.length ? _shot(gc, shots[i]) : _ghost(gc),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _frame(GymColors gc, Widget child) {
    final dark = gc.bg.computeLuminance() < 0.5;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: dark ? Color.lerp(gc.bgRaised2, Colors.white, 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.5 : 0.16), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(13), child: child),
    );
  }

  Widget _shot(GymColors gc, String file) => _frame(
        gc,
        Image.file(File(MediaStore.pathFor(file) ?? ''),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
      );

  Widget _ghost(GymColors gc) => Opacity(
        opacity: 0.55,
        child: _frame(
          gc,
          ColoredBox(
            color: gc.bgRaised2,
            child: Center(child: Icon(PhosphorIconsRegular.image, size: 22, color: gc.textTertiary)),
          ),
        ),
      );
}

class _ProfileHeader extends SliverPersistentHeaderDelegate {
  _ProfileHeader({
    required this.gc,
    required this.top,
    required this.onBanner,
    required this.onEdit,
    required this.onShare,
  });

  final GymColors gc;
  final double top;
  final VoidCallback onBanner;
  final VoidCallback onEdit;
  final VoidCallback onShare;

  static const _banner = 176.0;
  static const _bar = 60.0;
  static const _levelRow = 34.0;

  double get _cut => fit.gamification ? 0 : _levelRow;
  double get _identity => 128.0 - _cut;
  double get _identityBlock => 136.0 - _cut;

  @override
  double get maxExtent => _banner + _identity;

  @override
  double get minExtent => top + _bar;

  @override
  bool shouldRebuild(_ProfileHeader old) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final range = maxExtent - minExtent;
    final shrunk = range <= 0 ? 1.0 : (shrinkOffset / range).clamp(0.0, 1.0);
    final bytes = fit.profileBanner;
    final p = fit.profile;

    final height = math.max(maxExtent - shrinkOffset, minExtent);
    final bannerHeight = (height - 18 - _identityBlock + 38).clamp(minExtent, height);

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: bannerHeight,
            child: GestureDetector(
              onTap: onBanner,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: gc.bgRaised,
                      image: DecorationImage(
                        image: bytes == null ? kDefaultBanner : MemoryImage(bytes),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            gc.bg.withValues(alpha: 0.18 + 0.6 * shrunk),
                            gc.bg.withValues(alpha: 0.10 + 0.6 * shrunk),
                            gc.bg.withValues(alpha: 0.55),
                            gc.bg,
                          ],
                          stops: const [0, 0.38, 0.78, 1],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: top + 9,
            right: 16,
            child: Row(children: [
              _round(PhosphorIconsRegular.shareNetwork, onShare),
              const SizedBox(width: 10),
              _round(PhosphorIconsRegular.gearSix, fit.goPreferences),
            ]),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: Opacity(
              opacity: (1 - shrunk * 2).clamp(0.0, 1.0),
              child: _full(p),
            ),
          ),
          Positioned(
            left: 20,
            top: top + 6,
            height: 44,
            child: Opacity(
              opacity: ((shrunk - 0.62) / 0.38).clamp(0.0, 1.0),
              child: _compact(p),
            ),
          ),
        ],
      ),
    );
  }

  Widget _round(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration:
            BoxDecoration(color: Colors.black.withValues(alpha: 0.5), shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _compact(Profile p) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileAvatar(size: 34),
        const SizedBox(width: 11),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(fit.displayName, style: AppTheme.f(15.5, color: gc.text)),
              if (p.badge.isNotEmpty) ...[
                const SizedBox(width: 5),
                Icon(PhosphorIconsFill.sealCheck, size: 14, color: badgeColor(p.badge)),
              ],
            ]),
            Text('@${fit.profileHandle}',
                style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _full(Profile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProfileAvatar(size: 76),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: gc.bgRaised2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(t.editProfile,
                    style: AppTheme.f(13.5, weight: FontWeight.w600, color: gc.text)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Row(children: [
          Flexible(
            child: Text(p.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.f(24, weight: FontWeight.w800, color: gc.text)),
          ),
          if (p.badge.isNotEmpty) ...[
            const SizedBox(width: 7),
            Icon(PhosphorIconsFill.sealCheck, size: 19, color: badgeColor(p.badge)),
          ],
        ]),
        const SizedBox(height: 4),
        Text(
          '@${fit.profileHandle}  ·  ${fit.weightLabel(p.weightKg)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary),
        ),
        if (fit.gamification) ...[
        const SizedBox(height: 8),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: gc.bgRaised2,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(t.levelShort(fit.athleteLevel),
                style: AppTheme.f(12, weight: FontWeight.w700, color: gc.text)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              t.levelToNext(fit.sessionsToNextLevel, fit.athleteLevel + 1),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textTertiary),
            ),
          ),
        ]),
        ],
      ],
    );
  }
}
