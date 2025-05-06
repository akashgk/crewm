import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'absence_repository_provider.dart';

import 'absence_with_member_provider.dart';

final absenceCountProvider = FutureProvider.family
    .autoDispose<int, AbsenceListParams>((ref, params) async {
      final repository = ref.read(absenceRepositoryProvider);
      return repository.getAbsenceCount(
        type: params.type,
        startDate: params.startDate,
        endDate: params.endDate,
      );
    });
