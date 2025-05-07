import 'package:crewmeister/config/theme/theme_mode_provider.dart';
import 'package:crewmeister/services/path_strategy/path_strategy_mp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

void main() {
  setPathUrlStrategy();
  runApp(const ProviderScope(child: AbsenceManagerApp()));
}

class AbsenceManagerApp extends ConsumerWidget {
  const AbsenceManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Absence Manager',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      themeMode: themeMode,
    );
  }
}
