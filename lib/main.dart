import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tessera/core/router/router.dart';
import 'package:tessera/core/theme/app_theme.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';

void main() {
  DartPluginRegistrant.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();
  final snackbarKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => EventBookCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    snackbarKey.currentState?.showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              // BlocListener<EventsFilterCubit, EventsFilterState>(
              //   listener: (context, state) {
              //     // TODO: implement listener
              //   },
              // ),
            ],
            child: MaterialApp(
              scaffoldMessengerKey: snackbarKey,
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              onGenerateRoute: _appRouter.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
