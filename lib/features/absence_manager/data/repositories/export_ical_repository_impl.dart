import 'package:crewmeister/services/download_service.dart';
import 'package:crewmeister/services/file_service.dart';
import 'package:crewmeister/services/ical_service.dart';
import 'package:crewmeister/services/share_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/absence.dart';

import '../../domain/entities/member.dart';
import '../../domain/repositories/ical_repository.dart';

class ExportAbsenceToICal implements ExportAbsenceToICalRepository {
  final ICalService icalService;
  final FileService fileService;
  final ShareService shareService;
  final DownloadService downloadService;

  ExportAbsenceToICal(
    this.icalService,
    this.fileService,
    this.shareService,
    this.downloadService,
  );

  @override
  Future<void> exportAbsenceToICal(Absence absence, Member? member) async {
    final icalContent = icalService.createICalFromAbsence(absence, member);

    if (kIsWeb) {
      await downloadService.downloadFile(
        'absence_${member?.name ?? 'USER'}_${absence.id}.ics',
        icalContent,
        'text/calendar',
      );
    } else {
      final file = await fileService.writeICal(
        member?.name ?? 'USER',
        absence.id,
        icalContent,
      );
      await shareService.shareFile(file.path);
    }
  }
}

final exportIcalProvider = Provider<ExportAbsenceToICal>((ref) {
  return ExportAbsenceToICal(
    ref.watch(icalServiceProvider),
    ref.watch(fileServiceProvider),
    ref.watch(shareServiceProvider),
    ref.watch(downloadServiceProvider),
  );
});
