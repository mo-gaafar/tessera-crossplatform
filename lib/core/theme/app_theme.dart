import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

/// Contains the app's [ThemeData] for both light and dark modes.
class AppTheme {
  /// Returns the app's light theme.
  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'NeuePlak',
          bodyColor: AppColors.textOnLight,
          // displayColor: AppColors.secondaryTextOnLight,
        ),
    scaffoldBackgroundColor: AppColors.lightBackground,
  );

  /// Returns the app's dark theme.
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      surface: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'NeuePlak'),
  );
}
