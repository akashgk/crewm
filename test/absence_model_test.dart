import 'package:crewmeister/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('AbsenceModel', () {
    final mockJson = {
      'admitterId': 1,
      'admitterNote': 'Approved',
      'confirmedAt': '2023-01-01T10:00:00Z',
      'createdAt': '2023-01-01T09:00:00Z',
      'crewId': 101,
      'endDate': '2023-01-05T00:00:00Z',
      'id': 1001,
      'memberNote': 'Feeling sick',
      'rejectedAt': null,
      'startDate': '2023-01-01T00:00:00Z',
      'type': 'sickness',
      'userId': 501,
    };

    test('should correctly deserialize from JSON', () {
      final model = AbsenceModel.fromJson(mockJson);

      expect(model.admitterId, 1);
      expect(model.admitterNote, 'Approved');
      expect(model.confirmedAt, DateTime.parse('2023-01-01T10:00:00Z'));
      expect(model.createdAt, DateTime.parse('2023-01-01T09:00:00Z'));
      expect(model.crewId, 101);
      expect(model.endDate, DateTime.parse('2023-01-05T00:00:00Z'));
      expect(model.id, 1001);
      expect(model.memberNote, 'Feeling sick');
      expect(model.rejectedAt, null);
      expect(model.startDate, DateTime.parse('2023-01-01T00:00:00Z'));
      expect(model.type, 'sickness');
      expect(model.userId, 501);
    });

    test('should convert to Absence entity correctly', () {
      final model = AbsenceModel.fromJson(mockJson);
      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.type, AbsenceType.sickness);
      expect(entity.memberNote, 'Feeling sick');
      expect(entity.admitterNote, 'Approved');
    });

    test('should throw if unknown absence type is passed', () {
      final badJson = Map<String, dynamic>.from(mockJson);
      badJson['type'] = 'unknown_type';

      final model = AbsenceModel.fromJson(badJson);

      expect(() => model.toEntity(), throwsA(isA<Exception>()));
    });
  });
}