import 'package:flutter/material.dart';

import '../../../domain/entities/absence_with_member.dart';
import 'absence_card.dart';

class AbsenceListMobile extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final List<AbsenceWithMember> absencesDetailList;

  const AbsenceListMobile({
    super.key,
    required this.absencesDetailList,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: absencesDetailList.length,
      padding: padding,
      itemBuilder: (context, index) {
        final detail = absencesDetailList[index];
        return AbsenceCard(item: detail);
      },
    );
  }
}
