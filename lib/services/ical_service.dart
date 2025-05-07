import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/member.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ICalService {
  String _formatDate(DateTime date) =>
      '${date.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.').first}Z';

  String createICalFromAbsence(Absence absence, Member? member) {
    final startDate = absence.startDate;
    DateTime? endDate = absence.endDate;

    if (startDate == null || endDate == null) {
      throw Exception('Start date and end date must be provided');
    }
    if (startDate.isAfter(endDate)) {
      throw Exception('Start date must be before end date');
    }

    if (startDate == endDate) {
      endDate = startDate.add(const Duration(days: 1));
    }

    return '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Absence Manager//EN
BEGIN:VEVENT
UID:absence-${absence.id}@crewmeister.com
DTSTAMP:${_formatDate(DateTime.now())}
DTSTART:${_formatDate(startDate)}
DTEND:${_formatDate(endDate)}
SUMMARY:${member?.name} on ${absence.type.name} leave
DESCRIPTION:${member?.name} on ${absence.type.name} leave from ${absence.formatPeriod} \\nMember Note: ${absence.memberNote}\\nAdmitter Note: ${absence.admitterNote}
STATUS:${absence.type.name.toUpperCase()}
END:VEVENT
END:VCALENDAR
''';
  }
}

final icalServiceProvider = Provider<ICalService>((ref) {
  return ICalService();
});
