import 'package:flutter/material.dart';
import 'package:tessera/constants/constants.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    surface: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
);
