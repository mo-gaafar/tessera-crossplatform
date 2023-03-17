import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: lightTheme));

  void toggleTheme() {
    state.theme == lightTheme
        ? emit(ThemeState(theme: darkTheme))
        : emit(ThemeState(theme: lightTheme));
  }
}
