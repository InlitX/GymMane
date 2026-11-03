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
import '../widgets/file_thumb.dart';
import '../widgets/glass.dart';
import '../widgets/medal_shelf.dart';
import '../widgets/photo_source_sheet.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/ui_kit.dart';
import 'gym_pass_screen.dart';
import 'settings_screen.dart';

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
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),
              Rise(index: 0, child: _pills(gc)),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (fit.gamification) ...[
                      Rise(
                        index: 1,
                        child: _box(gc,
                            title: t.awardsTitle,
                            count: '${fit.awardCount}',
                            onMore: fit.goAwards,
                            child: const SizedBox(height: 82, child: MedalShelf(size: 54))),
                      ),
                      const SizedBox(height: 30),
                    ],
                    Rise(
                      index: 2,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        _heading(gc, t.snapshots,
                            count: fit.momentCount > 0 ? '${fit.momentCount}' : null,
                            onMore: fit.momentCount > 0 ? fit.goMoments : null),
                        const SizedBox(height: 16),
                        _photoCards(gc),
                      ]),
                    ),
                    const SizedBox(height: 30),
                    if (fit.passOn) ...[
                      Rise(
                        index: 3,
                        child: _box(gc,
                            title: t.gymPass,
                            count: fit.gymPasses.length > 1 ? '${fit.gymPasses.length}' : null,
                            onMore: fit.goGymPasses,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: fit.lastPass == null
                                  ? GymPassEmpty(onTap: () => addGymPass(context))
                                  : GymPassCarousel(key: ValueKey(fit.gymPasses.length)),
                            )),
                      ),
                      const SizedBox(height: 30),
                    ],
                    Rise(
                      index: 4,
                      child: _box(gc,
                          title: t.historyTitle,
                          count: fit.sessions.isEmpty ? null : '${fit.sessions.length}',
                          onMore: fit.sessions.isEmpty ? null : fit.goHistory,
                          child: _year(gc)),
                    ),
                  ],
                ),
              ),
            ],
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

    return SizedBox(
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
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: months[m - 1] > 0 ? () => fit.goHistory(month: DateTime(DateTime.now().year, m)) : null,
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

  Widget _heading(GymColors gc, String title, {String? count, VoidCallback? onMore}) {
    final label = AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onMore,
      child: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Row(
          children: [
            Text(title.toUpperCase(), style: label),
            if (count != null) ...[
              const SizedBox(width: 8),
              Text(count, style: label.copyWith(color: gc.textSecondary)),
            ],
            const Spacer(),
            if (onMore != null) _seeAll(gc, onMore),
          ],
        ),
      ),
    );
  }

  Widget _seeAll(GymColors gc, VoidCallback onTap) => Pressable(
        onTap: onTap,
        scale: 0.94,
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(14)),
          child: Text(t.healthSeeAll, style: AppTheme.f(12, weight: FontWeight.w700, color: gc.text)),
        ),
      );

  Widget _box(GymColors gc, {required String title, String? count, VoidCallback? onMore, required Widget child}) {
    final dark = gc.bg.computeLuminance() < 0.5;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: gc.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: dark
                    ? [Color.lerp(gc.bg, Colors.black, 0.5)!, Color.lerp(gc.bg, gc.bgRaised, 0.4)!]
                    : [gc.bgRaised2, gc.bg],
              ),
            ),
            child: child,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 4, 4),
            child: Row(
              children: [
                Text(title, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.text)),
                if (count != null) ...[
                  const SizedBox(width: 7),
                  Text(count, style: AppTheme.f(14, weight: FontWeight.w700, color: gc.textTertiary)),
                ],
                const Spacer(),
                if (onMore != null) _seeAll(gc, onMore),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pills(GymColors gc) {
    final cells = [
      (PhosphorIconsRegular.barbell, '${fit.totalSessions}', t.statWorkouts),
      (PhosphorIconsRegular.timer, '${fit.trainedSpan.$1} ${fit.trainedSpan.$2}', ''),
      (PhosphorIconsRegular.trendUp, '${fit.liftedSpan.$1} ${fit.liftedSpan.$2}', ''),
      if (fit.gamification) (PhosphorIconsRegular.medal, t.levelShort(fit.athleteLevel), ''),
      (PhosphorIconsRegular.scales, fit.weightLabel(fit.profile.weightKg), ''),
    ];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: cells.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (icon, value, label) = cells[i];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(18)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 15, color: gc.text),
              const SizedBox(width: 7),
              Text(value,
                  style: AppTheme.f(13.5, weight: FontWeight.w800, color: gc.text)
                      .copyWith(fontFeatures: const [FontFeature.tabularFigures()])),
              if (label.isNotEmpty) ...[
                const SizedBox(width: 5),
                Text(label, style: AppTheme.f(13, weight: FontWeight.w500, color: gc.textSecondary)),
              ],
            ]),
          );
        },
      ),
    );
  }

  static const _turns = [-0.06, 0.045, -0.03, 0.055];

  Widget _photoCards(GymColors gc) {
    final shots = fit.momentsNewest.take(4).map((m) => m.file).toList();
    const w = 104.0, h = 136.0;
    return Semantics(
      button: true,
      label: shots.isEmpty ? t.addPhoto : t.photosCard,
      child: Pressable(
        onTap: shots.isEmpty ? _snapshot : fit.goMoments,
        scale: 0.97,
        child: SizedBox(
          height: h + 20,
          child: LayoutBuilder(builder: (context, box) {
            const n = 4;
            final step = math.min(w * 0.8, (box.maxWidth - w) / (n - 1));
            return Stack(
              clipBehavior: Clip.none,
              children: [
                for (var i = 0; i < n; i++)
                  Positioned(
                    left: i * step,
                    top: i.isOdd ? 12 : 6,
                    width: w,
                    height: h,
                    child: Transform.rotate(
                      angle: _turns[i],
                      child: i < shots.length ? _shot(gc, shots[i]) : _ghost(gc),
                    ),
                  ),
                if (shots.isEmpty)
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: gc.text,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 18)],
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(PhosphorIconsRegular.camera, size: 16, color: gc.bg),
                          const SizedBox(width: 7),
                          Text(t.addPhoto, style: AppTheme.f(13, weight: FontWeight.w800, color: gc.bg)),
                        ]),
                      ),
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
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: dark ? gc.bgRaised2 : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.4 : 0.12), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: child),
    );
  }

  Widget _shot(GymColors gc, String file) => _frame(
        gc,
        FileThumb(MediaStore.pathFor(file) ?? '',
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => ColoredBox(color: gc.bgRaised2)),
      );

  Widget _ghost(GymColors gc) => Opacity(
        opacity: 0.5,
        child: _frame(gc, ColoredBox(color: gc.bgRaised)),
      );
}

