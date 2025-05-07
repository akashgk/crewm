import 'package:crewmeister/core/widgets/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/repositories/export_ical_repository_impl.dart';
import '../providers/absence_with_member_provider.dart';

class AbsenceDetailScreen extends ConsumerWidget {
  final int absenceId;

  const AbsenceDetailScreen({required this.absenceId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAbsence = ref.watch(absenceDetailWithMemberProvider(absenceId));
    final theme = Theme.of(context);
    final dateFormat = DateFormat('d MMM yyyy');

    return Scaffold(
      body: asyncAbsence.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => const Center(
              child: ErrorState(
                title: 'Incorrect Absence ID',
                message: 'Please check the ID and try again.',
                icon: Icons.error_outline,
              ),
            ),
        data: (data) {
          final absence = data.absence;
          final member = data.member;

          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  member?.image != null
                                      ? NetworkImage(member!.image!)
                                      : null,
                              child:
                                  member?.image == null
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member?.name ?? 'User ${absence.userId}',
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Chip(
                                    label: Text(
                                      absence.status,
                                      style: TextStyle(
                                        color: _statusColor(absence.status),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    backgroundColor: _statusColor(
                                      absence.status,
                                    ).withValues(alpha: .1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Details
                        _infoCard(
                          context,
                          icon: Image.asset(
                            absence.type.iconPath,
                            height: 24,
                            width: 24,
                          ),
                          title: 'Absence Type',
                          content:
                              absence.type.name[0].toUpperCase() +
                              absence.type.name.substring(1),
                        ),
                        _infoCard(
                          context,
                          icon: const Icon(Icons.calendar_today_outlined),
                          title: 'Period',
                          content:
                              '${dateFormat.format(absence.startDate!)} → ${dateFormat.format(absence.endDate!)}',
                        ),

                        if (absence.memberNote.isNotEmpty)
                          _infoCard(
                            context,
                            icon: const Icon(Icons.note_alt_outlined),
                            title: 'Member Note',
                            content: absence.memberNote,
                          ),

                        if (absence.admitterNote.isNotEmpty)
                          _infoCard(
                            context,
                            icon: const Icon(
                              Icons.assignment_turned_in_outlined,
                            ),
                            title: 'Admitter Note',
                            content: absence.admitterNote,
                          ),

                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.calendar_month),
                            label: const Text('Export to iCal'),
                            onPressed: () async {
                              await ref
                                  .watch(exportIcalProvider)
                                  .exportAbsenceToICal(absence, member);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(content, style: theme.textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    return switch (status) {
      'Confirmed' => Colors.green,
      'Rejected' => Colors.red,
      _ => Colors.orange,
    };
  }
}
