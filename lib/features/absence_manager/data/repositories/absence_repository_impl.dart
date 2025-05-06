import 'package:crewmeister/core/utils/json_reader.dart';
import 'package:crewmeister/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/domain/repositories/absence_repository.dart';

class AbsenceRepositoryImpl implements AbsenceRepository {
  final String absenceSource;

  AbsenceRepositoryImpl({required this.absenceSource});

  List<Absence> _cachedAbsences = [];

  Future<void> _loadData() async {
    if (_cachedAbsences.isNotEmpty) return;

    final absenceListJson = await readJsonFile(absenceSource);

    _cachedAbsences =
        absenceListJson
            .map((e) => AbsenceModel.fromJson(e).toEntity())
            .toList();
  }

  @override
  Future<List<Absence>> getAbsences({
    int offset = 0,
    int limit = 10,
    AbsenceType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await _loadData();
    var filtered = _cachedAbsences;

    if (type != null) {
      filtered = filtered.where((a) => a.type == type).toList();
    }
    if (startDate != null) {
      filtered =
          filtered
              .where((a) => a.startDate?.isAfter(startDate) ?? false)
              .toList();
    }
    if (endDate != null) {
      filtered =
          filtered.where((a) => a.endDate?.isBefore(endDate) ?? false).toList();
    }

    return filtered.skip(offset).take(limit).toList();
  }

  @override
  Future<Absence?> getAbsenceById(int id) async {
    await _loadData();
    return _cachedAbsences.where((a) => a.id == id).firstOrNull;
  }

  @override
  Future<int> getAbsenceCount({
    AbsenceType? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final all = await getAbsences(
      offset: 0,
      limit: 99999,
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
    return all.length;
  }

  @override
  Future<String> generateICal() async {
    // Placeholder
    return 'BEGIN:VCALENDAR\n...';
  }
}
