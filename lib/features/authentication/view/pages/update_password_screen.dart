// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/constants/app_colors.dart';
import 'package:tessera/core/widgets/app_scaffold.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

/// Screen notifying the user that an email has been sent to update their password.
class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text(
          "Update your password",
          style: TextStyle(fontFamily: 'NeuePlak', fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.red.shade900,
            width: double.infinity,
            child: const Text(
              '🕒  For your security, this link expires in 2 hours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 30,
            child: const Icon(
              Icons.lock_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Check your email to update your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NeuePlak',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              'We sent a link to ${context.read<AuthCubit>().currentUser.email} to update your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontSize: 20.0,
                  fontFamily: 'NeuePlak'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: const Text(
                'Change email',
                style: TextStyle(color: Colors.blue),
              ),
              // ignore: avoid_print
              onTap: () => Navigator.popUntil(
                  context, ModalRoute.withName('/login_signup')),
            ),
          ),
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              child: const Text(
                'Resend verification email',
                style: TextStyle(color: Colors.blue),
              ),
              // ignore: avoid_print
              onTap: () async {
                await context.read<AuthCubit>().forgotPassword();
              },
            ),
          ),
        ],
      ),
    );
  }
}
