import 'package:crewmeister/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/export_ical_repository_impl.dart';
import '../../../domain/entities/absence.dart';
import '../../../domain/entities/member.dart';

class AbsenceInfoBottomSheet extends StatelessWidget {
  final Absence absence;
  final Member? member;
  final String iconPath;
  const AbsenceInfoBottomSheet({
    super.key,
    required this.absence,
    this.member,
    required this.iconPath,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (member?.image != null)
            CircleAvatar(
              radius: 40,
              child: Shimmer(
                child: Container(
                  height: 40,
                  width: 40,

                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
              backgroundImage: NetworkImage(member!.image!),
            )
          else
            const CircleAvatar(radius: 40, child: Icon(Icons.person)),

          const SizedBox(height: 12),

          Text(
            member?.name ?? 'Unknown Member',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 16),

          ListTile(
            title: const Text('Type'),
            subtitle: Text(absence.type.name),
          ),
          ListTile(
            title: const Text('Period'),
            subtitle: Text(absence.formatPeriod),
          ),
          if (absence.memberNote.isNotEmpty)
            ListTile(
              title: const Text('Member Note'),
              subtitle: Text(absence.memberNote),
            ),
          if (absence.admitterNote.isNotEmpty)
            ListTile(
              title: const Text('Admitter Note'),
              subtitle: Text(absence.admitterNote),
            ),
          ListTile(title: const Text('Status'), subtitle: Text(absence.status)),

          const SizedBox(height: 20),

          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  ref
                      .watch(exportIcalProvider)
                      .exportAbsenceToICal(absence, member);
                },
                child: const Text('Export to iCal'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
