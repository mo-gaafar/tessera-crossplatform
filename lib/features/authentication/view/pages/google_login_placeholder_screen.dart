import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/core/services/authentication/authentication.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

import '../../../../core/services/authentication/google_authentication.dart';

class GoogleLoginPlaceholderScreen extends StatelessWidget {
  const GoogleLoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignedIn) {
          Navigator.of(context).pushReplacementNamed('/landingPage');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await context.read<AuthCubit>().signIn(GoogleAuthService());
            },
            child: const Text('Sign in with Google'),
          ),
        ),
      ),
    );
  }
}
