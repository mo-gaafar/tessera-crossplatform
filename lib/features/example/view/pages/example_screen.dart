import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';

import '../../../../core/services/authentication/authentication.dart';
import '../../../../core/services/authentication/google_authentication.dart';
import '../../../authentication/cubit/auth_cubit.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Screen'),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: const Icon(Icons.dark_mode),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await context.read<AuthCubit>().signOut();

            if (context.read<AuthCubit>().state is SignedOut) {
              Navigator.of(context).pushReplacementNamed('/loginOptions');
            }
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
