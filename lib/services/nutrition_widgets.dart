import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../widgets/home_widget_views.dart';
import '../widgets/nutrition_art.dart';

typedef WidgetRender = Future<void> Function(Widget view, String key, Size size);

class NutritionWidgets {
  NutritionWidgets._();

  static const water = 'WaterWidgetProvider';
  static const protein = 'ProteinWidgetProvider';
  static const kcal = 'KcalWidgetProvider';
  static const providers = [water, protein, kcal];
  static const levels = 48;
  static const kcalSize = Size(320, 150);
  static const _pendingKey = 'nutri_pending';
  static const _route = MethodChannel('gymmane/open');
  static String _signature = '';

  static String signature() {
    final today = DateTime.now();
    final g = fit.goalsFor(today);
    final m = fit.totalOn(today);
    return [
      fit.nutritionBeta,
      fit.waterOn(today),
      m.kcal.round(),
      m.protein.round(),
      m.carbs.round(),
      m.fat.round(),
      g.kcal,
      g.protein,
      g.carbs,
      g.fat,
      g.waterMl,
      g.glassMl,
      fit.isLb,
      fit.useKj,
      fit.shakeFoodId,
      fit.language,
      today.day,
    ].join('|');
  }

  static void watch(VoidCallback update) {
    _signature = signature();
    fit.addListener(() {
      final next = signature();
      if (next == _signature) return;
      _signature = next;
      update();
    });
  }

  static Future<void> takePending() async {
    if (kIsWeb || !Platform.isAndroid) return;
    try {
      final raw = await HomeWidget.getWidgetData<String>(_pendingKey);
      if (raw == null || raw.isEmpty) return;
      await HomeWidget.saveWidgetData<String>(_pendingKey, '');
      fit.takeWidgetLog(raw);
    } catch (e) {
      debugPrint('NutritionWidgets.takePending falló: $e');
    }
  }

  static void listenOpen(void Function(String route) onOpen) {
    if (kIsWeb || !Platform.isAndroid) return;
    _route.setMethodCallHandler((call) async {
      final route = call.arguments;
      if (call.method == 'open' && route is String) onOpen(route);
    });
  }

  static Future<String?> takeOpen() async {
    if (kIsWeb || !Platform.isAndroid) return null;
    try {
      return await _route.invokeMethod<String>('take');
    } catch (_) {
      return null;
    }
  }

  static Future<void> paint({
    required WidgetRender render,
    required bool Function(String provider) wants,
    required GymColors day,
    required GymColors night,
    required bool framed,
  }) async {
    final today = DateTime.now();
    final g = fit.goalsFor(today);
    final total = fit.totalOn(today);
    final off = fit.nutritionBeta ? null : t.widgetNutritionOff;
    await HomeWidget.saveWidgetData<String>('nutri_on', fit.nutritionBeta ? '1' : '0');
    await HomeWidget.saveWidgetData<String>('nutri_day', _stamp(today));
    await HomeWidget.saveWidgetData<String>('nutri_dec', decimalSeparator);
    await HomeWidget.saveWidgetData<String>(
      'nutri_geo',
      VesselWidgetGeometry.fractions().map((v) => v.toStringAsFixed(5)).join(','),
    );
    await HomeWidget.saveWidgetData<String>('nutri_text', _hex(day.text));
    await HomeWidget.saveWidgetData<String>('nutri_text_night', _hex(night.text));
    await HomeWidget.saveWidgetData<String>('nutri_done', _hex(day.sage));
    await HomeWidget.saveWidgetData<String>('nutri_done_night', _hex(night.sage));

    if (wants(water)) {
      await _both(
        render,
        (gc) => VesselWidgetView(
          gc: gc,
          title: t.waterLabel,
          icon: PhosphorIconsFill.drop,
          tone: gc.water,
          goal: '/ ${fit.waterLabel(g.waterMl)}',
          pill: '+ ${fit.waterLabel(g.glassMl)}',
          message: off,
          framed: framed,
        ),
        'water_base',
        VesselWidgetGeometry.size,
        day,
        night,
      );
      await _frames('water', VesselLook.water);
      await _numbers('water', {
        'value': '${fit.waterOn(today)}',
        'goal': '${g.waterMl}',
        'step': '${g.glassMl}',
        'mode': fit.isLb ? 'oz' : 'L',
        'tone': _hex(day.water),
        'tone_night': _hex(night.water),
      });
    }

    if (wants(protein)) {
      final shake = fit.shakeFood;
      final step = shake == null ? 0 : shake.macros.protein.round();
      await _both(
        render,
        (gc) => VesselWidgetView(
          gc: gc,
          title: t.macroProtein,
          icon: PhosphorIconsFill.lightning,
          tone: gc.protein,
          goal: '/ ${g.protein} g',
          pill: shake == null ? t.widgetPickShake : '+ $step g',
          message: off,
          framed: framed,
        ),
        'protein_base',
        VesselWidgetGeometry.size,
        day,
        night,
      );
      await _frames('protein', VesselLook.shake(shakeColor(shake)));
      await _numbers('protein', {
        'value': '${total.protein.round()}',
        'goal': '${g.protein}',
        'step': '$step',
        'food': shake?.id ?? '',
        'mode': 'g',
        'tone': _hex(day.protein),
        'tone_night': _hex(night.protein),
      });
    }

    if (wants(kcal)) {
      final kj = fit.useKj;
      int energy(num kcal) => (kj ? kcal * 4.184 : kcal).round();
      await _both(
        render,
        (gc) => KcalWidgetView(
          gc: gc,
          kcal: energy(total.kcal),
          goal: energy(g.kcal),
          protein: total.protein,
          carbs: total.carbs,
          fat: total.fat,
          goals: (g.protein, g.carbs, g.fat),
          unit: kj ? 'kJ' : 'kcal',
          message: off,
          size: kcalSize,
          framed: framed,
        ),
        'kcal_img',
        kcalSize,
        day,
        night,
      );
      await _both(
        render,
        (gc) => KcalWidgetView(
          gc: gc,
          kcal: 0,
          goal: energy(g.kcal),
          protein: 0,
          carbs: 0,
          fat: 0,
          goals: (g.protein, g.carbs, g.fat),
          unit: kj ? 'kJ' : 'kcal',
          message: off,
          size: kcalSize,
          framed: framed,
        ),
        'kcal_fresh_img',
        kcalSize,
        day,
        night,
      );
    }
  }

