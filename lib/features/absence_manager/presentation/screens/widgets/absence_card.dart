import 'package:crewmeister/features/absence_manager/domain/entities/absence.dart';
import 'package:crewmeister/features/absence_manager/domain/entities/member.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/absence_with_member_provider.dart';

class AbsenceCard extends StatelessWidget {
  final AbsenceWithMember item;

  const AbsenceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final absence = item.absence;
    final member = item.member;
    final iconPath = absence.type.iconPath;

    return InkWell(
      onTap: () => _showAbsenceDetails(context, absence, member),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Icon
              Image.asset(iconPath, height: 40, width: 40),

              const SizedBox(width: 16),

              // Name + Type + Date
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
                      _formatPeriod(absence),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Status
              _statusChip(absence),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPeriod(Absence absence) {
    final format = DateFormat('d MMM yyyy');
    final start =
        absence.startDate != null ? format.format(absence.startDate!) : 'N/A';
    final end =
        absence.endDate != null ? format.format(absence.endDate!) : 'N/A';
    return '$start → $end';
  }

  Widget _statusChip(Absence absence) {
    final status =
        absence.confirmedAt != null
            ? 'Confirmed'
            : absence.rejectedAt != null
            ? 'Rejected'
            : 'Requested';

    final color = switch (status) {
      'Confirmed' => Colors.green,
      'Rejected' => Colors.red,
      _ => Colors.orange,
    };

    return Chip(
      label: Text(status),
      backgroundColor: color.withValues(alpha: 0.1),
      labelStyle: TextStyle(color: color),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Member image
              if (member?.image != null)
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(member!.image!),
                )
              else
                const CircleAvatar(radius: 40, child: Icon(Icons.person)),

              const SizedBox(height: 12),

              // Member name
              Text(
                member?.name ?? 'Unknown Member',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 16),

              // Info section
              ListTile(
                title: const Text('Type'),
                subtitle: Text(absence.type.name),
              ),
              ListTile(
                title: const Text('Period'),
                subtitle: Text(_formatPeriod(absence)),
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
              ListTile(
                title: const Text('Status'),
                subtitle: Text(
                  absence.confirmedAt != null
                      ? 'Confirmed'
                      : absence.rejectedAt != null
                      ? 'Rejected'
                      : 'Requested',
                ),
              ),

              const SizedBox(height: 20),

              // Export button
              ElevatedButton.icon(
                onPressed: () async {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('iCal exported:')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Export to iCal'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
