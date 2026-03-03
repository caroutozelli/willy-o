import 'package:flutter/material.dart';
import 'package:willy_o/core/constants/app_colors.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.kPrimaryColor,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.kPrimaryColor,
          brightness: Brightness.dark,
        ),
      );
}
