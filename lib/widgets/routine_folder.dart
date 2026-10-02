import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/workout.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'ui_kit.dart';

const kFolderHues = [
  Color(0xFFF3C7B1),
  Color(0xFFA78BDA),
  Color(0xFFA8C99E),
  Color(0xFF9CC2E8),
  Color(0xFFE8CF98),
  Color(0xFFE6A4B9),
];

Color folderHue(Routine r) =>
    kFolderHues[(r.color >= 0 ? r.color : r.id.codeUnits.fold<int>(0, (a, c) => a + c)) % kFolderHues.length];

class RoutineFolder extends StatelessWidget {
  const RoutineFolder({super.key, required this.routine, required this.onMenu});

  final Routine routine;
  final VoidCallback onMenu;

  static const _tab = 16.0;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final r = routine;
    final n = r.exerciseIds.length;
    final hue = folderHue(r);
    final dark = gc.bg.computeLuminance() < 0.5;
    final back = Color.lerp(hue, Colors.black, dark ? 0.42 : 0.18)!;
    final front = Color.lerp(gc.bgRaised2, hue, dark ? 0.14 : 0.3)!;
    final ink = Color.lerp(hue, Colors.black, 0.35)!;

    return Pressable(
      onTap: () => fit.openRoutine(r.id),
      scale: 0.975,
      child: SizedBox(
        height: 196,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              width: 74,
              height: _tab + 24,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: gc.bgRaised,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                ),
              ),
            ),
            Positioned.fill(
              top: _tab,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: gc.bgRaised,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              top: _tab + 8,
              height: 64,
              child: Transform.rotate(
                angle: -0.018,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: back, borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              top: _tab + 16,
              height: 64,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 40, 0),
                decoration: BoxDecoration(color: hue, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(ink.withValues(alpha: 0.45), 1),
                    const SizedBox(height: 5),
                    _line(ink.withValues(alpha: 0.2), 0.55),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 6,
              right: 6,
              top: _tab + 50,
              bottom: 46,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 8, 10),
                decoration: BoxDecoration(
                  color: front,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: dark ? 0.35 : 0.1),
                      blurRadius: 14,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(text: fit.routineTitle(r)),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(PhosphorIconsBold.caretRight, size: 13, color: gc.textSecondary),
                                ),
                              ),
                            ]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.f(16, weight: FontWeight.w800, color: gc.text, height: 1.15),
                          ),
                        ),
                        Semantics(
                          button: true,
                          label: t.moreOptions,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: onMenu,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.1), shape: BoxShape.circle),
                              child: Icon(PhosphorIconsBold.dotsThreeVertical, size: 16, color: gc.text),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      [if (r.group.isNotEmpty) r.group, t.exerciseCount(n)].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 46,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: n > 0 ? () => fit.startRoutine(r) : () => fit.openRoutine(r.id),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(n > 0 ? PhosphorIconsFill.play : PhosphorIconsBold.plus, size: 12, color: gc.textSecondary),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(n > 0 ? titleCase(t.startWorkout) : t.addExercises,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.f(13.5, weight: FontWeight.w700, color: gc.textSecondary)),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(Color c, double width) => FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: width,
        child: Container(height: 2.5, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
      );
}
