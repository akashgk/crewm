import 'package:crewmeister/services/ical_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/member.dart';


void main() {
  late ICalService service;

  setUp(() {
    service = ICalService();
  });

  final member = Member(userId: 1, name: 'John Doe', image: null);
  final start = DateTime(2023, 5, 1);
  final end = DateTime(2023, 5, 3);

  Absence createAbsence({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Absence(
      id: 1,
      admitterId: null,
      admitterNote: 'Approved by HR',
      confirmedAt: null,
      createdAt: null,
      crewId: 1,
      endDate: endDate,
      startDate: startDate,
      memberNote: 'Going to doctor',
      rejectedAt: null,
      type: AbsenceType.vacation,
      userId: 1,
    );
  }

test('adds one day if startDate equals endDate', () {
  final absence = createAbsence(startDate: start, endDate: start);
  final ical = service.createICalFromAbsence(absence, member);

  // Check that DTSTART and DTEND exist
  final dtStartMatch = RegExp(r'DTSTART:(\d{8}T\d{6}Z)').firstMatch(ical);
  final dtEndMatch = RegExp(r'DTEND:(\d{8}T\d{6}Z)').firstMatch(ical);

  expect(dtStartMatch, isNotNull);
  expect(dtEndMatch, isNotNull);

  final dtStart = dtStartMatch!.group(1)!;
  final dtEnd = dtEndMatch!.group(1)!;

  final startDate = DateTime.parse(dtStart.replaceAll('Z', ''));
  final endDate = DateTime.parse(dtEnd.replaceAll('Z', ''));

  expect(endDate.difference(startDate), const Duration(days: 1));
});

  test('throws when startDate or endDate is null', () {
    final absence = createAbsence(startDate: null, endDate: end);
    expect(() => service.createICalFromAbsence(absence, member), throwsException);
  });

  test('throws when startDate is after endDate', () {
    final absence = createAbsence(startDate: end, endDate: start);
    expect(() => service.createICalFromAbsence(absence, member), throwsException);
  });


}