import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/absence.dart';

final selectedAbsenceTypeProvider = StateProvider<AbsenceType?>((ref) => null);

final selectedDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

final currentPageProvider = StateProvider<int>((ref) => 0);

const int itemsPerPage = 10;