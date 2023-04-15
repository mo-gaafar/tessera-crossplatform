import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tessera/core/theme/app_theme.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';

void main() {
  group(
    'Test ThemeCubit basic functionality',
    () {
      late ThemeCubit themeCubit;

      setUp(
        () {
          themeCubit = ThemeCubit();
        },
      );

      tearDown(
        () => themeCubit.close(),
      );

      test(
        'should return lightTheme as the state when ThemeCubit is initialized.',
        () => expect(
          themeCubit.state,
          ThemeState(theme: AppTheme.lightTheme),
        ),
      );

      blocTest<ThemeCubit, ThemeState>(
        'emits darkTheme state when toggleTheme() is triggered.',
        build: () => themeCubit,
        act: (bloc) => bloc.toggleTheme(),
        expect: () => <ThemeState>[ThemeState(theme: AppTheme.darkTheme)],
      );
    },
  );
}
