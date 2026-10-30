import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/gym_pass.dart';
import '../services/pass_scan.dart';
import '../services/screen_awake.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/entrance.dart';
import '../widgets/glass.dart';
import '../widgets/gym_pass_card.dart';
import '../widgets/liquid_notch.dart';
import '../widgets/routine_folder.dart';
import '../widgets/sheet_page.dart';
import '../widgets/ui_kit.dart';

class GymPassScreen extends StatelessWidget {
  const GymPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final passes = fit.gymPasses;
    return RiseScope(
      id: 'passes',
      once: false,
      child: SheetPage(
        title: t.gymPass,
        eyebrow: t.profile,
        onBack: fit.backFromGymPasses,
        actions: [
          RoundAction(
            onTap: () => addGymPass(context),
            label: t.gymPassAdd,
            child: Icon(PhosphorIconsRegular.plus, size: 17, color: gc.text),
          ),
        ],
        children: [
          if (passes.isEmpty)
            Rise(index: 0, child: GymPassEmpty(onTap: () => addGymPass(context)))
          else
            for (final (i, p) in passes.indexed) ...[
              if (i > 0) const SizedBox(height: 18),
              Rise(
                index: i,
                child: Pressable(
                  scale: 0.98,
                  onTap: () => showGymPass(context, p),
                  onLongPress: () => _menu(context, p, i),
                  child: GymPassCard(pass: p),
                ),
              ),
              const SizedBox(height: 10),
              Row(children: [
                const SizedBox(width: 4),
                Expanded(
                  child: Text(passFormatLabel(p.format).toUpperCase(),
                      style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
                ),
                Pressable(
                  scale: 0.92,
                  onTap: () => _menu(context, p, i),
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: gc.bgRaised, borderRadius: BorderRadius.circular(15)),
                    child: Icon(PhosphorIconsBold.dotsThree, size: 16, color: gc.text),
                  ),
                ),
              ]),
            ],
          const SizedBox(height: 26),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(PhosphorIconsRegular.lockSimple, size: 13, color: gc.textTertiary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(t.gymPassPrivate,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(11.5, weight: FontWeight.w500, color: gc.textTertiary)),
            ),
          ]),
        ],
      ),
    );
  }

  void _menu(BuildContext context, GymPass p, int i) {
    final gc = context.gc;
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) => Container(
        padding: sheetPad(sheet),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(p.name, subtitle: passFormatLabel(p.format)),
            const SizedBox(height: 14),
            OptionGroup([
              OptionItem(t.gymPassShow, icon: PhosphorIconsRegular.qrCode, onTap: () {
                Navigator.pop(sheet);
                showGymPass(context, p);
              }),
              OptionItem(t.gymPassEdit, icon: PhosphorIconsRegular.pencilSimple, onTap: () {
                Navigator.pop(sheet);
                editGymPass(context, pass: p);
              }),
              if (i > 0)
                OptionItem(t.moveUp, icon: PhosphorIconsRegular.arrowUp, onTap: () {
                  Navigator.pop(sheet);
                  fit.moveGymPass(i, i - 1);
                }),
              if (i < fit.gymPasses.length - 1)
                OptionItem(t.moveDown, icon: PhosphorIconsRegular.arrowDown, onTap: () {
                  Navigator.pop(sheet);
                  fit.moveGymPass(i, i + 1);
                }),
              OptionItem(t.delete, icon: PhosphorIconsRegular.trash, danger: true, onTap: () {
                Navigator.pop(sheet);
                final undo = fit.removeGymPass(p.id);
                if (undo == null) return;
                showNotchToast(context, t.gymPassDeleted,
                    subtitle: p.name, icon: PhosphorIconsFill.trash, accent: gc.warn, action: t.undo, onTap: undo);
              }),
            ]),
          ],
        ),
      ),
    );
  }
}

class GymPassEmpty extends StatelessWidget {
  const GymPassEmpty({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      scale: 0.98,
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: kPassRatio,
        child: CustomPaint(
          painter: _DashedCard(gc.text.withValues(alpha: 0.18)),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.09), shape: BoxShape.circle),
                child: Icon(PhosphorIconsRegular.qrCode, size: 22, color: gc.text),
              ),
              const SizedBox(height: 14),
              Text(t.gymPassAdd, style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text)),
              const SizedBox(height: 4),
              Text(t.gymPassEmpty,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(12.5, weight: FontWeight.w500, color: gc.textSecondary, height: 1.35)),
            ]),
          ),
        ),
      ),
    );
  }
}

