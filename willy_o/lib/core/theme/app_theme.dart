import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.kBackgroundLight,
        colorScheme: const ColorScheme.light(
          primary: AppColors.kPrimaryColor,
          secondary: AppColors.kSecondaryColor,
          error: AppColors.kErrorColor,
        ),
        elevatedButtonTheme: _elevatedButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.kBackgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.kPrimaryColor,
          secondary: AppColors.kSecondaryColor,
          error: AppColors.kErrorColor,
        ),
        elevatedButtonTheme: _elevatedButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
      );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: AppColors.kSecondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.kOverlay,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.kPrimaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.kPrimaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.kPrimaryColor, width: 2),
    ),
    labelStyle: const TextStyle(color: AppColors.kTextGold),
    hintStyle: const TextStyle(color: AppColors.kTextSecondary),
  );
}
