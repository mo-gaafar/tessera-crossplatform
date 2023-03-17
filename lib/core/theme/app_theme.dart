import 'package:flutter/material.dart';
import 'package:tessera/constants/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
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

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    surface: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'NeuePlak'),
);
