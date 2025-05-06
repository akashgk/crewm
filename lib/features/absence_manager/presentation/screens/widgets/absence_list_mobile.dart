import 'package:crewmeister/features/absence_manager/presentation/providers/absence_with_member_provider.dart';
import 'package:flutter/material.dart';

import 'absence_card.dart';

class AbsenceListMobile extends StatelessWidget {
  final List<AbsenceWithMember> absencesDetailList;

  const AbsenceListMobile({super.key, required this.absencesDetailList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: absencesDetailList.length,
      itemBuilder: (context, index) {
        final detail = absencesDetailList[index];

        return AbsenceCard(item: detail);
      },
    );
  }
}
