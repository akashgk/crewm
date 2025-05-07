import 'package:crewmeister/features/absence_manager/data/models/member_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemberModel', () {
    final mockJson = {
      'id': 1,
      'crewId': 101,
      'userId': 501,
      'name': 'John Doe',
      'image': 'https://example.com/image.jpg',
    };

    test('should correctly deserialize from JSON', () {
      final model = MemberModel.fromJson(mockJson);

      expect(model.id, 1);
      expect(model.crewId, 101);
      expect(model.userId, 501);
      expect(model.name, 'John Doe');
      expect(model.image, 'https://example.com/image.jpg');
    });


    test('should convert to Member entity correctly', () {
      final model = MemberModel.fromJson(mockJson);
      final entity = model.toEntity();

      expect(entity.userId, model.userId);
      expect(entity.name, model.name);
      expect(entity.image, model.image);
    });
  });
}