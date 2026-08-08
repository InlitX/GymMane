import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/theme/app_theme.dart';
import 'package:gymmane/widgets/profile_avatar.dart';

final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

Widget _host() => MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: Center(child: ProfileAvatar())),
    );

Widget _liveHost() => MaterialApp(
      theme: AppTheme.dark,
      home: AnimatedBuilder(
        animation: fit,
        builder: (_, _) => Scaffold(body: Center(child: ProfileAvatar())),
      ),
    );

final photo = find.byWidgetPredicate(
  (w) => w is Image && w.image is MemoryImage,
  description: 'la foto de perfil',
);

final defaultPhoto = find.byWidgetPredicate(
  (w) => w is Image && w.image == ProfileAvatar.defaultPhoto,
  description: 'la foto por defecto',
);

void main() {

  tearDown(() {
    fit.clearProfilePhoto();
    fit.persistNow();
  });

  test('the photo survives a round trip through the backup', () {
    fit.setProfilePhoto(_png);
    final backup = fit.exportJson();

    fit.clearProfilePhoto();
    expect(fit.profilePhoto, isNull);

    expect(fit.importJson(backup), true);
    expect(fit.profilePhoto, _png);
  });

  test('no photo means no photo — not a broken avatar', () {
    fit.clearProfilePhoto();
    expect(fit.profilePhoto, isNull);
    expect(fit.profile.toJson().containsKey('photo'), false);
  });

  test('a corrupt photo degrades to the emblem instead of throwing', () {
    fit.profile.photo = 'not base64 at all!!';
    expect(fit.profilePhoto, isNull);
  });

  test('decoding is cached until the photo changes', () {
    fit.setProfilePhoto(_png);
    expect(identical(fit.profilePhoto, fit.profilePhoto), true);
  });

  testWidgets('avatar falls back to the default photo, not a hole', (tester) async {
    fit.clearProfilePhoto();
    fit.persistNow();
    await tester.pumpWidget(_host());
    expect(photo, findsNothing);
    expect(defaultPhoto, findsOneWidget);
  });

  testWidgets('avatar renders the photo when there is one', (tester) async {
    fit.setProfilePhoto(_png);
    fit.persistNow();
    await tester.pumpWidget(_host());
    expect(photo, findsOneWidget);
  });

  testWidgets('avatar reacts to a photo picked while it is on screen', (tester) async {
    fit.clearProfilePhoto();
    fit.persistNow();
    await tester.pumpWidget(_liveHost());
    expect(photo, findsNothing);

    fit.setProfilePhoto(_png);
    fit.persistNow();
    await tester.pump();
    expect(photo, findsOneWidget);

    fit.clearProfilePhoto();
    fit.persistNow();
    await tester.pump();
    expect(photo, findsNothing);
  });
}
