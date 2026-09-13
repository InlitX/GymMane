import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_kit.dart';

const _kVersion = '1.2.0';
const _kAuthor = 'InlitX';
const _kAuthorUrl = 'https://github.com/InlitX';
const _kRepoUrl = 'https://github.com/InlitX/GymMane';
const _kKofiUrl = 'https://ko-fi.com/inlitx';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: t.about,
              onBack: fit.backFromAbout,
              titleSize: 18,
              titleSpacing: 1,
            ),
            const SizedBox(height: 18),
            _hero(gc),
            const SizedBox(height: 20),
            _group(gc, [
              (PhosphorIconsRegular.gift, t.freeForever, t.freeForeverWhy),
              (PhosphorIconsRegular.wifiSlash, t.fullyOffline, t.fullyOfflineWhy),
              (PhosphorIconsRegular.export, t.yoursToTake, t.yoursToTakeWhy),
            ]),
            const SizedBox(height: 18),
            _sectionLabel(gc, t.whatsInside),
            const SizedBox(height: 8),
            _group(gc, [
              (PhosphorIconsRegular.barbell, t.exercisesInside(kExercises.length),
                  t.exercisesInsideWhy),
              (PhosphorIconsRegular.calculator, t.calculatorsInside, t.calculatorsInsideWhy),
              (PhosphorIconsRegular.chartLineUp, t.mathInside, t.mathInsideWhy),
            ]),
            const SizedBox(height: 22),
            Text(t.aboutBlurb,
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.6)),
            const SizedBox(height: 20),
            _credits(gc),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(GymColors gc, String label) => Text(label.toUpperCase(),
      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3));

  Widget _hero(GymColors gc) {
    return Container(
      height: 178,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -46,
            bottom: -56,
            child: Container(
              width: 162,
              height: 162,
              decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: 128,
            top: -42,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: gc.emberSoft, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: 6,
            top: 14,
            bottom: 14,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset('assets/img/runner.png', fit: BoxFit.fitHeight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('GymMane',
                    style: AppTheme.f(33, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.5)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                  decoration: BoxDecoration(
                    color: gc.bgRaised2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(t.version(_kVersion),
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _group(GymColors gc, List<(IconData, String, String)> rows) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                border: i < rows.length - 1
                    ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6)))
                    : null,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1, right: 14),
                    child: SizedBox(
                      width: 22,
                      child: Icon(rows[i].$1, size: 19, color: gc.textSecondary),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rows[i].$2, style: AppTheme.f(14.5, weight: FontWeight.w600, color: gc.text)),
                        const SizedBox(height: 3),
                        Text(rows[i].$3,
                            style: AppTheme.f(12.5,
                                weight: FontWeight.w500, color: gc.textSecondary, height: 1.4)),
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

  Widget _credits(GymColors gc) {
    final rows = <(IconData, String, String, String, Color?)>[
      (PhosphorIconsFill.heart, t.madeWithLoveBy, _kAuthor, _kAuthorUrl, gc.accent),
      (PhosphorIconsRegular.githubLogo, t.sourceCode, 'InlitX/GymMane', _kRepoUrl, null),
      (PhosphorIconsRegular.coffee, t.buyCoffee, 'ko-fi.com/inlitx', _kKofiUrl, null),
    ];
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++)
            Semantics(
              button: true,
              link: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _open(rows[i].$4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: i < rows.length - 1
                        ? Border(bottom: BorderSide(color: gc.border.withValues(alpha: 0.6)))
                        : null,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: SizedBox(
                          width: 22,
                          child: Icon(rows[i].$1, size: 19, color: rows[i].$5 ?? gc.textSecondary),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rows[i].$2.toUpperCase(),
                                style: AppTheme.f(10,
                                    weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.3)),
                            const SizedBox(height: 4),
                            Text(rows[i].$3,
                                style: AppTheme.f(15.5, weight: FontWeight.w700, color: gc.text)),
                          ],
                        ),
                      ),
                      Icon(PhosphorIconsRegular.arrowUpRight, size: 15, color: gc.textTertiary),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _open(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}
