import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema de alto contraste y textos grandes.
class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary, primary: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.text),
          titleMedium: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text),
          bodyLarge: TextStyle(fontSize: 18, color: AppColors.text),
          bodyMedium: TextStyle(fontSize: 16, color: AppColors.muted),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          height: 84,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primaryLight,
          labelTextStyle: WidgetStatePropertyAll(
              TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      );
}
