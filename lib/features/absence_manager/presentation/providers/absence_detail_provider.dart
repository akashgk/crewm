import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'absence_repository_provider.dart';

final absenceDetailProvider = FutureProvider.family
    .autoDispose<Absence?, int>((ref, id) async {
  final repository = ref.read(absenceRepositoryProvider);
  return repository.getAbsenceById(id);
});