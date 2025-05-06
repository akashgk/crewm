import 'package:crewmeister/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../providers/absence_with_member_provider.dart';

class AbsenceTableView extends StatelessWidget {
  final List<AbsenceWithMember> absencesDetailList;

  const AbsenceTableView({super.key, required this.absencesDetailList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('d MMM yyyy');

    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            child: DataTable(
              columnSpacing: 20,
              headingRowColor: WidgetStateProperty.all(
                theme.primaryColor.withValues(alpha: 0.1),
              ),
              headingTextStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              dataRowMinHeight: 56,
              showCheckboxColumn: false,
              dataRowMaxHeight: 70,
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Start Date')),
                DataColumn(label: Text('End Date')),
                DataColumn(label: Text('Status')),
              ],
              rows:
                  absencesDetailList.mapIndexed((index, a) {
                    final absence = a.absence;
                    final member = a.member;
                    final status =
                        absence.confirmedAt != null
                            ? 'Confirmed'
                            : absence.rejectedAt != null
                            ? 'Rejected'
                            : 'Requested';

                    final statusColor = switch (status) {
                      'Confirmed' => Colors.green,
                      'Rejected' => Colors.red,
                      _ => Colors.orange,
                    };

                    final backgroundColor =
                        index % 2 == 0
                            ? theme.cardColor
                            : theme.cardColor.withValues(alpha: 0.95);

                    return DataRow(
                      color: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.error)) {
                          return Colors.red;
                        } else if (states.contains(WidgetState.hovered) &&
                            states.contains(WidgetState.focused)) {
                          return Colors.blueAccent;
                        } else if (states.contains(WidgetState.focused)) {
                          return Colors.blue;
                        } else if (!states.contains(WidgetState.disabled)) {
                          return backgroundColor;
                        }
                        return backgroundColor;
                      }),

                      onSelectChanged: (_) {
                        context.goNamed(
                          'absenceDetail',
                          pathParameters: {'id': absence.id.toString()},
                        );
                      },
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage:
                                    member?.image != null
                                        ? NetworkImage(member!.image!)
                                        : null,
                                child:
                                    member?.image == null
                                        ? const Icon(Icons.person, size: 14)
                                        : null,
                              ),
                              const SizedBox(width: 8),
                              Text(member?.name ?? 'User ${absence.userId}'),
                            ],
                          ),
                        ),
                        DataCell(Text(absence.type.name)),
                        DataCell(
                          Text(
                            absence.startDate != null
                                ? dateFormat.format(absence.startDate!)
                                : '—',
                          ),
                        ),
                        DataCell(
                          Text(
                            absence.endDate != null
                                ? dateFormat.format(absence.endDate!)
                                : '—',
                          ),
                        ),
                        DataCell(
                          Chip(
                            label: Text(status),
                            backgroundColor: statusColor.withValues(alpha: 0.1),
                            labelStyle: TextStyle(color: statusColor),
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
