import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../l10n/l10n.dart';
import '../models/note.dart';
import '../services/media_store.dart';
import '../state/fit_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'dialogs.dart';
import 'file_thumb.dart';
import 'glass.dart';
import 'note_kit.dart';
import 'routine_folder.dart';
import 'ui_kit.dart';

Color noteFolderHue(NoteFolder f) => kFolderHues[f.color.clamp(0, kFolderHues.length - 1)];

const double kNoteFolderWidth = 152;

double noteFolderHeight(BuildContext context) =>
    124 + MediaQuery.textScalerOf(context).scale(15) * 1.15 * 2 + MediaQuery.textScalerOf(context).scale(11.5) * 1.3;

class NoteFolderCard extends StatelessWidget {
  const NoteFolderCard({super.key, required this.folder, required this.onTap, required this.onMenu, this.notes});

  final NoteFolder folder;
  final List<GymNote>? notes;
  final VoidCallback onTap;
  final VoidCallback onMenu;

  static const _tab = 14.0;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final hue = noteFolderHue(folder);
    final dark = gc.bg.computeLuminance() < 0.5;
    final notes = this.notes ?? fit.notesInFolder(folder.id);
    final pocket = Color.lerp(gc.bgRaised2, hue, dark ? 0.24 : 0.36)!;
    final back = Color.lerp(hue, Colors.black, dark ? 0.2 : 0.05)!;
    final tab = Color.lerp(gc.bgRaised, hue, dark ? 0.1 : 0.2)!;
    final paper = dark ? const Color(0xFFEDE9E4) : Colors.white;
    const ink = Color(0xFF2A2623);
    String? photo;
    for (final n in notes) {
      for (final m in n.media) {
        final path = MediaStore.pathFor(m);
        if (path != null && !MediaStore.isVideo(m)) {
          photo = path;
          break;
        }
      }
      if (photo != null) break;
    }
    final latest = notes.isEmpty ? null : notes.first;
    final detail = [
      t.noteCount(notes.length),
      if (latest != null) noteDayLabel(latest.date),
    ].join(' · ');

    return Pressable(
      onTap: onTap,
      onLongPress: onMenu,
      scale: 0.97,
      child: SizedBox(
        width: kNoteFolderWidth,
        height: noteFolderHeight(context),
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 0,
            width: 58,
            height: _tab + 20,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.lerp(tab, Colors.white, dark ? 0.06 : 0.3)!, tab],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: _tab,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: tab,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            right: 8,
            top: _tab + 4,
            height: 62,
            child: _paper(back, angle: 0.04, child: _lines(ink.withValues(alpha: 0.16))),
          ),
          if (photo != null)
            Positioned(
              left: 12,
              right: 22,
              top: _tab + 9,
              height: 66,
              child: _paper(
                paper,
                angle: -0.035,
                pad: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FileThumb(photo, width: kNoteFolderWidth - 42, height: 52),
                ),
              ),
            )
          else if (latest != null)
            Positioned(
              left: 9,
              right: 15,
              top: _tab + 13,
              height: 62,
              child: _paper(
                paper,
                angle: -0.025,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(latest.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.f(10, weight: FontWeight.w800, color: ink, height: 1.2)),
                  const SizedBox(height: 5),
                  _lines(ink.withValues(alpha: 0.18)),
                ]),
              ),
            ),
          Positioned(
            left: 4,
            right: 4,
            top: _tab + 48,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.lerp(pocket, Colors.white, dark ? 0.07 : 0.28)!, pocket, Color.lerp(pocket, Colors.black, dark ? 0.12 : 0.04)!],
                  stops: const [0, 0.35, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: dark ? 0.36 : 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Text(folder.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.f(15, weight: FontWeight.w800, color: gc.text, height: 1.15)),
                  ),
                  Semantics(
                    button: true,
                    label: t.moreOptions,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onMenu,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 2, 4),
                        child: Icon(PhosphorIconsBold.dotsThreeVertical, size: 15, color: gc.textSecondary),
                      ),
                    ),
                  ),
                ]),
                const Spacer(),
                Text(detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.f(11.5, weight: FontWeight.w600, color: gc.textSecondary)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _paper(Color color, {required double angle, required Widget child, EdgeInsets pad = const EdgeInsets.fromLTRB(10, 8, 10, 0)}) =>
      Transform.rotate(
        angle: angle,
        child: Container(
          padding: pad,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
            boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 4, offset: Offset(0, 1))],
          ),
          alignment: Alignment.topLeft,
          child: child,
        ),
      );

  Widget _lines(Color c) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FractionallySizedBox(
          widthFactor: 0.7,
          child: Container(height: 2.5, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
        ),
        const SizedBox(height: 4),
        FractionallySizedBox(
          widthFactor: 0.45,
          child: Container(height: 2.5, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))),
        ),
      ]);
}

