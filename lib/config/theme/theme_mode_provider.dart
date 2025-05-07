import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeProvider extends StateNotifier<ThemeMode> {
  ThemeModeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      _setLight();
    } else if (state == ThemeMode.light) {
      _setDark();
    }
  }

  void _setLight() {
    state = ThemeMode.light;
  }

  void _setDark() {
    state = ThemeMode.dark;
  }

  void setSystem() {
    state = ThemeMode.system;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeProvider, ThemeMode>((
  ref,
) {
  return ThemeModeProvider(); // default
});