  static Future<void> _both(
    WidgetRender render,
    Widget Function(GymColors) build,
    String key,
    Size size,
    GymColors day,
    GymColors night,
  ) async {
    await render(build(day), key, size);
    if (!identical(day, night)) {
      await render(build(night), '${key}_night', size);
    } else {
      final path = await HomeWidget.getWidgetData<String>(key);
      if (path != null) await HomeWidget.saveWidgetData<String>('${key}_night', path);
    }
  }

  static Future<void> _numbers(String prefix, Map<String, String> values) async {
    for (final e in values.entries) {
      await HomeWidget.saveWidgetData<String>('${prefix}_${e.key}', e.value);
    }
  }

  static Future<void> _frames(String prefix, VesselLook look) async {
    final key = '${look.asset}|${look.liquid.toARGB32()}|$levels|2';
    final dir = Directory('${(await getApplicationSupportDirectory()).path}/widget_frames');
    final last = File('${dir.path}/${prefix}_$levels.png');
    if (await HomeWidget.getWidgetData<String>('${prefix}_frames_key') == key && last.existsSync()) return;
    dir.createSync(recursive: true);
    final image = await _load(look.asset);
    final mask = await _load(look.asset.replaceFirst('.webp', '-mask.webp'));
    final texture = look.texture == null ? null : await _load(look.texture!);
    const height = VesselWidgetGeometry.vesselHeight;
    final size = Size(height * image.width / image.height, height);
    const scale = 3.0;
    for (var i = 0; i <= levels; i++) {
      final picture = paintVesselFrame(
        look: look,
        image: image,
        mask: mask,
        texture: texture,
        level: i / levels,
        phase: (i * 0.071) % 1,
        size: size,
        scale: scale,
      );
      final frame = await picture.toImage((size.width * scale).ceil(), (size.height * scale).ceil());
      picture.dispose();
      final png = await frame.toByteData(format: ui.ImageByteFormat.png);
      frame.dispose();
      if (png == null) continue;
      await File('${dir.path}/${prefix}_$i.png').writeAsBytes(png.buffer.asUint8List(), flush: true);
    }
    image.dispose();
    mask.dispose();
    texture?.dispose();
    await HomeWidget.saveWidgetData<String>('${prefix}_frames', '${dir.path}/${prefix}_');
    await HomeWidget.saveWidgetData<String>('${prefix}_frames_n', '$levels');
    await HomeWidget.saveWidgetData<String>('${prefix}_frames_key', key);
  }

  static Future<ui.Image> _load(String asset) async {
    final data = await rootBundle.load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    codec.dispose();
    return frame.image;
  }

  static String _stamp(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String _hex(Color c) => '#${c.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
