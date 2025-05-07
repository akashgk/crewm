import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/absence_count_provider.dart';
import '../../providers/absence_filter_state_provider.dart';
import '../../providers/absence_with_member_provider.dart';

class PaginationControls extends ConsumerWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final selectedType = ref.watch(selectedAbsenceTypeProvider);
    final dateRange = ref.watch(selectedDateRangeProvider);

    final countAsync = ref.watch(
      absenceCountProvider(
        AbsenceListParams(
          type: selectedType,
          startDate: dateRange?.start,
          endDate: dateRange?.end,
        ),
      ),
    );

    return countAsync.when(
      loading: () => const SizedBox(height: 48),
      error: (e, _) => Text('Error: $e'),
      data: (totalCount) {
        final totalPages = (totalCount / itemsPerPage).ceil();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  currentPage > 0
                      ? () => ref.read(currentPageProvider.notifier).state--
                      : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text('Page ${currentPage + 1} of $totalPages'),
            IconButton(
              onPressed:
                  (currentPage + 1) < totalPages
                      ? () => ref.read(currentPageProvider.notifier).state++
                      : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        );
      },
    );
  }
}
