import '../entities/member.dart';

abstract class MemberRepository {
  Future<List<Member>> getMembers();
  Future<Member?> getMemberById(int id);
}
