import 'package:intl/intl.dart';

enum AbsenceType {
  sickness('assets/icons/sick.png', 'Sickness'),
  vacation('assets/icons/vacation.png', 'Vacation');

  const AbsenceType(this.iconPath, this.name);

  final String iconPath;
  final String name;
}

class Absence {
  final int? admitterId;
  final String admitterNote;
  final DateTime? confirmedAt;
  final DateTime? createdAt;
  final int? crewId;
  final DateTime? endDate;
  final int id;
  final String memberNote;
  final DateTime? rejectedAt;
  final DateTime? startDate;
  final AbsenceType type;
  final int userId;

  Absence({
    this.admitterId,
    this.admitterNote = '',
    this.confirmedAt,
    this.createdAt,
    this.crewId,
    this.endDate,
    required this.id,
    this.memberNote = '',
    this.rejectedAt,
    this.startDate,
    required this.type,
    required this.userId,
  });

  String get status =>
      confirmedAt != null
          ? 'Confirmed'
          : rejectedAt != null
          ? 'Rejected'
          : 'Requested';

  String get formatPeriod {
    final format = DateFormat('d MMM yyyy');
    final start = startDate != null ? format.format(startDate!) : 'N/A';
    final end = endDate != null ? format.format(endDate!) : 'N/A';
    return '$start → $end';
  }
}
