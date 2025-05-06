import 'package:crewmeister/core/utils/extensions.dart';

import '../../domain/entities/member.dart';

class MemberModel {
  final int id;
  final int crewId;
  final int userId;
  final String name;
  final String? image;

  MemberModel({
    required this.id,
    required this.crewId,
    required this.userId,
    required this.name,
    this.image,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json.verifyKey<int>('id')!,
      crewId: json.verifyKey<int>('crewId')!,
      userId: json.verifyKey<int>('userId')!,
      name: json.verifyKey<String>('name')!,
      image: json.verifyKey<String?>('image'),
    );
  }

  Member toEntity() {
    return Member(userId: userId, name: name, image: image);
  }
}
