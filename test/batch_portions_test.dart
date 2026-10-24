import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/models/nutrition.dart';

void main() {
  Map<String, dynamic> raw([Object? p]) => {
        'id': 'b1',
        'n': 'Chicken rice',
        'i': [
          {'n': 'Rice', 'g': 2000, 'k': 0},
        ],
        'at': '2026-10-24T12:00:00.000',
        'cg': 2000,
        'left': 2000,
        'p': ?p,
      };

  test('old batches split in 4 by default', () {
    final b = Batch.fromJson(raw())!;
    expect(b.portions, 4);
    expect(b.toJson().containsKey('p'), isFalse);
  });

  test('portions survive a round trip and stay in range', () {
    final b = Batch.fromJson(raw())!.copyWith(portions: 6);
    expect(Batch.fromJson(b.toJson())!.portions, 6);
    expect(Batch.fromJson(raw(40))!.portions, 12);
    expect(Batch.fromJson(raw(0))!.portions, 2);
  });
}
