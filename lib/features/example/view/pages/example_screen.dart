// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/theme/cubit/theme_cubit.dart';
import '../../../authentication/cubit/auth_cubit.dart';

import '../../../authentication/cubit/email_auth_cubit.dart';

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
            await context.read<EmailAuthCubit>().signOut(context.read<EmailAuthCubit>().state.userData);
            await context.read<AuthCubit>().signOut();

            if (context.read<AuthCubit>().state is SignedOut) {
              Navigator.of(context).pushReplacementNamed('/loginOptions');
            }
            if (context.read<EmailAuthCubit>().state is EmailSignedOut) {
              Navigator.of(context).pushReplacementNamed('/loginOptions');
            }
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
