// lib/config/router/app_router.dart
import 'package:crewmeister/core/widgets/error_state.dart';
import 'package:crewmeister/features/absence_manager/presentation/screens/absence_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crewmeister/features/absence_manager/presentation/screens/absence_list_screen.dart';

import 'app_route.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      AppRoute(
        '/',
        'absenceList',
        (context, state) => const AbsenceListScreen(),
      ),
      AppRoute('/absence/:id', 'absenceDetail', (context, state) {
        final id = int.tryParse(state.pathParameters['id']!);
        if (id == null) {
          return Center(
            child: ErrorState(
              message: 'Invalid absence ID',
              onRetry: () {
                context.goNamed('absenceList');
              },
            ),
          );
        }
        return AbsenceDetailScreen(absenceId: id);
      }),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: ErrorState(
            message: 'Invalid absence ID',
            onRetry: () {
              context.goNamed('absenceList');
            },
          ),
        ),
  );
}
