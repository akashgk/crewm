import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    primaryColor: const Color(0xFF4A90E2),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF4A90E2),
      onPrimary: Colors.white,
      secondary: Color(0xFFE0F7FA),
      error: Color(0xFFE74C3C),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF2C3E50),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4A90E2),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade200,
      labelStyle: const TextStyle(color: Color(0xFF2C3E50)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF90CAF9),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF90CAF9),
      onPrimary: Colors.black,
      secondary: Color(0xFF1E1E1E),
      error: Color(0xFFEF5350),
      onError: Colors.black,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade800,
      labelStyle: const TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          Color(0xFF1E88E5),
        ), // Deeper blue
        foregroundColor: const WidgetStatePropertyAll(
          Colors.white,
        ), // White text on dark button
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF1565C0).withValues(alpha: .2),
        ), // Ripple effect
        elevation: const WidgetStatePropertyAll(2),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
    ),
  );
}