class _DashedCard extends CustomPainter {
  const _DashedCard(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width * 0.06;
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(r)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (final m in path.computeMetrics()) {
      for (var d = 0.0; d < m.length; d += 12) {
        canvas.drawPath(m.extractPath(d, d + 6), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedCard old) => old.color != color;
}

Future<void> showGymPass(BuildContext context, GymPass pass) async {
  fit.useGymPass(pass.id);
  HapticFeedback.lightImpact();
  ScreenAwake.bright(true);
  ScreenAwake.keepOn(true);
  await Navigator.of(context).push(PageRouteBuilder<void>(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 360),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (_, animation, _) => _PassView(pass: pass, animation: animation),
  ));
  ScreenAwake.bright(false);
  if (!fit.keepScreenOn || !fit.isSessionActive) ScreenAwake.keepOn(false);
}

class _PassView extends StatelessWidget {
  const _PassView({required this.pass, required this.animation});

  final GymPass pass;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final size = MediaQuery.sizeOf(context);
    final side = (size.width - 64).clamp(0.0, 360.0);
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final v = Curves.easeOutCubic.transform(animation.value);
          return ColoredBox(
            color: Color.lerp(Colors.transparent, gc.bg, v)!,
            child: Opacity(
              opacity: v,
              child: Transform.translate(offset: Offset(0, 30 * (1 - v)), child: child),
            ),
          );
        },
        child: SafeArea(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(pass.name,
                  textAlign: TextAlign.center,
                  style: AppTheme.f(22, weight: FontWeight.w800, color: gc.text, letterSpacing: -0.4)),
              const SizedBox(height: 4),
              Text(pass.member.isNotEmpty ? pass.member : fit.displayName,
                  style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
              const SizedBox(height: 22),
              Container(
                width: side,
                padding: EdgeInsets.all(pass.square ? 22 : 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(color: passHue(pass.hue).withValues(alpha: 0.25), blurRadius: 60, spreadRadius: 4),
                  ],
                ),
                child: SizedBox(
                  height: pass.square ? side - 44 : side * 0.5,
                  child: PassCode(code: pass.code, format: pass.format),
                ),
              ),
              const SizedBox(height: 22),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(PhosphorIconsRegular.sun, size: 14, color: gc.textTertiary),
                const SizedBox(width: 6),
                Text(t.gymPassShowHint, style: AppTheme.f(12, weight: FontWeight.w600, color: gc.textTertiary)),
              ]),
            ]),
          ),
        ),
      ),
      ),
    );
  }
}

Future<void> addGymPass(BuildContext context) async {
  final gc = context.gc;
  final how = await showAppSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheet) {
      Widget row(IconData icon, String title, String hint, String value) => Pressable(
            scale: 0.98,
            onTap: () => Navigator.pop(sheet, value),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: gc.text.withValues(alpha: 0.09), shape: BoxShape.circle),
                  child: Icon(icon, size: 19, color: gc.text),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: AppTheme.f(14.5, weight: FontWeight.w700, color: gc.text)),
                    const SizedBox(height: 2),
                    Text(hint, style: AppTheme.f(12, weight: FontWeight.w500, color: gc.textSecondary, height: 1.3)),
                  ]),
                ),
                Icon(PhosphorIconsRegular.caretRight, size: 15, color: gc.textTertiary),
              ]),
            ),
          );
      return Container(
        padding: sheetPad(sheet),
        decoration: BoxDecoration(
          color: gc.bgRaised,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(t.gymPassAdd, subtitle: t.gymPassPrivate),
            const SizedBox(height: 16),
            row(PhosphorIconsRegular.camera, t.gymPassScan, t.gymPassScanHint, 'camera'),
            row(PhosphorIconsRegular.image, t.gymPassPhoto, t.gymPassPhotoHint, 'photo'),
            row(PhosphorIconsRegular.keyboard, t.gymPassType, t.gymPassTypeHint, 'type'),
          ],
        ),
      );
    },
  );
  if (how == null || !context.mounted) return;
  if (how == 'type') return editGymPass(context, typing: true);
  final code = await _readCode(context, how == 'camera' ? ImageSource.camera : ImageSource.gallery);
  if (code == null || !context.mounted) return;
  await editGymPass(context, code: code);
}

