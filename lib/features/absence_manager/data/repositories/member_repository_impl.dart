import 'package:crewmeister/core/utils/json_reader.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/member.dart';

import '../../domain/repositories/member_repository.dart';
import '../models/member_model.dart';

class MemberRepositoryImpl implements MemberRepository {
  final String memberSource;

  Map<int, Member> _cachedMembers = {};

  MemberRepositoryImpl({required this.memberSource});

  Future<void> _loadData() async {
    if (_cachedMembers.isNotEmpty) return;

    final memberListJson = await readJsonFile(memberSource);

    final memberList =
        memberListJson.map((e) => MemberModel.fromJson(e).toEntity()).toList();

    _cachedMembers = {for (var e in memberList) e.userId: e};
  }

  @override
  Future<Member?> getMemberById(int id) async {
    await _loadData();
    return _cachedMembers[id];
  }

  @override
  Future<List<Member>> getMembers() async {
    await _loadData();
    return _cachedMembers.values.toList();
  }
}
