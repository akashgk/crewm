import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';

void main() {
  group('AbsenceType', () {
    test('returns correct name and iconPath for sickness', () {
      expect(AbsenceType.sickness.name, 'Sickness');
      expect(AbsenceType.sickness.iconPath, 'assets/icons/sick.png');
    });

    test('returns correct name and iconPath for vacation', () {
      expect(AbsenceType.vacation.name, 'Vacation');
      expect(AbsenceType.vacation.iconPath, 'assets/icons/vacation.png');
    });
  });

  group('Absence.status', () {
    test('returns Confirmed when confirmedAt is not null', () {
      final absence = Absence(
        id: 1,
        userId: 1,
        type: AbsenceType.sickness,
        confirmedAt: DateTime.now(),
      );
      expect(absence.status, 'Confirmed');
    });

    test('returns Rejected when rejectedAt is not null and confirmedAt is null', () {
      final absence = Absence(
        id: 2,
        userId: 1,
        type: AbsenceType.vacation,
        rejectedAt: DateTime.now(),
      );
      expect(absence.status, 'Rejected');
    });

    test('returns Requested when both confirmedAt and rejectedAt are null', () {
      final absence = Absence(
        id: 3,
        userId: 1,
        type: AbsenceType.vacation,
      );
      expect(absence.status, 'Requested');
    });
  });

  group('Absence.formatPeriod', () {
    test('formats dates correctly', () {
      final absence = Absence(
        id: 4,
        userId: 1,
        type: AbsenceType.vacation,
        startDate: DateTime(2023, 5, 1),
        endDate: DateTime(2023, 5, 3),
      );
      final formatted = absence.formatPeriod;
      final formatter = DateFormat('d MMM yyyy');
      expect(formatted, '${formatter.format(absence.startDate!)} → ${formatter.format(absence.endDate!)}');
    });

    test('returns N/A for missing dates', () {
      final absence = Absence(
        id: 5,
        userId: 1,
        type: AbsenceType.vacation,
      );
      expect(absence.formatPeriod, 'N/A → N/A');
    });
  });
}