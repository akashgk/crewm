import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crewmeister/services/file_service.dart';
import 'package:crewmeister/features/absence_manager/data/repositories/member_repository_impl.dart';

class MockFileService extends Mock implements FileService {}

void main() {
  late MockFileService fileService;
  late MemberRepositoryImpl repository;

  final mockJson = [
    {
      'id': 1,
      'crewId': 100,
      'userId': 501,
      'name': 'John Doe',
      'image': 'https://example.com/john.jpg',
    },
    {
      'id': 2,
      'crewId': 100,
      'userId': 502,
      'name': 'Jane Smith',
      'image': null,
    }
  ];

  setUp(() {
    fileService = MockFileService();
    repository = MemberRepositoryImpl(fileService, memberSource: 'mock.json');

    when(() => fileService.readJsonFile(any()))
        .thenAnswer((_) async => mockJson);
  });

  test('getMembers returns all members', () async {
    final members = await repository.getMembers();

    expect(members.length, 2);
    expect(members[0].name, 'John Doe');
    expect(members[1].image, isNull);
  });

  test('getMemberById returns correct member', () async {
    final member = await repository.getMemberById(502);

    expect(member, isNotNull);
    expect(member?.name, 'Jane Smith');
  });

  test('getMemberById returns null for unknown id', () async {
    final member = await repository.getMemberById(999);
    expect(member, isNull);
  });

  test('data is cached after first load', () async {
    await repository.getMemberById(501);
    verify(() => fileService.readJsonFile('mock.json')).called(1);

    await repository.getMemberById(502);
    verifyNever(() => fileService.readJsonFile('mock.json'));
  });
}