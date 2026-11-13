import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../state/fit_state.dart';
import 'file_share.dart';
import 'plan_pdf.dart';

String _stamp(RangeReport r) {
  String day(DateTime date) => date.toIso8601String().split('T').first;
  return '${day(r.from)}_${day(r.to)}';
}

String _sectionName(ReportSection section) => switch (section) {
  ReportSection.weighIns => 'weigh-ins',
  _ => section.name,
};

Uint8List buildReportZip(RangeReport r, Set<ReportSection> sections) {
  final archive = Archive();
  final stamp = _stamp(r);
  for (final section in ReportSection.values.where(sections.contains)) {
    archive.addFile(
      ArchiveFile.string('gymmane-${_sectionName(section)}-$stamp.csv', fit.reportSectionCsv(r, section)),
    );
  }
  return ZipEncoder().encodeBytes(archive);
}

Future<void> shareReportZip(RangeReport r, Set<ReportSection> sections) => shareFile(
  'gymmane-report-${_stamp(r)}.zip',
  buildReportZip(r, sections),
  mime: 'application/zip',
  subject: reportRangeLabel(r),
);
