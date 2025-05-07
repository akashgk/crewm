import 'package:crewmeister/services/file_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewmeister/features/absence_manager/data/repositories/absence_repository_impl.dart';

final absenceRepositoryProvider = Provider<AbsenceRepositoryImpl>((ref) {
  return AbsenceRepositoryImpl(
    ref.watch(fileServiceProvider),
    absenceSource: 'assets/data/absences.json',
  );
});
