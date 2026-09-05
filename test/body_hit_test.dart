import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/body_svg.dart';
import 'package:path_drawing/path_drawing.dart';

void main() {
  test('body muscles are hit-testable across the figure', () {
    final areas = {
      for (final e in muscleFills.entries)
        e.key: [
          for (final d in muscleHits[e.key]?.isNotEmpty ?? false ? muscleHits[e.key]! : e.value)
            parseSvgPathData(d),
        ],
    };

    final found = <String>{};
    for (double y = 0; y < bodyViewH; y += 5) {
      for (double x = 0; x < bodyViewW; x += 5) {
        final p = Offset(x, y);
        for (final e in areas.entries) {
          if (e.value.any((path) => path.contains(p))) {
            found.add(e.key);
            break;
          }
        }
      }
    }

    expect(found.length, greaterThan(6), reason: 'too few muscles are tappable');
  });
}
