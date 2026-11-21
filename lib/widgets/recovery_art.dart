import 'package:flutter/material.dart';

String _asset(String name) => 'assets/img/recovery-$name.webp';

Widget _image(String name, double height) =>
    Image.asset(_asset(name), height: height, fit: BoxFit.contain, cacheHeight: (height * 3).round());

class RecoveryArt extends StatelessWidget {
  const RecoveryArt(this.kind, {super.key, this.size = 58});

  final String kind;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: _image(switch (kind) {
        'sauna' => 'sauna',
        'cold' => 'cold',
        'contrast' => 'contrast',
        _ => 'lungs',
      }, size),
    );
  }
}

class RecoveryPeek extends StatelessWidget {
  const RecoveryPeek({super.key});

  static const _items = [
    ('towel', -124.0, 50.0, -0.06, 1.31, 8.0),
    ('sauna', -66.0, 68.0, -0.05, 0.89, 6.0),
    ('heat', 4.0, 64.0, 0.06, 0.85, 10.0),
    ('cold', 72.0, 64.0, -0.06, 0.86, 6.0),
    ('lungs', 140.0, 60.0, 0.1, 0.92, 2.0),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Stack(
        clipBehavior: Clip.none,
        children: [
          for (final (name, dx, h, turn, aspect, lift) in _items)
            Positioned(
              left: box.maxWidth / 2 + dx - h * aspect / 2,
              width: h * aspect,
              top: 38 - h * 0.55 - lift,
              height: h,
              child: Transform.rotate(
                angle: turn,
                child: Image.asset(_asset(name), fit: BoxFit.contain, cacheHeight: (h * 3).round()),
              ),
            ),
        ],
      ),
    );
  }
}
