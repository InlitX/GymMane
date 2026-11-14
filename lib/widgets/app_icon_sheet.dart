import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../services/app_icon.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'glass.dart';
import 'ui_kit.dart';

String appIconName(String id) => switch (id) {
      'light' => t.appIconLight,
      'sand' => t.appIconSand,
      'graphite' => t.appIconGraphite,
      'sage' => t.appIconSage,
      'night' => t.appIconNight,
      'material' => t.appIconMaterial,
      'medal' => t.appIconMedal,
      'glass' => t.appIconGlass,
      'stopwatch' => t.appIconStopwatch,
      'marble' => t.appIconMarble,
      _ => t.appIconDefault,
    };

void showAppIconSheet(BuildContext context) {
  for (final s in AppIcon.styles) {
    precacheImage(AssetImage(s.asset), context);
  }
  showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _AppIconSheet(),
  );
}

class AppIconThumb extends StatelessWidget {
  const AppIconThumb(this.style, {super.key, required this.size});

  final AppIconStyle style;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.24),
      child: Image.asset(style.asset, width: size, height: size, fit: BoxFit.cover, gaplessPlayback: true),
    );
  }
}

class _AppIconSheet extends StatelessWidget {
  const _AppIconSheet();

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Container(
      padding: sheetPad(context),
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      decoration: sheetDecoration(gc),
      child: ValueListenableBuilder<String>(
        valueListenable: AppIcon.current,
        builder: (context, current, _) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(t.appIcon, subtitle: t.appIconHint),
            const SizedBox(height: 18),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Group(label: t.appIconColors, styles: [for (final s in AppIcon.styles) if (!s.design) s], current: current),
                    const SizedBox(height: 22),
                    _Group(label: t.appIconDesigns, styles: [for (final s in AppIcon.styles) if (s.design) s], current: current),
                    const SizedBox(height: 16),
                    Text(t.appIconNote,
                        textAlign: TextAlign.center,
                        style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary, height: 1.4)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(label: t.done, onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.label, required this.styles, required this.current});

  final String label;
  final List<AppIconStyle> styles;
  final String current;

  static const _tile = 84.0;

  @override
  Widget build(BuildContext context) {
    final names = MediaQuery.textScalerOf(context).scale(12.5) * 1.4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 12),
          child: SectionLabel(label),
        ),
        SizedBox(
          height: _tile + 8 + 8 + names + 6,
          child: _FadedStrip(
            itemCount: styles.length,
            itemBuilder: (_, i) => SizedBox(
              width: _tile + 8,
              child: _Tile(style: styles[i], on: styles[i].id == current),
            ),
          ),
        ),
      ],
    );
  }
}

class _FadedStrip extends StatefulWidget {
  const _FadedStrip({required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<_FadedStrip> createState() => _FadedStripState();
}

class _FadedStripState extends State<_FadedStrip> {
  static const _fade = 22.0;
  final _scroll = ScrollController();
  double _start = 0;
  double _end = 0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_update);
    WidgetsBinding.instance.addPostFrameCallback((_) => _update());
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _update() {
    if (!mounted || !_scroll.hasClients) return;
    final p = _scroll.position;
    final start = (p.pixels / _fade).clamp(0.0, 1.0);
    final end = ((p.maxScrollExtent - p.pixels) / _fade).clamp(0.0, 1.0);
    if (start == _start && end == _end) return;
    setState(() {
      _start = start;
      _end = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        final edge = (_fade / rect.width).clamp(0.0, 0.5);
        final left = rtl ? _end : _start;
        final right = rtl ? _start : _end;
        return LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 1 - left),
            Colors.white,
            Colors.white,
            Colors.white.withValues(alpha: 1 - right),
          ],
          stops: [0, edge, 1 - edge, 1],
        ).createShader(rect);
      },
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: (_) {
          _update();
          return false;
        },
        child: ListView.separated(
          controller: _scroll,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.only(end: 6),
          itemCount: widget.itemCount,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.style, required this.on});

  final AppIconStyle style;
  final bool on;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Semantics(
      button: true,
      selected: on,
      label: appIconName(style.id),
      child: Pressable(
        onTap: () {
          HapticFeedback.selectionClick();
          AppIcon.set(style.id);
        },
        child: Column(
          children: [
            LayoutBuilder(builder: (context, box) {
              final size = box.maxWidth - 8;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size * 0.24 + 4),
                  border: Border.all(color: on ? gc.accent : Colors.transparent, width: 2),
                ),
                child: Stack(clipBehavior: Clip.none, children: [
                  AppIconThumb(style, size: size),
                  PositionedDirectional(
                    end: -4,
                    bottom: -4,
                    child: AnimatedScale(
                      scale: on ? 1 : 0,
                      duration: const Duration(milliseconds: 220),
                      curve: on ? Curves.easeOutBack : Curves.easeInCubic,
                      child: Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: gc.accent,
                          shape: BoxShape.circle,
                          border: Border.all(color: gc.bgRaised, width: 2),
                        ),
                        child: Icon(PhosphorIconsBold.check, size: 11, color: gc.onEmber),
                      ),
                    ),
                  ),
                ]),
              );
            }),
            const SizedBox(height: 8),
            Text(appIconName(style.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTheme.f(12.5,
                    weight: on ? FontWeight.w700 : FontWeight.w600, color: on ? gc.text : gc.textSecondary)),
          ],
        ),
      ),
    );
  }
}
