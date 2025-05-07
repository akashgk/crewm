import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/member.dart';

import 'package:flutter/material.dart';

import '../../../domain/entities/absence_with_member.dart';
import 'absence_info_bottom_sheet.dart';

class AbsenceCard extends StatelessWidget {
  final AbsenceWithMember item;

  const AbsenceCard({super.key, required this.item});

  Widget _statusChip(Absence absence) {
    final color = switch (absence.status) {
      'Confirmed' => Colors.green,
      'Rejected' => Colors.red,
      _ => Colors.orange,
    };

    return Chip(
      label: Text(absence.status),
      backgroundColor: color.withValues(alpha: 0.1),
      labelStyle: TextStyle(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final absence = item.absence;
    final member = item.member;
    final iconPath = absence.type.iconPath;

    return InkWell(
      onTap: () => _showAbsenceDetails(context, absence, member),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(iconPath, height: 40, width: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member?.name ?? 'User ${absence.userId}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      absence.type.name[0].toUpperCase() +
                          absence.type.name.substring(1),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      absence.formatPeriod,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _statusChip(absence),
            ],
          ),
        ),
      ),
    );
  }

  void _showAbsenceDetails(
    BuildContext context,
    Absence absence,
    Member? member,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return AbsenceInfoBottomSheet(
          absence: absence,
          member: member,
          iconPath: absence.type.iconPath,
        );
      },
    );
  }
}
