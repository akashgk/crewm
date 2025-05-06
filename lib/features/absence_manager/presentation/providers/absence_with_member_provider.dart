import 'package:crewmeister/features/absence_manager/presentation/providers/absence_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/absence.dart';
import '../../domain/entities/member.dart';
import 'absence_detail_provider.dart';
import 'member_repository_provider.dart';

class AbsenceWithMember {
  final Absence absence;
  final Member? member;

  AbsenceWithMember({required this.absence, required this.member});
}

class AbsenceListParams {
  final int offset;
  final int limit;
  final AbsenceType? type;
  final DateTime? startDate;
  final DateTime? endDate;

  AbsenceListParams({
    this.offset = 0,
    this.limit = 10,
    this.type,
    this.startDate,
    this.endDate,
  });

  @override
  bool operator ==(Object other) =>
      other is AbsenceListParams &&
      offset == other.offset &&
      limit == other.limit &&
      type == other.type &&
      startDate == other.startDate &&
      endDate == other.endDate;

  @override
  int get hashCode => Object.hash(offset, limit, type, startDate, endDate);
}

final absenceWithMemberListProvider = FutureProvider.autoDispose
    .family<List<AbsenceWithMember>, AbsenceListParams>((
      ref,
      absenceParams,
    ) async {
      final absenceRepo = ref.read(absenceRepositoryProvider);
      final memberRepo = ref.read(memberRepositoryProvider);
      await Future.delayed(const Duration(seconds: 1)); 
      final absences = await absenceRepo.getAbsences(
        offset: absenceParams.offset,
        limit: absenceParams.limit,
        type: absenceParams.type,
        startDate: absenceParams.startDate,
        endDate: absenceParams.endDate,
      );

      final result = <AbsenceWithMember>[];

      for (final a in absences) {
        final member = await memberRepo.getMemberById(a.userId);
        result.add(AbsenceWithMember(absence: a, member: member));
      }

      return result;
    });




final absenceDetailWithMemberProvider =
    FutureProvider.family.autoDispose<AbsenceWithMember, int>((ref, id) async {
  final absence = await ref.watch(absenceDetailProvider(id).future);

  if (absence == null) {
    throw Exception('Absence not found');
  }

  final memberRepo = ref.read(memberRepositoryProvider);
  final member = await memberRepo.getMemberById(absence.userId);

  return AbsenceWithMember(absence: absence, member: member);
});