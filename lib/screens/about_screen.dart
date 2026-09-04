import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../catalog/exercise_catalog.dart';
import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/svg_icon.dart';
import '../widgets/ui_kit.dart';

const _kVersion = '1.1.0';
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
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [
              RoundBtn(icon: Ic.chevronLeft, onTap: fit.backFromAbout),
              const SizedBox(width: 12),
              Text(t.about, style: AppTheme.d(18, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
            ]),
            const SizedBox(height: 20),
            _hero(gc),
            const SizedBox(height: 24),
            _principle(gc, PhosphorIconsRegular.gift, t.freeForever, t.freeForeverWhy),
            const SizedBox(height: 10),
            _principle(gc, PhosphorIconsRegular.wifiSlash, t.fullyOffline, t.fullyOfflineWhy),
            const SizedBox(height: 10),
            _principle(gc, PhosphorIconsRegular.export, t.yoursToTake, t.yoursToTakeWhy),
            const SizedBox(height: 24),
            Text(t.whatsInside,
                style: AppTheme.d(12, weight: FontWeight.w600, color: gc.textSecondary, letterSpacing: 3)),
            const SizedBox(height: 10),
            _principle(gc, PhosphorIconsRegular.barbell, t.exercisesInside(kExercises.length),
                t.exercisesInsideWhy),
            const SizedBox(height: 10),
            _principle(gc, PhosphorIconsRegular.calculator, t.calculatorsInside, t.calculatorsInsideWhy),
            const SizedBox(height: 10),
            _principle(gc, PhosphorIconsRegular.chartLineUp, t.mathInside, t.mathInsideWhy),
            const SizedBox(height: 24),
            Text(t.aboutBlurb,
                textAlign: TextAlign.center, style: AppTheme.s(12, color: gc.textTertiary, height: 1.6)),
            const SizedBox(height: 20),
            _credit(gc, PhosphorIconsFill.heart, t.madeWithLoveBy, _kAuthor, _kAuthorUrl),
            const SizedBox(height: 10),
            _credit(gc, PhosphorIconsRegular.githubLogo, t.sourceCode, 'InlitX/GymMane', _kRepoUrl),
            const SizedBox(height: 10),
            _credit(gc, PhosphorIconsRegular.coffee, t.buyCoffee, 'ko-fi.com/inlitx', _kKofiUrl),
          ],
        ),
      ),
    );
  }

  Widget _credit(GymColors gc, IconData icon, String label, String value, String url) {
    return Semantics(
      button: true,
      link: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _open(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            border: Border.all(color: gc.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: gc.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: AppTheme.d(10.5,
                            weight: FontWeight.w600, color: gc.textTertiary, letterSpacing: 2)),
                    const SizedBox(height: 4),
                    Text(value,
                        style: AppTheme.d(17, weight: FontWeight.w700, color: gc.text)),
                  ],
                ),
              ),
              Icon(PhosphorIconsRegular.arrowUpRight, size: 15, color: gc.textTertiary),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _open(String url) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Widget _hero(GymColors gc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: gc.bgRaised,
          border: Border.all(color: gc.border),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -50,
              bottom: -60,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(color: gc.accentSoft, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              right: -10,
              top: 8,
              bottom: 8,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/img/runner.png', fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('GYMMANE',
                      style: AppTheme.d(34, weight: FontWeight.w700, color: gc.text, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(t.version(_kVersion), style: AppTheme.s(12, color: gc.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _principle(GymColors gc, IconData icon, String title, String why) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        border: Border.all(color: gc.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 18, color: gc.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.s(14, weight: FontWeight.w600, color: gc.text)),
                const SizedBox(height: 3),
                Text(why, style: AppTheme.s(12, color: gc.textSecondary, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
