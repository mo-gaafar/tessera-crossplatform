import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/theme/app_theme.dart';

part 'theme_state.dart';

/// Cubit that handles the app's theme.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: AppTheme.lightTheme));

  /// Toggles the theme between light and dark.
  void toggleTheme() {
    state.theme == AppTheme.lightTheme
        ? emit(ThemeState(theme: AppTheme.darkTheme))
        : emit(ThemeState(theme: AppTheme.lightTheme));
  }
}