class _ProfileHeader extends SliverPersistentHeaderDelegate {
  _ProfileHeader({
    required this.gc,
    required this.top,
    required this.onBanner,
    required this.onEdit,
  });

  final GymColors gc;
  final double top;
  final VoidCallback onBanner;
  final VoidCallback onEdit;

  static const _bar = 60.0;
  static const _avatar = 86.0;

  double get _banner => top + 172;

  @override
  double get maxExtent => _banner + 82;

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
    final bannerBottom = math.max(minExtent, _banner - shrinkOffset);
    final fade = (1 - shrunk * 2).clamp(0.0, 1.0);
    final avatarTop = bannerBottom - _avatar + 18;
    final gone = ((shrunk - 0.35) / 0.45).clamp(0.0, 1.0);
    final bar = ((shrunk - 0.7) / 0.3).clamp(0.0, 1.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: bannerBottom,
          child: Opacity(
            opacity: 1 - gone,
            child: GestureDetector(
              onTap: onBanner,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
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
                            Colors.black.withValues(alpha: 0.35),
                            Colors.black.withValues(alpha: 0),
                            gc.bg.withValues(alpha: 0.35 + 0.65 * shrunk),
                            gc.bg,
                          ],
                          stops: const [0, 0.3, 0.72, 1],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (bar > 0)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: IgnorePointer(
              child: Opacity(opacity: bar, child: EdgeBlur(height: top + 64, sigma: 14)),
            ),
          ),
        Positioned(
          top: top + 9,
          right: 16,
          child: _round(PhosphorIconsRegular.gearSix, fit.goPreferences),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: bannerBottom - 2,
          child: IgnorePointer(
            child: Opacity(
              opacity: fade,
              child: Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: gc.text.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: avatarTop,
          child: Opacity(opacity: fade, child: const ProfileAvatar(size: _avatar)),
        ),
        Positioned(
          right: 20,
          top: avatarTop + _avatar - 36,
          child: Opacity(
            opacity: fade,
            child: IgnorePointer(ignoring: fade < 0.5, child: _editPill()),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: avatarTop + _avatar + 14,
          child: Opacity(opacity: fade, child: _full(p)),
        ),
        Positioned(
          left: 72,
          right: 72,
          top: top + 9,
          height: 38,
          child: IgnorePointer(
            child: Opacity(
              opacity: bar,
              child: Transform.translate(offset: Offset(0, 8 * (1 - bar)), child: Center(child: _compact(p))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _round(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.38), shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  Widget _editPill() {
    return Pressable(
      onTap: onEdit,
      scale: 0.94,
      child: Container(
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: gc.text.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: gc.text.withValues(alpha: 0.12)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(PhosphorIconsRegular.pencilSimple, size: 11.5, color: gc.textSecondary),
          const SizedBox(width: 5),
          Text(t.editProfile, style: AppTheme.f(11.5, weight: FontWeight.w700, color: gc.textSecondary)),
        ]),
      ),
    );
  }

  Widget _compact(Profile p) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileAvatar(size: 24),
        const SizedBox(width: 8),
        Flexible(
          child: Text(fit.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.f(15.5, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.2)),
        ),
        if (p.badge.isNotEmpty) ...[
          const SizedBox(width: 5),
          Icon(PhosphorIconsFill.sealCheck, size: 14, color: badgeColor(p.badge)),
        ],
      ],
    );
  }

  Widget _full(Profile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(24, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.3)),
            ),
            if (p.badge.isNotEmpty) ...[
              const SizedBox(width: 7),
              Icon(PhosphorIconsFill.sealCheck, size: 19, color: badgeColor(p.badge)),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '@${fit.profileHandle}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.f(14, weight: FontWeight.w500, color: gc.textSecondary),
        ),
      ],
    );
  }
}
