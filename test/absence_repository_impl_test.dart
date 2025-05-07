import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/data/repositories/absence_repository_impl.dart';
import 'package:crewmeister/services/file_service.dart';

class MockFileService extends Mock implements FileService {}

void main() {
  late MockFileService fileService;
  late AbsenceRepositoryImpl repository;

  final mockJson = [
    {
      'id': 1,
      'admitterId': 1,
      'admitterNote': 'Approved',
      'confirmedAt': '2023-01-01T10:00:00Z',
      'createdAt': '2023-01-01T09:00:00Z',
      'crewId': 101,
      'endDate': '2023-01-05T00:00:00Z',
      'memberNote': 'Sick',
      'rejectedAt': null,
      'startDate': '2023-01-01T00:00:00Z',
      'type': 'sickness',
      'userId': 501,
    },
    {
      'id': 2,
      'admitterId': null,
      'admitterNote': null,
      'confirmedAt': null,
      'createdAt': '2023-02-01T10:00:00Z',
      'crewId': 101,
      'endDate': '2023-02-05T00:00:00Z',
      'memberNote': 'Trip',
      'rejectedAt': null,
      'startDate': '2023-02-01T00:00:00Z',
      'type': 'vacation',
      'userId': 502,
    },
  ];

  setUp(() {
    fileService = MockFileService();
    repository = AbsenceRepositoryImpl(fileService, absenceSource: 'mock.json');

    when(
      () => fileService.readJsonFile(any()),
    ).thenAnswer((_) async => mockJson);
  });

  test('getAbsences returns all absences by default', () async {
    final result = await repository.getAbsences();
    expect(result.length, 2);
  });

  test('getAbsences applies offset and limit', () async {
    final result = await repository.getAbsences(offset: 1, limit: 1);
    expect(result.length, 1);
    expect(result.first.id, 2);
  });

  test('getAbsences filters by type', () async {
    final result = await repository.getAbsences(type: AbsenceType.vacation);
    expect(result.length, 1);
    expect(result.first.type, AbsenceType.vacation);
  });

  test('getAbsences filters by startDate', () async {
    final result = await repository.getAbsences(
      startDate: DateTime(2023, 02, 01),
    );
    expect(result.length, 1);
    expect(result.first.id, 2);
  });

  test('getAbsences filters by endDate', () async {
    final result = await repository.getAbsences(
      endDate: DateTime(2023, 01, 10),
    );
    expect(result.length, 1);
    expect(result.first.id, 1);
  });

  test('getAbsenceById returns correct absence', () async {
    final result = await repository.getAbsenceById(2);
    expect(result?.id, 2);
  });

  test('getAbsenceById returns null if not found', () async {
    final result = await repository.getAbsenceById(999);
    expect(result, isNull);
  });

  test('getAbsenceCount returns correct filtered count', () async {
    final count = await repository.getAbsenceCount(type: AbsenceType.vacation);
    expect(count, 1);
  });
}
