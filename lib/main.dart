import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tessera/core/router/router.dart';
import 'package:tessera/core/theme/app_theme.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_book_cubit.dart';
import 'package:tessera/features/attendees_view/events/cubit/event_data_cubit.dart';
import 'package:tessera/features/attendees_view/events/data/event_data.dart';
import 'package:tessera/features/organizers_view/ticketing/cubit/promocode_store_cubit.dart';

import 'features/organizers_view/ticketing/cubit/event_tickets_cubit.dart';
import 'features/organizers_view/ticketing/cubit/tickets_store_cubit.dart';

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
        BlocProvider(
          create: (context) => EventTicketsCubit(),
        ),
        BlocProvider(
          create: (context) => MyCubit(),
        ),
        BlocProvider(
          create: (context) => PromocodeCubit(),
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
