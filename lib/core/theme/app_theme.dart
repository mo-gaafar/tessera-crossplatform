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
      // primaryContainer: Colors.white,
      onSecondaryContainer: Colors.black,
      onTertiaryContainer: AppColors.secondaryTextOnLight,
      inversePrimary: AppColors.secondary.withOpacity(0.3),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'NeuePlak',
          bodyColor: AppColors.textOnLight,
          // displayColor: AppColors.secondaryTextOnLight,
        ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: Colors.grey.shade300,
    snackBarTheme: ThemeData.light().snackBarTheme.copyWith(
          backgroundColor: Colors.red.shade900,
          contentTextStyle: const TextStyle(color: Colors.white),
        ),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          foregroundColor: Colors.black,
          color: Colors.white,
          elevation: 0,
          toolbarHeight: 65,
          titleTextStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 25,
            fontFamily: 'NeuePlak',
          ),
        ),
    tabBarTheme: ThemeData.light().tabBarTheme.copyWith(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade400,
        ),
    iconTheme: ThemeData.light().iconTheme.copyWith(
          color: AppColors.textOnLight,
        ),
  );

  /// Returns the app's dark theme.
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      surface: AppColors.primary,
      primary: AppColors.primary,
      secondary: Colors.white,
      // primaryContainer: Colors.black,
      onSecondaryContainer: const Color(0xfff2f2f2),
      onTertiaryContainer: Colors.grey,
      inversePrimary: Colors.grey.shade900,
    ),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          foregroundColor: Colors.white,
          color: Colors.black,
          elevation: 0,
          toolbarHeight: 65,
          titleTextStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 25,
            fontFamily: 'NeuePlak',
          ),
        ),
    tabBarTheme: ThemeData.dark().tabBarTheme.copyWith(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade400,
        ),
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'NeuePlak'),
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: AppColors.darkBackground,
  );
}
