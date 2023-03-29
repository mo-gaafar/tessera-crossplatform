import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    onSecondaryContainer: Colors.black,
    onTertiaryContainer: AppColors.secondaryTextOnLight,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'NeuePlak',
        bodyColor: AppColors.textOnLight,
        // displayColor: AppColors.secondaryTextOnLight,
      ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardColor: Colors.grey.shade300,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    onPrimaryContainer: Colors.amber,
    surface: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondaryContainer: const Color(0xfff2f2f2),
    onTertiaryContainer: Colors.grey,
  ),
  cardColor: Colors.grey.shade900,
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'NeuePlak'),
  scaffoldBackgroundColor: AppColors.darkBackground,
);
