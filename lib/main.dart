import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tessera/core/router/router.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

void main() {
  DartPluginRegistrant.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

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
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.theme,
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
