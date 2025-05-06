import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewmeister/features/absence_manager/data/repositories/member_repository_impl.dart';

final memberRepositoryProvider = Provider<MemberRepositoryImpl>((ref) {
  return MemberRepositoryImpl(memberSource: 'assets/data/members.json');
});