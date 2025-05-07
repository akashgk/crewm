import '../entities/absence.dart';

import '../entities/member.dart';

abstract class ExportAbsenceToICalRepository {
  Future<void> exportAbsenceToICal(Absence absence, Member? membe);
}
