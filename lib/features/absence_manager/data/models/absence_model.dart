import 'package:crewmeister/core/utils/extensions.dart';

import '../../domain/entities/absence.dart';

class AbsenceModel {
  final int? admitterId;
  final String? admitterNote;
  final DateTime? confirmedAt;
  final DateTime? createdAt;
  final int? crewId;
  final DateTime? endDate;
  final int id;
  final String? memberNote;
  final DateTime? rejectedAt;
  final DateTime? startDate;
  final String type;
  final int userId;

  AbsenceModel({
    this.admitterId,
    this.admitterNote,
    this.confirmedAt,
    this.createdAt,
    this.crewId,
    this.endDate,
    required this.id,
    this.memberNote,
    this.rejectedAt,
    this.startDate,
    required this.type,
    required this.userId,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) {
    return AbsenceModel(
      admitterId: json.verifyKey<int?>('admitterId'),
      admitterNote: json.verifyKey<String?>('admitterNote'),
      confirmedAt:
          json['confirmedAt'] != null
              ? DateTime.tryParse(json['confirmedAt'])
              : null,
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      crewId: json.verifyKey<int>('crewId'),
      endDate:
          json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      id: json.verifyKey<int>('id')!,
      memberNote: json.verifyKey<String?>('memberNote'),
      rejectedAt:
          json['rejectedAt'] != null
              ? DateTime.tryParse(json['rejectedAt'])
              : null,
      startDate:
          json['startDate'] != null
              ? DateTime.tryParse(json['startDate'])
              : null,
      type: json.verifyKey<String>('type')!,
      userId: json.verifyKey<int>('userId')!,
    );
  }

  Absence toEntity() {
    return Absence(
      admitterId: admitterId,
      admitterNote: admitterNote ?? '',
      confirmedAt: confirmedAt,
      createdAt: createdAt,
      crewId: crewId,
      endDate: endDate,
      id: id,
      memberNote: memberNote ?? '',
      rejectedAt: rejectedAt,
      startDate: startDate,
      type: _mapType(type),
      userId: userId,
    );
  }

  AbsenceType _mapType(String value) {
    return switch (value) {
      'sickness' => AbsenceType.sickness,
      'vacation' => AbsenceType.vacation,
      _ => throw Exception('Unknown absence type: $value'),
    };
  }
}