Future<String?> _readCode(BuildContext context, ImageSource source) async {
  final XFile? shot;
  try {
    shot = await ImagePicker().pickImage(source: source, requestFullMetadata: false);
  } catch (_) {
    return null;
  }
  if (shot == null || !context.mounted) return null;
  final gc = context.gc;
  showNotchToast(context, t.gymPassReading, icon: PhosphorIconsRegular.qrCode, accent: gc.accent);
  final code = await readQrFromFile(shot.path);
  if (!context.mounted) return null;
  if (code == null) {
    HapticFeedback.heavyImpact();
    showNotchToast(context, t.gymPassNotFound, icon: PhosphorIconsFill.warningCircle, accent: gc.warn);
    return null;
  }
  HapticFeedback.mediumImpact();
  return code;
}

Future<void> editGymPass(BuildContext context, {GymPass? pass, String? code, bool typing = false}) =>
    showAppSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _PassEditor(pass: pass, code: code, typing: typing),
    );

class _PassEditor extends StatefulWidget {
  const _PassEditor({this.pass, this.code, this.typing = false});

  final GymPass? pass;
  final String? code;
  final bool typing;

  @override
  State<_PassEditor> createState() => _PassEditorState();
}

class _PassEditorState extends State<_PassEditor> {
  late final _name = TextEditingController(text: widget.pass?.name ?? t.gymPassDefaultName);
  late final _code = TextEditingController(text: widget.pass?.code ?? widget.code ?? '');
  late PassFormat _format = widget.pass?.format ?? (widget.typing ? PassFormat.code128 : PassFormat.qr);
  late int _hue = widget.pass?.hue ?? fit.gymPasses.length % kFolderHues.length;

  static const _formats = [
    PassFormat.qr,
    PassFormat.code128,
    PassFormat.ean13,
    PassFormat.code39,
  ];

  @override
  void dispose() {
    _name.dispose();
    _code.dispose();
    super.dispose();
  }

  bool get _valid => passCodeValid(_format, _code.text.trim());

  GymPass get _draft => GymPass(
        id: widget.pass?.id ?? 'draft',
        name: _name.text.trim().isEmpty ? t.gymPassDefaultName : _name.text.trim(),
        code: _code.text.trim(),
        format: _format,
        hue: _hue,
        member: widget.pass?.member ?? '',
      );

  void _save() {
    if (!_valid) return;
    final d = _draft;
    if (widget.pass == null) {
      fit.addGymPass(name: d.name, code: d.code, format: d.format, hue: d.hue);
    } else {
      fit.updateGymPass(d);
    }
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
  }

  Future<void> _rescan() async {
    final source = await pickPhotoFor(context);
    if (source == null || !mounted) return;
    final code = await _readCode(context, source);
    if (code == null || !mounted) return;
    setState(() {
      _code.text = code;
      _format = PassFormat.qr;
    });
  }

  Widget _field(GymColors gc, TextEditingController c, String hint, {bool numeric = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
        child: TextField(
          controller: c,
          onChanged: (_) => setState(() {}),
          keyboardType: numeric ? TextInputType.visiblePassword : TextInputType.text,
          textCapitalization: numeric ? TextCapitalization.characters : TextCapitalization.words,
          cursorColor: gc.accent,
          style: AppTheme.f(15, weight: FontWeight.w700, color: gc.text, letterSpacing: numeric ? 1.2 : 0),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: AppTheme.f(15, weight: FontWeight.w600, color: gc.textTertiary),
          ),
        ),
      );

