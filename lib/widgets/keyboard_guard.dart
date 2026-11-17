import 'dart:async';

import 'package:flutter/widgets.dart';

bool get keyboardInUse {
  final at = FocusManager.instance.primaryFocus?.context;
  if (at == null) return false;
  return at.widget is EditableText || at.findAncestorWidgetOfExactType<EditableText>() != null;
}

class KeyboardGuard extends StatefulWidget {
  const KeyboardGuard({super.key, required this.child});

  final Widget child;

  static const patience = Duration(milliseconds: 700);

  @override
  State<KeyboardGuard> createState() => _KeyboardGuardState();
}

class _KeyboardGuardState extends State<KeyboardGuard> {
  Timer? _wait;
  bool _stale = false;
  double _inset = 0;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addListener(_check);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_check);
    _wait?.cancel();
    super.dispose();
  }

  void _check() {
    if (_judge() && mounted) setState(() {});
  }

  bool _judge() {
    final orphan = _inset > 0 && !keyboardInUse;
    if (!orphan) {
      _wait?.cancel();
      _wait = null;
      final was = _stale;
      _stale = false;
      return was;
    }
    if (_stale || _wait != null) return false;
    _wait = Timer(KeyboardGuard.patience, () {
      _wait = null;
      if (mounted && _inset > 0 && !keyboardInUse) setState(() => _stale = true);
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    _inset = media.viewInsets.bottom;
    _judge();
    final drop = _stale && _inset > 0;
    return MediaQuery(
      data: drop
          ? media.copyWith(
              viewInsets: media.viewInsets.copyWith(bottom: 0),
              padding: media.padding.copyWith(bottom: media.viewPadding.bottom),
            )
          : media,
      child: widget.child,
    );
  }
}
