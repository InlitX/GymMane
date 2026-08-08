import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/body_svg.dart';
import 'package:path_drawing/path_drawing.dart';

void main() {
  test('body muscles are hit-testable across the figure', () {
    var hits = 0;
    final found = <String>{};
    for (double y = 0; y < bodyViewH; y += 5) {
      for (double x = 0; x < bodyViewW; x += 5) {
        final p = Offset(x, y);
        for (final e in muscleFills.entries) {
          final probes =
              (muscleHits[e.key]?.isNotEmpty ?? false) ? muscleHits[e.key]! : e.value;
          var hit = false;
          for (final d in probes) {
            if (parseSvgPathData(d).contains(p)) {
              hit = true;
              break;
            }
          }
          if (hit) {
            hits++;
            found.add(e.key);
            break;
          }
        }
      }
    }

    // ignore: avoid_print
    print('GRID HITS=$hits  muscles found=${found.length}/13: ${found.toList()..sort()}');
    expect(found.length, greaterThan(6), reason: 'too few muscles are tappable');
  });
}