class NewNoteFolderCard extends StatelessWidget {
  const NewNoteFolderCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    return Pressable(
      onTap: onTap,
      scale: 0.97,
      child: SizedBox(
        width: kNoteFolderWidth,
        height: noteFolderHeight(context),
        child: Container(
          margin: const EdgeInsets.only(top: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gc.border, width: 1.5),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(color: gc.bgRaised, shape: BoxShape.circle),
              child: Icon(PhosphorIconsBold.plus, size: 15, color: gc.text),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(t.noteFolderNew,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.f(12.5, weight: FontWeight.w700, color: gc.textSecondary)),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<String?> showNoteFolderEditor(BuildContext context, {NoteFolder? folder}) => showAppSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _FolderEditor(folder: folder),
    );

class _FolderEditor extends StatefulWidget {
  const _FolderEditor({this.folder});

  final NoteFolder? folder;

  @override
  State<_FolderEditor> createState() => _FolderEditorState();
}

class _FolderEditorState extends State<_FolderEditor> {
  late final _name = TextEditingController(text: widget.folder?.name ?? '');
  late int _hue = widget.folder?.color ?? fit.noteFolders.length % kFolderHues.length;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  bool get _ok => _name.text.trim().isNotEmpty;

  void _save() {
    if (!_ok) return;
    final f = widget.folder;
    if (f == null) {
      Navigator.of(context).pop(fit.addNoteFolder(_name.text, _hue));
    } else {
      fit.editNoteFolder(f.id, name: _name.text, color: _hue);
      Navigator.of(context).pop(f.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = context.gc;
    final preview = NoteFolder(id: widget.folder?.id ?? '-', name: _name.text.trim().isEmpty ? t.noteFolderName : _name.text.trim(), color: _hue);
    return Container(
      padding: sheetPad(context),
      decoration: sheetDecoration(gc),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SheetHandle(),
          const SizedBox(height: 16),
          SheetTitle(widget.folder == null ? t.noteFolderNew : t.noteFolderEdit),
          const SizedBox(height: 16),
          Center(child: IgnorePointer(child: NoteFolderCard(folder: preview, onTap: () {}, onMenu: () {}))),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(color: gc.bgRaised2, borderRadius: BorderRadius.circular(16)),
            child: TextField(
              controller: _name,
              autofocus: widget.folder == null,
              maxLength: 32,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _save(),
              cursorColor: gc.accent,
              style: AppTheme.f(15, weight: FontWeight.w600, color: gc.text),
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                hintText: t.noteFolderName,
                hintStyle: AppTheme.f(15, weight: FontWeight.w600, color: gc.textTertiary),
              ),
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 22),
          PrimaryButton(
            label: t.save,
            onTap: _save,
            bg: _ok ? gc.ember : gc.mutedFill,
            fg: _ok ? gc.onEmber : gc.textTertiary,
          ),
        ]),
      ),
    );
  }
}

void showNoteFolderMenu(BuildContext context, NoteFolder f) {
  final gc = context.gc;
  showAppSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheet) => Container(
      padding: sheetPad(sheet),
      decoration: sheetDecoration(gc),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SheetHandle(),
        const SizedBox(height: 16),
        SheetTitle(f.name, subtitle: t.noteCount(fit.notesInFolder(f.id).length)),
        const SizedBox(height: 14),
        OptionGroup([
          OptionItem(t.noteFolderEdit, icon: PhosphorIconsRegular.pencilSimple, onTap: () {
            Navigator.pop(sheet);
            showNoteFolderEditor(context, folder: f);
          }),
          OptionItem(t.delete, icon: PhosphorIconsRegular.trash, danger: true, onTap: () async {
            Navigator.pop(sheet);
            final ok = await askConfirm(
              context,
              title: t.noteFolderDelete,
              body: t.noteFolderDeleteBody,
              confirmLabel: t.delete,
              danger: true,
            );
            if (ok) fit.deleteNoteFolder(f.id);
          }),
        ]),
      ]),
    ),
  );
}

Future<String?> pickNoteFolder(BuildContext context, String current) => showAppSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheet) {
        final gc = sheet.gc;
        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.7),
          padding: sheetPad(sheet),
          decoration: sheetDecoration(gc),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SheetHandle(),
            const SizedBox(height: 16),
            SheetTitle(t.noteFolderLabel),
            const SizedBox(height: 14),
            Flexible(
              child: OptionGroup(scroll: true, [
                OptionItem(t.noteFolderNone,
                    icon: PhosphorIconsRegular.tray, selected: current.isEmpty, onTap: () => Navigator.pop(sheet, '')),
                for (final f in fit.noteFolders)
                  OptionItem(f.name,
                      leading: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(color: noteFolderHue(f), shape: BoxShape.circle),
                      ),
                      selected: f.id == current,
                      onTap: () => Navigator.pop(sheet, f.id)),
                OptionItem(t.noteFolderNew, icon: PhosphorIconsRegular.folderPlus, onTap: () async {
                  final id = await showNoteFolderEditor(sheet);
                  if (id != null && sheet.mounted) Navigator.pop(sheet, id);
                }),
              ]),
            ),
          ]),
        );
      },
    );
