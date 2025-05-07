import 'package:crewmeister/config/theme/theme_mode_provider.dart';
import 'package:crewmeister/core/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    String name,
    Widget Function(BuildContext context, GoRouterState state) builder, {
    List<GoRoute> routes = const [],
    this.useFade = false,
    String? title,
  }) : super(
         path: path,
         name: name,
         routes: routes,
         pageBuilder: (context, state) {
           final pageContent = Scaffold(
             appBar: CustomAppBar(
               title: title ?? 'Crewmeister',
               actions: [
                 Consumer(
                   builder: (context, ref, child) {
                     final themeMode = ref.watch(themeModeProvider);
                     return IconButton(
                       icon:
                           themeMode == ThemeMode.dark
                               ? const Icon(Icons.sunny)
                               : const Icon(Icons.nightlight_round),
                       onPressed: () {
                         ref.read(themeModeProvider.notifier).toggleTheme();
                       },
                     );
                   },
                 ),
               ],
             ),
             body: SafeArea(child: builder(context, state)),
             resizeToAvoidBottomInset: false,
           );
           if (useFade) {
             return CustomTransitionPage(
               key: state.pageKey,
               child: pageContent,
               transitionsBuilder: (
                 context,
                 animation,
                 secondaryAnimation,
                 child,
               ) {
                 return FadeTransition(opacity: animation, child: child);
               },
             );
           }
           return CupertinoPage(child: pageContent);
         },
       );
  final bool useFade;
}
