import '../entities/absence.dart';

abstract class AbsenceRepository {
  Future<List<Absence>> getAbsences({
    int offset = 0,
    int limit = 10,
    AbsenceType? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Absence?> getAbsenceById(int id);

  Future<int> getAbsenceCount({
    AbsenceType? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<String> generateICal(); // Optional bonus
}
