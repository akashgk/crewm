import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/absence_filter_state_provider.dart';

class DateRangeSelector extends ConsumerWidget {
  const DateRangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(selectedDateRangeProvider);
    final formatter = DateFormat('d MMM yyyy');

    if (dateRange == null) {
      return ElevatedButton(
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
      );
    }

    return TextButton.icon(
      onPressed: () {
        ref.read(selectedDateRangeProvider.notifier).state = null;
        ref.read(currentPageProvider.notifier).state = 0;
      },
      icon: const Icon(Icons.clear),
      label: Text(
        '${formatter.format(dateRange.start)} → ${formatter.format(dateRange.end)}',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