  Widget _label(GymColors gc, String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8, top: 18),
        child: Text(text.toUpperCase(),
            style: AppTheme.f(10.5, weight: FontWeight.w700, color: gc.textTertiary, letterSpacing: 1.4)),
      );

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final code = _code.text.trim();
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.92),
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      decoration: BoxDecoration(
        color: gc.bgRaised,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        padding: sheetPad(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(widget.pass == null ? t.gymPassAdd : t.gymPassEdit),
            const SizedBox(height: 18),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              child: KeyedSubtree(
                key: ValueKey(_valid),
                child: _valid
                    ? GymPassCard(pass: _draft, hero: false)
                    : AspectRatio(
                        aspectRatio: kPassRatio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: gc.bgRaised2,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(24),
                          child: Text(code.isEmpty ? t.gymPassTypeHint : t.gymPassInvalid,
                              textAlign: TextAlign.center,
                              style: AppTheme.f(13, weight: FontWeight.w600, color: gc.textSecondary)),
                        ),
                      ),
              ),
            ),
            _label(gc, t.gymPassName),
            _field(gc, _name, t.gymPassDefaultName),
            _label(gc, t.gymPassFormat),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (final f in _formats)
                Pressable(
                  scale: 0.94,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _format = f);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: f == _format ? gc.ember : gc.bgRaised2,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(passFormatLabel(f),
                        style: AppTheme.f(12.5,
                            weight: FontWeight.w700, color: f == _format ? gc.onEmber : gc.textSecondary)),
                  ),
                ),
            ]),
            _label(gc, t.gymPassCode),
            _field(gc, _code, '0123456789', numeric: true),
            _label(gc, t.gymPassColor),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              for (var i = 0; i < kFolderHues.length; i++)
                Pressable(
                  scale: 0.88,
                  onTap: () => setState(() => _hue = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 38,
                    height: 38,
                    padding: EdgeInsets.all(i == _hue ? 4 : 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: i == _hue ? gc.text : Colors.transparent, width: 2),
                    ),
                    child: DecoratedBox(decoration: BoxDecoration(color: kFolderHues[i], shape: BoxShape.circle)),
                  ),
                ),
            ]),
            const SizedBox(height: 14),
            Center(
              child: TextButton.icon(
                onPressed: _rescan,
                icon: Icon(PhosphorIconsRegular.arrowsClockwise, size: 15, color: gc.textSecondary),
                label: Text(t.gymPassRescan,
                    style: AppTheme.f(13, weight: FontWeight.w700, color: gc.textSecondary)),
              ),
            ),
            const SizedBox(height: 18),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _valid ? 1 : 0.4,
              child: PrimaryButton(label: t.save, onTap: _save),
            ),
          ],
        ),
      ),
    );
  }
}

Future<ImageSource?> pickPhotoFor(BuildContext context) => showAppSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) {
        final gc = sheet.gc;
        return Container(
          padding: sheetPad(sheet),
          decoration: BoxDecoration(
            color: gc.bgRaised,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetHandle(),
              const SizedBox(height: 18),
              OptionGroup([
                OptionItem(t.gymPassScan,
                    icon: PhosphorIconsRegular.camera, onTap: () => Navigator.pop(sheet, ImageSource.camera)),
                OptionItem(t.gymPassPhoto,
                    icon: PhosphorIconsRegular.image, onTap: () => Navigator.pop(sheet, ImageSource.gallery)),
              ]),
            ],
          ),
        );
      },
    );

class GymPassCarousel extends StatefulWidget {
  const GymPassCarousel({super.key});

  @override
  State<GymPassCarousel> createState() => _GymPassCarouselState();
}

class _GymPassCarouselState extends State<GymPassCarousel> {
  late int _index = math.max(0, fit.gymPasses.indexWhere((p) => p.id == fit.lastPass?.id));
  late final PageController _pages = PageController(initialPage: _index, viewportFraction: 0.92);

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final passes = fit.gymPasses;
    if (passes.length == 1) {
      return Pressable(
        scale: 0.98,
        onTap: () => showGymPass(context, passes.first),
        child: GymPassCard(pass: passes.first),
      );
    }
    final index = _index.clamp(0, passes.length - 1);
    return LayoutBuilder(builder: (context, box) {
      final height = (box.maxWidth * 0.92 - 10) / kPassRatio;
      return Column(children: [
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: PageView.builder(
              controller: _pages,
              itemCount: passes.length,
              onPageChanged: (i) {
                HapticFeedback.selectionClick();
                setState(() => _index = i);
                fit.useGymPass(passes[i].id);
              },
              itemBuilder: (context, i) => AnimatedBuilder(
                animation: _pages,
                builder: (context, child) {
                  final page = _pages.hasClients && _pages.position.haveDimensions ? _pages.page! : index.toDouble();
                  final d = (page - i).abs().clamp(0.0, 1.0);
                  return Transform.scale(
                    scale: 1 - 0.07 * d,
                    child: Opacity(opacity: 1 - 0.45 * d, child: child),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Pressable(
                    scale: 0.98,
                    onTap: () => showGymPass(context, passes[i]),
                    child: GymPassCard(pass: passes[i], hero: false),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (var i = 0; i < passes.length; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == index ? gc.text : gc.text.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
        ]),
      ]);
    });
  }
}
