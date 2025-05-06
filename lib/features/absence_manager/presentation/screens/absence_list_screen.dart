import 'package:crewmeister/core/widgets/empty_state.dart';
import 'package:crewmeister/core/widgets/loading_list.dart';
import 'package:crewmeister/core/widgets/responsive_layout.dart';
import 'package:crewmeister/features/absence_manager/presentation/providers/absence_filter_state_provider.dart';
import 'package:crewmeister/features/absence_manager/presentation/screens/widgets/absence_table_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/error_state.dart';
import '../providers/absence_count_provider.dart';
import '../providers/absence_with_member_provider.dart';
import 'widgets/absence_filter.dart';
import 'widgets/absence_list_mobile.dart';

class AbsenceListScreen extends ConsumerWidget {
  const AbsenceListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedAbsenceTypeProvider);
    final dateRange = ref.watch(selectedDateRangeProvider);
    final page = ref.watch(currentPageProvider);

    final absencesAsync = ref.watch(
      absenceWithMemberListProvider(
        AbsenceListParams(
          offset: page * itemsPerPage,
          limit: itemsPerPage,
          type: selectedType,
          startDate: dateRange?.start,
          endDate: dateRange?.end,
        ),
      ),
    );

    final totalCountAsync = ref.watch(
      absenceCountProvider(
        AbsenceListParams(
          type: selectedType,
          startDate: dateRange?.start,
          endDate: dateRange?.end,
        ),
      ),
    );

    return Column(
      children: [
        totalCountAsync.when(
          loading: () => const Text('Loading count...'),
          error: (e, _) => const Text('Error loading count'),
          data: (count) => Text('Total Absences: $count'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          child: Row(
            children: [
              AbsenceFilter(
                selectedType: selectedType,
                onChanged: (value) {
                  ref.read(selectedAbsenceTypeProvider.notifier).state = value;
                  ref.read(currentPageProvider.notifier).state = 0;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDateRange: dateRange,
                  );
                  if (picked != null) {
                    ref.read(selectedDateRangeProvider.notifier).state = picked;
                    ref.read(currentPageProvider.notifier).state = 0;
                  }
                },
                child: const Text('Select Date Range'),
              ),
            ],
          ),
        ),

        Expanded(
          child: absencesAsync.when(
            loading: () => const Loadinglist(),
            error: (e, _) => ErrorState(message: e.toString()),
            data: (absencesDetailsList) {
              if (absencesDetailsList.isEmpty) {
                return const EmptyState(message: 'No absences found.');
              }
              return ResponsiveLayout(
                mobile: AbsenceListMobile(
                  absencesDetailList: absencesDetailsList,
                ),
                desktop: AbsenceTableView(
                  absencesDetailList: absencesDetailsList,
                ),
                tablet: AbsenceListMobile(
                  absencesDetailList: absencesDetailsList,
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed:
                    page > 0
                        ? () => ref.read(currentPageProvider.notifier).state--
                        : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${page + 1}'),
              IconButton(
                onPressed: () => ref.read(currentPageProvider.notifier).state++,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
