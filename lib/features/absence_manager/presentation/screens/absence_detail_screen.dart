import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/absence.dart';
import '../providers/absence_with_member_provider.dart';

class AbsenceDetailScreen extends ConsumerWidget {
  final int absenceId;

  const AbsenceDetailScreen({required this.absenceId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAbsence = ref.watch(absenceDetailWithMemberProvider(absenceId));
    final theme = Theme.of(context);

    return asyncAbsence.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (data) {
        final absence = data.absence;
        final member = data.member;
        final dateFormat = DateFormat('d MMM yyyy');

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with image + name
              Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage:
                        member?.image != null
                            ? NetworkImage(member!.image!)
                            : null,
                    child:
                        member?.image == null
                            ? const Icon(Icons.person, size: 36)
                            : null,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    member?.name ?? 'User ${absence.userId}',
                    style: theme.textTheme.headlineSmall,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Type
              Row(
                children: [
                  Image.asset(absence.type.iconPath, height: 28, width: 28),
                  const SizedBox(width: 8),
                  Text(
                    absence.type.name[0].toUpperCase() +
                        absence.type.name.substring(1),
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Period
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Period'),
                subtitle: Text(
                  '${dateFormat.format(absence.startDate!)} → ${dateFormat.format(absence.endDate!)}',
                ),
              ),

              // Status
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Status'),
                subtitle: _statusChip(absence),
              ),

              if (absence.memberNote.isNotEmpty)
                Card(
                  margin: const EdgeInsets.only(top: 16),
                  child: ListTile(
                    leading: const Icon(Icons.note_alt),
                    title: const Text('Member Note'),
                    subtitle: Text(absence.memberNote),
                  ),
                ),

              if (absence.admitterNote.isNotEmpty)
                Card(
                  margin: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    leading: const Icon(Icons.assignment_turned_in),
                    title: const Text('Admitter Note'),
                    subtitle: Text(absence.admitterNote),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },    );
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
}
