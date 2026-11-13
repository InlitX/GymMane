import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../models/workout.dart';

/// Builds a real Office Open XML workbook containing every logged set.
///
/// Rows are ordered oldest to newest. Warm-up and specialist set types are
/// retained, and cardio fields are included alongside lifting metrics.
Uint8List workoutHistoryXlsx(List<LoggedSession> sessions) {
  const headers = [
    'Date',
    'Workout',
    'Exercise',
    'Muscle',
    'Set',
    'Reps',
    'Weight (kg)',
    'Volume (kg)',
    'Est. 1RM (kg)',
    'Distance (km)',
    'Duration (s)',
    'Set type',
    'RPE',
    'RIR',
    'Note',
  ];

  final ordered = [...sessions]..sort((a, b) => a.day.compareTo(b.day));
  final rows = <List<String?>>[];
  for (final session in ordered) {
    final date = _date(session.day);
    for (final exercise in session.exercises) {
      for (var i = 0; i < exercise.sets.length; i++) {
        final set = exercise.sets[i];
        rows.add([
          date,
          session.name ?? '',
          exercise.name,
          exercise.primary,
          '${i + 1}',
          '${set.reps}',
          _number(set.weight),
          _number(set.volume),
          set.counts ? _number(set.oneRm) : '',
          set.km == null ? '' : _number(set.km!),
          set.sec?.toString() ?? '',
          set.kind.name,
          set.rpe == null ? '' : _number(set.rpe!),
          set.rir == null ? '' : _number(set.rir!),
          set.note,
        ]);
      }
    }
  }

  if (rows.length > 1048575) {
    throw StateError('Excel supports at most 1,048,575 workout rows plus a header.');
  }

  final archive = Archive();
  archive.addFile(ArchiveFile.string(
    '[Content_Types].xml',
    '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
  <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
</Types>''',
  ));
  archive.addFile(ArchiveFile.string(
    '_rels/.rels',
    '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>''',
  ));
  archive.addFile(ArchiveFile.string(
    'xl/workbook.xml',
    '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <bookViews><workbookView/></bookViews>
  <sheets><sheet name="Workout History" sheetId="1" r:id="rId1"/></sheets>
</workbook>''',
  ));
  archive.addFile(ArchiveFile.string(
    'xl/_rels/workbook.xml.rels',
    '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>''',
  ));
  archive.addFile(ArchiveFile.string(
    'xl/styles.xml',
    '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <fonts count="2">
    <font><sz val="11"/><name val="Calibri"/></font>
    <font><b/><color rgb="FF141413"/><sz val="11"/><name val="Calibri"/></font>
  </fonts>
  <fills count="3">
    <fill><patternFill patternType="none"/></fill>
    <fill><patternFill patternType="gray125"/></fill>
    <fill><patternFill patternType="solid"><fgColor rgb="FFC8A45F"/><bgColor indexed="64"/></patternFill></fill>
  </fills>
  <borders count="1"><border><left/><right/><top/><bottom/><diagonal/></border></borders>
  <cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
  <cellXfs count="2">
    <xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
    <xf numFmtId="0" fontId="1" fillId="2" borderId="0" xfId="0" applyFont="1" applyFill="1"/>
  </cellXfs>
  <cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles>
</styleSheet>''',
  ));

  final lastRow = rows.length + 1;
  final sheet = StringBuffer()
    ..writeln('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
    ..writeln('<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">')
    ..writeln('<dimension ref="A1:O$lastRow"/>')
    ..writeln('<sheetViews><sheetView workbookViewId="0"><pane ySplit="1" topLeftCell="A2" activePane="bottomLeft" state="frozen"/></sheetView></sheetViews>')
    ..writeln('<sheetFormatPr defaultRowHeight="16"/>')
    ..writeln('<cols>')
    ..writeln('<col min="1" max="1" width="13" customWidth="1"/>')
    ..writeln('<col min="2" max="2" width="18" customWidth="1"/>')
    ..writeln('<col min="3" max="3" width="28" customWidth="1"/>')
    ..writeln('<col min="4" max="4" width="14" customWidth="1"/>')
    ..writeln('<col min="5" max="6" width="9" customWidth="1"/>')
    ..writeln('<col min="7" max="11" width="14" customWidth="1"/>')
    ..writeln('<col min="12" max="12" width="13" customWidth="1"/>')
    ..writeln('<col min="13" max="14" width="9" customWidth="1"/>')
    ..writeln('<col min="15" max="15" width="32" customWidth="1"/>')
    ..writeln('</cols>')
    ..writeln('<sheetData>')
    ..writeln(_xlsxRow(1, [
      for (var i = 0; i < headers.length; i++) _xlsxTextCell(_column(i + 1), 1, headers[i], style: 1),
    ]));
  for (var i = 0; i < rows.length; i++) {
    final rowNumber = i + 2;
    final values = rows[i];
    final cells = <String>[];
    for (var column = 0; column < values.length; column++) {
      final value = values[column];
      if (value == null || value.isEmpty) continue;
      final ref = '${_column(column + 1)}$rowNumber';
      if (column >= 4 && column <= 10 || column == 12 || column == 13) {
        final numeric = double.tryParse(value);
        if (numeric != null && numeric.isFinite) {
          cells.add(_xlsxNumberCell(ref, numeric));
          continue;
        }
      }
      cells.add(_xlsxTextCell(_column(column + 1), rowNumber, value));
    }
    sheet.writeln(_xlsxRow(rowNumber, cells));
  }
  sheet
    ..writeln('</sheetData>')
    ..writeln('<autoFilter ref="A1:O$lastRow"/>')
    ..writeln('</worksheet>');
  archive.addFile(ArchiveFile.string('xl/worksheets/sheet1.xml', sheet.toString()));

  return ZipEncoder().encodeBytes(archive);
}

String _date(DateTime value) =>
    '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

String _number(num value) {
  final v = value.toDouble();
  if (!v.isFinite) return '';
  if (v == v.roundToDouble()) return v.toStringAsFixed(0);
  var result = v.toStringAsFixed(2);
  while (result.endsWith('0')) {
    result = result.substring(0, result.length - 1);
  }
  if (result.endsWith('.')) result = result.substring(0, result.length - 1);
  return result;
}

String _column(int index) {
  var n = index;
  var result = '';
  while (n > 0) {
    n--;
    result = String.fromCharCode(65 + n % 26) + result;
    n ~/= 26;
  }
  return result;
}

String _xml(String value) => value
    .replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&apos;');

String _xlsxTextCell(String column, int row, String value, {int style = 0}) =>
    '<c r="$column$row" t="inlineStr" s="$style"><is><t xml:space="preserve">${_xml(value)}</t></is></c>';

String _xlsxNumberCell(String ref, num value) =>
    '<c r="$ref"><v>${value.toString()}</v></c>';

String _xlsxRow(int number, List<String> cells) => '<row r="$number">${cells.join()}</row>';
), '');
}

String _column(int index) {
  var n = index;
  var result = '';
  while (n > 0) {
    n--;
    result = String.fromCharCode(65 + n % 26) + result;
    n ~/= 26;
  }
  return result;
}

String _xml(String value) => value
    .replaceAll(RegExp(r'[\\u0000-\\u0008\\u000B\\u000C\\u000E-\\u001F]'), '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&apos;');

String _xlsxTextCell(String column, int row, String value, {int style = 0}) =>
    '<c r="$column$row" t="inlineStr" s="$style"><is><t xml:space="preserve">${_xml(value)}</t></is></c>';

String _xlsxNumberCell(String ref, num value) =>
    '<c r="$ref"><v>${value.toString()}</v></c>';

String _xlsxRow(int number, List<String> cells) => '<row r="$number">${cells.join()}</row>';
